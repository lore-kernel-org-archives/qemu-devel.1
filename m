Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC96C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436D920732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIrU5Eb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436D920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Ef-0002s3-Dn
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DC-0000og-5G
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D9-0001Sa-FV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scXZbLfGf2wuLlYsTEFEHQHZT8J5ASPx+w+nFJSVsro=;
 b=fIrU5Eb5Y7BTOcRrJ6e5VVUUdiy75OCM2r8MlR7WNrT5CeZ3x/cjGmWDxGJjK08Dubs00b
 TmV3v/oLLBAkHxzukGlPct6BQBl+r9UzbJ4c5QQ9S/zsnS2Qo6cYlD3gxQBbCZMZxIu39q
 xWIoaG42mWdaSvV8FguX0bWEukKVj6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182--3cG4pP0P5-fKu97H3DxsA-1; Fri, 21 Aug 2020 06:23:49 -0400
X-MC-Unique: -3cG4pP0P5-fKu97H3DxsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFBA10082E7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF1925DA74;
 Fri, 21 Aug 2020 10:23:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 016/152] configure: add support for pseudo-"in source tree"
 builds
Date: Fri, 21 Aug 2020 06:21:13 -0400
Message-Id: <20200821102329.29777-17-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Meson requires the build dir to be separate from the source tree. Many
people are used to just running "./configure && make" though and the
meson conversion breaks that.

This introduces some backcompat support to make it appear as if an
"in source tree" build is being done, but with the the results in the
"build/" directory. This allows "./configure && make" to work as it
did historically, albeit with the output binaries staying under build/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore |  2 ++
 configure  | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index f8b3cd6fd5..d1e5e06242 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
+/GNUmakefile
+/build/
 /.doctrees
 /config-devices.*
 /config-all-devices.*
diff --git a/configure b/configure
index 35d6492343..cc04a560a0 100755
--- a/configure
+++ b/configure
@@ -11,6 +11,51 @@ unset CLICOLOR_FORCE GREP_OPTIONS
 # Don't allow CCACHE, if present, to use cached results of compile tests!
 export CCACHE_RECACHE=yes
 
+# make source path absolute
+source_path=$(cd "$(dirname -- "$0")"; pwd)
+
+if test "$PWD" == "$source_path"
+then
+    echo "Using './build' as the directory for build output"
+
+    MARKER=build/auto-created-by-configure
+
+    if test -e build
+    then
+	if test -f $MARKER
+	then
+	   rm -rf build
+	else
+	    echo "ERROR: ./build dir already exists and was not previously created by configure"
+	    exit 1
+	fi
+    fi
+
+    mkdir build
+    touch $MARKER
+
+    cat > GNUmakefile <<EOF
+# This file is auto-generated by configure to support in-source tree
+# 'make' command invokation
+
+ifeq (\$(MAKECMDGOALS),)
+recurse: all
+endif
+
+.NOTPARALLEL: %
+%: force
+	@echo 'changing dir to build for \$(MAKE) "\$(MAKECMDGOALS)"...'
+	@\$(MAKE) -C build -f Makefile \$(MAKECMDGOALS)
+	@if test "\$(MAKECMDGOALS)" = "distclean" && test -e build/auto-created-by-configure ; then rm -rf build GNUmakefile ; fi
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
@@ -279,9 +324,6 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-# make source path absolute
-source_path=$(cd "$(dirname -- "$0")"; pwd)
-
 if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
 then
   error_exit "main directory cannot contain spaces nor colons"
-- 
2.26.2



