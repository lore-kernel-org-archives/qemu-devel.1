Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C80C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3472465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjcyhzf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3472465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifksU-0008OQ-SK
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifkrJ-0007Ss-0N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifkrH-0003Vl-H3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:19:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifkrA-0003PE-56
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576243183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZYL7F6gvK4pRsIDqosx/JqqT5tyk+i8zgLBy3ZPN04=;
 b=fjcyhzf/BxxrEcpZLddHPuyBmWvyPK3qalr+bCcdle17qP1ivg1jiYVHWtn6Ro/LXaKSa7
 r+1RZgofrDwEE0JupjXQmiDPZQKk3i6HwDczH4OkTCm2o2J1rlb1H+S4kZh1wpDaxwbBEP
 5P9n2+gwQnXvl6/JZqziPN2ok/3nmGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-wEqf63WfMPe_sin7gSsXQw-1; Fri, 13 Dec 2019 08:19:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC6918552A8;
 Fri, 13 Dec 2019 13:19:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F3ED60C05;
 Fri, 13 Dec 2019 13:19:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, cota@braap.org,
 rkagan@virtuozzo.com
Subject: [PATCH 2/2] qsp: Use WITH_RCU_READ_LOCK_GUARD
Date: Fri, 13 Dec 2019 13:19:31 +0000
Message-Id: <20191213131931.143878-3-dgilbert@redhat.com>
In-Reply-To: <20191213131931.143878-1-dgilbert@redhat.com>
References: <20191213131931.143878-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wEqf63WfMPe_sin7gSsXQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The automatic rcu read lock maintenance works quite
nicely in this case where it previously relied on a comment to
delimit the lifetime and now has a block.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 util/qsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index 62265417fd..7d5147f1b2 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -598,7 +598,6 @@ static void qsp_ht_delete(void *p, uint32_t h, void *ht=
p)
=20
 static void qsp_mktree(GTree *tree, bool callsite_coalesce)
 {
-    QSPSnapshot *snap;
     struct qht ht, coalesce_ht;
     struct qht *htp;
=20
@@ -610,20 +609,19 @@ static void qsp_mktree(GTree *tree, bool callsite_coa=
lesce)
      * We must remain in an RCU read-side critical section until we're don=
e
      * with the snapshot.
      */
-    rcu_read_lock();
-    snap =3D atomic_rcu_read(&qsp_snapshot);
+    WITH_RCU_READ_LOCK_GUARD() {
+        QSPSnapshot *snap =3D atomic_rcu_read(&qsp_snapshot);
=20
-    /* Aggregate all results from the global hash table into a local one *=
/
-    qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
-             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
-    qht_iter(&qsp_ht, qsp_aggregate, &ht);
+        /* Aggregate all results from the global hash table into a local o=
ne */
+        qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
+                 QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+        qht_iter(&qsp_ht, qsp_aggregate, &ht);
=20
-    /* compute the difference wrt the snapshot, if any */
-    if (snap) {
-        qsp_diff(&snap->ht, &ht);
+        /* compute the difference wrt the snapshot, if any */
+        if (snap) {
+            qsp_diff(&snap->ht, &ht);
+        }
     }
-    /* done with the snapshot; RCU can reclaim it */
-    rcu_read_unlock();
=20
     htp =3D &ht;
     if (callsite_coalesce) {
--=20
2.23.0


