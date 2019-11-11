Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C6C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7AF2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTN3aHiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7AF2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCCY-0002UH-EL
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9a-00084x-Q1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9U-0002nd-Qb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9U-0002nN-MW
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWX2ctN6XoWefEe2vb6nKkxe1T5DYNE3IqEfaYYWvXw=;
 b=HTN3aHiVwWLxFUnU54ZRXGXO/nzVz4uqrbDQYqI2/wT6SFhVMsRtOSiXV2/aO5eCoDispr
 Mk9BKqF01RY9HeiwzkBHUvMAuRfEwLzXuPyR9pJad2S6pLfqss1WhNAdWYJ9Q4iohnS0K9
 T6CmypE+V+/ycnwIwxkBXdHxhRM5L7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-P4zVO02qNYSj50LgzzNASQ-1; Mon, 11 Nov 2019 11:02:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B47B5800C72;
 Mon, 11 Nov 2019 16:02:49 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30B42608FB;
 Mon, 11 Nov 2019 16:02:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 10/23] quorum: Implement .bdrv_recurse_can_replace()
Date: Mon, 11 Nov 2019 17:02:03 +0100
Message-Id: <20191111160216.197086-11-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: P4zVO02qNYSj50LgzzNASQ-1
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 3a824e77e3..8ee03e9baf 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(BlockDr=
iverState *bs,
     return false;
 }
=20
+static bool quorum_recurse_can_replace(BlockDriverState *bs,
+                                       BlockDriverState *to_replace)
+{
+    BDRVQuorumState *s =3D bs->opaque;
+    int i;
+
+    for (i =3D 0; i < s->num_children; i++) {
+        /*
+         * We have no idea whether our children show the same data as
+         * this node (@bs).  It is actually highly likely that
+         * @to_replace does not, because replacing a broken child is
+         * one of the main use cases here.
+         *
+         * We do know that the new BDS will match @bs, so replacing
+         * any of our children by it will be safe.  It cannot change
+         * the data this quorum node presents to its parents.
+         *
+         * However, replacing @to_replace by @bs in any of our
+         * children's chains may change visible data somewhere in
+         * there.  We therefore cannot recurse down those chains with
+         * bdrv_recurse_can_replace().
+         * (More formally, bdrv_recurse_can_replace() requires that
+         * @to_replace will be replaced by something matching the @bs
+         * passed to it.  We cannot guarantee that.)
+         *
+         * Thus, we can only check whether any of our immediate
+         * children matches @to_replace.
+         *
+         * (In the future, we might add a function to recurse down a
+         * chain that checks that nothing there cares about a change
+         * in data from the respective child in question.  For
+         * example, most filters do not care when their child's data
+         * suddenly changes, as long as their parents do not care.)
+         */
+        if (s->children[i].child->bs =3D=3D to_replace) {
+            Error *local_err =3D NULL;
+
+            /*
+             * We now have to ensure that there is no other parent
+             * that cares about replacing this child by a node with
+             * potentially different data.
+             */
+            s->children[i].to_be_replaced =3D true;
+            bdrv_child_refresh_perms(bs, s->children[i].child, &local_err)=
;
+
+            /* Revert permissions */
+            s->children[i].to_be_replaced =3D false;
+            bdrv_child_refresh_perms(bs, s->children[i].child, &error_abor=
t);
+
+            if (local_err) {
+                error_free(local_err);
+                return false;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static int quorum_valid_threshold(int threshold, int num_children, Error *=
*errp)
 {
=20
@@ -1195,6 +1256,7 @@ static BlockDriver bdrv_quorum =3D {
=20
     .is_filter                          =3D true,
     .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_fi=
lter,
+    .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
=20
     .strong_runtime_opts                =3D quorum_strong_runtime_opts,
 };
--=20
2.23.0


