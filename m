Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F524C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA7520708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLFbjOyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA7520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHlM-0002IS-8x
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcT-0004sY-CS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcS-00044o-BI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcS-00044C-82
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oPtPL8zf9tJoCJa4teoozK5YutntkpEjfe0LxqwwmU=;
 b=TLFbjOyDbxh3aZ8swKrdBGjno2rRmH+lAsL6kyaXMvOx3sIY9R+pFwtqnaDIKAlJqnLLKS
 dYIp2kDS6VddWLnXK7UiwdRI33jCEt+Emdx15WjEPXSi+6MBUoH4cuMsOrG0aSEadBCy5M
 Dd8RGs4KMGcsQSVzqBjsw9hUIWJFO3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-Rz-x4JnINymMcem07Z0-2A-1; Thu, 30 Jan 2020 16:44:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10F27341D;
 Thu, 30 Jan 2020 21:44:54 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1B060BE1;
 Thu, 30 Jan 2020 21:44:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Date: Thu, 30 Jan 2020 22:44:19 +0100
Message-Id: <20200130214431.333510-10-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Rz-x4JnINymMcem07Z0-2A-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this to verify that Quorum can let one of its children be
replaced without breaking anything else.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 59cd524502..6a7224c9e4 100644
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
@@ -1128,6 +1135,18 @@ static void quorum_child_perm(BlockDriverState *bs, =
BdrvChild *c,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
 {
+    BDRVQuorumState *s =3D bs->opaque;
+    int child_i =3D -1;
+
+    if (c) {
+        for (child_i =3D 0; child_i < s->num_children; child_i++) {
+            if (s->children[child_i].child =3D=3D c) {
+                break;
+            }
+        }
+        assert(child_i < s->num_children);
+    }
+
     *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
=20
     /*
@@ -1137,6 +1156,12 @@ static void quorum_child_perm(BlockDriverState *bs, =
BdrvChild *c,
     *nshared =3D (shared & (BLK_PERM_CONSISTENT_READ |
                           BLK_PERM_WRITE_UNCHANGED))
              | DEFAULT_PERM_UNCHANGED;
+
+    if (child_i >=3D 0 && s->children[child_i].to_be_replaced) {
+        /* Prepare for sudden data changes */
+        *nperm |=3D BLK_PERM_WRITE;
+        *nshared &=3D ~BLK_PERM_CONSISTENT_READ;
+    }
 }
=20
 static const char *const quorum_strong_runtime_opts[] =3D {
--=20
2.24.1


