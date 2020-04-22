Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF75C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E060920776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE1DqB5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E060920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ9I-0002om-22
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6U-0006zP-TI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6R-0004OK-3x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6Q-0004LZ-O4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbNUyR2X80XAt9gdGYyjU4QQjkaQE1JBi/X/D4xnlgw=;
 b=VE1DqB5DITgCu1PkHg8ReS/g4Efn0l8Oyu2QA2/McfYuv2RgA1k2ivNCJaHUYzUw8DmdZ5
 yDP5dMqcv4bgQNiyrIGCfNPqyUB2lM9yJPuFEIsT1rMRlbf8NAJzVQgvXmBL4zROSg0LIg
 jClGFM4GTaMae3F3xWg8CuU1fVKnwoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-v11_MVcONiGCSVQsxYdaMg-1; Wed, 22 Apr 2020 13:23:59 -0400
X-MC-Unique: v11_MVcONiGCSVQsxYdaMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2F7DB62;
 Wed, 22 Apr 2020 17:23:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A49DA6084B;
 Wed, 22 Apr 2020 17:23:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] run-coverity-scan: download tools outside the container
Date: Wed, 22 Apr 2020 13:23:50 -0400
Message-Id: <20200422172351.26583-8-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This lets us look at coverity_tool.md5 across executions of run-coverity-sc=
an
and skip the download.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/coverity-scan.docker |  3 +-
 scripts/coverity-scan/run-coverity-scan    | 42 +++++++++++-----------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-=
scan/coverity-scan.docker
index 6f0460b66c..efcf63224d 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -127,5 +127,6 @@ RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
 ENV PATH $PATH:/usr/libexec/python3-sphinx/
 ENV COVERITY_TOOL_BASE=3D/coverity-tools
+COPY coverity_tool.tgz coverity_tool.tgz
+RUN mkdir -p /coverity-tools/coverity_tool && cd /coverity-tools/coverity_=
tool && tar xf /coverity_tool.tgz
 COPY run-coverity-scan run-coverity-scan
-RUN ./run-coverity-scan --update-tools-only --tokenfile /work/token
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index 0c2c0e4087..49df8dcc06 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -114,15 +114,17 @@ update_coverity_tools () {
             echo "Downloaded tarball didn't match md5sum!"
             exit 1
         fi
-        # extract the new one, keeping it corralled in a 'coverity_tool' d=
irectory
-        echo "Unpacking coverity build tools..."
-        mkdir -p coverity_tool
-        cd coverity_tool
-        tar xf ../coverity_tool.tgz
-        cd ..
-        mv coverity_tool.md5.new coverity_tool.md5
-    fi
=20
+        if [ "$DOCKER" !=3D yes ]; then
+            # extract the new one, keeping it corralled in a 'coverity_too=
l' directory
+            echo "Unpacking coverity build tools..."
+            mkdir -p coverity_tool
+            cd coverity_tool
+            tar xf ../coverity_tool.tgz
+            cd ..
+            mv coverity_tool.md5.new coverity_tool.md5
+        fi
+    fi
     rm -f coverity_tool.md5.new
 }
=20
@@ -289,6 +291,14 @@ if [ -z "$COVERITY_EMAIL" ]; then
     COVERITY_EMAIL=3D"$(git config user.email)"
 fi
=20
+# Otherwise, continue with the full build and upload process.
+
+check_upload_permissions
+
+if [ "$UPDATE" !=3D no ]; then
+    update_coverity_tools
+fi
+
 # Run ourselves inside docker if that's what the user wants
 if [ "$DOCKER" =3D yes ]; then
     # Put the Coverity token into a temporary file that only
@@ -308,13 +318,13 @@ if [ "$DOCKER" =3D yes ]; then
     if [ "$UPDATE" !=3D no ]; then
         # build docker container including the coverity-scan tools
         echo "Building docker container..."
-        # TODO: This re-downloads the tools every time, rather than
-        # caching and reusing the image produced with the downloaded tools=
.
+        # TODO: This re-unpacks the tools every time, rather than caching
+        # and reusing the image produced by the COPY of the .tgz file.
         # Not sure why.
         tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
                        -t coverity-scanner -f scripts/coverity-scan/coveri=
ty-scan.docker \
-                       -v "$SECRETDIR:/work" \
-                       --extra-files scripts/coverity-scan/run-coverity-sc=
an
+                       --extra-files scripts/coverity-scan/run-coverity-sc=
an \
+                                     "$COVERITY_TOOL_BASE"/coverity_tool.t=
gz
     fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
@@ -345,14 +355,6 @@ if [ "$DOCKER" =3D yes ]; then
     exit 0
 fi
=20
-# Otherwise, continue with the full build and upload process.
-
-check_upload_permissions
-
-if [ "$UPDATE" !=3D no ]; then
-    update_coverity_tools
-fi
-
 TOOLBIN=3D"$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-analy=
sis-*/bin)"
=20
 if ! test -x "$TOOLBIN/cov-build"; then
--=20
2.18.2



