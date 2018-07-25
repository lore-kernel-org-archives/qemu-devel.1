Received: from eggs.gnu.org ([2001:4830:134:3::10]:51500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <silveronemi@gmail.com>) id 1fiPPi-0006wa-6i
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <silveronemi@gmail.com>) id 1fiPPf-0003YO-4y
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:25:34 -0400
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:39089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <silveronemi@gmail.com>)
	id 1fiPPe-0003Vc-Q4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:25:30 -0400
Received: by mail-ua0-x22c.google.com with SMTP id g18-v6so5809702uam.6
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:25:30 -0700 (PDT)
MIME-Version: 1.0
From: "Humberto \"SilverOne\" Carvalho" <silveronemi@gmail.com>
Date: Wed, 25 Jul 2018 20:25:18 +0100
Message-ID: <CANrBoSjsOypfar4RpPKZx+OW2LMBeoV88BJ88wAnBQPvvZX_wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu_clock_get_ns does not take into account
 icount_time_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

When using icount with shift, virtual time is defined as icount << N.
However, qemu_clock_get_ns simply returns cpu_get_icount, thereby returning
icount instead of icount << N.

If you check the qemu/util/qemu-timer.c file you will find the following
function:

597: int64_t qemu_clock_get_ns(QEMUClockType type)
598: {
....
602: switch (type) {
....
606: case QEMU_CLOCK_VIRTUAL:
607: if (use_icount) {
608: return cpu_get_icount();

Now on line 606, in case we requested QEMU_CLOCK_VIRTUAL, and we are using
icount, the value of cpu_get_icount(); will be returned.

However if I understand correctly, in order to convert icount to ns, you
must take into account the icount shift -- as defined in the documentation:
"The virtual cpu will execute one instruction every 2^N ns of virtual
time.".

Therefor, the correct value to return would be
cpu_icount_to_ns(cpu_get_icount()), where cpu_icount_to_ns is defined in
cpus.c:

296: int64_t cpu_icount_to_ns(int64_t icount)
297: {
298: return icount << icount_time_shift;
299: }

Best Regards,
Humberto "SilverOne" Carvalho
