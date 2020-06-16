Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87488C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306CD2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h73cYB+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306CD2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7UY-00032u-DX
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QM-0006jW-KZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QJ-0002As-Tf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCWPnW9NpKBObU1OeJx/RRMHYxLgWOn5n0GvmCJYNSE=;
 b=h73cYB+t8dx3gk2BBSRO7z1vtkGGZL8FLKXhn/4Fz4P9wUz3r9ijl/LfLEsdE6sNERPmIm
 ArcPeYEmGns3BtAQNgl/q9YKaEClSut8ItOVRHOuQYTCFwU4SXY0hDi1lahXlAR4sXt9kN
 88c9qYznnpRvVCwiFh/B0s5LZjcF8Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-T0R9bWkjORqDO7VoAfHPqg-1; Tue, 16 Jun 2020 04:58:23 -0400
X-MC-Unique: T0R9bWkjORqDO7VoAfHPqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF3F418585BC;
 Tue, 16 Jun 2020 08:58:22 +0000 (UTC)
Received: from thuth.com (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDE6A6ED96;
 Tue, 16 Jun 2020 08:58:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 4/7] fuzz: add oss-fuzz build-script
Date: Tue, 16 Jun 2020 10:58:10 +0200
Message-Id: <20200616085813.29296-5-thuth@redhat.com>
In-Reply-To: <20200616085813.29296-1-thuth@redhat.com>
References: <20200616085813.29296-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

It is neater to keep this in the QEMU repo, since any change that
requires an update to the oss-fuzz build configuration, can make the
necessary changes in the same series.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20200612055145.12101-1-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS               |   1 +
 scripts/oss-fuzz/build.sh | 105 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 scripts/oss-fuzz/build.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index a922775e45..9ec50e165d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2339,6 +2339,7 @@ R: Bandan Das <bsd@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: tests/qtest/fuzz/
+F: scripts/oss-fuzz/
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
new file mode 100755
index 0000000000..f5cee3d67e
--- /dev/null
+++ b/scripts/oss-fuzz/build.sh
@@ -0,0 +1,105 @@
+#!/bin/sh -e
+#
+# OSS-Fuzz build script. See:
+# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
+#
+# The file is consumed by:
+# https://github.com/google/oss-fuzz/blob/master/projects/qemu/Dockerfiles
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+# build project
+# e.g.
+# ./autogen.sh
+# ./configure
+# make -j$(nproc) all
+
+# build fuzzers
+# e.g.
+# $CXX $CXXFLAGS -std=c++11 -Iinclude \
+#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
+#     $LIB_FUZZING_ENGINE /path/to/library.a
+
+fatal () {
+    echo "Error : ${*}, exiting."
+    exit 1
+}
+
+OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
+
+# There seems to be a bug in clang-11 (used for builds on oss-fuzz) :
+#   accel/tcg/cputlb.o: In function `load_memop':
+#   accel/tcg/cputlb.c:1505: undefined reference to `qemu_build_not_reached'
+#
+# When building with optimization, the compiler is expected to prove that the
+# statement cannot be reached, and remove it. For some reason clang-11 doesn't
+# remove it, resulting in an unresolved reference to qemu_build_not_reached
+# Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
+# to " #define qemu_build_not_reached()  g_assert_not_reached() "
+EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
+
+if ! { [ -e "./COPYING" ] &&
+   [ -e "./MAINTAINERS" ] &&
+   [ -e "./Makefile" ] &&
+   [ -e "./docs" ] &&
+   [ -e "./VERSION" ] &&
+   [ -e "./linux-user" ] &&
+   [ -e "./softmmu" ];} ; then
+    fatal "Please run the script from the top of the QEMU tree"
+fi
+
+mkdir -p $OSS_FUZZ_BUILD_DIR || fatal "mkdir $OSS_FUZZ_BUILD_DIR failed"
+cd $OSS_FUZZ_BUILD_DIR || fatal "cd $OSS_FUZZ_BUILD_DIR failed"
+
+
+if [ -z ${LIB_FUZZING_ENGINE+x} ]; then
+    LIB_FUZZING_ENGINE="-fsanitize=fuzzer"
+fi
+
+if [ -z ${OUT+x} ]; then
+    DEST_DIR=$(realpath "./DEST_DIR")
+else
+    DEST_DIR=$OUT
+fi
+
+mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
+
+# Build once to get the list of dynamic lib paths, and copy them over
+../configure --disable-werror --cc="$CC" --cxx="$CXX" \
+    --extra-cflags="$EXTRA_CFLAGS"
+
+if ! make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" \
+    i386-softmmu/fuzz; then
+    fatal "Build failed. Please specify a compiler with fuzzing support"\
+          "using the \$CC and \$CXX environemnt variables, or specify a"\
+          "\$LIB_FUZZING_ENGINE compatible with your compiler"\
+          "\nFor example: CC=clang CXX=clang++ $0"
+fi
+
+for i in $(ldd ./i386-softmmu/qemu-fuzz-i386 | cut -f3 -d' '); do
+    cp "$i" "$DEST_DIR/lib/"
+done
+rm ./i386-softmmu/qemu-fuzz-i386
+
+# Build a second time to build the final binary with correct rpath
+../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
+    --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
+    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
+make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" i386-softmmu/fuzz
+
+# Copy over the datadir
+cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
+
+# Run the fuzzer with no arguments, to print the help-string and get the list
+# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
+# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
+# executable name)
+for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+do
+    cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
+done
+
+echo "Done. The fuzzers are located in $DEST_DIR"
+exit 0
-- 
2.18.1


