Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuG-0005NK-G8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuF-00060E-Mb
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:44 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:16 +0100
Message-Id: <20180308180423.941-5-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/11] hw/s390x: Add the possibility to specify
 the netboot image on the command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The file name of the netboot binary is currently hard-coded to
"s390-netboot.img", without a possibility for the user to select
an alternative firmware image here. That's unfortunate, especially
since the basics are already there: The filename is a property of
the s390-ipl device. So we just have to add a check whether the user
already provided the property and only set the default if the string
is still empty. Now it is possible to select a different firmware
image with "-global s390-ipl.netboot_fw=/path/to/s390-netboot.img".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1519731154-3127-1-git-send-email-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d0c3deba6..8726b4c281 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -254,8 +254,10 @@ static void s390_init_ipl_dev(const char *kernel_filename,
     }
     qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
     qdev_prop_set_string(dev, "firmware", firmware);
-    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
     qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
+    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
+        qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
+    }
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
                               new, NULL);
     object_unref(new);
-- 
2.13.6
