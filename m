Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83159C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A16520882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A16520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKzF-0007yV-Tw
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKq3-00014T-QD
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKq1-0004fH-ON
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpq-0004XO-2v; Fri, 20 Sep 2019 11:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3259C8A1C92;
 Fri, 20 Sep 2019 15:28:37 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFFD45D6A7;
 Fri, 20 Sep 2019 15:28:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 13/22] mirror: Double-check immediately before replacing
Date: Fri, 20 Sep 2019 17:27:55 +0200
Message-Id: <20190920152804.12875-14-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 20 Sep 2019 15:28:37 +0000 (UTC)
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

There is no guarantee that we can still replace the node we want to
replace at the end of the mirror job.  Double-check by calling
bdrv_recurse_can_replace().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 706d80fced..d877637e1e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -695,7 +695,19 @@ static int mirror_exit_common(Job *job)
          * drain potential other users of the BDS before changing the gr=
aph. */
         assert(s->in_drain);
         bdrv_drained_begin(target_bs);
-        bdrv_replace_node(to_replace, target_bs, &local_err);
+        /*
+         * Cannot use check_to_replace_node() here, because that would
+         * check for an op blocker on @to_replace, and we have our own
+         * there.
+         */
+        if (bdrv_recurse_can_replace(src, to_replace)) {
+            bdrv_replace_node(to_replace, target_bs, &local_err);
+        } else {
+            error_setg(&local_err, "Can no longer replace '%s' by '%s', =
"
+                       "because it can no longer be guaranteed that doin=
g so "
+                       "would not lead to an abrupt change of visible da=
ta",
+                       to_replace->node_name, target_bs->node_name);
+        }
         bdrv_drained_end(target_bs);
         if (local_err) {
             error_report_err(local_err);
--=20
2.21.0


