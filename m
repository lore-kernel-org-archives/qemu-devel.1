Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCEAC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42DB21926
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gICME5ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42DB21926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq38n-0008Su-Sq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38Q-0007PR-Dq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38P-0001Do-9c
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38P-0001Bd-1e; Tue, 23 Jul 2019 18:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563920389; x=1595456389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=boA+Z2tHFjiw8PC+GjVyKRaSk8JwNJ8dEkm+i6cC7Zo=;
 b=gICME5owkw77mjNa8K56JljzGFUyhUSHU/2op80yo5Z0RUIoFrNYuf74
 ddWQodArBn+TPiAj10haavtitRQyfQXHVtk3yDt2LKoQ8fXKIjgCvIT5r
 +XKVVkWoiOpRj46zvFLFPz7R0seRwySu0nTTMMz+HoVrxOT8EDBqvXDxs
 oYYWLSEff4XrqYkpTz1/r7rrZtnMURRw/gzERaI84i4Etwh2NxH72EeJ4
 0ofsN/OTBqUvZJNnyI/DnozADRCF/5oiUCMHT1E6YFyC5JAlrh8M/UuF2
 N/fVAWwQRsym7E3k4Nw1Y74fFnhO6bzY0WlSgx6glfBl6O2blIc0iIzCz w==;
IronPort-SDR: 2ha2nUzZGfVXBoYhSAsfgBGRdVKDNy/K4l0KNcldSfvLqX/10v5amggqa9q9NR/3jRbsOdSnCu
 kERAA84Q5FbB7i4WanQxagFqXOXD5x2HTlKVnvZEg5aCiRfOfTUWsp6TlfZwbsNb87HfsjnpeT
 3k9w8ZOVlgl4dPko+cSa2BQWjGDShvJr34QPTJNiXD2AUtBhAAMLxUzAkUF326P+FyZwQRsHZi
 L0XbwhasiK/yHWXflookHB+tqoTU9Wu/IeaZM4kc/srSltnPm2QGe5y5+q8VOcgMvHhsBJyLX6
 wh8=
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; d="scan'208";a="113843264"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2019 06:19:47 +0800
IronPort-SDR: 2A6z9/afXMcW6QFiLtA/XFaX+JchohENtMrJoojwaJ6IVrF7HwHfgAg1qxVN6gR9AxTYOGhk6e
 CyW0pYwnu0yCm469mpU7fWBtYiS/Hzs3spid4iIp8yPHTjXoOwi2nAx/ojqGX1T5n8zSBNgkVQ
 PZHyX1zSbu43PMlv05/72L32rreZvMdR7Okx8bo5XJcLd/VJDjcKtrHt18542DAmR1fO8Tf7W/
 6tczpgG/sQibLH/DpBerqVeoxXBFUt/85r/AdFy8TaooRephn+jmAt2ajdfRizo3FcFKpU8IEX
 D94ldi38+O1UYf5UiO5cBsiu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 15:18:00 -0700
IronPort-SDR: qNuqHMHbi12Ei4mSu0vG/YGmo8TpWcFu9yIBFPaVHw9z9DBkxYawjdSIydkSOjBWfwPE894rtF
 f+EW3LO/rZUxEt6jA1AuEHJrDl243tSXBKNESNOzUGcHfp8jPQTaKN6AbQc8JkZXMbEwsyJzsb
 caL4C70wC1QhsAaXHd/C/Dd/6g0P+TiFqhruzqO/ApifgZtCJ80IjDy3V+M44J5O6KKt9bqckj
 SzHN4p2huXap5LTycE1Ur62lav/jsR42HvbozermSUAqVr03TewGl9Y4eBdt7KQCCRSvjKjhx2
 pCI=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 15:19:46 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Jul 2019 18:19:40 -0400
Message-Id: <20190723221940.25585-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
References: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v3 4/4] raw: Don't open ZBDs if backend can't
 handle them
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Abort opening a zoned device as a raw file in case the chosen
block backend driver lacks proper support for this type of
storage.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index e307cab7a4..507dba98c5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2870,6 +2870,20 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
             goto fail;
         }
     }
+
+    /*
+     * If we are opening a zoned block device, check if the backend
+     * driver can properly handle such devices, abort if not.
+     */
+    if (bdrv_is_zoned(bs) &&
+        (shared & BLK_PERM_SUPPORT_ZONED) &&
+        !(perm & BLK_PERM_SUPPORT_ZONED)) {
+        error_setg(errp,
+                   "block backend driver doesn't support HM zoned devices");
+        ret = -ENOTSUP;
+        goto fail;
+    }
+
     return 0;
 
 fail:
-- 
2.21.0


