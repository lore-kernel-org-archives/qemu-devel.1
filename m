Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A9C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45B720724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESYK-0001An-0R
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 02:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1jESXD-0000Gr-0E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1jESXB-0005nA-Kl
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57266 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1jESXB-0004xC-99
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6CA49346316582089C95;
 Wed, 18 Mar 2020 14:50:26 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 14:50:18 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/2] hw/smbios: add options for type 4 max-speed and
 current-speed
Date: Wed, 18 Mar 2020 14:48:19 +0800
Message-ID: <20200318064820.19363-2-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200318064820.19363-1-guoheyi@huawei.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

Strictly speaking, the "max speed" and "current speed" in type 4
are not really for the max speed and current speed of processor, for
"max speed" identifies a capability of the system, and "current speed"
identifies the processor's speed at boot (see smbios spec), but some
applications do not tell the differences.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>

---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

v3 -> v4:
- Fix the default value when not specifying "-smbios type=3D4" option;
  it would be 0 instead of 2000 in previous versions
- Use uint64_t type to check value overflow

v2 -> v3:
- Refine comments per Igor's suggestion.

v1 -> v2:
- change "_" in option names to "-"
- check if option value is too large to fit in SMBIOS type 4 speed
fields.
---
 hw/smbios/smbios.c | 36 ++++++++++++++++++++++++++++++++----
 qemu-options.hx    |  3 ++-
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ffd98727ee..b95de935e8 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -92,9 +92,21 @@ static struct {
     const char *manufacturer, *version, *serial, *asset, *sku;
 } type3;
=20
+/*
+ * SVVP requires max_speed and current_speed to be set and not being
+ * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Set the
+ * default value to 2000MHz as we did before.
+ */
+#define DEFAULT_CPU_SPEED 2000
+
 static struct {
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *par=
t;
-} type4;
+    uint64_t max_speed;
+    uint64_t current_speed;
+} type4 =3D {
+    .max_speed =3D DEFAULT_CPU_SPEED,
+    .current_speed =3D DEFAULT_CPU_SPEED
+};
=20
 static struct {
     size_t nvalues;
@@ -272,6 +284,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] =3D=
 {
         .name =3D "version",
         .type =3D QEMU_OPT_STRING,
         .help =3D "version number",
+    },{
+        .name =3D "max-speed",
+        .type =3D QEMU_OPT_NUMBER,
+        .help =3D "max speed in MHz",
+    },{
+        .name =3D "current-speed",
+        .type =3D QEMU_OPT_NUMBER,
+        .help =3D "speed at system boot in MHz",
     },{
         .name =3D "serial",
         .type =3D QEMU_OPT_STRING,
@@ -586,9 +606,8 @@ static void smbios_build_type_4_table(MachineState *m=
s, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
     t->voltage =3D 0;
     t->external_clock =3D cpu_to_le16(0); /* Unknown */
-    /* SVVP requires max_speed and current_speed to not be unknown. */
-    t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
-    t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
+    t->max_speed =3D cpu_to_le16(type4.max_speed);
+    t->current_speed =3D cpu_to_le16(type4.current_speed);
     t->status =3D 0x41; /* Socket populated, CPU enabled */
     t->processor_upgrade =3D 0x01; /* Other */
     t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
@@ -1129,6 +1148,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp=
)
             save_opt(&type4.serial, opts, "serial");
             save_opt(&type4.asset, opts, "asset");
             save_opt(&type4.part, opts, "part");
+            type4.max_speed =3D qemu_opt_get_number(opts, "max-speed",
+                                                  DEFAULT_CPU_SPEED);
+            type4.current_speed =3D qemu_opt_get_number(opts, "current-s=
peed",
+                                                      DEFAULT_CPU_SPEED)=
;
+            if (type4.max_speed > UINT16_MAX ||
+                type4.current_speed > UINT16_MAX) {
+                error_setg(errp, "SMBIOS CPU speed is too large (> %d)",
+                           UINT16_MAX);
+            }
             return;
         case 11:
             qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
diff --git a/qemu-options.hx b/qemu-options.hx
index 962a5ebaa6..7665addc78 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2277,6 +2277,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Ds=
tr][,serial=3Dstr]\n"
     "              [,asset=3Dstr][,part=3Dstr]\n"
+    "              [,max-speed=3D%d][,current-speed=3D%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr]=
[,serial=3Dstr]\n"
     "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
@@ -2298,7 +2299,7 @@ SRST
 ``-smbios type=3D3[,manufacturer=3Dstr][,version=3Dstr][,serial=3Dstr][,=
asset=3Dstr][,sku=3Dstr]``
     Specify SMBIOS type 3 fields
=20
-``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr]``
+``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr][,max-speed=3D%d][,current-spee=
d=3D%d]``
     Specify SMBIOS type 4 fields
=20
 ``-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,s=
erial=3Dstr][,asset=3Dstr][,part=3Dstr][,speed=3D%d]``
--=20
2.19.1


