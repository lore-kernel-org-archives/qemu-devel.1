Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F165217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F165217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgay-0005As-26
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqgaV-0003bH-Eo
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqgaT-0003vm-Av
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqgaQ-0003ra-53; Thu, 25 Jul 2019 12:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EED830917AF;
 Thu, 25 Jul 2019 16:27:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-146.ams2.redhat.com
 [10.36.117.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B928E5D71A;
 Thu, 25 Jul 2019 16:27:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:27:03 +0200
Message-Id: <20190725162704.12622-4-kwolf@redhat.com>
In-Reply-To: <20190725162704.12622-1-kwolf@redhat.com>
References: <20190725162704.12622-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 25 Jul 2019 16:27:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] mirror: Keep target drained until graph
 changes are done
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling bdrv_drained_end() for target_bs can restarts requests too
early, so that they would execute on mirror_top_bs, which however has
already dropped all permissions.

Keep the target node drained until all graph changes have completed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 8cb75fb409..7483051f8d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -644,6 +644,11 @@ static int mirror_exit_common(Job *job)
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
=20
+    /* The mirror job has no requests in flight any more, but we need to
+     * drain potential other users of the BDS before changing the graph.=
 */
+    assert(s->in_drain);
+    bdrv_drained_begin(target_bs);
+
     /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
      * inserting target_bs at s->to_replace, where we might not be able =
to get
      * these permissions.
@@ -684,12 +689,7 @@ static int mirror_exit_common(Job *job)
             bdrv_reopen_set_read_only(target_bs, ro, NULL);
         }
=20
-        /* The mirror job has no requests in flight any more, but we nee=
d to
-         * drain potential other users of the BDS before changing the gr=
aph. */
-        assert(s->in_drain);
-        bdrv_drained_begin(target_bs);
         bdrv_replace_node(to_replace, target_bs, &local_err);
-        bdrv_drained_end(target_bs);
         if (local_err) {
             error_report_err(local_err);
             ret =3D -EPERM;
@@ -704,7 +704,6 @@ static int mirror_exit_common(Job *job)
         aio_context_release(replace_aio_context);
     }
     g_free(s->replaces);
-    bdrv_unref(target_bs);
=20
     /*
      * Remove the mirror filter driver from the graph. Before this, get =
rid of
@@ -724,9 +723,12 @@ static int mirror_exit_common(Job *job)
     bs_opaque->job =3D NULL;
=20
     bdrv_drained_end(src);
+    bdrv_drained_end(target_bs);
+
     s->in_drain =3D false;
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
+    bdrv_unref(target_bs);
=20
     return ret;
 }
--=20
2.20.1


