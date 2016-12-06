Received: from eggs.gnu.org ([2001:4830:134:3::10]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEJtO-0000ya-RJ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEJtJ-0000E5-Mq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:51:02 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:60283
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEJtJ-0000Dl-Co
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:50:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6HoH5h004818
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 12:50:54 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2761393kyc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:50:53 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Dec 2016 10:50:53 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Dec 2016 18:50:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH] virtio: fix HW_COMPAT_2_6 macro for
 virtio-*-pci drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
-device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
types because the internal virtio-pci.disable-modern=on compat property
always prevail.

This should ideally be fixed in the qdev properties core code, but it is
too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
the compat properties for every virtio-*-pci subtypes instead of the base
virtio-pci type.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

This fix is for both QEMU 2.8 and 2.7.1.

Generated with:

for i in $(git grep 'define TYPE_VIRTIO_.*_PCI' hw/virtio/virtio-pci.h | \
           awk '{print $3 }'); do 
    printf '{\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-modern\","'\\'"\n        .value    = \"on\","'\\'"\n    },{"'\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-legacy\","'\\'"\n        .value    = \"off\","'\\'"\n    }," $i $i
done

 include/hw/compat.h |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 0f06e113bee2..793ba3ddb393 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -26,11 +26,123 @@
         .property = "format_transport_address",\
         .value    = "off",\
     },{\
-        .driver   = "virtio-pci",\
+        .driver   = "virtio-scsi-pci",\
         .property = "disable-modern",\
         .value    = "on",\
     },{\
-        .driver   = "virtio-pci",\
+        .driver   = "virtio-scsi-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-blk-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-blk-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-balloon-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-balloon-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-serial-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-serial-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-net-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-net-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-9p-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-9p-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-rng-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-rng-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-input-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-input-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-input-hid-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-input-hid-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-keyboard-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-keyboard-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-mouse-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-mouse-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-tablet-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-tablet-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-input-host-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-input-host-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-gpu-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-gpu-pci",\
+        .property = "disable-legacy",\
+        .value    = "off",\
+    },{\
+        .driver   = "virtio-crypto-pci",\
+        .property = "disable-modern",\
+        .value    = "on",\
+    },{\
+        .driver   = "virtio-crypto-pci",\
         .property = "disable-legacy",\
         .value    = "off",\
     },
