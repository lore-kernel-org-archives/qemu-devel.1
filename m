Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422EBC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F471208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MMLvW8FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F471208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48425 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsUt-00043f-7M
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:55:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsPx-0008Cw-VL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsPw-0002Vk-V0
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43353 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsPw-0002R7-BC; Wed, 29 May 2019 02:50:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv15rXYz9sCJ; Wed, 29 May 2019 16:50:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112621;
	bh=BkQijpXj/KCURZ/rN6s0iYa5Zt/xqM674NRmoCOpbX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMLvW8FRZqE5WD3IwaJE6Xb56IxHPKswr34PqNWau7FtY1SyoQ02kEKXwXY7t3jUC
	a4ssuzw/ExVvcoZ9iznQDjFe4UMihI++/QnP6mfb4D6z7/u4LxNf23TmcocGgdF44o
	BwldK2gSXCvw8ZCMGF8tkwbXa1wNpOyE6YzABT/k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:34 +1000
Message-Id: <20190529065017.15149-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 01/44] tests: Fix up docker cross builds for
 ppc64 (BE) targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently have docker cross building targets for powerpc (32-bit, BE)
and ppc64el (64-bit, LE), but not for pcp64 (64-bit, BE).  This is an
irritating gap in make check-tcg coverage so correct it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/docker/Makefile.include                      |  1 +
 tests/docker/dockerfiles/debian-ppc64-cross.docker | 11 +++++++++++
 tests/tcg/ppc/Makefile.include                     |  3 +++
 3 files changed, 15 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-ppc64-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index c0e1bf57a3..aaf5396b85 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -107,6 +107,7 @@ docker-image-debian-sparc64-cross: docker-image-debia=
n-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-powerpc-cross: docker-image-debian-sid
+docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=3D1
=20
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/d=
ocker/dockerfiles/debian-ppc64-cross.docker
new file mode 100644
index 0000000000..7f239c322d
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
@@ -0,0 +1,11 @@
+#
+# Docker ppc64 cross-compiler target
+#
+# This docker target builds on the debian sid base image which
+# contains cross compilers for Debian "ports" targets.
+FROM qemu:debian-sid
+
+RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+       gcc-powerpc64-linux-gnu \
+       libc6-dev-ppc64-cross || { echo "Failed to build - see debian-sid=
.docker notes"; exit 1; }
diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.incl=
ude
index b062c30dd3..ae01fb8fad 100644
--- a/tests/tcg/ppc/Makefile.include
+++ b/tests/tcg/ppc/Makefile.include
@@ -1,6 +1,9 @@
 ifeq ($(TARGET_NAME),ppc)
 DOCKER_IMAGE=3Ddebian-powerpc-cross
 DOCKER_CROSS_COMPILER=3Dpowerpc-linux-gnu-gcc
+else ifeq ($(TARGET_NAME),ppc64)
+DOCKER_IMAGE=3Ddebian-ppc64-cross
+DOCKER_CROSS_COMPILER=3Dpowerpc64-linux-gnu-gcc
 else ifeq ($(TARGET_NAME),ppc64le)
 DOCKER_IMAGE=3Ddebian-ppc64el-cross
 DOCKER_CROSS_COMPILER=3Dpowerpc64le-linux-gnu-gcc
--=20
2.21.0


