Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24196C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19E2217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19E2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTAHZ-0000i5-4P
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 15:18:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTAFv-0007v1-94
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTAFu-0000DV-BM
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:16:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTAFr-0000B6-Nt; Tue, 21 May 2019 15:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71C3F5D61C;
	Tue, 21 May 2019 19:16:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-63.ams2.redhat.com [10.36.117.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 613DC6013B;
	Tue, 21 May 2019 19:16:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 21 May 2019 21:16:37 +0200
Message-Id: <20190521191638.32713-2-kwolf@redhat.com>
In-Reply-To: <20190521191638.32713-1-kwolf@redhat.com>
References: <20190521191638.32713-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 21 May 2019 19:16:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] block: Drain source node in
 bdrv_replace_node()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of just asserting that no requests are in flight in
bdrv_replace_node(), which is a requirement that most callers ignore, we
can just drain the source node right there. This fixes at least starting
a commit job while I/O is active on the backing chain, but probably
other callers, too.

Having requests in flight on the target node isn't a problem because the
target just gets new parents, but the call path of running requests
isn't modified. So we can just drop this assertion without a replacement.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1711643
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index cb11537029..75f370dbba 100644
--- a/block.c
+++ b/block.c
@@ -4021,13 +4021,13 @@ void bdrv_replace_node(BlockDriverState *from, Bl=
ockDriverState *to,
     uint64_t perm =3D 0, shared =3D BLK_PERM_ALL;
     int ret;
=20
-    assert(!atomic_read(&from->in_flight));
-    assert(!atomic_read(&to->in_flight));
-
     /* Make sure that @from doesn't go away until we have successfully a=
ttached
      * all of its parents to @to. */
     bdrv_ref(from);
=20
+    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context())=
;
+    bdrv_drained_begin(from);
+
     /* Put all parents into @list and calculate their cumulative permiss=
ions */
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
         assert(c->bs =3D=3D from);
@@ -4068,6 +4068,7 @@ void bdrv_replace_node(BlockDriverState *from, Bloc=
kDriverState *to,
=20
 out:
     g_slist_free(list);
+    bdrv_drained_end(from);
     bdrv_unref(from);
 }
=20
--=20
2.20.1


