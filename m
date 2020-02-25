Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A7C35E03
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E189120658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hH9gCBc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E189120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bGO-0004OF-1m
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6bFR-0002qC-RP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6bFO-0008CR-56
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6bFN-0008AG-Tq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582641100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRTsAP4sEyii5NTzDPqB0L9DG+RxCVYCepurkg2rPhc=;
 b=hH9gCBc0pXyH847/sDj83JiHrcqClvEzo1Pz0Uha5jD7Do3hrHQkpNmCPWQxxy/6sdNFDQ
 Rs9UDs7vgvMVeGrFX2fIrJMViyCtm2AM+L0iW/d+kmdEWBt51jrU9LPOJ1zfbJd+XA9S5b
 BnGflJfNCwWOdY24+8rEts3NdtYBsc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-fIrDQ02ZOrGsqlp1Y4L0ow-1; Tue, 25 Feb 2020 09:31:35 -0500
X-MC-Unique: fIrDQ02ZOrGsqlp1Y4L0ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1C7107ACCA;
 Tue, 25 Feb 2020 14:31:34 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 283B9385;
 Tue, 25 Feb 2020 14:31:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] qcow2: Fix alloc_cluster_abort() for pre-existing clusters
Date: Tue, 25 Feb 2020 15:31:28 +0100
Message-Id: <20200225143130.111267-2-mreitz@redhat.com>
In-Reply-To: <20200225143130.111267-1-mreitz@redhat.com>
References: <20200225143130.111267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

handle_alloc() reuses preallocated zero clusters.  If anything goes
wrong during the data write, we do not change their L2 entry, so we
must not let qcow2_alloc_cluster_abort() free them.

Fixes: 8b24cd141549b5b264baeddd4e72902cfb5de23b
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.24.1


