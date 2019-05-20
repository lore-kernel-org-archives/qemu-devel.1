Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD099C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80DE2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80DE2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSq5X-0007nx-RG
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:44:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyD-0001yl-N7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyC-0003pe-1P
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSpyB-0003oa-Lj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86BC23086258;
	Mon, 20 May 2019 21:37:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F49F5D704;
	Mon, 20 May 2019 21:37:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:36:56 +0200
Message-Id: <20190520213700.12620-4-philmd@redhat.com>
In-Reply-To: <20190520213700.12620-1-philmd@redhat.com>
References: <20190520213700.12620-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 21:37:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/7] tests: refactor fw_cfg_test
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@163.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Currently, fw_cfg_test uses one QTestState for every test case.
This will add all command lines for every test case and
this is unnecessary. This patch split the test cases and for
every test case it uses his own QTestState. This patch does following
things:

1. Get rid of the global 'fw_cfg', this need add a uninit function

2. Convert every test case in a separate QTestState

After this patch, we can add fw_cfg test case freely and will not
have effect on other test cases.

Signed-off-by: Li Qiang <liq3ea@163.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190424140643.62457-2-liq3ea@163.com>
[PMD: Removed 'ret' local variable in main()]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/fw_cfg-test.c | 93 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 15 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index a370ad56678..4597626dd78 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -21,62 +21,127 @@ static uint16_t nb_cpus =3D 1;
 static uint16_t max_cpus =3D 1;
 static uint64_t nb_nodes =3D 0;
 static uint16_t boot_menu =3D 0;
-static QFWCFG *fw_cfg =3D NULL;
=20
 static void test_fw_cfg_signature(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
     char buf[5];
=20
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
     buf[4] =3D 0;
=20
     g_assert_cmpstr(buf, =3D=3D, "QEMU");
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_id(void)
 {
-    uint32_t id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t id;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
+    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
     g_assert((id =3D=3D 1) ||
              (id =3D=3D 3));
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_uuid(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
     uint8_t buf[16];
     static const uint8_t uuid[16] =3D {
         0x46, 0x00, 0xcb, 0x32, 0x38, 0xec, 0x4b, 0x2f,
         0x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2, 0xd8,
     };
=20
+    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
     g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+
 }
=20
 static void test_fw_cfg_ram_size(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D, ra=
m_size);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_nographic(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_nb_cpus(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_max_cpus(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D, ma=
x_cpus);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_numa(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
     uint64_t *cpu_mask;
     uint64_t *node_mask;
=20
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
=20
     cpu_mask =3D g_new0(uint64_t, max_cpus);
@@ -92,24 +157,27 @@ static void test_fw_cfg_numa(void)
=20
     g_free(node_mask);
     g_free(cpu_mask);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 static void test_fw_cfg_boot_menu(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s =3D qtest_init("");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D, b=
oot_menu);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
=20
 int main(int argc, char **argv)
 {
-    QTestState *s;
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
=20
-    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
-
-    fw_cfg =3D pc_fw_cfg_init(s);
-
     qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
     qtest_add_func("fw_cfg/id", test_fw_cfg_id);
     qtest_add_func("fw_cfg/uuid", test_fw_cfg_uuid);
@@ -126,10 +194,5 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
=20
-    ret =3D g_test_run();
-
-    pc_fw_cfg_uninit(fw_cfg);
-    qtest_quit(s);
-
-    return ret;
+    return g_test_run();
 }
--=20
2.20.1


