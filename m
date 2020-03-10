Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDAC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0073C24655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYaDksYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0073C24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdFD-0005Cz-6r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDj-0003D2-BO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDh-0008KC-EK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDg-0008HE-0v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4PbVj5xMlkqK+kn4NuY73/Y3URpFPXVaHBSpTgqM98=;
 b=PYaDksYAELgy8zCHZ1aZsP2VEDngS8c+UGwuAIoVzPTbm0r9d1K7zmvFHeFKhe6wb6z9qE
 Dt5+j7S0SaIkPq4NUcpbu7moGvN19hDnLn1CumDtFgq+GrCcNPYw+kefFzDZVDKfb8Gd4K
 Tx261azdwa6pFtCjY7TxkS9WGRvYhDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2qwaqT7NPruAFOzOFqYYEg-1; Tue, 10 Mar 2020 07:38:41 -0400
X-MC-Unique: 2qwaqT7NPruAFOzOFqYYEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BAB0801E53;
 Tue, 10 Mar 2020 11:38:40 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AECA87B2F;
 Tue, 10 Mar 2020 11:38:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/7] block: Make bdrv_get_cumulative_perm() public
Date: Tue, 10 Mar 2020 12:38:25 +0100
Message-Id: <20200310113831.27293-2-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 3 +++
 block.c                   | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index f422c0bff0..71164c4ee1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1226,6 +1226,9 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *c=
hild_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
=20
+void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
+                              uint64_t *shared_perm);
+
 /**
  * Sets a BdrvChild's permissions.  Avoid if the parent is a BDS; use
  * bdrv_child_refresh_perms() instead and make the parent's
diff --git a/block.c b/block.c
index 957630b1c5..79a5a2770f 100644
--- a/block.c
+++ b/block.c
@@ -1872,8 +1872,6 @@ static int bdrv_child_check_perm(BdrvChild *c, BlockR=
eopenQueue *q,
                                  bool *tighten_restrictions, Error **errp)=
;
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shar=
ed);
-static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
-                                     uint64_t *shared_perm);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -2097,8 +2095,8 @@ static void bdrv_set_perm(BlockDriverState *bs, uint6=
4_t cumulative_perms,
     }
 }
=20
-static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
-                                     uint64_t *shared_perm)
+void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
+                              uint64_t *shared_perm)
 {
     BdrvChild *c;
     uint64_t cumulative_perms =3D 0;
--=20
2.20.1


