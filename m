Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMHDW-0005R0-BS
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMHDT-0003rC-97
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMHDT-0003ol-2N
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:41:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C8366CB22
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 17:41:09 +0000 (UTC)
Date: Tue, 5 Dec 2017 17:41:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171205174100.GD2405@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Hotplug ram and vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org

Hi,
  Since I'm reworking the memory map update code I've been
trying to test it with hot adding RAM; but even on upstream
I'm finding that hot adding RAM causes the guest to stop passing
packets with vhost-user-bridge;  have either of you seen the same
thing?

I'm doing:
./tests/vhost-user-bridge -u /tmp/vubrsrc.sock
$QEMU -enable-kvm -m 1G,maxmem=2G,slots=4 -smp 2 -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -trace events=vhost-trace-file -chardev socket,id=char0,path=/tmp/vubrsrc.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 $IMAGE -net none 

(with a f27 guest) and then doing:
(qemu) object_add memory-backend-file,id=mem1,size=256M,mem-path=/dev/shm
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1

but then not getting any responses inside the guest.

I can see the code sending another set-mem-table with the
extra chunk of RAM and fd, and I think I can see the bridge
mapping it.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
