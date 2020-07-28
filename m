Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE7BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF9D21D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvpBUi2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF9D21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KIf-0004j6-1W
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHc-00035g-4J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHa-0003vu-Aw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpkaFcYQYHx+zZ+8hZ4X47r+pwThvDrfZySDw4Bws40=;
 b=KvpBUi2WVciix//u0t9Gxd326gq8JN49HXZNEyi6MSUZwCmZXEJoRBXyAYqEva2WsTEE3O
 4nU9pNWOsdIvFNzi84NgB3MbK1mYIqlrGO9bDTDbgkaQj29DnOxCCeDcwCv2o0Wo8i4HZ1
 vEcV1G+fj9q48SnRborwhjPB65kegbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-ylzLbyqgMhiubtCumDHCFg-1; Tue, 28 Jul 2020 03:44:13 -0400
X-MC-Unique: ylzLbyqgMhiubtCumDHCFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12B9A800597;
 Tue, 28 Jul 2020 07:44:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19AFF726B6;
 Tue, 28 Jul 2020 07:44:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/4] configure: Fix atomic64 test for --enable-werror on
 macOS
Date: Tue, 28 Jul 2020 09:44:02 +0200
Message-Id: <20200728074405.13118-2-thuth@redhat.com>
In-Reply-To: <20200728074405.13118-1-thuth@redhat.com>
References: <20200728074405.13118-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
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
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..6fbc72c794 100755
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


