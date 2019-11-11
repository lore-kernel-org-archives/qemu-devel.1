Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937DDC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C69021783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD85oIqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C69021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCO7-0000ie-RA
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9h-0008Ai-P1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9g-0002si-KT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9e-0002rz-EQ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vLRvKZ0AqOa77gWXnx/Um95rM/5mkSjRqxXXTMITcs=;
 b=VD85oIqrcyxA76keAWRZHmSvQ0d/ba/auoz9+Pq8NngUBebXZgcuS/mWjlxxQZcqBnqpyO
 0Ls5g0ayFk/UR+BTKhsLrtRstBLO0invWHN7d59OSXO5lkddHXoWtPYPRB4sOFOdbA1QAL
 tOJSHTc6xZ7R5oyAW169rWPQx3l8UnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-gEuF1lAONZGSKdPwyTZuHA-1; Mon, 11 Nov 2019 11:03:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AAB71800D63;
 Mon, 11 Nov 2019 16:02:59 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88BE1600CC;
 Mon, 11 Nov 2019 16:02:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 13/23] mirror: Double-check immediately before
 replacing
Date: Mon, 11 Nov 2019 17:02:06 +0100
Message-Id: <20191111160216.197086-14-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gEuF1lAONZGSKdPwyTZuHA-1
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

There is no guarantee that we can still replace the node we want to
replace at the end of the mirror job.  Double-check by calling
bdrv_recurse_can_replace().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index f0f2d9dff1..68a4404666 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -695,7 +695,19 @@ static int mirror_exit_common(Job *job)
          * drain potential other users of the BDS before changing the grap=
h. */
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
+            error_setg(&local_err, "Can no longer replace '%s' by '%s', "
+                       "because it can no longer be guaranteed that doing =
so "
+                       "would not lead to an abrupt change of visible data=
",
+                       to_replace->node_name, target_bs->node_name);
+        }
         bdrv_drained_end(target_bs);
         if (local_err) {
             error_report_err(local_err);
--=20
2.23.0


