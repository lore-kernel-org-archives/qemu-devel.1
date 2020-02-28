Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF87C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260A924699
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOqADu2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260A924699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7h9i-0006jk-Bg
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1j7h8b-00066K-1J
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1j7h8V-0000D4-Hc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:01:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1j7h8V-0000Cj-Dp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582902067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lF7dFytZabe/LSqujU7qyGMtLhtI8F7FfsAnHdFPzUQ=;
 b=iOqADu2hHrm8HTC03m/ptlLmuUeBdj6ImFj6PqmzLNBQzPU3Uh0Msn/XywfC3RO57DKDOe
 Za6IjdEWaiRMkVTKsmCRx3JCq8M+IaYcbow7rheYeFiOUNjgrsKdTS2X8sxN5IR+0gk9R4
 RP8kOF1u/B4jXOJVKHdi/oxKDgpbGqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-bD-JyW1pNKmqxrrLWBWh9g-1; Fri, 28 Feb 2020 10:01:05 -0500
X-MC-Unique: bD-JyW1pNKmqxrrLWBWh9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238BB1005512;
 Fri, 28 Feb 2020 15:01:04 +0000 (UTC)
Received: from turbo.com (unknown [10.36.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82C7460C18;
 Fri, 28 Feb 2020 15:01:02 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scsi/qemu-pr-helper: Fix out-of-bounds access to
 trnptid_list[]
Date: Fri, 28 Feb 2020 16:00:59 +0100
Message-Id: <20200228150059.2644362-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

The fix is to replace `paramp` with an anonymous struct that adds
additional space for the data, called `trnptid_list_storage`.
That space provides MATH_MX_TIDS entries, and is not accessed directly
but through a pointer to `descr.trnptid_list`, in the unlikely case a
future compiler inserts some padding between the two structs.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 scsi/qemu-pr-helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0659ceef09..01013221b3 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -421,7 +421,12 @@ static int multipath_pr_out(int fd, const uint8_t *cdb=
, uint8_t *sense,
     int rq_servact =3D cdb[1];
     int rq_scope =3D cdb[2] >> 4;
     int rq_type =3D cdb[2] & 0xf;
-    struct prout_param_descriptor paramp;
+    struct
+    {
+        struct prout_param_descriptor descr;
+        struct transportid *trnptid_list_storage[MPATH_MX_TIDS];
+    } paramp;
+    struct transportid **trnptid_list =3D paramp.descr.trnptid_list;
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
=20
@@ -455,9 +460,9 @@ static int multipath_pr_out(int fd, const uint8_t *cdb,=
 uint8_t *sense,
      * do the opposite).
      */
     memset(&paramp, 0, sizeof(paramp));
-    memcpy(&paramp.key, &param[0], 8);
-    memcpy(&paramp.sa_key, &param[8], 8);
-    paramp.sa_flags =3D param[20];
+    memcpy(&paramp.descr.key, &param[0], 8);
+    memcpy(&paramp.descr.sa_key, &param[8], 8);
+    paramp.descr.sa_flags =3D param[20];
     if (sz > PR_OUT_FIXED_PARAM_SIZE) {
         size_t transportid_len;
         int i, j;
@@ -520,12 +525,13 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
                 return CHECK_CONDITION;
             }
=20
-            paramp.trnptid_list[paramp.num_transportid++] =3D id;
+            assert(paramp.descr.num_transportid < MPATH_MX_TIDS);
+            trnptid_list[paramp.descr.num_transportid++] =3D id;
         }
     }
=20
     r =3D mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
-                                     &paramp, noisy, verbose);
+                                     &paramp.descr, noisy, verbose);
     return mpath_reconstruct_sense(fd, r, sense);
 }
 #endif
--=20
2.25.1


