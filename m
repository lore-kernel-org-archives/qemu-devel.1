Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BCC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73EC2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxSBmZBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73EC2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxQIU-0002Vw-Tr
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 03:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxQHv-00026Q-Q4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 03:32:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxQHt-0003ex-JH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 03:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595230356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=sVHNNusbabg3FXIodu/DdT9bEQbHngGHyukpd5x+iyg=;
 b=fxSBmZBW1DPrd+KV1NHGr+VqSvo6JpP3Q/stxBZ2i+IC9ZBIjwPmN5s4rFlCzem7WDZ+yr
 nCOoby7l8KfMKrgKbDwbtCM9Iq/cqlcQizHMYYg+RvD7giqbbK3ALIaBdSWMuFhMvdQ5JH
 u/n0oTYAf9x8AWhv//I9erVP92qDiNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-mIkB6c5mMrWRJpqypLNGfA-1; Mon, 20 Jul 2020 03:32:33 -0400
X-MC-Unique: mIkB6c5mMrWRJpqypLNGfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58F010059B4;
 Mon, 20 Jul 2020 07:32:32 +0000 (UTC)
Received: from thuth.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7506C7849A;
 Mon, 20 Jul 2020 07:32:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v2] gitlab-ci.yml: Add oss-fuzz build tests
Date: Mon, 20 Jul 2020 09:32:23 +0200
Message-Id: <20200720073223.22945-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

This tries to build and run the fuzzers with the same build-script used
by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
but it can catch changes that are not compatible with the the
./scripts/oss-fuzz/build.sh script.
The strange way of finding fuzzer binaries stems from the method used by
oss-fuzz:
https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
[thuth: Tweak the "script" to make it work, exclude slirp test, etc.]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Needs Alexander's "fuzz: Fix leak when assembling datadir path
       string" patch applied first, otherwise it fails due to the leak.

 .gitlab-ci.yml | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 41597c3603..362e5ee755 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,22 +164,20 @@ build-clang:
       ppc-softmmu s390x-softmmu arm-linux-user
     MAKE_CHECK_ARGS: check
 
-build-fuzzer:
+build-oss-fuzz:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
   script:
-    - mkdir build
-    - cd build
-    - ../configure --cc=clang --cxx=clang++ --enable-fuzzing
-                   --enable-sanitizers --target-list=x86_64-softmmu
-    - make -j"$JOBS" all check-build x86_64-softmmu/fuzz
-    - make check
-    - for fuzzer in i440fx-qos-fork-fuzz i440fx-qos-noreset-fuzz
-        i440fx-qtest-reboot-fuzz virtio-scsi-flags-fuzz virtio-scsi-fuzz ; do
-          echo Testing ${fuzzer} ... ;
-          x86_64-softmmu/qemu-fuzz-x86_64 --fuzz-target=${fuzzer} -runs=1000
-            || exit 1 ;
+    - mkdir build-oss-fuzz
+    - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
+      ./scripts/oss-fuzz/build.sh
+    - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f
+                      | grep -v slirp); do
+        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
+        echo Testing ${fuzzer} ... ;
+        ASAN_OPTIONS="fast_unwind_on_malloc=0"
+         "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
       done
 
 build-tci:
-- 
2.18.1


