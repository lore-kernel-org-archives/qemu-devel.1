Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49CC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAC72053B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAC72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Pkv-0007nz-Tq
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PR5-0003AB-7Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PR4-0001ab-9k
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PR2-0001ZD-82; Thu, 12 Sep 2019 09:46:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FC19796E4;
 Thu, 12 Sep 2019 13:46:55 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 851BA600C4;
 Thu, 12 Sep 2019 13:46:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:46:02 +0200
Message-Id: <20190912134604.22019-21-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 12 Sep 2019 13:46:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/22] qemu-io: Don't leak pattern file in error
 path
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


