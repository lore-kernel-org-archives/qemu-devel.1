Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA3220863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA3220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fiw-00087z-W6
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fTQ-0002re-JH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fTP-0005RR-IJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fTN-0005Qg-2L; Tue, 10 Sep 2019 08:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F1F3C04B2D5;
 Tue, 10 Sep 2019 12:42:16 +0000 (UTC)
Received: from localhost (ovpn-117-90.ams2.redhat.com [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47AAF1001948;
 Tue, 10 Sep 2019 12:42:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 14:41:36 +0200
Message-Id: <20190910124136.10565-8-mreitz@redhat.com>
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 12:42:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/7] curl: Check curl_multi_add_handle()'s
 return code
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we had done that all along, debugging would have been much simpler.
(Also, I/O errors are better than hangs.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index c343c7ed3d..f86299378e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -882,7 +882,13 @@ static void curl_setup_preadv(BlockDriverState *bs, =
CURLAIOCB *acb)
     trace_curl_setup_preadv(acb->bytes, start, state->range);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
=20
-    curl_multi_add_handle(s->multi, state->curl);
+    if (curl_multi_add_handle(s->multi, state->curl) !=3D CURLM_OK) {
+        state->acb[0] =3D NULL;
+        acb->ret =3D -EIO;
+
+        curl_clean_state(state);
+        goto out;
+    }
=20
     /* Tell curl it needs to kick things off */
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running)=
;
--=20
2.21.0


