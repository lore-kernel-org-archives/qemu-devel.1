Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03118C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFCE2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFCE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPBu-0002KO-OI
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoPAR-0004OV-PL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoPAQ-0006II-Mb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoPAO-0006Gf-Hs; Fri, 19 Jul 2019 05:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBEA530832D3;
 Fri, 19 Jul 2019 09:27:03 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F051660BE5;
 Fri, 19 Jul 2019 09:27:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:16 +0200
Message-Id: <20190719092618.24891-9-mreitz@redhat.com>
In-Reply-To: <20190719092618.24891-1-mreitz@redhat.com>
References: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 19 Jul 2019 09:27:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 08/10] block: Loop unsafely in
 bdrv*drained_end()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The graph must not change in these loops (or a QLIST_FOREACH_SAFE would
not even be enough).  We now ensure this by only polling once in the
root bdrv_drained_end() call, so we can drop the _SAFE suffix.  Doing so
makes it clear that the graph must not change.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 8f23cab82e..b89e155d21 100644
--- a/block/io.c
+++ b/block/io.c
@@ -76,9 +76,9 @@ static void bdrv_parent_drained_end(BlockDriverState *b=
s, BdrvChild *ignore,
                                     bool ignore_bds_parents,
                                     int *drained_end_counter)
 {
-    BdrvChild *c, *next;
+    BdrvChild *c;
=20
-    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
         if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
@@ -456,7 +456,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs,=
 bool recursive,
                                 BdrvChild *parent, bool ignore_bds_paren=
ts,
                                 int *drained_end_counter)
 {
-    BdrvChild *child, *next;
+    BdrvChild *child;
     int old_quiesce_counter;
=20
     assert(drained_end_counter !=3D NULL);
@@ -481,7 +481,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs,=
 bool recursive,
     if (recursive) {
         assert(!ignore_bds_parents);
         bs->recursive_quiesce_counter--;
-        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+        QLIST_FOREACH(child, &bs->children, next) {
             bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts,
                                 drained_end_counter);
         }
--=20
2.21.0


