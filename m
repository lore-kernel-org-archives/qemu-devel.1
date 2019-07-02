Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C4C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7363821473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7363821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9zh-0003vY-Mu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hi8hn-0004KX-JN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hi8hl-0007Qf-Kp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hi8hb-00072F-2I; Mon, 01 Jul 2019 22:39:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 326ABC057F2E;
 Tue,  2 Jul 2019 02:39:15 +0000 (UTC)
Received: from localhost (ovpn-204-243.brq.redhat.com [10.40.204.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3FEC60C44;
 Tue,  2 Jul 2019 02:39:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  2 Jul 2019 04:39:04 +0200
Message-Id: <20190702023905.32470-4-mreitz@redhat.com>
In-Reply-To: <20190702023905.32470-1-mreitz@redhat.com>
References: <20190702023905.32470-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 02:39:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] block/stream: refactor stream_run: drop goto
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The goto is unnecessary in the stream_run() since the common exit
code was removed in the commit eb23654dbe43b549ea2a9ebff9d8e:
"jobs: utilize job_exit shim".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1559152576-281803-3-git-send-email-andrey.shinkevich@virtuozz=
o.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 97fddb2608..65b13b27e0 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -120,13 +120,12 @@ static int coroutine_fn stream_run(Job *job, Error =
**errp)
     void *buf;
=20
     if (!bs->backing) {
-        goto out;
+        return 0;
     }
=20
     len =3D bdrv_getlength(bs);
     if (len < 0) {
-        ret =3D len;
-        goto out;
+        return len;
     }
     job_progress_set_remaining(&s->common.job, len);
=20
@@ -203,14 +202,10 @@ static int coroutine_fn stream_run(Job *job, Error =
**errp)
         bdrv_disable_copy_on_read(bs);
     }
=20
-    /* Do not remove the backing file if an error was there but ignored.=
  */
-    ret =3D error;
-
     qemu_vfree(buf);
=20
-out:
-    /* Modify backing chain and close BDSes in main loop */
-    return ret;
+    /* Do not remove the backing file if an error was there but ignored.=
 */
+    return error;
 }
=20
 static const BlockJobDriver stream_job_driver =3D {
--=20
2.21.0


