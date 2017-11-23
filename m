Received: from eggs.gnu.org ([2001:4830:134:3::10]:41106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs2A-0007mR-I4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs29-0001aR-9G
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eHs28-0001Z9-Tn
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06082FC7BA
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 13:59:16 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Nov 2017 21:59:05 +0800
Message-Id: <20171123135906.12852-2-famz@redhat.com>
In-Reply-To: <20171123135906.12852-1-famz@redhat.com>
References: <20171123135906.12852-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docs: Add image locking subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com

This documents the image locking feature and explains when and how
related options can be used.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 docs/qemu-block-drivers.texi | 36 ++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                |  1 +
 2 files changed, 37 insertions(+)

diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index 1cb1e55686..fa2e90d15f 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -785,6 +785,42 @@ warning: ssh server @code{ssh.example.com:22} does not support fsync
 With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
 supported.
 
+@node disk_image_locking
+@subsection Disk image file locking
+
+By default, QEMU tries to protect image files from unexpected concurrent
+access, as long as it's supported by the block protocol driver and host
+operating system. If multiple QEMU processes (including QEMU emulators and
+utilities) try to open the same image with conflicting accessing modes, all but
+the first one will get an error.
+
+This feature is currently supported by the file protocol on Linux with Open
+File Descriptor (OFD) locking API, and can be configured to fall back to POSIX
+locking if the POSIX host doesn't support Linux OFD locking.
+
+To explicitly enable image locking, specify "locking=on" in the file protocol
+driver options. If OFD locking is not possible, a warning will be printed and
+the POSIX locking API will be used. In this case there is risk that the lock
+will get silently lost when doing hot plugging and block jobs, due to the
+shortcomings of the POSIX locking API.
+
+QEMU transparently handles lock handover during shared storage migration.  For
+shared virtual disk images between multiple VMs, the "share-rw" device option
+should be used.
+
+Alternatively, locking can be fully disabled by "locking=off" block device
+option. In the command line the option is usually in the form of
+"file.locking=off" as the protocol driver is normally placed as a "file" child
+under a format driver. For example:
+
+@code{-blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file}
+
+To check if image locking is active, check the output of "lslocks" command on
+host and see if there are locks held by QEMU process on the image file. More
+than one bytes could be locked by a QEMU instance, each byte of which reflects
+a perticular permission that are acquired or protected by the running block
+driver.
+
 @c man end
 
 @ignore
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 617254917d..db2351c746 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -405,6 +405,7 @@ encrypted disk images.
 * disk_images_iscsi::         iSCSI LUNs
 * disk_images_gluster::       GlusterFS disk images
 * disk_images_ssh::           Secure Shell (ssh) disk images
+* disk_image_locking::        Disk image file locking
 @end menu
 
 @node disk_images_quickstart
-- 
2.14.3
