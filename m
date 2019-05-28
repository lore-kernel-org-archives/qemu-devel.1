Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B3C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11FA208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11FA208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhyH-0001bA-ON
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:41:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnj-0001LM-9R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnY-0001Vo-2S
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnN-0000vt-5p; Tue, 28 May 2019 15:30:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E45A3883D7;
	Tue, 28 May 2019 19:29:34 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7844B60565;
	Tue, 28 May 2019 19:29:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:42 +0200
Message-Id: <20190528192847.2730-17-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 28 May 2019 19:29:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/21] qemu-img: rebase: Reuse parent
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

In safe mode we open the entire chain, including the parent backing
file of the rebased file.
Do not open a new BlockBackend for the parent backing file, which
saves opening the rest of the chain twice, which for long chains
saves many "pricy" bdrv_open() calls.

Permissions for blk_new() were copied from blk_new_open() when
flags =3D 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190523163337.4497-2-shmuel.eiderman@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 28fba1e7a7..9bd0bb1e47 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3309,29 +3309,18 @@ static int img_rebase(int argc, char **argv)
=20
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
-        char backing_name[PATH_MAX];
         QDict *options =3D NULL;
+        BlockDriverState *base_bs =3D backing_bs(bs);
=20
-        if (bs->backing) {
-            if (bs->backing_format[0] !=3D '\0') {
-                options =3D qdict_new();
-                qdict_put_str(options, "driver", bs->backing_format);
-            }
-
-            if (force_share) {
-                if (!options) {
-                    options =3D qdict_new();
-                }
-                qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
-            }
-            bdrv_get_backing_filename(bs, backing_name, sizeof(backing_n=
ame));
-            blk_old_backing =3D blk_new_open(backing_name, NULL,
-                                           options, src_flags, &local_er=
r);
-            if (!blk_old_backing) {
+        if (base_bs) {
+            blk_old_backing =3D blk_new(BLK_PERM_CONSISTENT_READ,
+                                      BLK_PERM_ALL);
+            ret =3D blk_insert_bs(blk_old_backing, base_bs,
+                                &local_err);
+            if (ret < 0) {
                 error_reportf_err(local_err,
-                                  "Could not open old backing file '%s':=
 ",
-                                  backing_name);
-                ret =3D -1;
+                                  "Could not reuse old backing file '%s'=
: ",
+                                  base_bs->filename);
                 goto out;
             }
         } else {
--=20
2.21.0


