Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BEAC3F2CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE50220674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsocLmFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE50220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxIN-00047e-Rj
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGw-0002HX-QS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGv-0008JK-Kb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxGv-00084b-FT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfCX9xXcPSNiafrTCIlxD241Lt6uq38zwMtvTBs3n6A=;
 b=LsocLmFpGIBjboCzaiAH48FU/nO/sIumjyvhFl/QHdrwKpUi7L3O/9dXt9Rw5MBa9fGWtH
 An8VviLuXxHT1qgBPzb+toqSBikLHzgMbm3hju3NUqyQZ8sHzBmUfL9svDpLkCV1ZArU+q
 7rSDRRRBxh33lKD5N2AzakasIiowNzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-T9WO4QS-N-SInAq1uaFo6A-1; Mon, 16 Mar 2020 17:27:38 -0400
X-MC-Unique: T9WO4QS-N-SInAq1uaFo6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B631804544
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:27:35 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48EA419756;
 Mon, 16 Mar 2020 21:27:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/61] scsi/qemu-pr-helper: Fix out-of-bounds access to
 trnptid_list[]
Date: Mon, 16 Mar 2020 22:26:28 +0100
Message-Id: <1584394048-44994-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Christophe de Dinechin <dinechin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christophe de Dinechin <dinechin@redhat.com>

Compile error reported by gcc 10.0.1:

scsi/qemu-pr-helper.c: In function =E2=80=98multipath_pr_out=E2=80=99:
scsi/qemu-pr-helper.c:523:32: error: array subscript <unknown> is outside a=
rray bounds of =E2=80=98struct transportid *[0]=E2=80=99 [-Werror=3Darray-b=
ounds]
  523 |             paramp.trnptid_list[paramp.num_transportid++] =3D id;
      |             ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from scsi/qemu-pr-helper.c:36:
/usr/include/mpath_persist.h:168:22: note: while referencing =E2=80=98trnpt=
id_list=E2=80=99
  168 |  struct transportid *trnptid_list[];
      |                      ^~~~~~~~~~~~
scsi/qemu-pr-helper.c:424:35: note: defined here =E2=80=98paramp=E2=80=99
  424 |     struct prout_param_descriptor paramp;
      |                                   ^~~~~~

This highlights an actual implementation issue in function multipath_pr_out=
.
The variable paramp is declared with type `struct prout_param_descriptor`,
which is a struct terminated by an empty array in mpath_persist.h:

        struct transportid *trnptid_list[];

That empty array was filled with code that looked like that:

        trnptid_list[paramp.descr.num_transportid++] =3D id;

This is an actual out-of-bounds access.

The fix is to malloc `paramp`.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0659cee..181ed4a 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -421,10 +421,13 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
     int rq_servact =3D cdb[1];
     int rq_scope =3D cdb[2] >> 4;
     int rq_type =3D cdb[2] & 0xf;
-    struct prout_param_descriptor paramp;
+    g_autofree struct prout_param_descriptor *paramp =3D NULL;
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
=20
+    paramp =3D g_malloc0(sizeof(struct prout_param_descriptor)
+                       + sizeof(struct transportid *) * MPATH_MX_TIDS);
+
     if (sz < PR_OUT_FIXED_PARAM_SIZE) {
         /* Illegal request, Parameter list length error.  This isn't fatal=
;
          * we have read the data, send an error without closing the socket=
.
@@ -454,10 +457,9 @@ static int multipath_pr_out(int fd, const uint8_t *cdb=
, uint8_t *sense,
      * used by libmpathpersist (which, of course, will immediately
      * do the opposite).
      */
-    memset(&paramp, 0, sizeof(paramp));
-    memcpy(&paramp.key, &param[0], 8);
-    memcpy(&paramp.sa_key, &param[8], 8);
-    paramp.sa_flags =3D param[20];
+    memcpy(&paramp->key, &param[0], 8);
+    memcpy(&paramp->sa_key, &param[8], 8);
+    paramp->sa_flags =3D param[20];
     if (sz > PR_OUT_FIXED_PARAM_SIZE) {
         size_t transportid_len;
         int i, j;
@@ -520,12 +522,13 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
                 return CHECK_CONDITION;
             }
=20
-            paramp.trnptid_list[paramp.num_transportid++] =3D id;
+            assert(paramp->num_transportid < MPATH_MX_TIDS);
+            paramp->trnptid_list[paramp->num_transportid++] =3D id;
         }
     }
=20
     r =3D mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
-                                     &paramp, noisy, verbose);
+                                     paramp, noisy, verbose);
     return mpath_reconstruct_sense(fd, r, sense);
 }
 #endif
--=20
1.8.3.1



