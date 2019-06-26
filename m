Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6260C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67D2214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67D2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgFrx-0003ua-Vb
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 17:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hgFqn-0002wX-0L
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hgFqm-00055Z-0M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hgFqj-00052x-PZ; Wed, 26 Jun 2019 17:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B86F98553B;
 Wed, 26 Jun 2019 21:53:04 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6F601001E63;
 Wed, 26 Jun 2019 21:53:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 17:53:01 -0400
Message-Id: <20190626215301.30733-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 26 Jun 2019 21:53:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/qcow: Improve error when opening qcow2
 files as qcow
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
Cc: Qemu-Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 radmehrsaeed7@gmail.com, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: radmehrsaeed7@gmail.com
Fixes: https://bugs.launchpad.net/bugs/1832914
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/qcow.c b/block/qcow.c
index 6dee5bb792..a9cb6ae0bd 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -156,7 +156,12 @@ static int qcow_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         goto fail;
     }
     if (header.version !=3D QCOW_VERSION) {
-        error_setg(errp, "Unsupported qcow version %" PRIu32, header.ver=
sion);
+        error_setg(errp, "qcow (v%d) does not support qcow version %" PR=
Iu32,
+                   QCOW_VERSION, header.version);
+        if (header.version =3D=3D 2 || header.version =3D=3D 3) {
+            error_append_hint(errp, "Try the 'qcow2' driver instead.");
+        }
+
         ret =3D -ENOTSUP;
         goto fail;
     }
--=20
2.21.0


