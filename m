Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782DC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77D12082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL/6RkN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77D12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5pR-0006rb-W3
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l6-0006DS-8u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l2-0003nV-Sc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5l2-0003lt-Ba
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3uuTzvaVaravVIEhy1GldQgYWyp4LKpZz2DJpnAj9s=;
 b=TL/6RkN3bjDcbCSsvJI4Ct5zbYD+6uVdcwTr1BroM4H5rTRG1BuJ74Kioye5ZvY3D+maK2
 jahfem9pzgsP3DO7bRVDtEveM9KmsotQlX1CxDETHLvZNBIOEWxy5SQj0CNgaPnILOxLd1
 kyNK7nXjLUDYsF41mxZKDau3otPpahM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-x0OFmDckOSuE-tj7GAOE0A-1; Thu, 30 Apr 2020 05:45:13 -0400
X-MC-Unique: x0OFmDckOSuE-tj7GAOE0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C514F107ACCA;
 Thu, 30 Apr 2020 09:45:11 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E7460BF4;
 Thu, 30 Apr 2020 09:45:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/20] s390x: protvirt: Support unpack facility
Date: Thu, 30 Apr 2020 11:44:29 +0200
Message-Id: <20200430094445.25943-5-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

The unpack facility provides the means to setup a protected guest. A
protected guest cannot be introspected by the hypervisor or any
user/administrator of the machine it is running on.

Protected guests are encrypted at rest and need a special boot
mechanism via diag308 subcode 8 and 10.

Code 8 sets the PV specific IPLB which is retained separately from
those set via code 5.

Code 10 is used to unpack the VM into protected memory, verify its
integrity and start it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
to machine]
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200323083606.24520-1-frankja@linux.ibm.com>
[CH: fixed up KVM_PV_VM_ -> KVM_PV_]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                         |   2 +
 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  59 +++++++++++++-
 hw/s390x/ipl.h                      |  91 ++++++++++++++++++++-
 hw/s390x/pv.c                       |  98 +++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          | 119 +++++++++++++++++++++++++++-
 include/hw/s390x/pv.h               |  55 +++++++++++++
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 target/s390x/cpu.c                  |   1 +
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 |  39 ++++++++-
 target/s390x/kvm-stub.c             |   5 ++
 target/s390x/kvm.c                  |   5 ++
 target/s390x/kvm_s390x.h            |   1 +
 14 files changed, 468 insertions(+), 10 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 include/hw/s390x/pv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2bfc..831d4b014aea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -396,6 +396,8 @@ F: target/s390x/machine.c
 F: target/s390x/sigp.c
 F: target/s390x/cpu_features*.[ch]
 F: target/s390x/cpu_models.[ch]
+F: hw/s390x/pv.c
+F: include/hw/s390x/pv.h
 F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: include/hw/s390x/s390_flic.h
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index e02ed80b6829..a46a1c7894e0 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
 obj-$(CONFIG_KVM) +=3D tod-kvm.o
 obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
 obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
+obj-$(CONFIG_KVM) +=3D pv.o
 obj-y +=3D s390-ccw.o
 obj-y +=3D ap-device.o
 obj-y +=3D ap-bridge.o
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8c3e01957176..ce21494c08f7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -1,10 +1,11 @@
 /*
  * bootloader support
  *
- * Copyright IBM, Corp. 2012
+ * Copyright IBM, Corp. 2012, 2020
  *
  * Authors:
  *  Christian Borntraeger <borntraeger@de.ibm.com>
+ *  Janosch Frank <frankja@linux.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at =
your
  * option) any later version.  See the COPYING file in the top-level direc=
tory.
@@ -27,6 +28,7 @@
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
+#include "hw/s390x/pv.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
@@ -566,12 +568,31 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl =3D get_ipl_device();
=20
-    ipl->iplb =3D *iplb;
-    ipl->iplb_valid =3D true;
+    /*
+     * The IPLB set and retrieved by subcodes 8/9 is completely
+     * separate from the one managed via subcodes 5/6.
+     */
+    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
+        ipl->iplb_pv =3D *iplb;
+        ipl->iplb_valid_pv =3D true;
+    } else {
+        ipl->iplb =3D *iplb;
+        ipl->iplb_valid =3D true;
+    }
     ipl->netboot =3D is_virtio_net_device(iplb);
     update_machine_ipl_properties(iplb);
 }
