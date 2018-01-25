Received: from eggs.gnu.org ([2001:4830:134:3::10]:59414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNf-0006xq-RL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNf-0007t8-0E
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeaNe-0007rs-QL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:22 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 13:46:47 +0800
Message-Id: <20180125054648.18747-14-famz@redhat.com>
In-Reply-To: <20180125054648.18747-1-famz@redhat.com>
References: <20180125054648.18747-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 13/14] docs: Add section for NVMe VFIO driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-9-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180116060901.17413-9-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 docs/qemu-block-drivers.texi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index 503c1847aa..cd74767ed3 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -785,6 +785,43 @@ warning: ssh server @code{ssh.example.com:22} does not support fsync
 With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
 supported.
 
+@node disk_images_nvme
+@subsection NVMe disk images
+
+NVM Express (NVMe) storage controllers can be accessed directly by a userspace
+driver in QEMU.  This bypasses the host kernel file system and block layers
+while retaining QEMU block layer functionalities, such as block jobs, I/O
+throttling, image formats, etc.  Disk I/O performance is typically higher than
+with @code{-drive file=/dev/sda} using either thread pool or linux-aio.
+
+The controller will be exclusively used by the QEMU process once started. To be
+able to share storage between multiple VMs and other applications on the host,
+please use the file based protocols.
+
+Before starting QEMU, bind the host NVMe controller to the host vfio-pci
+driver.  For example:
+
+@example
+# modprobe vfio-pci
+# lspci -n -s 0000:06:0d.0
+06:0d.0 0401: 1102:0002 (rev 08)
+# echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
+# echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
+
+# qemu-system-x86_64 -drive file=nvme://@var{host}:@var{bus}:@var{slot}.@var{func}/@var{namespace}
+@end example
+
+Alternative syntax using properties:
+
+@example
+qemu-system-x86_64 -drive file.driver=nvme,file.device=@var{host}:@var{bus}:@var{slot}.@var{func},file.namespace=@var{namespace}
+@end example
+
+@var{host}:@var{bus}:@var{slot}.@var{func} is the NVMe controller's PCI device
+address on the host.
+
+@var{namespace} is the NVMe namespace number, starting from 1.
+
 @node disk_image_locking
 @subsection Disk image file locking
 
-- 
2.14.3
