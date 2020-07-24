Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF08C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3929B2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+U6LXnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3929B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyylU-00067A-LZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyykW-0004tR-8P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:32:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyykT-0004ZY-Mo
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=y5PVdZ0cYOEm5/CZaZhqijoIyn+UzcSxvl3in+uddos=;
 b=d+U6LXnrgbcG6YzAJiaTcEYHUlPCJUgqVvYa+dhXdqT3/3EORvNXCt/679c3LGaQuY2HBU
 Vf0wk9m05IzxhWuotu2AG7a2BYMUY+r4nh1Cy3zTCTgX31skc0qYPM/iqGKXsuN2BvrHhg
 LkgCRpDrR1XLYcMrgdZt0/IAFYyzk9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Q4sBTFLBPJK9-i4sX7iH-Q-1; Fri, 24 Jul 2020 10:32:28 -0400
X-MC-Unique: Q4sBTFLBPJK9-i4sX7iH-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAB1D8014D4;
 Fri, 24 Jul 2020 14:32:26 +0000 (UTC)
Received: from thuth.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0E6D2DE79;
 Fri, 24 Jul 2020 14:32:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/3] configure: Fix atomic64 test for --enable-werror on macOS
Date: Fri, 24 Jul 2020 16:32:18 +0200
Message-Id: <20200724143220.32751-2-thuth@redhat.com>
In-Reply-To: <20200724143220.32751-1-thuth@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using --enable-werror for the macOS builders in the Cirrus-CI,
the atomic64 test is currently failing, and config.log shows a bunch
of error messages like this:

 config-temp/qemu-conf.c:6:7: error: implicit declaration of function
 '__atomic_load_8' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
  y = __atomic_load_8(&x, 0);
      ^
 config-temp/qemu-conf.c:6:7: error: this function declaration is not a
 prototype [-Werror,-Wstrict-prototypes]

Seems like these __atomic_*_8 functions are available in one of the
libraries there, so that the test links and passes there when not
using --enable-werror. But there does not seem to be a valid prototype
for them in any of the header files, so that the test fails when using
--enable-werror.

Fix it by using the "official" built-in functions instead (see e.g.
https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html).
We are not using the *_8 variants in QEMU anyway.

Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 4bd80ed507..9eaf501f50 100755
--- a/configure
+++ b/configure
@@ -5919,11 +5919,11 @@ int main(void)
 {
   uint64_t x = 0, y = 0;
 #ifdef __ATOMIC_RELAXED
-  y = __atomic_load_8(&x, 0);
-  __atomic_store_8(&x, y, 0);
-  __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
-  __atomic_exchange_8(&x, y, 0);
-  __atomic_fetch_add_8(&x, y, 0);
+  y = __atomic_load_n(&x, __ATOMIC_RELAXED);
+  __atomic_store_n(&x, y, __ATOMIC_RELAXED);
+  __atomic_compare_exchange_n(&x, &y, x, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
+  __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
+  __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
 #else
   typedef char is_host64[sizeof(void *) >= sizeof(uint64_t) ? 1 : -1];
   __sync_lock_test_and_set(&x, y);
-- 
2.18.1


