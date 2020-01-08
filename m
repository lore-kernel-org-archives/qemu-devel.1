Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA082C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A472070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lfaNp/pO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A472070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip45n-0003MD-LM
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3of-0003yW-0O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3od-0002q0-Eq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48461 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3od-0002mg-2y; Wed, 08 Jan 2020 00:23:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMF4GZ0z9sSV; Wed,  8 Jan 2020 16:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461001;
 bh=aIwNYzOKPwG6QdHQ14D6UBG51U6gQFGHiVEGceGBmtg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lfaNp/pOOvIDo3vEx+UlhxRRX5IX4TaeVpExQzGwjVLshpSDGWEGn1BrKn01ABYVg
 YK2BFLZ38R/TsekrCrZ44HpExqLqtlgNGcQ3cNENJmfX7Sd3X5J5FbFnZWUPfl2LRu
 8W8TGNN9wI2FtoZjGgLltMd3OAoLgMreN2KxPdkA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/26] ppc/pnv: check return value of blk_pwrite()
Date: Wed,  8 Jan 2020 16:23:11 +1100
Message-Id: <20200108052312.238710-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When updating the PNOR file contents, we should check for a possible
failure of blk_pwrite().

Fixes Coverity issue CID 1412228.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200107171809.15556-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_pnor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index bfb1e92b03..0e86ae2fea 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -33,6 +33,7 @@ static uint64_t pnv_pnor_read(void *opaque, hwaddr addr=
, unsigned size)
 static void pnv_pnor_update(PnvPnor *s, int offset, int size)
 {
     int offset_end;
+    int ret;
=20
     if (s->blk) {
         return;
@@ -42,8 +43,11 @@ static void pnv_pnor_update(PnvPnor *s, int offset, in=
t size)
     offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
     offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
=20
-    blk_pwrite(s->blk, offset, s->storage + offset,
-               offset_end - offset, 0);
+    ret =3D blk_pwrite(s->blk, offset, s->storage + offset,
+                     offset_end - offset, 0);
+    if (ret < 0) {
+        error_report("Could not update PNOR: %s", strerror(-ret));
+    }
 }
=20
 static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
--=20
2.24.1


