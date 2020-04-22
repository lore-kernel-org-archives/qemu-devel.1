Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B947C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EDD20706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExqITkhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EDD20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJDn-0000FD-04
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6V-00070H-Jh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6R-0004OP-4q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6P-0004JN-OE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qo/78xll3eTysL0pv7Kk3fEWiAu3sqbSrU00zi1Q9jc=;
 b=ExqITkhjebr+Okhi5es5KYteH014y/KOd3Hjb9teEYOWhOKD4sRU2OO+93bLMMlzX1t1kp
 M7VZFGvlQIpQGPOQzVgQcXDojm8bRqgZXeTPyqUCS00pi6XnSPC4mVrjfKodNnWGM0LHYe
 yY6L9y0XJlDKWoryHS+QeNuDpGZ0ZzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-fOJeiifTMBygC1A09ybFZQ-1; Wed, 22 Apr 2020 13:23:57 -0400
X-MC-Unique: fOJeiifTMBygC1A09ybFZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B073B190B2A8;
 Wed, 22 Apr 2020 17:23:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 293BA6084B;
 Wed, 22 Apr 2020 17:23:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] run-coverity-scan: add --no-update-tools option
Date: Wed, 22 Apr 2020 13:23:48 -0400
Message-Id: <20200422172351.26583-6-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Provide a quick way to skip building the container while we figure out how
to get caching right.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 37 +++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index ae1fc7ae76..9403429849 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -31,6 +31,7 @@
 #   --dry-run : run the tools, but don't actually do the upload
 #   --docker : create and work inside a docker container
 #   --update-tools-only : update the cached copy of the tools, but don't r=
un them
+#   --no-update-tools : do not update the cached copy of the tools
 #   --tokenfile : file to read Coverity token from
 #   --version ver : specify version being analyzed (default: ask git)
 #   --description desc : specify description of this version (default: ask=
 git)
@@ -128,7 +129,7 @@ update_coverity_tools () {
=20
 # Check user-provided environment variables and arguments
 DRYRUN=3Dno
-UPDATE_ONLY=3Dno
+UPDATE=3Dyes
 DOCKER=3Dno
=20
 while [ "$#" -ge 1 ]; do
@@ -137,9 +138,13 @@ while [ "$#" -ge 1 ]; do
             shift
             DRYRUN=3Dyes
             ;;
+        --no-update-tools)
+            shift
+            UPDATE=3Dno
+            ;;
         --update-tools-only)
             shift
-            UPDATE_ONLY=3Dyes
+            UPDATE=3Donly
             ;;
         --version)
             shift
@@ -238,12 +243,12 @@ fi
 PROJNAME=3DQEMU
 TARBALL=3Dcov-int.tar.xz
=20
-if [ "$UPDATE_ONLY" =3D yes ] && [ "$DOCKER" =3D yes ]; then
+if [ "$UPDATE" =3D only ] && [ "$DOCKER" =3D yes ]; then
     echo "Combining --docker and --update-only is not supported"
     exit 1
 fi
=20
-if [ "$UPDATE_ONLY" =3D yes ]; then
+if [ "$UPDATE" =3D only ]; then
     # Just do the tools update; we don't need to check whether
     # we are in a source tree or have upload rights for this,
     # so do it before some of the command line and source tree checks.
@@ -286,7 +291,6 @@ fi
=20
 # Run ourselves inside docker if that's what the user wants
 if [ "$DOCKER" =3D yes ]; then
-    # build docker container including the coverity-scan tools
     # Put the Coverity token into a temporary file that only
     # we have read access to, and then pass it to docker build
     # using a volume.  A volume is enough for the token not to
@@ -301,14 +305,17 @@ if [ "$DOCKER" =3D yes ]; then
     echo "Created temporary directory $SECRETDIR"
     SECRET=3D"$SECRETDIR/token"
     echo "$COVERITY_TOKEN" > "$SECRET"
-    echo "Building docker container..."
-    # TODO: This re-downloads the tools every time, rather than
-    # caching and reusing the image produced with the downloaded tools.
-    # Not sure why.
-    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
-                   -t coverity-scanner -f scripts/coverity-scan/coverity-s=
can.docker \
-                   -v "$SECRETDIR:/work" \
-                   --extra-files scripts/coverity-scan/run-coverity-scan
+    if [ "$UPDATE" !=3D no ]; then
+        # build docker container including the coverity-scan tools
+        echo "Building docker container..."
+        # TODO: This re-downloads the tools every time, rather than
+        # caching and reusing the image produced with the downloaded tools=
.
+        # Not sure why.
+        tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                       -t coverity-scanner -f scripts/coverity-scan/coveri=
ty-scan.docker \
+                       -v "$SECRETDIR:/work" \
+                       --extra-files scripts/coverity-scan/run-coverity-sc=
an
+    fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     if [ "$DRYRUN" =3D yes ]; then
@@ -343,7 +350,9 @@ fi
=20
 check_upload_permissions
=20
-update_coverity_tools
+if [ "$UPDATE" !=3D no ]; then
+    update_coverity_tools
+fi
=20
 TOOLBIN=3D"$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-analy=
sis-*/bin)"
=20
--=20
2.18.2



