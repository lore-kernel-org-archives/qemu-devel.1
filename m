Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0DE2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/MsqyyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0DE2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnPa-0004JR-CO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMo-0007ks-DT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMm-0004L0-Gu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ldZrdFQQGz1Yy1QUIGAAXqyy0sFLWE05aOBnAswqw6M=;
 b=J/MsqyyNaO0urdVqtcjyT038z6oMqDOT9u96D31KGtzNLpGVjj0W3fb8be33ZV/eC1+S20
 gyBx3yEkjeR0PgRwAywm02aip/RZ2mvaf7XDxVYOnkTfGbh+/ToUsynJEQbRzC8dJXVV8D
 T4+wlZ/QspmO8DUjDn+CYpi7wbtzHA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-IAa5m0N6MwaEzOG1UUA1ZA-1; Tue, 21 Jul 2020 04:11:09 -0400
X-MC-Unique: IAa5m0N6MwaEzOG1UUA1ZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A4018C63C2;
 Tue, 21 Jul 2020 08:11:08 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4DD19C66;
 Tue, 21 Jul 2020 08:11:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/10] docs/fuzz: add instructions for generating a coverage
 report
Date: Tue, 21 Jul 2020 10:10:52 +0200
Message-Id: <20200721081055.14073-8-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200706195534.14962-5-alxndr@bu.edu>
[thuth: Replaced --enable-sanitizers with --enable-fuzzing]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/fuzzing.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 6d18115239..96d71c94d7 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -85,6 +85,25 @@ better coverage performance, depending on the target.
 Note that libFuzzer's exact behavior will depend on the version of
 clang and libFuzzer used to build the device fuzzers.
 
+== Generating Coverage Reports ==
+Code coverage is a crucial metric for evaluating a fuzzer's performance.
+libFuzzer's output provides a "cov: " column that provides a total number of
+unique blocks/edges covered. To examine coverage on a line-by-line basis we
+can use Clang coverage:
+
+ 1. Configure libFuzzer to store a corpus of all interesting inputs (see
+    CORPUS_DIR above)
+ 2. ./configure the QEMU build with:
+    --enable-fuzzing \
+    --extra-cflags="-fprofile-instr-generate -fcoverage-mapping"
+ 3. Re-run the fuzzer. Specify $CORPUS_DIR/* as an argument, telling libfuzzer
+    to execute all of the inputs in $CORPUS_DIR and exit. Once the process
+    exits, you should find a file, "default.profraw" in the working directory.
+ 4. Execute these commands to generate a detailed HTML coverage-report:
+ llvm-profdata merge -output=default.profdata default.profraw
+ llvm-cov show ./path/to/qemu-fuzz-i386 -instr-profile=default.profdata \
+ --format html -output-dir=/path/to/output/report
+
 == Adding a new fuzzer ==
 Coverage over virtual devices can be improved by adding additional fuzzers.
 Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-- 
2.18.1


