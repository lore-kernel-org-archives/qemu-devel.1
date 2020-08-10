Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A046A20866
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev33jy0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A046A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BJP-0006eu-Ns
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIW-0005A9-1g
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIT-0002gN-TU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3WR+7vf5orqhtCW52eKbI13vQ/eSMFjPNRLaT3u15wY=;
 b=Ev33jy0gKKB+qcrOgjUqUJ5vi5QsKWrozUj0vWNizwJWzpl9mht1emzcmkLG+pyKl/iYrV
 x6Ayr+BFpjb4OuGmpStaUJ7Nnf8uzoka7zIg1g1ZGxCRo3tWTQUANmDYXq25s5m9c2+XAj
 q6nAFTPYcpeDr/9UwBlsh2SaEUTZcfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-49tKpti4MOWlCzfPYc8hDg-1; Mon, 10 Aug 2020 13:09:15 -0400
X-MC-Unique: 49tKpti4MOWlCzfPYc8hDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336F119057A8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:14 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7950787D61
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 001/147] oss-fuzz/build: remove LIB_FUZZING_ENGINE
Date: Mon, 10 Aug 2020 19:06:39 +0200
Message-Id: <1597079345-42801-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson build scripts will only include qemu-fuzz-TARGET rules if configured
with --enable-fuzzing, and that takes care of adding -fsanitize=fuzzer.
Therefore we can just specify the configure option and stop modifying
the CFLAGS and CONFIG_FUZZ options in the "make" invocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/oss-fuzz/build.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index a07b302..52430cb 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -20,7 +20,7 @@
 # e.g.
 # $CXX $CXXFLAGS -std=c++11 -Iinclude \
 #     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
-#     $LIB_FUZZING_ENGINE /path/to/library.a
+#     -fsanitize=fuzzer /path/to/library.a
 
 fatal () {
     echo "Error : ${*}, exiting."
@@ -54,10 +54,6 @@ mkdir -p $OSS_FUZZ_BUILD_DIR || fatal "mkdir $OSS_FUZZ_BUILD_DIR failed"
 cd $OSS_FUZZ_BUILD_DIR || fatal "cd $OSS_FUZZ_BUILD_DIR failed"
 
 
-if [ -z ${LIB_FUZZING_ENGINE+x} ]; then
-    LIB_FUZZING_ENGINE="-fsanitize=fuzzer"
-fi
-
 if [ -z ${OUT+x} ]; then
     DEST_DIR=$(realpath "./DEST_DIR")
 else
@@ -67,14 +63,12 @@ fi
 mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
 # Build once to get the list of dynamic lib paths, and copy them over
-../configure --disable-werror --cc="$CC" --cxx="$CXX" \
+../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
 
-if ! make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" \
-    i386-softmmu/fuzz; then
+if ! make "-j$(nproc)" i386-softmmu/fuzz; then
     fatal "Build failed. Please specify a compiler with fuzzing support"\
-          "using the \$CC and \$CXX environemnt variables, or specify a"\
-          "\$LIB_FUZZING_ENGINE compatible with your compiler"\
+          "using the \$CC and \$CXX environemnt variables"\
           "\nFor example: CC=clang CXX=clang++ $0"
 fi
 
@@ -87,7 +81,7 @@ rm ./i386-softmmu/qemu-fuzz-i386
 ../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
     --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
     --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
-make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" i386-softmmu/fuzz
+make "-j$(nproc)" i386-softmmu/fuzz
 
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
-- 
1.8.3.1



