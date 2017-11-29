Received: from eggs.gnu.org ([2001:4830:134:3::10]:54341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4G8-0002Bh-1k
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4G6-0007Wb-Tu
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:48 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:20 +0100
Message-Id: <20171129152628.14906-3-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] docs: Add image locking subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This documents the image locking feature and explains when and how
related options can be used.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qemu-block-drivers.texi | 36 ++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                |  1 +
 2 files changed, 37 insertions(+)

diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index 1cb1e55686..503c1847aa 100644
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
+This feature is currently supported by the file protocol on Linux with the Open
+File Descriptor (OFD) locking API, and can be configured to fall back to POSIX
+locking if the POSIX host doesn't support Linux OFD locking.
+
+To explicitly enable image locking, specify "locking=on" in the file protocol
+driver options. If OFD locking is not possible, a warning will be printed and
+the POSIX locking API will be used. In this case there is a risk that the lock
+will get silently lost when doing hot plugging and block jobs, due to the
+shortcomings of the POSIX locking API.
+
+QEMU transparently handles lock handover during shared storage migration.  For
+shared virtual disk images between multiple VMs, the "share-rw" device option
+should be used.
+
+Alternatively, locking can be fully disabled by "locking=off" block device
+option. In the command line, the option is usually in the form of
+"file.locking=off" as the protocol driver is normally placed as a "file" child
+under a format driver. For example:
+
+@code{-blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file}
+
+To check if image locking is active, check the output of the "lslocks" command
+on host and see if there are locks held by the QEMU process on the image file.
+More than one byte could be locked by the QEMU instance, each byte of which
+reflects a particular permission that is acquired or protected by the running
+block driver.
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
2.13.6
