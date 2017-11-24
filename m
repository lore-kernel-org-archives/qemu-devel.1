Received: from eggs.gnu.org ([2001:4830:134:3::10]:39729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eIAmK-0000LT-9X
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eIAm9-0008Pj-17
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:00:12 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 24 Nov 2017 10:59:49 +0100
Message-Id: <20171124095949.16323-2-cohuck@redhat.com>
In-Reply-To: <20171124095949.16323-1-cohuck@redhat.com>
References: <20171124095949.16323-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 1/1] s390/kvm_virtio/linux-headers:
 remove traces of old virtio transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We no longer support the old s390 transport, neither does the newest
Linux kernel. Remove it from the linux header script as well as the
s390x virtio code.  We still should handle the VIRTIO_NOTIFY hypercall,
to tolerate early printk on older guest kernels without an sclp console.
We continue to ignore these events.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171115154223.109991-1-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-hcall.h                   |  6 ++-
 include/standard-headers/asm-s390/kvm_virtio.h | 64 --------------------------
 scripts/update-linux-headers.sh                |  1 -
 3 files changed, 4 insertions(+), 67 deletions(-)
 delete mode 100644 include/standard-headers/asm-s390/kvm_virtio.h

diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index cbc270eef3..9800c4b351 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,7 +1,7 @@
 /*
  * Support for virtio hypercalls on s390x
  *
- * Copyright 2012 IBM Corp.
+ * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
@@ -12,9 +12,11 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
-#include "standard-headers/asm-s390/kvm_virtio.h"
 #include "standard-headers/asm-s390/virtio-ccw.h"
 
+/* The only thing that we need from the old kvm_virtio.h file */
+#define KVM_S390_VIRTIO_NOTIFY 0
+
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 int s390_virtio_hypercall(CPUS390XState *env);
diff --git a/include/standard-headers/asm-s390/kvm_virtio.h b/include/standard-headers/asm-s390/kvm_virtio.h
deleted file mode 100644
index daad3249d2..0000000000
--- a/include/standard-headers/asm-s390/kvm_virtio.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * definition for virtio for kvm on s390
- *
- * Copyright IBM Corp. 2008
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
- *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- */
-
-#ifndef __KVM_S390_VIRTIO_H
-#define __KVM_S390_VIRTIO_H
-
-#include "standard-headers/linux/types.h"
-
-struct kvm_device_desc {
-	/* The device type: console, network, disk etc.  Type 0 terminates. */
-	uint8_t type;
-	/* The number of virtqueues (first in config array) */
-	uint8_t num_vq;
-	/*
-	 * The number of bytes of feature bits.  Multiply by 2: one for host
-	 * features and one for guest acknowledgements.
-	 */
-	uint8_t feature_len;
-	/* The number of bytes of the config array after virtqueues. */
-	uint8_t config_len;
-	/* A status byte, written by the Guest. */
-	uint8_t status;
-	uint8_t config[0];
-};
-
-/*
- * This is how we expect the device configuration field for a virtqueue
- * to be laid out in config space.
- */
-struct kvm_vqconfig {
-	/* The token returned with an interrupt. Set by the guest */
-	uint64_t token;
-	/* The address of the virtio ring */
-	uint64_t address;
-	/* The number of entries in the virtio_ring */
-	uint16_t num;
-
-};
-
-#define KVM_S390_VIRTIO_NOTIFY		0
-#define KVM_S390_VIRTIO_RESET		1
-#define KVM_S390_VIRTIO_SET_STATUS	2
-
-/* The alignment to use between consumer and producer parts of vring.
- * This is pagesize for historical reasons. */
-#define KVM_S390_VIRTIO_RING_ALIGN	4096
-
-
-/* These values are supposed to be in ext_params on an interrupt */
-#define VIRTIO_PARAM_MASK		0xff
-#define VIRTIO_PARAM_VRING_INTERRUPT	0x0
-#define VIRTIO_PARAM_CONFIG_CHANGED	0x1
-#define VIRTIO_PARAM_DEV_ADD		0x2
-
-#endif
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 76fd894a77..135a10d96a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -95,7 +95,6 @@ for arch in $ARCHLIST; do
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
     if [ $arch = s390 ]; then
-        cp_portable "$tmpdir/include/asm/kvm_virtio.h" "$output/include/standard-headers/asm-s390/"
         cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
     fi
     if [ $arch = arm ]; then
-- 
2.13.6
