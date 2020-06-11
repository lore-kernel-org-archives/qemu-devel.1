Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C173C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D09A207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8bLYnRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D09A207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTAY-0001NS-Fc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8H-0007CT-74
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8E-0000ls-Po
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4FdChKq6cAC1AvirjpOGLQBCc9XB8opK4v+ZgHbNbU=;
 b=V8bLYnRh6dU05OgvyYV7TED4n48gfly0zqSWRcKNTABIPyGelLkygBuDIiK00RY9a0K80H
 3bMdl+iqy5ZJzy/7U9EiRX45a+CY1xkIvJ5rhEpRZ90vHKE4koXqWdognf4D6dB4guw2lY
 GiabuO8b0EbZs/uT/m4FkZy/VL+UfUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-MrPeADYhNJOGZqcYGoyQeQ-1; Thu, 11 Jun 2020 15:44:56 -0400
X-MC-Unique: MrPeADYhNJOGZqcYGoyQeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147B0801503;
 Thu, 11 Jun 2020 19:44:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B06485EE0E;
 Thu, 11 Jun 2020 19:44:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 008/115] run-coverity-scan: support --update-tools-only --docker
Date: Thu, 11 Jun 2020 15:43:02 -0400
Message-Id: <20200611194449.31468-9-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just build the container when run-coverity-scan is invoked with
--update-tools-only --docker.  This requires moving the "docker build"
logic into the update_coverity_tools function.

The only snag is that --update-tools-only --docker requires access to
the dockerfile.  For now just report an error for --src-tarball, and
"docker build" will fail if not in a source tree.  Another possibility
could be to host our container images on a public registry, and use
"FROM qemu:fedora" to make the Dockerfile small enough that it can be
included directly in the run-coverity-scan script.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 39 +++++++++++++++----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 8bff952bf5..03a791dec9 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -95,6 +95,18 @@ check_upload_permissions() {
 }
 
 
+build_docker_image() {
+    # build docker container including the coverity-scan tools
+    echo "Building docker container..."
+    # TODO: This re-unpacks the tools every time, rather than caching
+    # and reusing the image produced by the COPY of the .tgz file.
+    # Not sure why.
+    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                   -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
+                   --extra-files scripts/coverity-scan/run-coverity-scan \
+                                 "$COVERITY_TOOL_BASE"/coverity_tool.tgz
+}
+
 update_coverity_tools () {
     # Check for whether we need to download the Coverity tools
     # (either because we don't have a copy, or because it's out of date)
@@ -128,6 +140,11 @@ update_coverity_tools () {
         fi
     fi
     rm -f coverity_tool.md5.new
+    cd "$SRCDIR"
+
+    if [ "$DOCKER" = yes ]; then
+        build_docker_image
+    fi
 }
 
 
@@ -252,15 +269,16 @@ fi
 PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
-if [ "$UPDATE" = only ] && [ "$DOCKER" = yes ]; then
-    echo "Combining --docker and --update-only is not supported"
-    exit 1
-fi
-
 if [ "$UPDATE" = only ]; then
     # Just do the tools update; we don't need to check whether
     # we are in a source tree or have upload rights for this,
     # so do it before some of the command line and source tree checks.
+
+    if [ "$DOCKER" = yes ] && [ ! -z "$SRCTARBALL" ]; then
+        echo --update-tools-only --docker is incompatible with --src-tarball.
+        exit 1
+    fi
+
     update_coverity_tools
     exit 0
 fi
@@ -322,17 +340,6 @@ if [ "$DOCKER" = yes ]; then
     echo "Created temporary directory $SECRETDIR"
     SECRET="$SECRETDIR/token"
     echo "$COVERITY_TOKEN" > "$SECRET"
-    if [ "$UPDATE" != no ]; then
-        # build docker container including the coverity-scan tools
-        echo "Building docker container..."
-        # TODO: This re-unpacks the tools every time, rather than caching
-        # and reusing the image produced by the COPY of the .tgz file.
-        # Not sure why.
-        tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
-                       -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
-                       --extra-files scripts/coverity-scan/run-coverity-scan \
-                                     "$COVERITY_TOOL_BASE"/coverity_tool.tgz
-    fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     ARGS="--no-update-tools"
-- 
2.26.2



