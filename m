Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87385C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515B920773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOvvPrlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515B920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVBO-0007mq-Ac
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1Q-0001Ee-ET
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:50:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1N-0005U0-Rl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=DLKnJJlqyxKlTxPdWtjq8QMe68+OdMuREqKFecQvsfU=;
 b=aOvvPrlD0E3T8kN8iAmcs7oKxkFU+SMxW1uCUHC0UCqQe0AKCUBIu0Qs6DV9Sa7Tc0hFSL
 Bs6jOXqqKf+Vm1UtnAUX0f66VAkl5/heOmlUNRN10i3hIhB7Wm9ZS2dHXzVGsZwMkpX8JU
 5TVElVcNQfJ/ffYc6mKIEXRSXICqlCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-DlmhCj00Pq2xBAq2lqi_qg-1; Wed, 02 Sep 2020 11:49:58 -0400
X-MC-Unique: DlmhCj00Pq2xBAq2lqi_qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A770C807356;
 Wed,  2 Sep 2020 15:49:57 +0000 (UTC)
Received: from thuth.com (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF35E5D9CC;
 Wed,  2 Sep 2020 15:49:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 14/15] gitlab-ci.yml: Run check-qtest and check-unit at the
 end of the fuzzer job
Date: Wed,  2 Sep 2020 17:49:31 +0200
Message-Id: <20200902154932.390595-15-thuth@redhat.com>
In-Reply-To: <20200902154932.390595-1-thuth@redhat.com>
References: <20200902154932.390595-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The fuzzer job finishes quite early, so we can run the unit tests and
qtests with -fsanitize=address here without extending the total test time.

Message-Id: <20200831153228.229185-1-thuth@redhat.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8ae3e31c3f..5f2964a85e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -255,13 +255,15 @@ build-oss-fuzz:
     - mkdir build-oss-fuzz
     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
       ./scripts/oss-fuzz/build.sh
+    - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
     - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f
                       | grep -v slirp); do
         grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
         echo Testing ${fuzzer} ... ;
-        ASAN_OPTIONS="fast_unwind_on_malloc=0"
-         "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
+        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
       done
+    # Unrelated to fuzzer: run some tests with -fsanitize=address
+    - cd build-oss-fuzz && make check-qtest-i386 check-unit
 
 build-tci:
   <<: *native_build_job_definition
-- 
2.18.2


