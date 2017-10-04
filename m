Received: from eggs.gnu.org ([2001:4830:134:3::10]:41561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzi2M-0000Fs-Dc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzi2J-0005b6-8y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzi2J-0005a4-1w
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:40:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEA567F3F3
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 11:40:21 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 12:40:06 +0100
Message-Id: <20171004114008.14849-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] Reporting of rotation rate for disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

While looking at libvirt tagged questions on serverfault I saw
someone ask how to indicate that a virtual disk is an SSD rather
than rotating rust.

https://serverfault.com/questions/876467/how-to-add-virtual-storage-as-ssd-in-kvm

IIUC, IDE / SCSI don't really have an explicit concept of a
disk being SSD vs HDD, but they do have a means of reporting
the disk rotation rate and both specify that SSDs should
report RPM==1.

Linux uses this to determine whether to set the 'rotational'
property to 0 for the I/O queue, and also whether to allow
the disk to contribute random entropy (only HDDs contribute).

This felt like something QEMU ought to allow the mgmt application
to set based on the storage it is using to back the virtual block
devices. So this series adds a 'rotation_rate' property to the
SCSI and IDE disks, taking an RPM value per their respective
specifications.

There is no mechanism to report this information to virtio-blk.
We could perhaps argue that people should use virtio-scsi instead,
because fixing virtio-blk would require enhancement to both QEMU
and Linux virtio-blk drivers (and other guest OS drivers too)

I'm unclear if there is anything I should have done wrt the
device migration vmstate when adding this extra field, or if it
is safe to just expect the mgmt app to set the property correctly
on src+dst ?

Daniel P. Berrange (2):
  scsi-disk: support reporting of rotation rate
  ide: support reporting of rotation rate

 hw/ide/core.c             |  1 +
 hw/ide/qdev.c             |  1 +
 hw/scsi/scsi-disk.c       | 20 ++++++++++++++++++++
 include/hw/ide/internal.h |  8 ++++++++
 4 files changed, 30 insertions(+)

-- 
2.13.5
