Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24543C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A6920732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A6920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWbC-00078e-3d
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPB-0001Oc-P3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005D1-A2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052n-QN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 7960A3074895
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 67278305B7A4;
 Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 25/26] kvm: vmi: extend handshake to include the e820
 table
Date: Wed, 15 Apr 2020 03:59:37 +0300
Message-Id: <20200415005938.23895-26-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The introspection tool can use the e820 table to avoid accessing
(read/write) or modifying access (rwx) for reserved memory pages.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 68 ++++++++++++++++++++++++++++++----
 include/sysemu/vmi-handshake.h | 23 +++++++++++-
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 02877eec06..f70d78848a 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -26,6 +26,7 @@
 #include "migration/misc.h"
 #include "qapi/qmp/qobject.h"
 #include "monitor/monitor.h"
+#include "hw/i386/e820_memory_layout.h"
=20
 #include "sysemu/vmi-intercept.h"
 #include "sysemu/vmi-handshake.h"
@@ -412,23 +413,74 @@ static void register_types(void)
=20
 type_init(register_types);
=20
+static uint8_t handshake_cpu_type(void)
+{
+#ifdef TARGET_X86_64
+    return QEMU_VMI_CPU_TYPE_X86_64;
+#elif TARGET_I386
+    return QEMU_VMI_CPU_TYPE_I386;
+#else
+    return QEMU_VMI_CPU_TYPE_UNKNOWN;
+#endif
+}
+
+static int cmp_address(const void *a, const void *b)
+{
+    uint64_t addr_a =3D ((qemu_vmi_e820_entry *)a)->address;
+    uint64_t addr_b =3D ((qemu_vmi_e820_entry *)b)->address;
+
+    return (addr_a > addr_b) - (addr_a < addr_b);
+}
+
+static void fill_e820_info(qemu_vmi_e820_entry *dest, int n)
+{
+    int idx;
+
+    for (idx =3D 0; idx < n; idx++)
+        e820_get_entry2(idx, &dest[idx].type, &dest[idx].address,
+                        &dest[idx].length);
+
+    qsort(dest, n, sizeof(*dest), cmp_address);
+}
+
 static bool send_handshake_info(VMIntrospection *i, Error **errp)
 {
-    qemu_vmi_to_introspector send =3D {};
+    qemu_vmi_to_introspector *send;
+    int max_n_e820, n_e820;
     const char *vm_name;
+    size_t send_sz;
     int r;
=20
-    send.struct_size =3D sizeof(send);
-    send.start_time =3D i->vm_start_time;
-    memcpy(&send.uuid, &qemu_uuid, sizeof(send.uuid));
+    max_n_e820 =3D 8 * sizeof(((qemu_vmi_to_introspector *)0)->arch.e820=
_count);
+    n_e820 =3D e820_get_num_entries();
+
+    if (n_e820 < 0 || n_e820 > max_n_e820) {
+        warn_report("VMI: discard e820 info (size %d, max %d)",
+                    n_e820, max_n_e820);
+        n_e820 =3D 0;
+    }
+
+    send_sz =3D sizeof(*send) + n_e820 * sizeof(qemu_vmi_e820_entry);
+
+    send =3D g_malloc0(send_sz);
+
+    send->struct_size =3D send_sz;
+    send->start_time =3D i->vm_start_time;
+    send->cpu_type =3D handshake_cpu_type();
+    memcpy(&send->uuid, &qemu_uuid, sizeof(send->uuid));
     vm_name =3D qemu_get_vm_name();
     if (vm_name) {
-        snprintf(send.name, sizeof(send.name), "%s", vm_name);
-        send.name[sizeof(send.name) - 1] =3D 0;
+        snprintf(send->name, sizeof(send->name), "%s", vm_name);
+        send->name[sizeof(send->name) - 1] =3D 0;
+    }
+    send->arch.e820_count =3D n_e820;
+    if (n_e820) {
+        fill_e820_info(send->arch.e820_entries, n_e820);
     }
=20
-    r =3D qemu_chr_fe_write_all(&i->sock, (uint8_t *)&send, sizeof(send)=
);
-    if (r !=3D sizeof(send)) {
+    r =3D qemu_chr_fe_write_all(&i->sock, (uint8_t *)send, send_sz);
+    g_free(send);
+    if (r !=3D send_sz) {
         error_setg_errno(errp, errno, "VMI: error writing to '%s'",
                          i->chardevid);
         return false;
diff --git a/include/sysemu/vmi-handshake.h b/include/sysemu/vmi-handshak=
e.h
index 19bdfb6740..3c5201d37b 100644
--- a/include/sysemu/vmi-handshake.h
+++ b/include/sysemu/vmi-handshake.h
@@ -9,6 +9,25 @@
 enum { QEMU_VMI_NAME_SIZE =3D 64 };
 enum { QEMU_VMI_COOKIE_HASH_SIZE =3D 20};
=20
+enum {
+    QEMU_VMI_CPU_TYPE_I386 =3D 0,
+    QEMU_VMI_CPU_TYPE_X86_64 =3D 1,
+    QEMU_VMI_CPU_TYPE_UNKNOWN =3D 255
+};
+
+typedef struct qemu_vmi_e820_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+    uint32_t padding;
+} qemu_vmi_e820_entry;
+
+typedef struct qemu_vmi_to_introspector_x86 {
+   uint8_t e820_count;
+   uint8_t padding[3];
+   qemu_vmi_e820_entry e820_entries[0];
+} qemu_vmi_to_introspector_x86;
+
 /**
  * qemu_vmi_to_introspector:
  *
@@ -22,9 +41,11 @@ enum { QEMU_VMI_COOKIE_HASH_SIZE =3D 20};
 typedef struct qemu_vmi_to_introspector {
     uint32_t struct_size;
     uint8_t  uuid[16];
-    uint32_t padding;
+    uint8_t  cpu_type;
+    uint8_t  padding[3];
     int64_t  start_time;
     char     name[QEMU_VMI_NAME_SIZE];
+    qemu_vmi_to_introspector_x86 arch;
     /* ... */
 } qemu_vmi_to_introspector;
=20

