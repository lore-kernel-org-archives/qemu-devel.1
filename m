Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A57AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529662067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529662067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn12L-0000cP-Ju
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hn12B-00008y-2U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hn129-0008SI-Vr
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>)
 id 1hn127-0008QP-Jj; Mon, 15 Jul 2019 09:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0A73C057F30;
 Mon, 15 Jul 2019 13:28:46 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41AA06012C;
 Mon, 15 Jul 2019 13:28:44 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:28:44 +0200
Message-Id: <20190715132844.506584-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 13:28:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] gluster: fix .bdrv_reopen_prepare when
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the backing_file is specified as a JSON object, the
qemu_gluster_reopen_prepare() fails with this message:
    invalid URI json:{"server.0.host": ...}

In this case, we should call qemu_gluster_init() using the QDict
'state->options' that contains the JSON parameters already parsed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1542445
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
    - check if 'state->bs->exact_filename' is empty, instead to parse
      'state->bs->filename' to check if it contains "json:" [Max]
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
2.20.1