=20
+IplParameterBlock *s390_ipl_get_iplb_pv(void)
+{
+    S390IPLState *ipl =3D get_ipl_device();
+
+    if (!ipl->iplb_valid_pv) {
+        return NULL;
+    }
+    return &ipl->iplb_pv;
+}
+
 IplParameterBlock *s390_ipl_get_iplb(void)
 {
     S390IPLState *ipl =3D get_ipl_device();
@@ -660,6 +681,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
=20
+int s390_ipl_prepare_pv_header(void)
+{
+    IplParameterBlock *ipib =3D s390_ipl_get_iplb_pv();
+    IPLBlockPV *ipib_pv =3D &ipib->pv;
+    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
+    int rc;
+
+    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
+                             ipib_pv->pv_header_len);
+    rc =3D s390_pv_set_sec_parms((uintptr_t)hdr,
+                               ipib_pv->pv_header_len);
+    g_free(hdr);
+    return rc;
+}
+
+int s390_ipl_pv_unpack(void)
+{
+    IplParameterBlock *ipib =3D s390_ipl_get_iplb_pv();
+    IPLBlockPV *ipib_pv =3D &ipib->pv;
+    int i, rc =3D 0;
+
+    for (i =3D 0; i < ipib_pv->num_comp; i++) {
+        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
+                            TARGET_PAGE_ALIGN(ipib_pv->components[i].size)=
,
+                            ipib_pv->components[i].tweak_pref);
+        if (rc) {
+            break;
+        }
+    }
+    return rc;
+}
+
 void s390_ipl_prepare_cpu(S390CPU *cpu)
 {
     S390IPLState *ipl =3D get_ipl_device();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index a5665e6bfde2..89b3044d7a2e 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -1,8 +1,9 @@
 /*
  * s390 IPL device
  *
- * Copyright 2015 IBM Corp.
+ * Copyright 2015, 2020 IBM Corp.
  * Author(s): Zhang Fan <bjfanzh@cn.ibm.com>
+ * Janosch Frank <frankja@linux.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
@@ -15,6 +16,24 @@
 #include "cpu.h"
 #include "hw/qdev-core.h"
=20
+struct IPLBlockPVComp {
+    uint64_t tweak_pref;
+    uint64_t addr;
+    uint64_t size;
+} QEMU_PACKED;
+typedef struct IPLBlockPVComp IPLBlockPVComp;
+
+struct IPLBlockPV {
+    uint8_t  reserved18[87];    /* 0x18 */
+    uint8_t  version;           /* 0x6f */
+    uint32_t reserved70;        /* 0x70 */
+    uint32_t num_comp;          /* 0x74 */
+    uint64_t pv_header_addr;    /* 0x78 */
+    uint64_t pv_header_len;     /* 0x80 */
+    struct IPLBlockPVComp components[];
+} QEMU_PACKED;
+typedef struct IPLBlockPV IPLBlockPV;
+
 struct IplBlockCcw {
     uint8_t  reserved0[85];
     uint8_t  ssid;
@@ -71,6 +90,7 @@ union IplParameterBlock {
         union {
             IplBlockCcw ccw;
             IplBlockFcp fcp;
+            IPLBlockPV pv;
             IplBlockQemuScsi scsi;
         };
     } QEMU_PACKED;
@@ -85,8 +105,11 @@ typedef union IplParameterBlock IplParameterBlock;
=20
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
+int s390_ipl_prepare_pv_header(void);
+int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
+IplParameterBlock *s390_ipl_get_iplb_pv(void);
=20
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -94,6 +117,7 @@ enum s390_reset {
     S390_RESET_REIPL,
     S390_RESET_MODIFIED_CLEAR,
     S390_RESET_LOAD_NORMAL,
+    S390_RESET_PV,
 };
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type=
);
@@ -133,6 +157,7 @@ struct S390IPLState {
     /*< private >*/
     DeviceState parent_obj;
     IplParameterBlock iplb;
+    IplParameterBlock iplb_pv;
     QemuIplParameters qipl;
     uint64_t start_addr;
     uint64_t compat_start_addr;
@@ -140,6 +165,7 @@ struct S390IPLState {
     uint64_t compat_bios_start_addr;
     bool enforce_bios;
     bool iplb_valid;
+    bool iplb_valid_pv;
     bool netboot;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
@@ -162,6 +188,8 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "a=
lignment of iplb wrong");
 #define DIAG_308_RC_OK              0x0001
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
+#define DIAG_308_RC_NO_PV_CONF      0x0902
+#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
=20
 #define DIAG308_RESET_MOD_CLR       0
 #define DIAG308_RESET_LOAD_NORM     1
@@ -169,12 +197,17 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, =
"alignment of iplb wrong");
 #define DIAG308_LOAD_NORMAL_DUMP    4
 #define DIAG308_SET                 5
 #define DIAG308_STORE               6
+#define DIAG308_PV_SET              8
+#define DIAG308_PV_STORE            9
+#define DIAG308_PV_START            10
=20
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PV 0x05
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
=20
 #define S390_IPLB_HEADER_LEN 8
+#define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
@@ -184,6 +217,62 @@ static inline bool iplb_valid_len(IplParameterBlock *i=
plb)
     return be32_to_cpu(iplb->len) <=3D sizeof(IplParameterBlock);
 }
