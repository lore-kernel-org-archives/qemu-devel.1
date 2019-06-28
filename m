Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E482C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A431208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A431208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnYH-00047J-DZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hgnXU-0003OQ-5p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hgnXT-0000BW-0D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hgnXS-00009S-Je
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:51:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FE712F8BEC;
 Fri, 28 Jun 2019 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-191.sin2.redhat.com
 [10.67.116.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 598E05B693;
 Fri, 28 Jun 2019 09:51:18 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Qemu Developers <qemu-devel@nongnu.org>
Date: Fri, 28 Jun 2019 15:19:01 +0530
Message-Id: <20190628094901.13347-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 28 Jun 2019 09:51:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qemu-bridge-helper: restrict bridge name to
 IFNAMSIZ
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
 "Daniel P . Berrange" <berrange@redhat.com>,
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
issue. Restrict bridge name to IFNAMSIZ, including null byte.

Reported-by: Riccardo Schirone <rschiron@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qemu-bridge-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index f9940deefd..2eca8c5cc4 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -246,7 +246,7 @@ int main(int argc, char **argv)
         if (strcmp(argv[index], "--use-vnet") =3D=3D 0) {
             use_vnet =3D 1;
         } else if (strncmp(argv[index], "--br=3D", 5) =3D=3D 0) {
-            bridge =3D &argv[index][5];
+            bridge =3D strndup(&argv[index][5], IFNAMSIZ - 1);
         } else if (strncmp(argv[index], "--fd=3D", 5) =3D=3D 0) {
             unixfd =3D atoi(&argv[index][5]);
         } else {
--=20
2.21.0


