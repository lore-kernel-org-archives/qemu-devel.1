Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF0C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AE12146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AE12146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48163 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9dT-0002zD-Sk
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi7Db-0003eP-H3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi7DP-00049U-Vk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi7DF-00020l-0B; Mon, 01 Jul 2019 21:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2787EFA8D6;
 Tue,  2 Jul 2019 01:01:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA961001B2D;
 Tue,  2 Jul 2019 01:01:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:59:06 -0300
Message-Id: <20190702005912.15905-22-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
References: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 01:01:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/27] hw/block/pflash_cfi02: Fix CFI in
 autoselect mode
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Checkoway <stephen.checkoway@oberlin.edu>

After a flash device enters CFI mode from autoselect mode, the reset
command returns the device to autoselect mode. An additional reset
command is necessary to return to read array mode.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-7-stephen.checkoway@oberlin.edu>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c   | 22 ++++++++++++++++++----
 tests/pflash-cfi02-test.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 08b2bc83cb..13f76fa71d 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -66,6 +66,7 @@ do {                                                   =
    \
 /* Special write cycles for CFI queries. */
 enum {
     WCYCLE_CFI              =3D 7,
+    WCYCLE_AUTOSELECT_CFI   =3D 8,
 };
=20
 struct PFlashCFI02 {
@@ -311,6 +312,12 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
     cmd =3D value;
     if (pfl->cmd !=3D 0xA0) {
         if (cmd =3D=3D 0xF0) {
+            if (pfl->wcycle =3D=3D WCYCLE_AUTOSELECT_CFI) {
+                /* Return to autoselect mode. */
+                pfl->wcycle =3D 3;
+                pfl->cmd =3D 0x90;
+                return;
+            }
             goto reset_flash;
         }
     }
@@ -333,7 +340,6 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
         /* We're in read mode */
     check_unlock0:
         if (boff =3D=3D 0x55 && cmd =3D=3D 0x98) {
-        enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle =3D WCYCLE_CFI;
             pfl->cmd =3D 0x98;
@@ -410,9 +416,16 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
                 /* Unlock bypass reset */
                 goto reset_flash;
             }
-            /* We can enter CFI query mode from autoselect mode */
-            if (boff =3D=3D 0x55 && cmd =3D=3D 0x98)
-                goto enter_CFI_mode;
+            /*
+             * We can enter CFI query mode from autoselect mode, but we =
must
+             * return to autoselect mode after a reset.
+             */
+            if (boff =3D=3D 0x55 && cmd =3D=3D 0x98) {
+                /* Enter autoselect CFI query mode */
+                pfl->wcycle =3D WCYCLE_AUTOSELECT_CFI;
+                pfl->cmd =3D 0x98;
+                return;
+            }
             /* No break here */
         default:
             DPRINTF("%s: invalid write for command %02x\n",
@@ -493,6 +506,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
         break;
     /* Special values for CFI queries */
     case WCYCLE_CFI:
+    case WCYCLE_AUTOSELECT_CFI:
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 1659eaebce..00e2261742 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -407,6 +407,42 @@ static void test_geometry(const void *opaque)
     qtest_quit(qtest);
 }
=20
+/*
+ * Test that
+ * 1. enter autoselect mode;
+ * 2. enter CFI mode; and then
+ * 3. exit CFI mode
+ * leaves the flash device in autoselect mode.
+ */
+static void test_cfi_in_autoselect(const void *opaque)
+{
+    const FlashConfig *config =3D opaque;
+    QTestState *qtest;
+    qtest =3D qtest_initf("-M musicpal,accel=3Dqtest"
+                        " -drive if=3Dpflash,file=3D%s,format=3Draw,copy=
-on-read",
+                        image_path);
+    FlashConfig explicit_config =3D expand_config_defaults(config);
+    explicit_config.qtest =3D qtest;
+    const FlashConfig *c =3D &explicit_config;
+
+    /* 1. Enter autoselect. */
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
+
+    /* 2. Enter CFI. */
+    flash_cmd(c, CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), =3D=3D, replicate(=
c, 'Q'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), =3D=3D, replicate(=
c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), =3D=3D, replicate(=
c, 'Y'));
+
+    /* 3. Exit CFI. */
+    reset(c);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
+
+    qtest_quit(qtest);
+}
+
 static void cleanup(void *opaque)
 {
     unlink(image_path);
@@ -474,6 +510,9 @@ int main(int argc, char **argv)
         qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
+
+    qtest_add_data_func("pflash-cfi02/cfi-in-autoselect", &configuration=
[0],
+                        test_cfi_in_autoselect);
     int result =3D g_test_run();
     cleanup(NULL);
     return result;
--=20
2.20.1