=20
+static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
+{
+    IPLBlockPV *ipib_pv =3D &iplb->pv;
+    int i;
+
+    if (ipib_pv->num_comp =3D=3D 0) {
+        return false;
+    }
+
+    for (i =3D 0; i < ipib_pv->num_comp; i++) {
+        /* Addr must be 4k aligned */
+        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
+            return false;
+        }
+
+        /* Tweak prefix is monotonically increasing with each component */
+        if (i < ipib_pv->num_comp - 1 &&
+            ipib_pv->components[i].tweak_pref >=3D
+            ipib_pv->components[i + 1].tweak_pref) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
+{
+        IPLBlockPV *ipib_pv =3D &iplb->pv;
+
+        if (ipib_pv->pv_header_len > 2 * TARGET_PAGE_SIZE) {
+            return false;
+        }
+
+        if (!address_space_access_valid(&address_space_memory,
+                                        ipib_pv->pv_header_addr,
+                                        ipib_pv->pv_header_len,
+                                        false,
+                                        MEMTXATTRS_UNSPECIFIED)) {
+            return false;
+        }
+
+        return true;
+}
+
+static inline bool iplb_valid_pv(IplParameterBlock *iplb)
+{
+    if (iplb->pbt !=3D S390_IPL_TYPE_PV ||
+        be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
+        return false;
+    }
+    if (!ipl_valid_pv_header(iplb)) {
+        return false;
+    }
+    return ipl_valid_pv_components(iplb);
+}
+
 static inline bool iplb_valid(IplParameterBlock *iplb)
 {
     switch (iplb->pbt) {
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
new file mode 100644
index 000000000000..a40a8448060c
--- /dev/null
+++ b/hw/s390x/pv.c
@@ -0,0 +1,98 @@
+/*
+ * Protected Virtualization functions
+ *
+ * Copyright IBM Corp. 2020
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+
+#include <linux/kvm.h>
+
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "hw/s390x/pv.h"
+
+static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
+{
+    struct kvm_pv_cmd pv_cmd =3D {
+        .cmd =3D cmd,
+        .data =3D (uint64_t)data,
+    };
+    int rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
+
+    if (rc) {
+        error_report("KVM PV command %d (%s) failed: header rc %x rrc %x "
+                     "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
+                     rc);
+    }
+    return rc;
+}
+
+/*
+ * This macro lets us pass the command as a string to the function so
+ * we can print it on an error.
+ */
+#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data);
+#define s390_pv_cmd_exit(cmd, data)    \
+{                                      \
+    int rc;                            \
+                                       \
+    rc =3D __s390_pv_cmd(cmd, #cmd, data);\
+    if (rc) {                          \
+        exit(1);                       \
+    }                                  \
+}
+
+int s390_pv_vm_enable(void)
+{
+    return s390_pv_cmd(KVM_PV_ENABLE, NULL);
+}
+
+void s390_pv_vm_disable(void)
+{
+     s390_pv_cmd_exit(KVM_PV_DISABLE, NULL);
+}
+
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
+{
+    struct kvm_s390_pv_sec_parm args =3D {
+        .origin =3D origin,
+        .length =3D length,
+    };
+
+    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
+}
+
+/*
+ * Called for each component in the SE type IPL parameter block 0.
+ */
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
+{
+    struct kvm_s390_pv_unp args =3D {
+        .addr =3D addr,
+        .size =3D size,
+        .tweak =3D tweak,
+    };
+
+    return s390_pv_cmd(KVM_PV_UNPACK, &args);
+}
+
+void s390_pv_perf_clear_reset(void)
+{
+    s390_pv_cmd_exit(KVM_PV_PREP_RESET, NULL);
+}
+
+int s390_pv_verify(void)
+{
+    return s390_pv_cmd(KVM_PV_VERIFY, NULL);
+}
+
+void s390_pv_unshare(void)
+{
+    s390_pv_cmd_exit(KVM_PV_UNSHARE_ALL, NULL);
+}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0fa00a9fff3d..b4d681da43af 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1,9 +1,10 @@
 /*
  * virtio ccw machine
  *
- * Copyright 2012 IBM Corp.
+ * Copyright 2012, 2020 IBM Corp.
  * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *            Janosch Frank <frankja@linux.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
@@ -42,6 +43,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "hw/s390x/pv.h"
+#include <linux/kvm.h>
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -317,10 +320,78 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_=
on_cpu_data arg)
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
=20
+static void s390_machine_unprotect(S390CcwMachineState *ms)
+{
+    s390_pv_vm_disable();
+    ms->pv =3D false;
+}
+
+static int s390_machine_protect(S390CcwMachineState *ms)
+{
+    int rc;
+
+    /* Create SE VM */
+    rc =3D s390_pv_vm_enable();
+    if (rc) {
+        return rc;
+    }
+
+    ms->pv =3D true;
+
+    /* Set SE header and unpack */
+    rc =3D s390_ipl_prepare_pv_header();
+    if (rc) {
+        goto out_err;
+    }
+
+    /* Decrypt image */
+    rc =3D s390_ipl_pv_unpack();
+    if (rc) {
+        goto out_err;
+    }
+
+    /* Verify integrity */
+    rc =3D s390_pv_verify();
+    if (rc) {
+        goto out_err;
+    }
+    return rc;
+
+out_err:
+    s390_machine_unprotect(ms);
+    return rc;
+}
+
+static void s390_machine_inject_pv_error(CPUState *cs)
+{
+    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
+    CPUS390XState *env =3D &S390_CPU(cs)->env;
+
+    /* Report that we are unable to enter protected mode */
+    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
+}
+
+static void s390_pv_prepare_reset(S390CcwMachineState *ms)
+{
+    CPUState *cs;
+
+    if (!s390_is_pv()) {
+        return;
+    }
+    /* Unsharing requires all cpus to be stopped */
+    CPU_FOREACH(cs) {
+        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
+    }
+    s390_pv_unshare();
+    s390_pv_perf_clear_reset();
+}
+
 static void s390_machine_reset(MachineState *machine)
 {
+    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
     enum s390_reset reset_type;
     CPUState *cs, *t;
+    S390CPU *cpu;
=20
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -328,9 +399,15 @@ static void s390_machine_reset(MachineState *machine)
     /* all CPUs are paused and synchronized at this point */
     s390_cmma_reset();
=20
+    cpu =3D S390_CPU(cs);
+
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        if (s390_is_pv()) {
+            s390_machine_unprotect(ms);
+        }
+
         qemu_devices_reset();
         s390_crypto_reset();
=20
@@ -338,22 +415,56 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_MODIFIED_CLEAR:
+        /*
+         * Susbsystem reset needs to be done before we unshare memory
+         * and lose access to VIRTIO structures in guest memory.
+         */
+        subsystem_reset();
+        s390_crypto_reset();
+        s390_pv_prepare_reset(ms);
         CPU_FOREACH(t) {
             run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
         }
-        subsystem_reset();
-        s390_crypto_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_LOAD_NORMAL:
+        /*
+         * Susbsystem reset needs to be done before we unshare memory
+         * and lose access to VIRTIO structures in guest memory.
+         */
+        subsystem_reset();
+        s390_pv_prepare_reset(ms);
         CPU_FOREACH(t) {
             if (t =3D=3D cs) {
                 continue;
             }
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
-        subsystem_reset();
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
+        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
+        break;
+    case S390_RESET_PV: /* Subcode 10 */
+        subsystem_reset();
+        s390_crypto_reset();
+
+        CPU_FOREACH(t) {
+            if (t =3D=3D cs) {
+                continue;
+            }
+            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+        }
+        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
+
+        if (s390_machine_protect(ms)) {
+            s390_machine_inject_pv_error(cs);
+            /*
+             * Continue after the diag308 so the guest knows something
+             * went wrong.
+             */
+            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+            return;
+        }
+
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     default:
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
new file mode 100644
index 000000000000..c6cb360f2f6a
--- /dev/null
+++ b/include/hw/s390x/pv.h
@@ -0,0 +1,55 @@
+/*
+ * Protected Virtualization header
+ *
+ * Copyright IBM Corp. 2020
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#ifndef HW_S390_PV_H
+#define HW_S390_PV_H
+
+#ifdef CONFIG_KVM
+#include "hw/s390x/s390-virtio-ccw.h"
+
+static inline bool s390_is_pv(void)
+{
+    static S390CcwMachineState *ccw;
+    Object *obj;
+
+    if (ccw) {
+        return ccw->pv;
+    }
+
+    /* we have to bail out for the "none" machine */
+    obj =3D object_dynamic_cast(qdev_get_machine(),
+                              TYPE_S390_CCW_MACHINE);
+    if (!obj) {
+        return false;
+    }
+    ccw =3D S390_CCW_MACHINE(obj);
+    return ccw->pv;
+}
+
+int s390_pv_vm_enable(void);
+void s390_pv_vm_disable(void);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+void s390_pv_perf_clear_reset(void);
+int s390_pv_verify(void);
+void s390_pv_unshare(void);
+#else /* CONFIG_KVM */
+static inline bool s390_is_pv(void) { return false; }
+static inline int s390_pv_vm_enable(void) { return 0; }
+static inline void s390_pv_vm_disable(void) {}
+static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) =
{ return 0; }
+static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tw=
eak) { return 0; }
+static inline void s390_pv_perf_clear_reset(void) {}
+static inline int s390_pv_verify(void) { return 0; }
+static inline void s390_pv_unshare(void) {}
+#endif /* CONFIG_KVM */
+
+#endif /* HW_S390_PV_H */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-vir=
tio-ccw.h
index 8aa27199c912..cd1dccc6e3ba 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -28,6 +28,7 @@ typedef struct S390CcwMachineState {
     /*< public >*/
     bool aes_key_wrap;
     bool dea_key_wrap;
+    bool pv;
     uint8_t loadparm[8];
 } S390CcwMachineState;
=20
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 427a46e3e1b6..bb7a588e3b79 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,6 +37,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
+#include "hw/s390x/pv.h"
 #include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_feature=
s_def.inc.h
index 31dff0d84e97..60db28351d05 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Defl=
ate-conversion facility (
 DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed-De=
cimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-exten=
sion-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
+DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
=20
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to b=
yte-80) */
 DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-s=
uppression facility")
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 8aba6341f948..b2cbefb8cfe4 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,8 @@
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/pv.h"
+#include "kvm_s390x.h"
=20
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
@@ -52,6 +54,10 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uin=
t64_t r3)
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t ad=
dr,
                               uintptr_t ra, bool write)
 {
+    /* Handled by the Ultravisor */
+    if (s390_is_pv()) {
+        return 0;
+    }
     if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -1;
@@ -67,6 +73,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_=
t r1, uint64_t addr,
=20
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr=
_t ra)
 {
+    bool valid;
     CPUState *cs =3D env_cpu(env);
     uint64_t addr =3D  env->regs[r1];
     uint64_t subcode =3D env->regs[r3];
@@ -82,6 +89,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, ui=
nt64_t r3, uintptr_t ra)
         return;
     }
