Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D5C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EEA2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5nrDFik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EEA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGar-0006o9-JA
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ7-0004eH-Bf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ6-0006xy-1s
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZ5-0006uo-U9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKkXA2wVGMUN+3EbJfGVtOBBQkN8e1+AE5jOJzlfh7o=;
 b=I5nrDFikM4Q1HmB3+aQfYOL2V5oBLFo/bcEmI8tuAn2KXieirFvd5Fj2L2L10zSQTyy5YM
 JsDewB1L51xJ9yz64v8tqtRcXuvPs5Jmc8IO0coba06DpJ9BpZzZ07iijrJ8NWOWCTDeqL
 gzPqxxnss9V9PW+hDnXVzkFj5k/2tT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-2DpAq420Mw-QiRM6gHx4zw-1; Fri, 06 Mar 2020 12:15:08 -0500
X-MC-Unique: 2DpAq420Mw-QiRM6gHx4zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C332801E5C;
 Fri,  6 Mar 2020 17:15:07 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8407389A;
 Fri,  6 Mar 2020 17:15:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/29] qcow2: Fix alloc_cluster_abort() for pre-existing
 clusters
Date: Fri,  6 Mar 2020 18:14:30 +0100
Message-Id: <20200306171458.1848-2-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

handle_alloc() reuses preallocated zero clusters.  If anything goes
wrong during the data write, we do not change their L2 entry, so we
must not let qcow2_alloc_cluster_abort() free them.

Fixes: 8b24cd141549b5b264baeddd4e72902cfb5de23b
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225143130.111267-2-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 78c95dfa16..17f1363279 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1026,7 +1026,7 @@ err:
 void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    if (!has_data_file(bs)) {
+    if (!has_data_file(bs) && !m->keep_old_clusters) {
         qcow2_free_clusters(bs, m->alloc_offset,
                             m->nb_clusters << s->cluster_bits,
                             QCOW2_DISCARD_NEVER);
--=20
2.20.1


