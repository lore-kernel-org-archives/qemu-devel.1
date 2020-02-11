Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C1C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349AF206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtbZ643l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349AF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1SBU-00061v-8a
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 04:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j1SAO-0004X9-J0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j1SAN-0000jp-K9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j1SAN-0000jX-GI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581414555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Opj16yp/AbBRXEGUZp9SBYI352Hxez9tbxd8ID6dy0o=;
 b=UtbZ643l5KObxvBfq7S0lu5dbsCmSc+xk6ZtevoNFgrk7Vd+SbbzNVQwldmo6Y/Vjl44sn
 96fUQpVy/JbjKgApg7ttkJ01L1i7nbnvMk/F189w9mUf2croVXTVy4Ag8vzPo8wbeN6po3
 0jmqVUgz4J8bNQW0kAkGPWQ4Vhlkt94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-WOgzxcC4OeeE-Gp2PwTuJg-1; Tue, 11 Feb 2020 04:49:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 737948017DF;
 Tue, 11 Feb 2020 09:49:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-79.ams2.redhat.com [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B84B165D3;
 Tue, 11 Feb 2020 09:49:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] qcow2: Fix qcow2_alloc_cluster_abort() for external data
 file
Date: Tue, 11 Feb 2020 10:48:59 +0100
Message-Id: <20200211094900.17315-3-kwolf@redhat.com>
In-Reply-To: <20200211094900.17315-1-kwolf@redhat.com>
References: <20200211094900.17315-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WOgzxcC4OeeE-Gp2PwTuJg-1
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
Cc: kwolf@redhat.com, pbutsykin@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For external data file, cluster allocations return an offset in the data
file and are not refcounted. In this case, there is nothing to do for
qcow2_alloc_cluster_abort(). Freeing the same offset in the qcow2 file
is wrong and causes crashes in the better case or image corruption in
the worse case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8982b7b762..dc3c270226 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1015,8 +1015,11 @@ err:
 void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    qcow2_free_clusters(bs, m->alloc_offset, m->nb_clusters << s->cluster_=
bits,
-                        QCOW2_DISCARD_NEVER);
+    if (!has_data_file(bs)) {
+        qcow2_free_clusters(bs, m->alloc_offset,
+                            m->nb_clusters << s->cluster_bits,
+                            QCOW2_DISCARD_NEVER);
+    }
 }
=20
 /*
--=20
2.20.1


