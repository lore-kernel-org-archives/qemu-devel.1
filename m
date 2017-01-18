Received: from eggs.gnu.org ([2001:4830:134:3::10]:51555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTftm-0002M7-Nv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTfti-0000un-MB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:22:54 -0500
Received: from ns3.fnarfbargle.com ([43.245.164.105]:60340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
	id 1cTfti-0000pI-6T
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:22:50 -0500
Received: from srv.home ([10.8.0.1] ident=heh23013)
	by ns3.fnarfbargle.com with esmtps
	(TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTfj1-0000Lr-Rs
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:11:48 +0800
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <86a7d976-780a-508e-1edd-af4334cf9d5d@fnarfbargle.com>
Date: Wed, 18 Jan 2017 10:21:32 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] commit : "virtio: set ISR on dataplane notifications"
 breaks virtio-pci network on linux guest.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

G'day all,

Upgrading from 2.7.1 to 2.8 on my machines here leaves the guests 
without networking. All guests are using a vanilla self-compiled 4.8.12 
kernel. The host is using a 4.9.3 kernel.

Guests are using virtio networking into a bridge on the host.

tcpdump on the bridge shows the guests sending dhcp requests and the 
host sending replies, but the replies never make it into the guest.

A bisect between 2.7.1 & 2.8 shows the following commit at fault.

This would appear to be the same fault as mentioned here : 
https://bbs.archlinux.org/viewtopic.php?id=221434

It's no issue for me to leave my hosts at 2.7, but in case it hadn't 
been raised I thought I'd track it down and report it.

brad@test:~/qemu$ git bisect good
83d768b5640946b7da55ce8335509df297e2c7cd is the first bad commit
commit 83d768b5640946b7da55ce8335509df297e2c7cd
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Nov 18 16:07:02 2016 +0100

     virtio: set ISR on dataplane notifications

     Dataplane has been omitting forever the step of setting ISR when
     an interrupt is raised.  This caused little breakage, because the
     specification actually says that ISR may not be updated in MSI mode.

     Some versions of the Windows drivers however didn't clear MSI mode
     correctly, and proceeded using polling mode (using ISR, not the used
     ring index!) for crashdump and hibernation.  If it were just crashdump
     and hibernation it would not be a big deal, but recent releases of
     Windows do not really shut down, but rather log out and hibernate to
     make the next startup faster.  Hence, this manifested as a more serious
     hang during shutdown with e.g. Windows 8.1 and virtio-win 1.8.0 RPMs.
     Newer versions fixed this, while older versions do not use MSI at all.

     The failure has always been there for virtio dataplane, but it became
     visible after commits 9ffe337 ("virtio-blk: always use dataplane path
     if ioeventfd is active", 2016-10-30) and ad07cd6 ("virtio-scsi: always
     use dataplane path if ioeventfd is active", 2016-10-30) made virtio-blk
     and virtio-scsi always use the dataplane code under KVM.  The good news
     therefore is that it was not a bug in the patches---they were doing
     exactly what they were meant for, i.e. shake out remaining 
dataplane bugs.

     The fix is not hard, so it's worth arranging for the broken drivers.
     The virtio_should_notify+event_notifier_set pair that is common to
     virtio-blk and virtio-scsi dataplane is replaced with a new public
     function virtio_notify_irqfd that also sets ISR.  The irqfd emulation
     code now need not set ISR anymore, so virtio_irq is removed.

     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
     Tested-by: Farhan Ali <alifm@linux.vnet.ibm.com>
     Tested-by: Alex Williamson <alex.williamson@redhat.com>
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

:040000 040000 fa35e9e7e6b49f32f4c5b24586f65ca7f2e6fc73 
282ecd3bb6c512e135b3e10d70de6c9bc306203e M	hw
:040000 040000 6ded15de7a064a8c00ac60d3f61e09e5d66a5cdd 
7dc07e32776505c037da7bd9e95a78c2518fa458 M	include

Regards,
Brad