=20
+    if (subcode >=3D DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
     switch (subcode) {
     case DIAG308_RESET_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
@@ -94,6 +106,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, ui=
nt64_t r3, uintptr_t ra)
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
     case DIAG308_SET:
+    case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
             return;
         }
@@ -106,7 +119,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, u=
int64_t r3, uintptr_t ra)
=20
         cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
=20
-        if (!iplb_valid(iplb)) {
+        valid =3D subcode =3D=3D DIAG308_PV_SET ? iplb_valid_pv(iplb) : ip=
lb_valid(iplb);
+        if (!valid) {
             env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
             goto out;
         }
@@ -117,10 +131,15 @@ out:
         g_free(iplb);
         return;
     case DIAG308_STORE:
+    case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
             return;
         }
-        iplb =3D s390_ipl_get_iplb();
+        if (subcode =3D=3D DIAG308_PV_STORE) {
+            iplb =3D s390_ipl_get_iplb_pv();
+        } else {
+            iplb =3D s390_ipl_get_iplb();
+        }
         if (iplb) {
             cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
             env->regs[r1 + 1] =3D DIAG_308_RC_OK;
@@ -128,6 +147,22 @@ out:
             env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
         }
         return;
+    case DIAG308_PV_START:
+        iplb =3D s390_ipl_get_iplb_pv();
+        if (!iplb) {
+            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
+            return;
+        }
+
+        if (kvm_s390_get_hpage_1m()) {
+            error_report("Protected VMs can currently not be backed with "
+                         "huge pages");
+            env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
+            return;
+        }
+
+        s390_ipl_reset_request(cs, S390_RESET_PV);
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         break;
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index c4cd497f850e..aa185017a2a8 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -39,6 +39,11 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     return 0;
 }
=20
+int kvm_s390_get_hpage_1m(void)
+{
+    return 0;
+}
+
 int kvm_s390_get_ri(void)
 {
     return 0;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 7f7ebab84279..b2b14bde2b25 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -321,6 +321,11 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Erro=
r **errp)
     cap_hpage_1m =3D 1;
 }
=20
+int kvm_s390_get_hpage_1m(void)
+{
+    return cap_hpage_1m;
+}
+
 static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 0b21789796d7..dea813f45015 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -23,6 +23,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t co=
de);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
+int kvm_s390_get_hpage_1m(void);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
 int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
--=20
2.21.1


