Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8B62086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8B62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL73-0007Oj-DG
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpj-0000pL-TE
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpi-0004Uu-N1
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpg-0004SF-Fa; Fri, 20 Sep 2019 11:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8ED03082E10;
 Fri, 20 Sep 2019 15:28:27 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5244D60606;
 Fri, 20 Sep 2019 15:28:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 09/22] quorum: Add QuorumChild.to_be_replaced
Date: Fri, 20 Sep 2019 17:27:51 +0200
Message-Id: <20190920152804.12875-10-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 20 Sep 2019 15:28:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
index cf2171cc74..207054a64e 100644
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
@@ -1128,6 +1135,16 @@ static void quorum_child_perm(BlockDriverState *bs=
, BdrvChild *c,
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
@@ -1137,6 +1154,12 @@ static void quorum_child_perm(BlockDriverState *bs=
, BdrvChild *c,
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
2.21.0


