Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmhahn@pmhahn.de>) id 1dNG5m-0007dT-KH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmhahn@pmhahn.de>) id 1dNG5i-0002lI-Lr
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:09:02 -0400
Received: from parrot.pmhahn.de ([88.198.50.102]:34772)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmhahn@pmhahn.de>) id 1dNG5i-0002lC-EX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:08:58 -0400
References: <5d090b82-dae7-ac67-a032-92c2e776b70f@univention.de>
	<2e7e9fe3-e603-d75f-84c6-d0fb048266da@redhat.com>
	<58d3a273-e857-fe9e-0b1e-a4aca4aa54ef@univention.de>
From: Philipp Hahn <pmhahn@pmhahn.de>
Message-ID: <d323a0b6-164f-7378-c565-e42128cf56b6@pmhahn.de>
Date: Tue, 20 Jun 2017 12:08:56 +0200
MIME-Version: 1.0
In-Reply-To: <58d3a273-e857-fe9e-0b1e-a4aca4aa54ef@univention.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFH] qemu-2.6 memory corruption with OVMF and
 linux-4.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Hahn <hahn@univention.de>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org

Hello,

Am 18.06.2017 um 20:22 schrieb Philipp Hahn:
> Am 17.06.2017 um 18:51 schrieb Laszlo Ersek:
>> (I also recommend using the "vbindiff" tool for such problems, it is
>> great for picking out patterns.)
>>
>>           ** ** ** ** ** ** ** **   8  9 ** ** ** 13 14 15
>>           -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- --
>> 00000000  01 e8 00 00 00 00 00 00  8c 5e 00 00 00 10 ff f1
>> 00000010  5b 78 8a 3e 00 00 00 00  00 00 00 00 00 00 00 00
>> 00000020  8c 77 00 00 00 12 00 02  18 f0 00 00 00 00 00 00
>> 00000030  00 1e 00 00 00 00 00 00  8c 8c 00 00 00 12 00 02
>> 00000040  07 70 00 00 00 00 00 00  00 14 00 00 00 00 00 00
>> 00000050  8c 9c 00 00 00 12 00 02  22 00 00 00 00 00 00 00
>> 00000060  00 40 00 00 00 00 00 00  8c ac 00 00 00 10 ff f1
>>
>> 00000000  01 e8 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
>> 00000010  5b 78 8a 3e 00 00 00 00  00 3c 00 00 00 07 00 00
>> 00000020  8c 77 00 00 00 12 00 02  00 3c 00 00 00 07 00 00
>> 00000030  00 1e 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
>> 00000040  07 70 00 00 00 00 00 00  00 3c 00 00 00 07 00 00
>> 00000050  8c 9c 00 00 00 12 00 02  00 3c 00 00 00 07 00 00
>> 00000060  00 40 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
>>           -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- --
>>           ** ** ** ** ** ** ** **   8  9 ** ** ** 13 14 15
>>
>> The columns that I marked with "**" are identical between "good" and
>> "bad". (These are columns 0-7, 10-12.)
>>
>> Column 8 is overwritten by zeros (every 16th byte).
>>
>> Column 9 is overwritten by 0x3c (every 16th byte).
>>
>> Column 13 is super interesting. The most significant nibble in that
>> column is not disturbed. And, in the least significant nibble, the least
>> significant three bits are turned on. Basically, the corruption could be
>> described, for this column (i.e., every 16th byte), as
>>
>>   bad = good | 0x7
>>
>> Column 14 is overwritten by zeros (every 16th byte).
>>
>> Column 15 is overwritten by zeros (every 16th byte).
>>
>> My take is that your host machine has faulty RAM. Please run memtest86+
>> or something similar.
> 
> I will do so, but for me very unlikely:
> - it never happens with BIOS, only with OVMF
> - for each test I start q new QEMU process, which should use a different
> memory region
> - it repeatedly hits e1000 or libata.ko

Okay: memtest+-5.01 run for 8h and did not find any errors in those 3
passes.

> After updating from OVMF to 0~20161202.7bbe0b3e-1 from
> (0~20160813.de74668f-2 it has not yet happened again.

Anyway, thank you for your help.

Philipp
