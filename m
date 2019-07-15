Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F1C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B090320868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1zk-0008LA-IL
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn1zC-0006ae-Pd
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn1zA-0006Bp-P9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn1z8-0006Aa-DO; Mon, 15 Jul 2019 10:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B52ABC057F2B;
 Mon, 15 Jul 2019 14:29:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F4F65F74;
 Mon, 15 Jul 2019 14:29:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 16:29:05 +0200
Message-Id: <20190715142905.9078-12-mreitz@redhat.com>
In-Reply-To: <20190715142905.9078-1-mreitz@redhat.com>
References: <20190715142905.9078-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 14:29:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/11] gluster: fix .bdrv_reopen_prepare when
 backing file is a JSON object
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

When the backing_file is specified as a JSON object, the
qemu_gluster_reopen_prepare() fails with this message:
    invalid URI json:{"server.0.host": ...}

In this case, we should call qemu_gluster_init() using the QDict
'state->options' that contains the JSON parameters already parsed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1542445
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20190715132844.506584-1-sgarzare@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/gluster.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/gluster.c b/block/gluster.c
index 62f8ff2147..f64dc5b01e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -931,7 +931,17 @@ static int qemu_gluster_reopen_prepare(BDRVReopenSta=
te *state,
     gconf->has_debug =3D true;
     gconf->logfile =3D g_strdup(s->logfile);
     gconf->has_logfile =3D true;
-    reop_s->glfs =3D qemu_gluster_init(gconf, state->bs->filename, NULL,=
 errp);
+
+    /*
+     * If 'state->bs->exact_filename' is empty, 'state->options' should =
contain
+     * the JSON parameters already parsed.
+     */
+    if (state->bs->exact_filename[0] !=3D '\0') {
+        reop_s->glfs =3D qemu_gluster_init(gconf, state->bs->exact_filen=
ame, NULL,
+                                         errp);
+    } else {
+        reop_s->glfs =3D qemu_gluster_init(gconf, NULL, state->options, =
errp);
+    }
     if (reop_s->glfs =3D=3D NULL) {
         ret =3D -errno;
         goto exit;
--=20
2.21.0


