Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BD9206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L45ZEdfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BD9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguEs-0002dE-8s
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igts3-0005Lo-Iy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igts1-0004cC-Es
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igts1-0004b8-79
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576516160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbqnCUxN0zB+lXOmjXBKMWa4cpQ0zxpolifXhc8NANs=;
 b=L45ZEdfxYf/CxYk2sZGg8Gg+H8rRhcSuaeXlZINmlunqbv4hPYfjGAVvQ0snuGfLfjszZM
 v9wpySl1wG2bXL3PVAGLiF3BBwsan4Wzr21F3UYyY1QFeO30uOh4rbQd96A//ECbHukQLH
 n6fQfKRubWxXlepjGBtVEMRFdLYsQp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-DZqFIOgYOVCOhzrrAe0Rvw-1; Mon, 16 Dec 2019 12:09:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E7B81800D7B;
 Mon, 16 Dec 2019 17:09:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 129136FEE8;
 Mon, 16 Dec 2019 17:09:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 10/10] iotests: 211: Remove duplication with
 VM.blockdev_create()
Date: Mon, 16 Dec 2019 18:08:57 +0100
Message-Id: <20191216170857.11880-11-kwolf@redhat.com>
In-Reply-To: <20191216170857.11880-1-kwolf@redhat.com>
References: <20191216170857.11880-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DZqFIOgYOVCOhzrrAe0Rvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The blockdev_create() function in this test case adds an error check
that skips the test in case of failure because of memory shortage, but
provides otherwise the same functionality as VM.blockdev_create() from
iotests.py. Make it a thin wrapper around the iotests.py function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/211 | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 6afc894f76..8834ebfe85 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -27,15 +27,9 @@ iotests.verify_image_format(supported_fmts=3D['vdi'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3Dop=
tions,
-                        filters=3D[iotests.filter_qmp_testfiles])
-
-    if 'return' in result:
-        assert result['return'] =3D=3D {}
-        error =3D vm.run_job('job0')
-        if error and 'Could not allocate bmap' in error:
-            iotests.notrun('Insufficient memory')
-    iotests.log("")
+    error =3D vm.blockdev_create(options)
+    if error and 'Could not allocate bmap' in error:
+        iotests.notrun('Insufficient memory')
=20
 with iotests.FilePath('t.vdi') as disk_path, \
      iotests.VM() as vm:
--=20
2.20.1


