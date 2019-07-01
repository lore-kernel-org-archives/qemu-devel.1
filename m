Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F6C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F404B2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F404B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsNH-0007Fd-6r
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hhsLg-0005RD-SC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hhsLf-0007yG-TU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hhsLf-0007cA-L4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4A92308FB82;
 Mon,  1 Jul 2019 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.33.36.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D96F417502;
 Mon,  1 Jul 2019 09:11:15 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Qemu Developers <qemu-devel@nongnu.org>
Date: Mon,  1 Jul 2019 14:39:03 +0530
Message-Id: <20190701090904.31312-3-ppandit@redhat.com>
In-Reply-To: <20190701090904.31312-1-ppandit@redhat.com>
References: <20190701090904.31312-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 01 Jul 2019 09:11:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-bridge-helper: move repeating code
 in parse_acl_file
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
Cc: Riccardo Schirone <rschiron@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Move repeating error handling sequence in parse_acl_file routine
to an 'err' label.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qemu-bridge-helper.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 8ec0a65174..da647de38f 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -92,9 +92,7 @@ static int parse_acl_file(const char *filename, ACLList=
 *acl_list)
=20
         if (arg =3D=3D NULL) {
             fprintf(stderr, "Invalid config line:\n  %s\n", line);
-            fclose(f);
-            errno =3D EINVAL;
-            return -1;
+            goto err;
         }
=20
         *arg =3D 0;
@@ -111,9 +109,7 @@ static int parse_acl_file(const char *filename, ACLLi=
st *acl_list)
=20
         if (strcmp(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
             fprintf(stderr, "name `%s' too long: %lu\n", arg, strlen(arg=
));
-            fclose(f);
-            errno =3D EINVAL;
-            return -1;
+            goto err;
         }
=20
         if (strcmp(cmd, "deny") =3D=3D 0) {
@@ -139,15 +135,17 @@ static int parse_acl_file(const char *filename, ACL=
List *acl_list)
             parse_acl_file(arg, acl_list);
         } else {
             fprintf(stderr, "Unknown command `%s'\n", cmd);
-            fclose(f);
-            errno =3D EINVAL;
-            return -1;
+            goto err;
         }
     }
=20
     fclose(f);
-
     return 0;
+
+err:
+    fclose(f);
+    errno =3D EINVAL;
+    return -1;
 }
=20
 static bool has_vnet_hdr(int fd)
--=20
2.21.0


