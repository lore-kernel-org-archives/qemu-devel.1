Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C5C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7001020883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7001020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hViCB-0003s3-JA
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:55:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hViAX-0002sC-Pg
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hViAW-0003zh-Si
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hViAU-0003p4-Ot; Tue, 28 May 2019 15:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFF2A30ADC7B;
	Tue, 28 May 2019 19:53:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 883765C8A3;
	Tue, 28 May 2019 19:53:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:53:38 +0200
Message-Id: <20190528195338.12376-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 28 May 2019 19:53:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qemu-img: Fix options leakage in img_rebase()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

img_rebase() can leak a QDict in two occasions.  Fix it.

Coverity: CID 1401416
Fixes: d16699b64671466b42079c45b89127aeea1ca565
Fixes: 330c72957196e0ae382abcaa97ebf4eb9bc8574f
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index b0535919b1..86e1923acf 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3347,6 +3347,7 @@ static int img_rebase(int argc, char **argv)
                                                              out_baseimg=
,
                                                              &local_err)=
;
             if (local_err) {
+                qobject_unref(options);
                 error_reportf_err(local_err,
                                   "Could not resolve backing filename: "=
);
                 ret =3D -1;
@@ -3359,7 +3360,9 @@ static int img_rebase(int argc, char **argv)
              */
             prefix_chain_bs =3D bdrv_find_backing_image(bs, out_real_pat=
h);
             if (prefix_chain_bs) {
+                qobject_unref(options);
                 g_free(out_real_path);
+
                 blk_new_backing =3D blk_new(BLK_PERM_CONSISTENT_READ,
                                           BLK_PERM_ALL);
                 ret =3D blk_insert_bs(blk_new_backing, prefix_chain_bs,
--=20
2.21.0


