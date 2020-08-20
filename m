Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE41C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4512072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKhBm6m4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4512072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nsc-0001qj-RP
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8nrr-00017W-OD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8nro-0005xS-QG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rl108cAE4F/0af//liEBKKNyPrrYOEqEwBkh7xj1HfI=;
 b=MKhBm6m4Dl7U9R63QyZiwr+05FkeemUT/FiQ1rYewfS4NmdEBxxrPoBSgIBP6C6hvE1LXM
 vDqGx0mBg2yoWHhCznjm4W8wyCNiRxa5wUd5PdeMBmYPrsRpSdRF1F6VYNkMW1buDQX5qh
 CZ9x+s5VWRanP4NKmp5tiVgjS8odAgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-sNdUBZuuOQOSWLzPshD1pw-1; Thu, 20 Aug 2020 12:56:39 -0400
X-MC-Unique: sNdUBZuuOQOSWLzPshD1pw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A74A31074649;
 Thu, 20 Aug 2020 16:56:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C5E25E1DE;
 Thu, 20 Aug 2020 16:56:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: add support for psuedo-"in source tree" builds
Date: Thu, 20 Aug 2020 17:55:44 +0100
Message-Id: <20200820165543.215372-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:28:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson requires the build dir to be separate from the source tree. Many
people are used to just running "./configure && make" though and the
meson conversion breaks that.

This introduces some backcompat support to make it appear as if an
"in source tree" build is being done, but with the the results in the
"build/" directory. This allows "./configure && make" to work as it
did historically, albeit with the output binaries staying under build/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

This is a simple integration of Eric's proposal from

  https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07290.html

with a bit of configure magic. It is enough to enable

   ./configure
   make
   make check

I've not tested it beyond that. Note it blows away the "build/"
dir each time ./configure is run so it is pristine each time.

We could optionally symlink binaries from build/ into $PWD
if poeople think that is important, eg by changing GNUmakefile
to have:

recurse: all
	for bin in `find build -maxdepth 1 -type f -executable | grep -v -E '(ninjatool|config.status)'`; \
	do \
	  ln -f -s $$bin . ; \
	done

and some cleanup logic to purge the symlinks for "make clean"

This goes on top of Paolo's most recent meson port v175 posting,
or whatever number it is upto now :-)

 .gitignore |  2 ++
 configure  | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 92311284ef..4ccb9ed975 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
+/GNUmakefile
+/build/
 /.doctrees
 /config-devices.*
 /config-all-devices.*
diff --git a/configure b/configure
index cc5f58f31a..a5c88ad1ac 100755
--- a/configure
+++ b/configure
@@ -11,6 +11,38 @@ unset CLICOLOR_FORCE GREP_OPTIONS
 # Don't allow CCACHE, if present, to use cached results of compile tests!
 export CCACHE_RECACHE=yes
 
+source_path=$(cd "$(dirname -- "$0")"; pwd)
+
+if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
+then
+  error_exit "main directory cannot contain spaces nor colons"
+fi
+
+if test "$PWD" == "$source_path"
+then
+    echo "Using './build' as the directory for build output"
+    rm -rf build
+    mkdir -p build
+    cat > GNUmakefile <<EOF
+
+ifeq (\$(MAKECMDGOALS),)
+recurse: all
+endif
+
+.NOTPARALLEL: %
+%: force
+	@echo 'changing dir to build for \$(MAKE) "\$(MAKECMDGOALS)"...'
+	@\$(MAKE) -C build -f Makefile \$(MAKECMDGOALS)
+	if test "\$(MAKECMDGOALS)" = "distclean" ; then rm -rf build ; fi
+force: ;
+.PHONY: force
+GNUmakefile: ;
+
+EOF
+    cd build
+    exec $source_path/configure "$@"
+fi
+
 # Temporary directory used for files created while
 # configure runs. Since it is in the build directory
 # we can safely blow away any previous version of it
@@ -297,14 +329,6 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-# make source path absolute
-source_path=$(cd "$(dirname -- "$0")"; pwd)
-
-if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
-then
-  error_exit "main directory cannot contain spaces nor colons"
-fi
-
 # default parameters
 cpu=""
 iasl="iasl"
-- 
2.26.2


