Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spamcollector@cableone.net>) id 1cXKca-0005rj-6M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 23:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spamcollector@cableone.net>) id 1cXKcX-0000RX-0O
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 23:28:16 -0500
Received: from mail.cableone.syn-alias.com ([64.8.70.48]:11893
	helo=mail.cableone.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <spamcollector@cableone.net>)
	id 1cXKcW-0000RC-Rx
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 23:28:12 -0500
Date: Fri, 27 Jan 2017 23:28:11 -0500 (EST)
From: spam collector <spamcollector@cableone.net>
Message-ID: <211445636.27792096.1485577691046.JavaMail.zimbra@cableone.net>
In-Reply-To: <57449461.27782934.1485577321294.JavaMail.zimbra@cableone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] HPET emulation and 64-bit access using 32-bit processor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi everyone,

It has been a little while since I have visited this list, which is a good thing,
since if I am visiting this list, there might be something wrong with QEMU :-)

(Note, last time I visited, there was a simple bit error in the ATA Ready code)

Anyway, this time I have a question, maybe more of a concern.

The current HPET emulation, at least the version I have from https://qemu.weilnetz.de/
(thank you Stefan) dated 2016-09-03, has an issue.  If you try to read from
the Comparator register as a 64-bit timer using a 32-bit processor, the results
are correct about 10% of the time.  However, if you simply set bit 8, forcing
the timer to use 32-bit mode, the read is correct 100% of the time.  I checked
everything I could to be sure it was not my code and I get the same results
with each different technique of reading this timer register.

As far as I can tell, there is no statement saying that you cannot use the
timer in a 64-bit mode while using a 32-bit processor as long as you read 
two consecutive 32-bit dwords, each correctly aligned.

Am I missing something here, or is there an error in QEMU's emulation of a
64-bit timer using a 32-bit processor?

I looked over the hpet.c file and I think the error is the clearing of the
HPET_TN_SETVAL bit.  If using a 32-bit processor and writing a 64-bit value,
you have to write two 32-bit dwords.  When the first dword is written, the
hpet emulation clears the HPET_TN_SETVAL bit, so the second dword, the high
order dword is written incorrectly, the HPET_TN_SETVAL should still be
set until *after* the high order dword is written.

For example, if I write 0x00001234_01234567 as a 64-bit value, using two
32-bit writes, the low-order dword (the first write) gets written as expected,
yet the second write, the high-order dword no longer has HPET_TN_SETVAL set,
so it does not get written as expected.  Therefore, the following happens
after the sequence shown above.

  accumulator = 0x00001234_01234567
  comparator =  0x00000000_01234567

Am I correct in this finding?

Also, and forgive me, I don't know the QEMU code as well as most of you here,
but the line at

534:  new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;

has two errors, in my opinion.  First, if I am writing a 32-bit value,
the high-order does not get cleared out (HPET_TN_32BIT = 0), therefore
new_val has garbage in the high-order dword. Then

535:   timer->period =
536      (timer->period & 0xffffffff00000000ULL) | new_val;

the high-order dword of timer->period gets modified by the 'or' operand.
This happens unless the high-order dword of the passed parameter, value,
is cleared on arrival.

The second error (in my opinion) in line 534 is the shift.  Why clear the
high-order bit?  This would not allow a comparator write above 63 bits.
Granted, it would be more than a thousand years before the 64th bit is
set, but why the clearing of the 64th bit?

Anyway, I didn't study it too much and I may be all wet here, but there
seems to be some errors in the hpet emulation.

Thank you for your time.
Ben
