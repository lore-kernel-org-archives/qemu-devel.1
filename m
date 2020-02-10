Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F73DC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BB020733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdV2nHc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BB020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Gph-0007yy-4G
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Gnt-0006EX-RC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Gns-0001V5-EO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Gns-0001Te-9S
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581370876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slx1Uc5NT50d59xWG/Bx+qVq3cAWVxFBYvTlyL2cQy8=;
 b=SdV2nHc7M1Hfj/jKFU7BJW09JXTxsYVmkmWPaL99XT/7xrq//oiZsS2iIK0DVNxtuQt6xF
 5rpfpQTxyec3lhvKPyum4vbPJoy82FGtQgu4S4n22t2zZb2XrszXCGzjL2PMod9ozF4lGg
 cOLgz1ueeu+xN9FKUzzTHV1NnhRPr1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-KOGYvyi-Oomm6Vhjv__WFw-1; Mon, 10 Feb 2020 16:41:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F86418FF665;
 Mon, 10 Feb 2020 21:41:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2285D9CA;
 Mon, 10 Feb 2020 21:41:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] nbd: Preparation for NBD_INFO_INIT_STATE
Date: Mon, 10 Feb 2020 15:41:07 -0600
Message-Id: <20200210214109.751734-2-eblake@redhat.com>
In-Reply-To: <20200210214109.751734-1-eblake@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210214109.751734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: KOGYvyi-Oomm6Vhjv__WFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Declare the constants being proposed for an NBD extension, which will
let qemu advertise/learn if an image began life with all zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt | 1 +
 include/block/nbd.h  | 9 +++++++++
 nbd/common.c         | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 45118809618e..35ba85367153 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -55,3 +55,4 @@ the operation of that feature.
 NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 * 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports,
 NBD_CMD_FLAG_FAST_ZERO
+* 5.0: NBD_INFO_INIT_STATE
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 7f46932d80f1..0de020904a37 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -200,6 +200,15 @@ enum {
 #define NBD_INFO_NAME           1
 #define NBD_INFO_DESCRIPTION    2
 #define NBD_INFO_BLOCK_SIZE     3
+#define NBD_INFO_INIT_STATE     4
+
+/* Initial state bits, when replying to NBD_INFO_INIT_STATE */
+enum {
+    NBD_INIT_SPARSE_BIT       =3D 0,
+    NBD_INIT_ZERO_BIT         =3D 1,
+};
+#define NBD_INIT_SPARSE         (1 << NBD_INIT_SPARSE_BIT)
+#define NBD_INIT_ZERO           (1 << NBD_INIT_ZERO_BIT)

 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during wri=
te */
diff --git a/nbd/common.c b/nbd/common.c
index ddfe7d118371..3e24feb0d502 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -129,6 +129,8 @@ const char *nbd_info_lookup(uint16_t info)
         return "description";
     case NBD_INFO_BLOCK_SIZE:
         return "block size";
+    case NBD_INFO_INIT_STATE:
+        return "init state";
     default:
         return "<unknown>";
     }
--=20
2.24.1


