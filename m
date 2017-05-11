Received: from eggs.gnu.org ([2001:4830:134:3::10]:56168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8nKq-0005JK-NC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8nKn-0007sF-Li
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8nKn-0007ru-Fn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:36:45 -0400
Date: Thu, 11 May 2017 13:36:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170511123639.GE2078@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] e1000e migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dmitry@daynix.com
Cc: qemu-devel@nongnu.org

Hi Dmitry,
  Have you seen any problems with e1000e migration under windows?
I've got a repeatable case where after migration with e1000e windows
hangs/almost hangs.
  I'm seeing the e1000e generate interrupts at a very very high
rate (maybe ~1000 second ish?) after migration.

  Some versions of qemu do it and some dont, but my attempts
at bisection lead me to code that should be irrelevant.

Prior to migration I see:

36461@1494504466.711929:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100082, IMS: 0x1f00004)
36461@1494504466.711992:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000082, IMS: 0x1a00004)
36461@1494504466.712076:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000082, IMS: 0x1f00004)
36461@1494504466.712245:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000082, IMS: 0x1a00004)
36461@1494504466.712332:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000082, IMS: 0x1f00004)

which I think the ICR means:
      31 - int asserted
      20 - RxQ0 - receive queue 0 interrupt
      7  - RXT0 - receiver timer interrupt
      1  - TXQE - Transmit Queue empty

after migration it varies more, I'm seeing mostly:
21977@1494504516.320707:e1000e_irq_pending_interrupts ICR PENDING: 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
      31 - int asserted
      24 - 'Other'
      22 - TxQ0 interrupt
      20 - RxQ0 interrupt
      07 - RXT0 Receiver timer interrupt
      06 - RX0 - Receiver overrun
      01 - TXQE - Transmit queue empty

For reference this is https://bugzilla.redhat.com/show_bug.cgi?id=1447935

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
