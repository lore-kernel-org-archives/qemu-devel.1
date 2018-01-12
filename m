Received: from eggs.gnu.org ([2001:4830:134:3::10]:41686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAv-0000m6-Fz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAu-00053n-HJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Jan 2018 16:55:54 +0800
Message-Id: <20180112085555.14447-9-famz@redhat.com>
In-Reply-To: <20180112085555.14447-1-famz@redhat.com>
References: <20180112085555.14447-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 8/9] docs: Add section for NVMe VFIO driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-9-famz@redhat.com>
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
