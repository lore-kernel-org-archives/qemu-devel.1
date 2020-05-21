Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87CB2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ/gROl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87CB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkb4-00059q-01
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbka0-0003Rh-U1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbkZz-00054p-Lt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590065142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1x1449wh9fFr7gq1V8OCFbpQf1TKKB1YZGtB8zf4V7c=;
 b=YQ/gROl+X1qIJ/7/UB8Hd5aWAHRFZEYAfgFLgVEfJmhngcCxy1awlGJBP2FZOSsOQJamTX
 Ds982Vtsts9PuIdeMlrFqyz+CbgvIuSVRxIufi7ESWbC3ZugmD0Ps/7CkkDalaf9zWRWhh
 m/HJeCDBn7UGiTqD874RumPBRf2phnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-dfaHOMhqPC2MO-S3r96W0g-1; Thu, 21 May 2020 08:45:40 -0400
X-MC-Unique: dfaHOMhqPC2MO-S3r96W0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7B2461;
 Thu, 21 May 2020 12:45:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAA0934201;
 Thu, 21 May 2020 12:45:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] run-coverity-scan: use docker.py
Date: Thu, 21 May 2020 08:45:31 -0400
Message-Id: <20200521124535.5329-5-pbonzini@redhat.com>
In-Reply-To: <20200521124535.5329-1-pbonzini@redhat.com>
References: <20200521124535.5329-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/coverity-scan.docker |  2 +-
 scripts/coverity-scan/run-coverity-scan    | 32 ++++++++++++++--------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index a4f64d1283..6f0460b66c 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -128,4 +128,4 @@ RUN rpm -q $PACKAGES | sort > /packages.txt
 ENV PATH $PATH:/usr/libexec/python3-sphinx/
 ENV COVERITY_TOOL_BASE=/coverity-tools
 COPY run-coverity-scan run-coverity-scan
-RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan --update-tools-only --tokenfile /run/secrets/coverity.token
+RUN ./run-coverity-scan --update-tools-only --tokenfile /work/token
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 990f75138d..e926623b3b 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -29,7 +29,9 @@
 
 # Command line options:
 #   --dry-run : run the tools, but don't actually do the upload
-#   --docker : create and work inside a docker container
+#   --docker : create and work inside a container
+#   --docker-engine : specify the container engine to use (docker/podman/auto);
+#                     implies --docker
 #   --update-tools-only : update the cached copy of the tools, but don't run them
 #   --tokenfile : file to read Coverity token from
 #   --version ver : specify version being analyzed (default: ask git)
@@ -197,6 +199,17 @@ while [ "$#" -ge 1 ]; do
             ;;
         --docker)
             DOCKER=yes
+            DOCKER_ENGINE=auto
+            shift
+            ;;
+        --docker-engine)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--docker-engine needs an argument"
+                exit 1
+            fi
+            DOCKER=yes
+            DOCKER_ENGINE="$1"
             shift
             ;;
         *)
@@ -283,9 +296,8 @@ if [ "$DOCKER" = yes ]; then
     # build docker container including the coverity-scan tools
     # Put the Coverity token into a temporary file that only
     # we have read access to, and then pass it to docker build
-    # using --secret. This requires at least Docker 18.09.
-    # Mostly what we are trying to do here is ensure we don't leak
-    # the token into the Docker image.
+    # using a volume.  A volume is enough for the token not to
+    # leak into the Docker image.
     umask 077
     SECRETDIR=$(mktemp -d)
     if [ -z "$SECRETDIR" ]; then
@@ -300,12 +312,10 @@ if [ "$DOCKER" = yes ]; then
     # TODO: This re-downloads the tools every time, rather than
     # caching and reusing the image produced with the downloaded tools.
     # Not sure why.
-    # TODO: how do you get 'docker build' to print the output of the
-    # commands it is running to its stdout? This would be useful for debug.
-    DOCKER_BUILDKIT=1 docker build -t coverity-scanner \
-                   --secret id=coverity.token,src="$SECRET" \
-                   -f scripts/coverity-scan/coverity-scan.docker \
-                   scripts/coverity-scan
+    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                   -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
+                   -v "$SECRETDIR:/work" \
+                   --extra-files scripts/coverity-scan/run-coverity-scan
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     if [ "$DRYRUN" = yes ]; then
@@ -323,7 +333,7 @@ if [ "$DOCKER" = yes ]; then
     # Arrange for this docker run to get access to the sources with -v.
     # We pass through all the configuration from the outer script to the inner.
     export COVERITY_EMAIL COVERITY_BUILD_CMD
-    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+    tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
            -v "$SECRETDIR:/work" coverity-scanner \
            ./run-coverity-scan --version "$VERSION" \
            --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token \
-- 
2.26.2



