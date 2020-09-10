Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0948E20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8KZpOxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0948E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJUN-0001k3-QM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTM-0008UC-Lu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTK-0007fr-B1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYz9Tr2y212XkXHhsr+3qx5QuMca9yqiXm4k6okHSa4=;
 b=d8KZpOxGHldPWLs58UppGUSE6WZcgEVMQNfI67TBOURzvRmd4jWr+uY+YuXpDWM0X21QAE
 /DOzzSfuJjYA9eV08utdTXS6sXUx6KnTYGxeypFJuIR0wSi69EYqw+qXb7qypIRgSUg9Rn
 Efbhoz3BSprvfiYTcukV8DwU+gDAMCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-C36wSHbTOIq5ThHOaB1LvA-1; Thu, 10 Sep 2020 06:06:27 -0400
X-MC-Unique: C36wSHbTOIq5ThHOaB1LvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38A71074640
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:06:26 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 675C31002D41;
 Thu, 10 Sep 2020 10:06:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] tests: fix output message formatting for crypto
 benchmarks
Date: Thu, 10 Sep 2020 11:06:07 +0100
Message-Id: <20200910100623.1088965-2-berrange@redhat.com>
In-Reply-To: <20200910100623.1088965-1-berrange@redhat.com>
References: <20200910100623.1088965-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The output was changed from g_print to g_test_message in

  commit 24441f912e67233d9c52ce6b459ed75de2484525
  Author: Marc-André Lureau <marcandre.lureau@redhat.com>
  Date:   Fri Aug 28 15:07:30 2020 +0400

    tests: do not print benchmark output to stdout

    As this makes the TAP output invalid. Use g_test_message().

The functions do not result in equivalent output. The g_print
statements were putting all the information on a single line
for ease of interpretation. The change to g_test_message split
the output across many lines making it painful to read.

The opportunity is used to tweak the information printed to be
more consistent across tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 12 ++++++++----
 tests/benchmark-crypto-hash.c   |  4 +++-
 tests/benchmark-crypto-hmac.c   |  7 +++----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
index 1936aa4ae0..c04f0a0fba 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -70,8 +70,10 @@ static void test_cipher_speed(size_t chunk_size,
     }
     g_test_timer_elapsed();
 
-    g_test_message("Enc chunk %zu bytes ", chunk_size);
-    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("enc(%s-%s) chunk %zu bytes %.2f MB/sec ",
+                   QCryptoCipherAlgorithm_str(alg),
+                   QCryptoCipherMode_str(mode),
+                   chunk_size, (double)total / MiB / g_test_timer_last());
 
     g_test_timer_start();
     remain = total;
@@ -85,8 +87,10 @@ static void test_cipher_speed(size_t chunk_size,
     }
     g_test_timer_elapsed();
 
-    g_test_message("Dec chunk %zu bytes ", chunk_size);
-    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("dec(%s-%s) chunk %zu bytes %.2f MB/sec ",
+                   QCryptoCipherAlgorithm_str(alg),
+                   QCryptoCipherMode_str(mode),
+                   chunk_size, (double)total / MiB / g_test_timer_last());
 
     qcrypto_cipher_free(cipher);
     g_free(plaintext);
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
index 598111e75a..927b00bb4d 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -48,7 +48,9 @@ static void test_hash_speed(const void *opaque)
     }
     g_test_timer_elapsed();
 
-    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("hash(%s): chunk %zu bytes %.2f MB/sec",
+                   QCryptoHashAlgorithm_str(opts->alg),
+                   opts->chunk_size, total / g_test_timer_last());
 
     g_free(out);
     g_free(in);
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
index f9fa22df95..5cca636789 100644
--- a/tests/benchmark-crypto-hmac.c
+++ b/tests/benchmark-crypto-hmac.c
@@ -55,10 +55,9 @@ static void test_hmac_speed(const void *opaque)
     } while (g_test_timer_elapsed() < 5.0);
 
     total /= MiB;
-    g_test_message("hmac(sha256): ");
-    g_test_message("Testing chunk_size %zu bytes ", chunk_size);
-    g_test_message("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
-    g_test_message("%.2f MB/sec\n", total / g_test_timer_last());
+    g_test_message("hmac(%s): chunk %zu bytes %.2f MB/sec",
+                   QCryptoHashAlgorithm_str(QCRYPTO_HASH_ALG_SHA256),
+                   chunk_size, total / g_test_timer_last());
 
     g_free(out);
     g_free(in);
-- 
2.26.2


