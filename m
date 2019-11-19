Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87CBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C222084D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXV8t9RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C222084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX77K-0008RM-K6
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX6zf-0005Zs-78
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX6ze-0004O5-6M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX6ze-0004Nm-2X
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574183325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dobyugg5ybakk5iMGwm4Jb6ml7KmvDKYGCYl6FkJhaU=;
 b=CXV8t9RSeraRwGl8crcsX7+QrWD8H61RN0s6IydTMug2VpjamgQy88FIjLpm2pTGtYumhs
 +saqFGi+mQ4uC/PVw9wxaLHg5I4MQJqYfSvP56maW53nwa2kA1tFwY2JV39lUlK5aKkENH
 Zv+HB3mBigoEUV/E7X9BP7w1uZdc+2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-k_Us7OhiN_aUuzkDt7PjMg-1; Tue, 19 Nov 2019 12:08:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E060B801E5A;
 Tue, 19 Nov 2019 17:08:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01DB95ED2C;
 Tue, 19 Nov 2019 17:08:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/6] travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS
Date: Tue, 19 Nov 2019 18:08:20 +0100
Message-Id: <20191119170822.45649-6-thuth@redhat.com>
In-Reply-To: <20191119170822.45649-1-thuth@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: k_Us7OhiN_aUuzkDt7PjMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The older clangs are still struggling to build and run everything
withing the 50 minute timeout so lets lighten the load a bit more. We
still have coverage for GCC and hopefully no obscure 32 bit guest only
breakages slip through the cracks.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index b9a026c8ee..c09b6a0014 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,7 +79,7 @@ env:
     - BASE_CONFIG=3D"--disable-docs --disable-tools"
     - TEST_CMD=3D"make check V=3D1"
     # This is broadly a list of "mainline" softmmu targets which have supp=
ort across the major distros
-    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,mip=
s-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64=
-softmmu"
+    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softmmu=
,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=3D1G
=20
--=20
2.23.0


