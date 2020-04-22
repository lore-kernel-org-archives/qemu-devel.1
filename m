Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70027C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECDB20776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgDoglv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECDB20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ8X-0001fd-CZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6V-00070a-PA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6U-0004Q2-Ak
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6T-0004Pc-UG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfbHAUK4NA4e7RJFR+eYDU5CnrMdlw5f1uZu0oZM0Vo=;
 b=fgDoglv0u24+08p8DA3Lbp1ZByAP34XDKtvF4alzqXzPyj5n7K3eGQPxPywwP1VaXIwy2N
 Wvh//oyjzwIkwcxD2+3aELKdcNxo/vIdcdL7ALtOWw9+lxbJDfsUSbqmwrOIkQp+rOqRsc
 etkbJV0fKBCfee/FW2vL+FewT0DDmBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-r8DeF8LnMReveaYx5mxqtQ-1; Wed, 22 Apr 2020 13:23:59 -0400
X-MC-Unique: r8DeF8LnMReveaYx5mxqtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12A4100CC88;
 Wed, 22 Apr 2020 17:23:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6892D6084B;
 Wed, 22 Apr 2020 17:23:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] run-coverity-scan: support --update-tools-only --docker
Date: Wed, 22 Apr 2020 13:23:51 -0400
Message-Id: <20200422172351.26583-9-pbonzini@redhat.com>
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

Just build the container when run-coverity-scan is invoked with
--update-tools-only --docker.  This requires moving the "docker build"
logic into the update_coverity_tools function.

The only snag is that --update-tools-only --docker requires access to
the dockerfile.  For now just report an error for --src-tarball, and
"docker build" will fail if not in a source tree.  Another possibility
could be to host our container images on a public registry, and use
"FROM qemu:fedora" to make the Dockerfile small enough that it can be
included directly in the run-coverity-scan script.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 39 +++++++++++++++----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index 49df8dcc06..900ce9dd14 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -93,6 +93,18 @@ check_upload_permissions() {
 }
=20
=20
+build_docker_image() {
+    # build docker container including the coverity-scan tools
+    echo "Building docker container..."
+    # TODO: This re-unpacks the tools every time, rather than caching
+    # and reusing the image produced by the COPY of the .tgz file.
+    # Not sure why.
+    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                   -t coverity-scanner -f scripts/coverity-scan/coverity-s=
can.docker \
+                   --extra-files scripts/coverity-scan/run-coverity-scan \
+                                 "$COVERITY_TOOL_BASE"/coverity_tool.tgz
+}
+
 update_coverity_tools () {
     # Check for whether we need to download the Coverity tools
     # (either because we don't have a copy, or because it's out of date)
@@ -126,6 +138,11 @@ update_coverity_tools () {
         fi
     fi
     rm -f coverity_tool.md5.new
+    cd "$SRCDIR"
+
+    if [ "$DOCKER" =3D yes ]; then
+        build_docker_image
+    fi
 }
=20
=20
@@ -245,15 +262,16 @@ fi
 PROJNAME=3DQEMU
 TARBALL=3Dcov-int.tar.xz
=20
-if [ "$UPDATE" =3D only ] && [ "$DOCKER" =3D yes ]; then
-    echo "Combining --docker and --update-only is not supported"
-    exit 1
-fi
-
 if [ "$UPDATE" =3D only ]; then
     # Just do the tools update; we don't need to check whether
     # we are in a source tree or have upload rights for this,
     # so do it before some of the command line and source tree checks.
+
+    if [ "$DOCKER" =3D yes ] && [ ! -z "$SRCTARBALL" ]; then
+        echo --update-tools-only --docker is incompatible with --src-tarba=
ll.
+        exit 1
+    fi
+
     update_coverity_tools
     exit 0
 fi
@@ -315,17 +333,6 @@ if [ "$DOCKER" =3D yes ]; then
     echo "Created temporary directory $SECRETDIR"
     SECRET=3D"$SECRETDIR/token"
     echo "$COVERITY_TOKEN" > "$SECRET"
-    if [ "$UPDATE" !=3D no ]; then
-        # build docker container including the coverity-scan tools
-        echo "Building docker container..."
-        # TODO: This re-unpacks the tools every time, rather than caching
-        # and reusing the image produced by the COPY of the .tgz file.
-        # Not sure why.
-        tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
-                       -t coverity-scanner -f scripts/coverity-scan/coveri=
ty-scan.docker \
-                       --extra-files scripts/coverity-scan/run-coverity-sc=
an \
-                                     "$COVERITY_TOOL_BASE"/coverity_tool.t=
gz
-    fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     ARGS=3D"--no-update-tools"
--=20
2.18.2


