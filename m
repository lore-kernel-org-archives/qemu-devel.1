Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EF6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6908207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4hwFlYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6908207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcJF-0002wB-60
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcGC-0005Cl-Sh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcGA-0000bm-SR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uXV+T/HYmL2WGCSQbjUYrOSpkTcCjueGq8gGiNN3NQ=;
 b=G4hwFlYgH359/wwCi3PGn+AyuE4qSV6kma9mNn64qNgOJpk/zg55UmyVj/cxIRpX/MeYmF
 //a3UzgVJXuMN8jnOYM3PznalpSKkVsV2FowT177X1MmthZY9g3OXs42ZIpH+xBf52w5UE
 zJKVMZeF/qeKXWDih9J2aLK9DVH4KVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-Io7p_g0NOyaPebPXzdr4oQ-1; Fri, 28 Aug 2020 07:09:28 -0400
X-MC-Unique: Io7p_g0NOyaPebPXzdr4oQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56F951074650
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:09:27 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB5774E1E;
 Fri, 28 Aug 2020 11:09:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] tests: do not print benchmark output to stdout
Date: Fri, 28 Aug 2020 15:07:30 +0400
Message-Id: <20200828110734.1638685-13-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 07:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As this makes the TAP output invalid. Use g_test_message().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 8 ++++----
 tests/benchmark-crypto-hash.c   | 2 +-
 tests/benchmark-crypto-hmac.c   | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
index 53032334ec..1936aa4ae0 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -70,8 +70,8 @@ static void test_cipher_speed(size_t chunk_size,
     }
     g_test_timer_elapsed();
 
-    g_print("Enc chunk %zu bytes ", chunk_size);
-    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("Enc chunk %zu bytes ", chunk_size);
+    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
 
     g_test_timer_start();
     remain = total;
@@ -85,8 +85,8 @@ static void test_cipher_speed(size_t chunk_size,
     }
     g_test_timer_elapsed();
 
-    g_print("Dec chunk %zu bytes ", chunk_size);
-    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("Dec chunk %zu bytes ", chunk_size);
+    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
 
     qcrypto_cipher_free(cipher);
     g_free(plaintext);
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
index d16837d00a..598111e75a 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -48,7 +48,7 @@ static void test_hash_speed(const void *opaque)
     }
     g_test_timer_elapsed();
 
-    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
+    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
 
     g_free(out);
     g_free(in);
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
index f1dfa240cb..f9fa22df95 100644
--- a/tests/benchmark-crypto-hmac.c
+++ b/tests/benchmark-crypto-hmac.c
@@ -55,10 +55,10 @@ static void test_hmac_speed(const void *opaque)
     } while (g_test_timer_elapsed() < 5.0);
 
     total /= MiB;
-    g_print("hmac(sha256): ");
-    g_print("Testing chunk_size %zu bytes ", chunk_size);
-    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
-    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+    g_test_message("hmac(sha256): ");
+    g_test_message("Testing chunk_size %zu bytes ", chunk_size);
+    g_test_message("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_test_message("%.2f MB/sec\n", total / g_test_timer_last());
 
     g_free(out);
     g_free(in);
-- 
2.26.2


