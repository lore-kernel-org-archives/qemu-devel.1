Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A69B206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9s1q55y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A69B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTeR-0001GJ-7t
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTda-0006ml-AZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdZ-0007r6-Au
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdZ-0007qp-7P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pL/4tsiBJijnv/MS3/MnnZB7fz4iUpoEpqQeJ2YCZog=;
 b=P9s1q55ytdTEXVNMGjyTHX6wOi8fWbSe4BfyTrpihGRPcnmB3kmaZvmpiWDmW/UQkGiaEp
 b3UrdjLPNA3DK5zZgvEVqxO9nD9x44sARlENJLxWSo6ZqQoJBR4vhZQg+vfHkFTtWWi74i
 urR2aXI+vWp2tpOB1n9HQuHCEIsG/rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-UbPbwy9VMLussHF6CuapzA-1; Thu, 12 Mar 2020 15:36:53 -0400
X-MC-Unique: UbPbwy9VMLussHF6CuapzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8BCC6BE62;
 Thu, 12 Mar 2020 19:36:51 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E49615C1D8;
 Thu, 12 Mar 2020 19:36:40 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 2/5] tests/docker: make "buildah bud" output similar to
 "docker build"
Date: Thu, 12 Mar 2020 15:36:13 -0400
Message-Id: <20200312193616.438922-3-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Podman users will most often be using buildah to build containers.
Among the differences between "buildah bud|build-using-dockerfile" and
a traditional "docker build" is that buildah does not run a container
during build.

To the best of my knowledge and experiments, this means that runtime
variables, such as ENV from one base image will not propagate into
another.  The end result is that the location for the cross compiler
binaries, defined in the base "qemu/debian9-mxe" image, are not passed
through this image.  Consequently, the cross compilers are not on PATH
and the build fails.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/docker/dockerfiles/debian-win32-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/doc=
ker/dockerfiles/debian-win32-cross.docker
index 9d7053e59d..d16d6431bc 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -9,7 +9,7 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
 ENV TARGET i686
=20
-ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
+ENV PATH $PATH:/usr/lib/mxe/usr/bin:/usr/lib/mxe/usr/$TARGET-w64-mingw32.s=
hared/bin
=20
 ENV PKG_CONFIG_PATH \
     $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgco=
nfig
--=20
2.24.1


