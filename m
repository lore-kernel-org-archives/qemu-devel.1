Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4339DC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1992070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPqB+Ki/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1992070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mse-0001Yk-9a
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j3moa-0004ij-3E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j3moY-00040a-Sk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j3moY-000403-P5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581970582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFjfuovdsvlzfwZC8+iwmDElh3VklZuJkaO/8GvGHzw=;
 b=YPqB+Ki/tYr0+KYzlyMbC+yepH0/PklPfM+sLSTrrhk89Gwr1OHcsQA8ihWAbFyzGoc/hz
 UVx/FBK/2u5NCUHY+DJou64CmzGy0dHEE/Z+OBODjyv7f32b+Sc0A/D5+ACgYflMzKq73v
 7D8iDf53i0U9+8u/Y1nK1q4NgTsy8yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-3Dgb7DxGN7uQAnzYdYDQhQ-1; Mon, 17 Feb 2020 15:16:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41984800D5B;
 Mon, 17 Feb 2020 20:16:15 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED265D9E2;
 Mon, 17 Feb 2020 20:16:14 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/6] travis.yml: Fix 'GCC9 with sanitizers' job on Ubuntu
 Bionic
Date: Mon, 17 Feb 2020 15:16:05 -0500
Message-Id: <20200217201609.788825-3-wainersm@redhat.com>
In-Reply-To: <20200217201609.788825-1-wainersm@redhat.com>
References: <20200217201609.788825-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3Dgb7DxGN7uQAnzYdYDQhQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes the 'GCC9 with sanitizers' job to run correctly
on Ubuntu Bionic. It was needed to solved the problems:

1) The new environment changed how APT sources are handled,
resulting on the error:

```
Disallowing sources: ubuntu-toolchain-r-test

To add unlisted APT sources, follow instructions in https://docs.travis-ci.=
com/user/installing-dependencies#Installing-Packages-with-the-APT-Addon
```

Thus, the reference to 'ubuntu-toolchain-r-test' is passed via
'sourceline' now.

2) Adjusted the name of some packages

3) Libssh-dev is not installed due known issue on Bionic

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e46c44bbee..232f84d196 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -336,7 +336,7 @@ matrix:
           update: true
           sources:
             # PPAs for newer toolchains
-            - ubuntu-toolchain-r-test
+            - sourceline: 'ppa:ubuntu-toolchain-r/test'
           packages:
             # Extra toolchains
             - gcc-9
@@ -346,7 +346,7 @@ matrix:
             - libattr1-dev
             - libbrlapi-dev
             - libcap-ng-dev
-            - libgnutls-dev
+            - libgnutls28-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
@@ -354,14 +354,15 @@ matrix:
             - libncurses5-dev
             - libnss3-dev
             - libpixman-1-dev
-            - libpng12-dev
+            - libpng-dev
             - librados-dev
             - libsdl2-dev
             - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-            - libssh-dev
+# https://bugs.launchpad.net/qemu/+bug/1838763
+#            - libssh-dev
             - liburcu-dev
             - libusb-1.0-0-dev
             - libvte-2.91-dev
--=20
2.24.1


