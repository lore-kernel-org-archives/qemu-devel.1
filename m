Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BFEECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8473E205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUtX-0008GO-Uw
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHUnr-0002yb-RX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHUnq-0008P1-2E
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHUnp-0008Nq-Pn
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 110D030B9BED;
 Mon,  7 Oct 2019 15:20:01 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF81C19C5B;
 Mon,  7 Oct 2019 15:19:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] tests/fw_cfg: Let the tests use a context
Date: Mon,  7 Oct 2019 17:19:02 +0200
Message-Id: <20191007151905.32766-5-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-1-philmd@redhat.com>
References: <20191007151905.32766-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 07 Oct 2019 15:20:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the local QTestCtx structure, and register the tests
with qtest_add_data_func(ctx).
For now the context only contains the machine name (which is
fixed to the 'pc' machine, since this test only runs on the
x86 architecture).

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Use const QTestCtx *ctx, do not g_new(QTestCtx) (Laszlo)
---
 tests/fw_cfg-test.c | 87 ++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 53ae82f7c8..65785bca73 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -23,13 +23,18 @@ static uint16_t max_cpus =3D 1;
 static uint64_t nb_nodes =3D 0;
 static uint16_t boot_menu =3D 0;
=20
-static void test_fw_cfg_signature(void)
+typedef struct {
+    const char *machine_name;
+} QTestCtx;
+
+static void test_fw_cfg_signature(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
     char buf[5];
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
@@ -40,13 +45,14 @@ static void test_fw_cfg_signature(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_id(void)
+static void test_fw_cfg_id(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
     uint32_t id;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
@@ -56,8 +62,9 @@ static void test_fw_cfg_id(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_uuid(void)
+static void test_fw_cfg_uuid(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
@@ -67,7 +74,8 @@ static void test_fw_cfg_uuid(void)
         0x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2, 0xd8,
     };
=20
-    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
,
+                    ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
@@ -78,12 +86,13 @@ static void test_fw_cfg_uuid(void)
=20
 }
=20
-static void test_fw_cfg_ram_size(void)
+static void test_fw_cfg_ram_size(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D, ra=
m_size);
@@ -92,12 +101,13 @@ static void test_fw_cfg_ram_size(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_nographic(void)
+static void test_fw_cfg_nographic(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
@@ -106,12 +116,13 @@ static void test_fw_cfg_nographic(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_nb_cpus(void)
+static void test_fw_cfg_nb_cpus(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
@@ -120,12 +131,13 @@ static void test_fw_cfg_nb_cpus(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_max_cpus(void)
+static void test_fw_cfg_max_cpus(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D, ma=
x_cpus);
@@ -133,14 +145,15 @@ static void test_fw_cfg_max_cpus(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_numa(void)
+static void test_fw_cfg_numa(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
     uint64_t *cpu_mask;
     uint64_t *node_mask;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
@@ -162,12 +175,13 @@ static void test_fw_cfg_numa(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_boot_menu(void)
+static void test_fw_cfg_boot_menu(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
=20
-    s =3D qtest_init("");
+    s =3D qtest_initf("-M %s", ctx->machine_name);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D, b=
oot_menu);
@@ -175,14 +189,15 @@ static void test_fw_cfg_boot_menu(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_reboot_timeout(void)
+static void test_fw_cfg_reboot_timeout(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
     uint32_t reboot_timeout =3D 0;
     size_t filesize;
=20
-    s =3D qtest_init("-boot reboot-timeout=3D15");
+    s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
@@ -194,14 +209,15 @@ static void test_fw_cfg_reboot_timeout(void)
     qtest_quit(s);
 }
=20
-static void test_fw_cfg_splash_time(void)
+static void test_fw_cfg_splash_time(const void *opaque)
 {
+    const QTestCtx *ctx =3D opaque;
     QFWCFG *fw_cfg;
     QTestState *s;
     uint16_t splash_time =3D 0;
     size_t filesize;
=20
-    s =3D qtest_init("-boot splash-time=3D12");
+    s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
     fw_cfg =3D pc_fw_cfg_init(s);
=20
     filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
@@ -215,25 +231,30 @@ static void test_fw_cfg_splash_time(void)
=20
 int main(int argc, char **argv)
 {
+    QTestCtx ctx;
+
     g_test_init(&argc, &argv, NULL);
=20
-    qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
-    qtest_add_func("fw_cfg/id", test_fw_cfg_id);
-    qtest_add_func("fw_cfg/uuid", test_fw_cfg_uuid);
-    qtest_add_func("fw_cfg/ram_size", test_fw_cfg_ram_size);
-    qtest_add_func("fw_cfg/nographic", test_fw_cfg_nographic);
-    qtest_add_func("fw_cfg/nb_cpus", test_fw_cfg_nb_cpus);
+    ctx.machine_name =3D "pc";
+
+    qtest_add_data_func("fw_cfg/signature", &ctx, test_fw_cfg_signature)=
;
+    qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
+    qtest_add_data_func("fw_cfg/uuid", &ctx, test_fw_cfg_uuid);
+    qtest_add_data_func("fw_cfg/ram_size", &ctx, test_fw_cfg_ram_size);
+    qtest_add_data_func("fw_cfg/nographic", &ctx, test_fw_cfg_nographic)=
;
+    qtest_add_data_func("fw_cfg/nb_cpus", &ctx, test_fw_cfg_nb_cpus);
 #if 0
     qtest_add_func("fw_cfg/machine_id", test_fw_cfg_machine_id);
     qtest_add_func("fw_cfg/kernel", test_fw_cfg_kernel);
     qtest_add_func("fw_cfg/initrd", test_fw_cfg_initrd);
     qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
 #endif
-    qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
-    qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
-    qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
-    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
-    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
+    qtest_add_data_func("fw_cfg/max_cpus", &ctx, test_fw_cfg_max_cpus);
+    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
+    qtest_add_data_func("fw_cfg/boot_menu", &ctx, test_fw_cfg_boot_menu)=
;
+    qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
+                        test_fw_cfg_reboot_timeout);
+    qtest_add_data_func("fw_cfg/splash_time", &ctx, test_fw_cfg_splash_t=
ime);
=20
     return g_test_run();
 }
--=20
2.21.0


