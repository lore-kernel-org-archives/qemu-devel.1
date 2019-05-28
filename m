Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC9C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971BE208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971BE208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi3T-00064I-T3
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:46:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhow-0002JI-OQ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhou-0002Ya-Pe
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhoe-00017l-N7; Tue, 28 May 2019 15:31:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A7BA7EBD3;
	Tue, 28 May 2019 19:29:38 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C67DD5C8A3;
	Tue, 28 May 2019 19:29:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:43 +0200
Message-Id: <20190528192847.2730-18-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 28 May 2019 19:29:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/21] qemu-img: rebase: Reduce reads on
 in-chain rebase
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

In the following case:

(base) A <- B <- C (tip)

when running:

    qemu-img rebase -b A C

QEMU would read all sectors not allocated in the file being rebased (C)
and compare them to the new base image (A), regardless of whether they
were changed or even allocated anywhere along the chain between the new
base and the top image (B). This causes many unneeded reads when
rebasing an image which represents a small diff of a large disk, as it
would read most of the disk's sectors.

Instead, use bdrv_is_allocated_above() to reduce the number of
unnecessary reads.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-id: 20190523163337.4497-3-shmuel.eiderman@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9bd0bb1e47..2d96a491e2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3164,7 +3164,7 @@ static int img_rebase(int argc, char **argv)
     BlockBackend *blk =3D NULL, *blk_old_backing =3D NULL, *blk_new_back=
ing =3D NULL;
     uint8_t *buf_old =3D NULL;
     uint8_t *buf_new =3D NULL;
-    BlockDriverState *bs =3D NULL;
+    BlockDriverState *bs =3D NULL, *prefix_chain_bs =3D NULL;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3353,6 +3353,12 @@ static int img_rebase(int argc, char **argv)
                 goto out;
             }
=20
+            /*
+             * Find out whether we rebase an image on top of a previous =
image
+             * in its chain.
+             */
+            prefix_chain_bs =3D bdrv_find_backing_image(bs, out_real_pat=
h);
+
             blk_new_backing =3D blk_new_open(out_real_path, NULL,
                                            options, src_flags, &local_er=
r);
             g_free(out_real_path);
@@ -3437,6 +3443,23 @@ static int img_rebase(int argc, char **argv)
                 continue;
             }
=20
+            if (prefix_chain_bs) {
+                /*
+                 * If cluster wasn't changed since prefix_chain, we don'=
t need
+                 * to take action
+                 */
+                ret =3D bdrv_is_allocated_above(backing_bs(bs), prefix_c=
hain_bs,
+                                              offset, n, &n);
+                if (ret < 0) {
+                    error_report("error while reading image metadata: %s=
",
+                                 strerror(-ret));
+                    goto out;
+                }
+                if (!ret) {
+                    continue;
+                }
+            }
+
             /*
              * Read old and new backing file and take into consideration=
 that
              * backing files may be smaller than the COW image.
--=20
2.21.0


