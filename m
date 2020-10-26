Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4DDC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF416223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caAeYjqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF416223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzXM-0006Ey-T5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPF-0002gc-96
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzP7-0006ha-M3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=QwqLwETTwMwtQBrfjojZlNqQn/DL9uFwH1MP8X5pkyA=;
 b=caAeYjqbaNDs25fzFs85gs/ZAfcEV05E2D1FNdy7QzZwjo1coXNr8C0E730Y2cWdNBK/m8
 UsZhCr6V4POEYBzvQusmKMkaRvw+BpZEtxOoyWONRPWtD3NpWgQMtynZVt6vWHo3839gFL
 Z7/Fz+vRqRomkhvtl35X2e85Zndj4NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-VIJoKiMQOKipfCdKTGInqg-1; Mon, 26 Oct 2020 06:07:00 -0400
X-MC-Unique: VIJoKiMQOKipfCdKTGInqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7584764AEB;
 Mon, 26 Oct 2020 10:06:59 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E7D28B84C;
 Mon, 26 Oct 2020 10:06:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/31] fuzz: Add support for custom crossover functions
Date: Mon, 26 Oct 2020 11:06:16 +0100
Message-Id: <20201026100632.212530-16-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

libfuzzer supports a "custom crossover function". Libfuzzer often tries
to blend two inputs to create a new interesting input. Sometimes, we
have a better idea about how to blend inputs together. This change
allows fuzzers to specify a custom function for blending two inputs
together.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20201023150746.107063-8-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/fuzz.c | 13 +++++++++++++
 tests/qtest/fuzz/fuzz.h | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index eb0070437f..7be7226bc0 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -118,6 +118,19 @@ static FuzzTarget *fuzz_get_target(char* name)
 }
 
 
+/* Sometimes called by libfuzzer to mutate two inputs into one */
+size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
+                                 const uint8_t *data2, size_t size2,
+                                 uint8_t *out, size_t max_out_size,
+                                 unsigned int seed)
+{
+    if (fuzz_target->crossover) {
+        return fuzz_target->crossover(data1, size1, data2, size2, out,
+                                      max_out_size, seed);
+    }
+    return 0;
+}
+
 /* Executed for each fuzzing-input */
 int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
 {
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 8eb765edc8..ed9ce17154 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -77,6 +77,29 @@ typedef struct FuzzTarget {
      */
     void(*fuzz)(QTestState *, const unsigned char *, size_t);
 
+    /*
+     * The fuzzer can specify a "Custom Crossover" function for combining two
+     * inputs from the corpus. This function is sometimes called by libfuzzer
+     * when mutating inputs.
+     *
+     * data1: location of first input
+     * size1: length of first input
+     * data1: location of second input
+     * size1: length of second input
+     * out: where to place the resulting, mutated input
+     * max_out_size: the maximum length of the input that can be placed in out
+     * seed: the seed that should be used to make mutations deterministic, when
+     *       needed
+     *
+     * See libfuzzer's LLVMFuzzerCustomCrossOver API for more info.
+     *
+     * Can be NULL
+     */
+    size_t(*crossover)(const uint8_t *data1, size_t size1,
+                       const uint8_t *data2, size_t size2,
+                       uint8_t *out, size_t max_out_size,
+                       unsigned int seed);
+
 } FuzzTarget;
 
 void flush_events(QTestState *);
@@ -91,6 +114,10 @@ void fuzz_qtest_set_serialize(bool option);
  */
 void fuzz_add_target(const FuzzTarget *target);
 
+size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
+                                 const uint8_t *data2, size_t size2,
+                                 uint8_t *out, size_t max_out_size,
+                                 unsigned int seed);
 int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
 int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
 
-- 
2.18.2


