Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08582072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ+nmMcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08582072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDV2h-0002WQ-1G
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1E-0000oZ-Ex
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1A-0005S3-PZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGX24JLWY+r+tY1063hh0dFOTGKKnnVLI9RwqEGli3I=;
 b=KJ+nmMcf+z3yQV/xIfH2ngT+MNpJ/UlW8PYsZXgZATmTdU6Awzqn9HdAYRVlSRRuy3sFQg
 xDYHmDstNc22lm6lFL6NIxnFjbBCyFv1Yqxo9D5Mdag43j0OLSkD4X4u7RlG4vsYoAf0lq
 X8z3rUuYOUkZFc8Q99JIr9geldT133E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-DVS02I7XOsiutP6ZcjJOZg-1; Wed, 02 Sep 2020 11:49:43 -0400
X-MC-Unique: DVS02I7XOsiutP6ZcjJOZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684A61005504;
 Wed,  2 Sep 2020 15:49:42 +0000 (UTC)
Received: from thuth.com (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD4C5D9CC;
 Wed,  2 Sep 2020 15:49:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 01/15] configure: Fix atomic64 test for --enable-werror on
 macOS
Date: Wed,  2 Sep 2020 17:49:18 +0200
Message-Id: <20200902154932.390595-2-thuth@redhat.com>
In-Reply-To: <20200902154932.390595-1-thuth@redhat.com>
References: <20200902154932.390595-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <20200728074405.13118-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 8a3acef89d..5645575688 100755
--- a/configure
+++ b/configure
@@ -5755,11 +5755,11 @@ int main(void)
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
2.18.2


