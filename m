Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C02C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED5B213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5B213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsRd-0002o9-MC
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hhsLW-00055w-Af
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hhsLU-0007kY-QD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hhsLU-0007VH-Kp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:11:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 262BB13A41;
 Mon,  1 Jul 2019 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.33.36.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558AF17502;
 Mon,  1 Jul 2019 09:11:12 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Qemu Developers <qemu-devel@nongnu.org>
Date: Mon,  1 Jul 2019 14:39:02 +0530
Message-Id: <20190701090904.31312-2-ppandit@redhat.com>
In-Reply-To: <20190701090904.31312-1-ppandit@redhat.com>
References: <20190701090904.31312-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 01 Jul 2019 09:11:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-bridge-helper: restrict interface
 name to IFNAMSIZ
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

The interface names in qemu-bridge-helper are defined to be
of size IFNAMSIZ(=3D16), including the terminating null('\0') byte.
The same is applied to interface names read from 'bridge.conf'
file to form ACLs rules. If user supplied '--br=3Dbridge' name
is not restricted to the same length, it could lead to ACL bypass
issue. Restrict interface name to IFNAMSIZ, including null byte.

Reported-by: Riccardo Schirone <rschiron@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qemu-bridge-helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

Update v2: report an error and exit
  -> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06239.html

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index f9940deefd..8ec0a65174 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -109,6 +109,13 @@ static int parse_acl_file(const char *filename, ACLL=
ist *acl_list)
         }
         *argend =3D 0;
=20
+        if (strcmp(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
+            fprintf(stderr, "name `%s' too long: %lu\n", arg, strlen(arg=
));
+            fclose(f);
+            errno =3D EINVAL;
+            return -1;
+        }
+
         if (strcmp(cmd, "deny") =3D=3D 0) {
             acl_rule =3D g_malloc(sizeof(*acl_rule));
             if (strcmp(arg, "all") =3D=3D 0) {
@@ -259,6 +266,10 @@ int main(int argc, char **argv)
         usage();
         return EXIT_FAILURE;
     }
+    if (strlen(bridge) >=3D IFNAMSIZ) {
+        fprintf(stderr, "name `%s' too long: %lu\n", bridge, strlen(brid=
ge));
+        return EXIT_FAILURE;
+    }
=20
     /* parse default acl file */
     QSIMPLEQ_INIT(&acl_list);
--=20
2.21.0


