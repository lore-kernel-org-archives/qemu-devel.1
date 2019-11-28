Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D49C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA4C21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX5/whJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA4C21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaN3o-0005eL-TP
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaLpX-0002jL-HR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaLpS-0005Xw-V7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaLpS-0005Qv-Lz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574955337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky4mgUkth1VGZLMbQpI8WowaMsYghd71kTf+NNV3KVA=;
 b=eX5/whJRN8IrWfE6Sy0rOH1iJgOESmQyhPg6OAXcnMoE/gJQwqwJDt70bFA5rVD/umz+z7
 03HrvOoid8uCKJATFv75a3uauMnVZyozVY6NHACMaFfiUVdpLc5ha36wA21mM61Iysxyuj
 Lnh2PPksQg7XsVDRv7fsOp3bYh4YFAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-ej2vlZpzO6G-Cee_2ZFhRQ-1; Thu, 28 Nov 2019 10:35:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4BA756B3D;
 Thu, 28 Nov 2019 15:35:32 +0000 (UTC)
Received: from thuth.com (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6F010001BD;
 Thu, 28 Nov 2019 15:35:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] configure: allow disable of cross compilation
 containers
Date: Thu, 28 Nov 2019 16:35:24 +0100
Message-Id: <20191128153525.2646-2-thuth@redhat.com>
In-Reply-To: <20191128153525.2646-1-thuth@redhat.com>
References: <20191128153525.2646-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ej2vlZpzO6G-Cee_2ZFhRQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Our docker infrastructure isn't quite as multiarch as we would wish so
lets allow the user to disable it if they want. This will allow us to
use still run check-tcg on non-x86 CI setups.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 configure              | 8 +++++++-
 tests/tcg/configure.sh | 6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 6099be1d84..fe6d0971f1 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ audio_win_int=3D""
 libs_qga=3D""
 debug_info=3D"yes"
 stack_protector=3D""
+use_containers=3D"yes"
=20
 if test -e "$source_path/.git"
 then
@@ -1539,6 +1540,10 @@ for opt do
   ;;
   --disable-plugins) plugins=3D"no"
   ;;
+  --enable-containers) use_containers=3D"yes"
+  ;;
+  --disable-containers) use_containers=3D"no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1722,6 +1727,7 @@ Advanced options (experts only):
                            track the maximum stack usage of stacks created=
 by qemu_alloc_stack
   --enable-plugins
                            enable plugins via shared library loading
+  --disable-containers     don't use containers for cross-building
=20
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -8039,7 +8045,7 @@ done
 (for i in $cross_cc_vars; do
   export $i
 done
-export target_list source_path
+export target_list source_path use_containers
 $source_path/tests/tcg/configure.sh)
=20
 # temporary config to build submodules
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 6c4a471aea..210e68396f 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -36,8 +36,10 @@ TMPC=3D"${TMPDIR1}/qemu-conf.c"
 TMPE=3D"${TMPDIR1}/qemu-conf.exe"
=20
 container=3D"no"
-if has "docker" || has "podman"; then
-  container=3D$($python $source_path/tests/docker/docker.py probe)
+if test $use_containers =3D "yes"; then
+    if has "docker" || has "podman"; then
+        container=3D$($python $source_path/tests/docker/docker.py probe)
+    fi
 fi
=20
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
--=20
2.18.1


