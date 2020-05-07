Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79ABC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3B22070B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRu/E+qW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3B22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhw6-0000s6-Po
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWhtC-0004po-Pj
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:52:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWhtB-0005lm-9p
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588863160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zteZrZetfxSuI4Tm8i5j4aAEqLXe40ZW0OB10HLi37M=;
 b=CRu/E+qWK/QyfG6wEeJuu26oBMPfMQ7s2JmydNEQymecYriqKdPUWhjEsFmDLLUhCH361h
 pIvTmU8siXtdmVldWfeW3CC9XNPjDb6+bWykBavQ7owUjeaRdx6DwGjpESXT8cKxphrjPV
 /1Cln/6lMze+APE8SBRsWEDRWUzIJyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-QgQqMbiDPzy1u6bV8jJrPQ-1; Thu, 07 May 2020 10:52:38 -0400
X-MC-Unique: QgQqMbiDPzy1u6bV8jJrPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25EB7835B42;
 Thu,  7 May 2020 14:52:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABF84579AD;
 Thu,  7 May 2020 14:52:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] mirror: Make sure that source and target size match
Date: Thu,  7 May 2020 16:52:27 +0200
Message-Id: <20200507145228.323412-3-kwolf@redhat.com>
In-Reply-To: <20200507145228.323412-1-kwolf@redhat.com>
References: <20200507145228.323412-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the target is shorter than the source, mirror would copy data until
it reaches the end of the target and then fail with an I/O error when
trying to write past the end.

If the target is longer than the source, the mirror job would complete
successfully, but the target wouldn't actually be an accurate copy of
the source image (it would contain some additional garbage at the end).

Fix this by checking that both images have the same size when the job
starts.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index aca95c9bc9..201ffa26f9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -872,6 +872,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
     BlockDriverState *target_bs =3D blk_bs(s->target);
     bool need_drain =3D true;
     int64_t length;
+    int64_t target_length;
     BlockDriverInfo bdi;
     char backing_filename[2]; /* we only need 2 characters because we are =
only
                                  checking for a NULL string */
@@ -887,24 +888,26 @@ static int coroutine_fn mirror_run(Job *job, Error **=
errp)
         goto immediate_exit;
     }
=20
+    target_length =3D blk_getlength(s->target);
+    if (target_length < 0) {
+        ret =3D target_length;
+        goto immediate_exit;
+    }
+
     /* Active commit must resize the base image if its size differs from t=
he
      * active layer. */
     if (s->base =3D=3D blk_bs(s->target)) {
-        int64_t base_length;
-
-        base_length =3D blk_getlength(s->target);
-        if (base_length < 0) {
-            ret =3D base_length;
-            goto immediate_exit;
-        }
-
-        if (s->bdev_length > base_length) {
+        if (s->bdev_length > target_length) {
             ret =3D blk_truncate(s->target, s->bdev_length, false,
                                PREALLOC_MODE_OFF, 0, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
         }
+    } else if (s->bdev_length !=3D target_length) {
+        error_setg(errp, "Source and target image have different sizes");
+        ret =3D -EINVAL;
+        goto immediate_exit;
     }
=20
     if (s->bdev_length =3D=3D 0) {
--=20
2.25.3


