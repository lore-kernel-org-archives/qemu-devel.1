Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1820C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE8D2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCykeDdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE8D2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnPW-0004Gg-0m
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMk-0007b6-K0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMi-0004KI-6y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDeCjODWd2sR1PLveUfus8P4jDOiazbulApwjnBgP2k=;
 b=fCykeDdO5+k6n4OH2asE/nrNLyexU7FH8wU7XM0Q0PsgHfsl8sE1WD8IQ05YBuoF59O/Wz
 av979rmq7NZA2XzexTvvmExlgW98AAjOqCLpEAtXLMGGw9pNZE6wx4eGm64UeFAfWpb24T
 wB/C5dHQ0fK685nTq48LfHnfJELe2Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-6bkaSYZ_OXKlOCF7DYzZ4w-1; Tue, 21 Jul 2020 04:11:05 -0400
X-MC-Unique: 6bkaSYZ_OXKlOCF7DYzZ4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26A7B18C63C1;
 Tue, 21 Jul 2020 08:11:04 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2272DE68;
 Tue, 21 Jul 2020 08:11:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/10] fuzz: build without AddressSanitizer, by default
Date: Tue, 21 Jul 2020 10:10:49 +0200
Message-Id: <20200721081055.14073-5-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

We already have a nice --enable-sanitizers option to enable
AddressSanitizer. There is no reason to duplicate and force this
functionality in --enable-fuzzing. In the future, if more sanitizers are
added to --enable-sanitizers, it might be impossible to build with both
--enable-sanitizers and --enable-fuzzing, since not all sanitizers are
compatible with libFuzzer. In that case, we could enable ASAN with
--extra-cflags="-fsanitize=address"

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200706195534.14962-2-alxndr@bu.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Added missing $CFLAGS]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 33cee41f9c..4bd80ed507 100755
--- a/configure
+++ b/configure
@@ -6337,7 +6337,7 @@ fi
 # checks for fuzzer
 if test "$fuzzing" = "yes" ; then
   write_c_fuzzer_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address,fuzzer" ""; then
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
       have_fuzzer=yes
   fi
 fi
@@ -7893,11 +7893,11 @@ if test "$have_mlockall" = "yes" ; then
 fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
-    FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
-    FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
-    CFLAGS="$CFLAGS -fsanitize=address,fuzzer-no-link"
+    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
+    FUZZ_CFLAGS=" -fsanitize=fuzzer"
+    CFLAGS="$CFLAGS -fsanitize=fuzzer-no-link"
   else
-    error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
+    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
     exit 1
   fi
 fi
-- 
2.18.1


