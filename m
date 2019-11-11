Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F141E20856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqGMIHGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F141E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCKk-00059L-QP
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9U-00080r-Ms
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9T-0002n2-CL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9T-0002mp-7Y
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEbi0Ur8DfgE4/ZOeodz1rU6ezfOkugTot9Q4UHBw8Y=;
 b=bqGMIHGMtsUUU8ItE+xLxu4oUhMnPe1fNxp+f3TgYRSwErJaFzbkSvj5WJZNJVfF1+u8DZ
 R0KtYXQshpftP3axJ/S+vlWyH0CQZAU5f0i2KjvBRmdTJD5qY7wPlyuC3ISvFeSvp5jMdy
 dhn8yYisIJvJ7Pnel3upVe6yDDIVeNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Die4-GB9Pl6yRNJr3PN7nw-1; Mon, 11 Nov 2019 11:02:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D90107ACC6;
 Mon, 11 Nov 2019 16:02:47 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89C374521;
 Mon, 11 Nov 2019 16:02:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 09/23] quorum: Add QuorumChild.to_be_replaced
Date: Mon, 11 Nov 2019 17:02:02 +0100
Message-Id: <20191111160216.197086-10-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Die4-GB9Pl6yRNJr3PN7nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this to verify that Quorum can let one of its children be
replaced without breaking anything else.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 59cd524502..3a824e77e3 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -67,6 +67,13 @@ typedef struct QuorumVotes {
=20
 typedef struct QuorumChild {
     BdrvChild *child;
+
+    /*
+     * If set, check whether this node can be replaced without any
+     * other parent noticing: Unshare CONSISTENT_READ, and take the
+     * WRITE permission.
+     */
+    bool to_be_replaced;
 } QuorumChild;
=20
 /* the following structure holds the state of one quorum instance */
@@ -1128,6 +1135,16 @@ static void quorum_child_perm(BlockDriverState *bs, =
BdrvChild *c,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
 {
+    BDRVQuorumState *s =3D bs->opaque;
+    int i;
+
+    for (i =3D 0; i < s->num_children; i++) {
+        if (s->children[i].child =3D=3D c) {
+            break;
+        }
+    }
+    assert(!c || i < s->num_children);
+
     *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
=20
     /*
@@ -1137,6 +1154,12 @@ static void quorum_child_perm(BlockDriverState *bs, =
BdrvChild *c,
     *nshared =3D (shared & (BLK_PERM_CONSISTENT_READ |
                           BLK_PERM_WRITE_UNCHANGED))
              | DEFAULT_PERM_UNCHANGED;
+
+    if (c && s->children[i].to_be_replaced) {
+        /* Prepare for sudden data changes */
+        *nperm |=3D BLK_PERM_WRITE;
+        *nshared &=3D ~BLK_PERM_CONSISTENT_READ;
+    }
 }
=20
 static const char *const quorum_strong_runtime_opts[] =3D {
--=20
2.23.0


