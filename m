Received: from eggs.gnu.org ([2001:4830:134:3::10]:53029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1emGop-00071z-2F
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1emGoj-0005zd-5J
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:31:11 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1emGoi-0005xC-WD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:31:05 -0500
Received: by mail-wr0-x22e.google.com with SMTP id s5so2823663wra.0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 02:31:04 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 15 Feb 2018 10:31:02 +0000
Message-ID: <CAJSP0QUzvNDGV9CNA6-HxPY5eCcEO6Me4E0+NvuSfpD2szb0hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] GSoC project idea: iSCSI target in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, ronnie sahlberg <ronniesahlberg@gmail.com>

There is currently no way to test the block/iscsi.c block driver.
Using a third-party iSCSI target isn't sufficient since we need fault
injection and control over I/O request execution in order to exercise
specific code paths in the initiator.

Are you willing to co-mentor a Google Summer of Code project to
implement an iSCSI target in QEMU?

There are two goals:
1. Runtime iSCSI target QMP commands to start/stop and add/remove LUNs.
2. qemu-iscsi wrapper program for easy command-line launching.

I think iSCSI target functionality will be useful beyond testing.  It
will make it possible to attach disk images to physical machines or
VMs using a widely implemented protocol.

QEMU already has blkdebug for fault injection and a SCSI target.
We're just missing the iSCSI wire protocol that wraps SCSI CDBs.  The
basic idea is to implement a runtime iSCSI server (similar to the NBD
server) that speaks the iSCSI protocol and passes SCSI requests to
QEMU's SCSI target.

I briefly looked at include/hw/scsi/scsi.h to check if this is
feasible.  It looks like it's possible to instantiate a SCSIBus
without a parent DeviceState.  The SCSI target is tied to device
emulation since every LUN is a SCSIDevice and it's also tied to live
migration.  But I don't think these things prevent iSCSI from reusing
this code.

The next step is to look at the iSCSI RFC to determine how feasible
this would be:
https://tools.ietf.org/html/rfc7143

Stefan
