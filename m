Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF2EC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D40820881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D40820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9o4-00014u-DX
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi7EN-0003mX-J0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi7EH-0004VM-4B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi7Ds-0001jM-4l; Mon, 01 Jul 2019 21:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F08A3C0AD2B2;
 Tue,  2 Jul 2019 01:00:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 873341001B2D;
 Tue,  2 Jul 2019 01:00:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:58:57 -0300
Message-Id: <20190702005912.15905-13-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
References: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 01:00:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/27] hw/block/pflash_cfi02: Fix command
 address comparison
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

Most AMD commands only examine 11 bits of the address. This masks the
addresses used in the comparison to 11 bits. The exceptions are word or
sector addresses which use offset directly rather than the shifted
offset, boff.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-4-stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c   |  8 +++++++-
 tests/pflash-cfi02-test.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e64dc69c6c..4be3837be5 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -281,11 +281,13 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
     }
     offset &=3D pfl->chip_len - 1;
=20
-    boff =3D offset & (pfl->sector_len - 1);
+    boff =3D offset;
     if (pfl->width =3D=3D 2)
         boff =3D boff >> 1;
     else if (pfl->width =3D=3D 4)
         boff =3D boff >> 2;
+    /* Only the least-significant 11 bits are used in most cases. */
+    boff &=3D 0x7FF;
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -538,6 +540,10 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
         }
     }
=20
+    /* Only 11 bits are used in the comparison. */
+    pfl->unlock_addr0 &=3D 0x7FF;
+    pfl->unlock_addr1 &=3D 0x7FF;
+
     pflash_setup_mappings(pfl);
     pfl->rom_mode =3D 1;
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index e7e16a8dd8..e090b2e3a0 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -21,8 +21,8 @@
=20
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH * 0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
=20
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -190,6 +190,14 @@ static void test_flash(void)
     g_assert_cmphex(flash_read(6), =3D=3D, 0xCDEF);
     g_assert_cmphex(flash_read(8), =3D=3D, 0xFFFF);
=20
+    /* Test ignored high order bits of address. */
+    flash_write(FLASH_WIDTH * 0x5555, UNLOCK0_CMD);
+    flash_write(FLASH_WIDTH * 0x2AAA, UNLOCK1_CMD);
+    flash_write(FLASH_WIDTH * 0x5555, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, 0x236D);
+    reset();
+
     qtest_quit(global_qtest);
 }
=20
--=20
2.20.1


