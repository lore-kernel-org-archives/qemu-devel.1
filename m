Received: from eggs.gnu.org ([2001:4830:134:3::10]:35256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1edJYI-0002j5-AA
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 12:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1edJYF-0002w2-3v
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 12:37:06 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1edJYE-0002t8-LP
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 12:37:03 -0500
References: <1516326941-11832-1-git-send-email-minyard@acm.org>
	<20180119051309-mutt-send-email-mst@kernel.org>
	<19605015-5d30-f91e-3344-32ae4555a7dd@acm.org>
	<3dc61d47-9315-0d59-912d-9952cbff970c@acm.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <c027971f-e8e0-2cb1-4411-1cf93dc03eb4@reactos.org>
Date: Sun, 21 Jan 2018 18:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <3dc61d47-9315-0d59-912d-9952cbff970c@acm.org>
Content-Type: multipart/mixed; boundary="------------CDACCC1D61570E8EB0DD2665"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Revert "smbus: do not immediately complete
 commands"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is a multi-part message in MIME format.
--------------CDACCC1D61570E8EB0DD2665
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/01/2018 à 22:15, Corey Minyard a écrit :
> On 01/19/2018 08:07 AM, Corey Minyard wrote:
>> On 01/18/2018 09:17 PM, Michael S. Tsirkin wrote:
>>> On Thu, Jan 18, 2018 at 07:55:41PM -0600, minyard@acm.org wrote:
>>>> From: Corey Minyard <cminyard@mvista.com>
>>>>
>>>> This reverts commit 880b1ffe6ec2f0ae25cc4175716227ad275e8b8a.
>>>>
>>>> The commit being reverted says:
>>>>
>>>>      PIIX4 errata says that "immediate polling of the Host Status Register BUSY
>>>>      bit may indicate that the SMBus is NOT busy."
>>>>      Due to this, some code does the following steps:
>>>>      (a) set parameters
>>>>      (b) start command
>>>>      (c) check for smbus busy bit set (to know that command started)
>>>>      (d) check for smbus busy bit not set (to know that command finished)
>>>>
>>>>      Let (c) happen, by immediately setting the busy bit, and really executing
>>>>      the command when status register has been read once.
>>>>
>>>>      This fixes a problem with AMIBIOS, which can now properly initialize the
>>>>      PIIX4.
>>>>
>>>> Emulating bad hardware so badly written software will work doesn't sound
>>>> like a good idea to me.  I have patches that add interrupt capability
>>>> to pm_smbus, but this change breaks that because the Linux driver
>>>> starts the transaction then waits for interrupts before reading the
>>>> status register.  That obviously won't work with these changes.
>>>>
>>>> The right way to fix this in AMIBIOS is to ignore the host busy bit
>>>> and use the other bits in the host status register to tell if the
>>>> transaction has completed.  Using host busy is racy, anyway, if you
>>>> get interrupted or something while processing, you may miss step (c)
>>>> in your algorithm and fail.
>>>>
>>>> Cc: Hervé Poussineau <hpoussin@reactos.org>
>>>> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>> Would it be possible to limit the change to when guest uses
>>> interrupts?
>>
>> I did think about that, but it seems rather frail.  What if another piece of software
>> does this but has the interrupt enable bit set?  And AMIBIOS is still broken doing
>> that algorithm on real hardware.  If you get a bus collision, for instance, that will
>> be almost instantaneous and the firmware is likely to miss it.
>>
>> The 82801 documentation is pretty clear that you should use the INTR and error
>> bits in the status register to know if a transaction is complete.
>>
>> If you really want to emulate real hardware, I guess the right way to do this
>> would be to add a delay between the start bit being set and the transaction
>> being done.  I'm not sure how timers work with vmstate, I'd have to look at
>> that.
> 
> I realized that the timer is not going to be able to correctly work around the
> AMIBIOS.  It would probably work most of the time, but if qemu got switched
> out, then switched back and the timer went off before the guest was allowed
> to run, then you would have the same issue.
> 
> Also, looking at a more complete implementation of the pm_smbus device,
> using the host busy bit to know when to start the transaction won't work,
> that bit also does other things when doing byte at a time block transfers.
> So a separate bool is needed to know when to do this.

AMIBIOS can't be fixed to do the right thing.
My first implementation of this patch was using a timer, and it was working quite well.
I don't think that smbus is very latency-sensitive, so I think a timer is a valid
solution to this problem. If a timer also works for your use case, I'll be happy with it.

See my patch proposal to use a timer instead. Does it fit your needs?

An improvement might be to execute the command either on the timer or when the guest
reads the host status register.

Regards,

Hervé

--------------CDACCC1D61570E8EB0DD2665
Content-Type: text/x-patch;
 name="0001-smbus-replace-transaction-execution-at-first-registe.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-smbus-replace-transaction-execution-at-first-registe.pa";
 filename*1="tch"

>From a5e13ceebd77b9f813fe1987b73fc8a3498cf7ca Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sun, 21 Jan 2018 14:17:27 +0100
Subject: [PATCH] smbus: replace transaction execution at first register read
 by a constant delay
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This execution at first register read was added in 880b1ffe6ec2f0ae25cc4175716227ad275e8b8a
While this is not very correct, it was enough to fix some use cases.

However, this break further developpements of the smbus emulation, especially
related to smbus interrupt (STS_INTR): the OS reads the host status register
only when an interrupt will be raised.
If QEMU executes the command (and raises the interrupt) only when the OS reads
the host status register, we have a dead-lock...

Change emulation to execute the command after a constant delay.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/i2c/pm_smbus.c         | 15 ++++++++-------
 include/hw/i2c/pm_smbus.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 0d26e0f6b5..e3ff47ec15 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -21,6 +21,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus.h"
+#include "qemu/timer.h"
 
 /* no save/load? */
 
@@ -53,8 +54,9 @@
 #endif
 
 
-static void smb_transaction(PMSMBus *s)
+static void smb_transaction(void *opaque)
 {
+    PMSMBus *s = opaque;
     uint8_t prot = (s->smb_ctl >> 2) & 0x07;
     uint8_t read = s->smb_addr & 0x01;
     uint8_t cmd = s->smb_cmd;
@@ -139,9 +141,10 @@ error:
 
 static void smb_transaction_start(PMSMBus *s)
 {
-    /* Do not execute immediately the command ; it will be
-     * executed when guest will read SMB_STAT register */
+    /* Do not execute immediately the command */
     s->smb_stat |= STS_HOST_BUSY;
+    timer_mod(s->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+              + (NANOSECONDS_PER_SECOND / 1000));
 }
 
 static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
@@ -191,10 +194,6 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     switch(addr) {
     case SMBHSTSTS:
         val = s->smb_stat;
-        if (s->smb_stat & STS_HOST_BUSY) {
-            /* execute command now */
-            smb_transaction(s);
-        }
         break;
     case SMBHSTCNT:
         s->smb_index = 0;
@@ -238,4 +237,6 @@ void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
     smb->smbus = i2c_init_bus(parent, "i2c");
     memory_region_init_io(&smb->io, OBJECT(parent), &pm_smbus_ops, smb,
                           "pm-smbus", 64);
+    smb->result_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                     smb_transaction, smb);
 }
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 2a837afdcb..02adeefcbf 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -4,6 +4,7 @@
 typedef struct PMSMBus {
     I2CBus *smbus;
     MemoryRegion io;
+    QEMUTimer *result_timer;
 
     uint8_t smb_stat;
     uint8_t smb_ctl;
-- 
2.11.0


--------------CDACCC1D61570E8EB0DD2665--
