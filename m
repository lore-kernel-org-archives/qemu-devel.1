Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F270FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD427208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD427208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhym-0001zE-1L
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:41:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoP-0001sI-3O
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoH-0002Bq-7h
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVho2-00017U-L5; Tue, 28 May 2019 15:30:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C8CF300CA9A;
	Tue, 28 May 2019 19:29:42 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3087A60C47;
	Tue, 28 May 2019 19:29:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:44 +0200
Message-Id: <20190528192847.2730-19-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:29:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/21] qemu-img: rebase: Reuse in-chain
 BlockDriverState
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

If a chain was detected, don't open a new BlockBackend from the target
backing file which will create a new BlockDriverState. Instead, create
an empty BlockBackend and attach the already open BlockDriverState.

Permissions for blk_new() were copied from blk_new_open() when
flags =3D 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190523163337.4497-4-shmuel.eiderman@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2d96a491e2..b0535919b1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3358,16 +3358,29 @@ static int img_rebase(int argc, char **argv)
              * in its chain.
              */
             prefix_chain_bs =3D bdrv_find_backing_image(bs, out_real_pat=
h);
-
-            blk_new_backing =3D blk_new_open(out_real_path, NULL,
-                                           options, src_flags, &local_er=
r);
-            g_free(out_real_path);
-            if (!blk_new_backing) {
-                error_reportf_err(local_err,
-                                  "Could not open new backing file '%s':=
 ",
-                                  out_baseimg);
-                ret =3D -1;
-                goto out;
+            if (prefix_chain_bs) {
+                g_free(out_real_path);
+                blk_new_backing =3D blk_new(BLK_PERM_CONSISTENT_READ,
+                                          BLK_PERM_ALL);
+                ret =3D blk_insert_bs(blk_new_backing, prefix_chain_bs,
+                                    &local_err);
+                if (ret < 0) {
+                    error_reportf_err(local_err,
+                                      "Could not reuse backing file '%s'=
: ",
+                                      out_baseimg);
+                    goto out;
+                }
+            } else {
+                blk_new_backing =3D blk_new_open(out_real_path, NULL,
+                                               options, src_flags, &loca=
l_err);
+                g_free(out_real_path);
+                if (!blk_new_backing) {
+                    error_reportf_err(local_err,
+                                      "Could not open new backing file '=
%s': ",
+                                      out_baseimg);
+                    ret =3D -1;
+                    goto out;
+                }
             }
         }
     }
--=20
2.21.0


