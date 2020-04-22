Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A0C5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3EB2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYyMOckx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3EB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ9I-0002nx-45
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6U-0006zE-Nd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6Q-0004Na-Cw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6Q-0004LB-0s
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kAXIjlf0ZyGEYURBbLw3pFu+02FXS2Wib+zTp7XjI8=;
 b=gYyMOckx5s1hi2qyeFtgnbFwiGGadgJ7Pq9shtQlYMiYMyW685yF9l4uiV902x2OsoZVJb
 ZQ0pP8W4bsI9rT3Bxr3VHxAuXOzDRFqjfjo/YjO4dTSbj2479s8cECBZ0oaqepJgdQtKYs
 W9OybDCk10brfScMzyJeIRwu55HYZh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-rDlhdHXXNGOLTmS198zrvw-1; Wed, 22 Apr 2020 13:23:57 -0400
X-MC-Unique: rDlhdHXXNGOLTmS198zrvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000EC8017F3;
 Wed, 22 Apr 2020 17:23:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63FAE6084B;
 Wed, 22 Apr 2020 17:23:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] run-coverity-scan: use docker.py
Date: Wed, 22 Apr 2020 13:23:47 -0400
Message-Id: <20200422172351.26583-5-pbonzini@redhat.com>
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

Our trusted docker wrapper allows run-coverity-scan to run with both
docker and podman.

For the "run" phase this is transparent; for the "build" phase however
scripts are replaced with a bind mount (-v).  This is not an issue
because the secret option is meant for secrets stored globally in the
system and bind mounts are a valid substitute for secrets that are known
to whoever builds the container.

This also removes the need for DOCKER_BUILDKIT=3D1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
=09Later in the series, the secret will not be used in "docker build"
=09at all.

 scripts/coverity-scan/coverity-scan.docker |  2 +-
 scripts/coverity-scan/run-coverity-scan    | 23 ++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-=
scan/coverity-scan.docker
index a4f64d1283..6f0460b66c 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -128,4 +128,4 @@ RUN rpm -q $PACKAGES | sort > /packages.txt
 ENV PATH $PATH:/usr/libexec/python3-sphinx/
 ENV COVERITY_TOOL_BASE=3D/coverity-tools
 COPY run-coverity-scan run-coverity-scan
-RUN --mount=3Dtype=3Dsecret,id=3Dcoverity.token,required ./run-coverity-sc=
an --update-tools-only --tokenfile /run/secrets/coverity.token
+RUN ./run-coverity-scan --update-tools-only --tokenfile /work/token
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index f7325b570c..ae1fc7ae76 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -197,6 +197,12 @@ while [ "$#" -ge 1 ]; do
             ;;
         --docker)
             DOCKER=3Dyes
+            DOCKER_ENGINE=3Dauto
+            shift
+            ;;
+        --docker=3D*)
+            DOCKER=3Dyes
+            DOCKER_ENGINE=3D${1#--docker=3D}
             shift
             ;;
         *)
@@ -283,9 +289,8 @@ if [ "$DOCKER" =3D yes ]; then
     # build docker container including the coverity-scan tools
     # Put the Coverity token into a temporary file that only
     # we have read access to, and then pass it to docker build
-    # using --secret. This requires at least Docker 18.09.
-    # Mostly what we are trying to do here is ensure we don't leak
-    # the token into the Docker image.
+    # using a volume.  A volume is enough for the token not to
+    # leak into the Docker image.
     umask 077
     SECRETDIR=3D$(mktemp -d)
     if [ -z "$SECRETDIR" ]; then
@@ -300,12 +305,10 @@ if [ "$DOCKER" =3D yes ]; then
     # TODO: This re-downloads the tools every time, rather than
     # caching and reusing the image produced with the downloaded tools.
     # Not sure why.
-    # TODO: how do you get 'docker build' to print the output of the
-    # commands it is running to its stdout? This would be useful for debug=
.
-    DOCKER_BUILDKIT=3D1 docker build -t coverity-scanner \
-                   --secret id=3Dcoverity.token,src=3D"$SECRET" \
-                   -f scripts/coverity-scan/coverity-scan.docker \
-                   scripts/coverity-scan
+    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                   -t coverity-scanner -f scripts/coverity-scan/coverity-s=
can.docker \
+                   -v "$SECRETDIR:/work" \
+                   --extra-files scripts/coverity-scan/run-coverity-scan
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     if [ "$DRYRUN" =3D yes ]; then
@@ -323,7 +326,7 @@ if [ "$DOCKER" =3D yes ]; then
     # Arrange for this docker run to get access to the sources with -v.
     # We pass through all the configuration from the outer script to the i=
nner.
     export COVERITY_EMAIL COVERITY_BUILD_CMD
-    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+    tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUI=
LD_CMD \
            -v "$SECRETDIR:/work" coverity-scanner \
            ./run-coverity-scan --version "$VERSION" \
            --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token=
 \
--=20
2.18.2



