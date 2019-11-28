Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD9AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8655F21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0lIBzn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8655F21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaNDl-00026w-Gu
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 12:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaLpb-0002mz-9T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaLpX-0005nl-39
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaLpW-0005b1-UN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574955339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhiK25DJ0Gx190woLZIgdOQi19vB1oWVhGBl5WzlQxU=;
 b=T0lIBzn0AfciZL5K8xZd2ogRzfbPyRN2AdRDn26jzq+4RSZsN7Goa+nwIkJk/Kf6rlBBEW
 C5SmUFt7qDjJhXWmj5ilXzMiHK6Ux/Q7ALbvc4yVxNg2e6hwHVxybrHNanPxtil1do/jlp
 ANcdbFFzfTAFj0B3fvDyBDR3kALuNPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-MCsSo2XfPnyvFL6tRIEXOg-1; Thu, 28 Nov 2019 10:35:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A5B8C381F;
 Thu, 28 Nov 2019 15:35:34 +0000 (UTC)
Received: from thuth.com (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5CA10021B3;
 Thu, 28 Nov 2019 15:35:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] travis.yml: Run tcg tests with tci
Date: Thu, 28 Nov 2019 16:35:25 +0100
Message-Id: <20191128153525.2646-3-thuth@redhat.com>
In-Reply-To: <20191128153525.2646-1-thuth@redhat.com>
References: <20191128153525.2646-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MCsSo2XfPnyvFL6tRIEXOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far we only have compile coverage for tci. But since commit
2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
for INDEX_op_ld16u_i64") has been included now, we can also run the
"tcg" and "qtest" tests with tci, so let's enable them in Travis now.
Since we don't gain much additional test coverage by compiling all
targets, and TCI is broken e.g. with the Sparc targets, we also limit
the target list to a reasonable subset now (which should still get
us test coverage by tests/boot-serial-test for example).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c09b6a0014..de7559e777 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -215,10 +215,11 @@ matrix:
         - TEST_CMD=3D""
=20
=20
-    # We manually include builds which we disable "make check" for
+    # Check the TCG interpreter (TCI)
     - env:
-        - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
-        - TEST_CMD=3D""
+        - CONFIG=3D"--enable-debug --enable-tcg-interpreter --disable-cont=
ainers
+            --target-list=3Dalpha-softmmu,arm-softmmu,hppa-softmmu,m68k-so=
ftmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-sof=
tmmu"
+        - TEST_CMD=3D"make check-qtest check-tcg V=3D1"
=20
=20
     # We don't need to exercise every backend with every front-end
--=20
2.18.1


