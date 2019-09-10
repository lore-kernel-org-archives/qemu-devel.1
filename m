Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3984C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89680206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89680206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aIt-0002YZ-Nb
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7aHs-0001W5-7o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7aHq-0004Sd-Au
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:10:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7aHm-0004Po-Fp; Tue, 10 Sep 2019 03:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 722CBA37671;
 Tue, 10 Sep 2019 07:09:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1818910018F9;
 Tue, 10 Sep 2019 07:09:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 09:09:49 +0200
Message-Id: <20190910070949.16256-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 07:09:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qemu-io: Don't leak pattern file in error path
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_io_alloc_from_file() needs to close the pattern file even if some
error occurred.

Setting f =3D NULL in the success path and checking it for NULL in the
error path isn't strictly necessary at this point, but let's do it
anyway in case someone later adds a 'goto error' after closing the file.

Coverity: CID 1405303
Fixes: 4d731510d34f280ed45a6de621d016f67a49ea48
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index d46fa166d3..349256a5fe 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -401,6 +401,7 @@ static void *qemu_io_alloc_from_file(BlockBackend *bl=
k, size_t len,
     }
=20
     fclose(f);
+    f =3D NULL;
=20
     if (len > pattern_len) {
         len -=3D pattern_len;
@@ -420,6 +421,9 @@ static void *qemu_io_alloc_from_file(BlockBackend *bl=
k, size_t len,
=20
 error:
     qemu_io_free(buf_origin);
+    if (f) {
+        fclose(f);
+    }
     return NULL;
 }
=20
--=20
2.20.1


