Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D3CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F6F20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLbJjUvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F6F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP437-0003IB-LY
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vY-0001BR-Ju
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vX-0001CF-Cb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vX-0001C0-8x
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbC9UZ0xsPhtoSiYs/wfvSdprO+PyukdEqG/LpCyRNM=;
 b=BLbJjUvN+dETbK1sS7QEGzdYXSnYKzOfFSHXt/iV8N3wNEZdLSHrnepk2Uv/39vYMZF1Bq
 v+yq49Tuv41eomqObGAZOQhbYtjJa11XwsDd4TlGZ84zn9GUvMZTFtCra2iVO0HNo6mQs/
 Ja8SkG8MtdSJ7WMIH+coovBSdt1IBrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-uYABZKqNPJembGVFDraTBw-1; Mon, 28 Oct 2019 08:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4954080183E;
 Mon, 28 Oct 2019 12:15:12 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D759C5D6BB;
 Mon, 28 Oct 2019 12:15:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/69] iotests: Let skip_if_unsupported accept a function
Date: Mon, 28 Oct 2019 13:13:56 +0100
Message-Id: <20191028121501.15279-5-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uYABZKqNPJembGVFDraTBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

This lets tests use skip_if_unsupported() with a potentially variable
list of required formats.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190917092004.999-5-mreitz@redhat.com
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index bd867d7e02..936d33df61 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -930,8 +930,12 @@ def skip_if_unsupported(required_formats=3D[], read_on=
ly=3DFalse):
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
         def func_wrapper(test_case: QMPTestCase, *args, **kwargs):
-            usf_list =3D list(set(required_formats) -
-                            set(supported_formats(read_only)))
+            if callable(required_formats):
+                fmts =3D required_formats(test_case)
+            else:
+                fmts =3D required_formats
+
+            usf_list =3D list(set(fmts) - set(supported_formats(read_only)=
))
             if usf_list:
                 test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
                     test_case, usf_list))
--=20
2.21.0


