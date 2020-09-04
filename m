Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65E20791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7v9cAES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65E20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAFw-0001vU-LX
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6P-0008VP-9x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6N-0005FA-BR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599219714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu1Kg1wdckySKcltYtdl2FfbJunXDMOLnibGU3qESxk=;
 b=D7v9cAESn7Xsew085L5zL1Rzw5MPW6zgRijE236qMwc07uBi8Qorjsg90W7zL0rraalX1N
 gtlNTMHVVRIC046GuqW+QvhfMFNpNSXDj0i2a1ua9FgIHGJn3hiETiwaUDdIvTmGYvtawq
 Flu2Og8mcTZSv/Cu80KZy4y9p/fvwGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-hYXD8MaFPReO6ir9Juys5w-1; Fri, 04 Sep 2020 07:41:52 -0400
X-MC-Unique: hYXD8MaFPReO6ir9Juys5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46AB21040A3D
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C266756DB;
 Fri,  4 Sep 2020 11:41:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/46] meson: convert atomic*-bench
Date: Fri,  4 Sep 2020 07:40:57 -0400
Message-Id: <20200904114122.31307-22-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-11-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  5 -----
 tests/meson.build      | 10 ++++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 04ffda66a5..0388a0e4fd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -44,11 +44,6 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 
 QEMU_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
-# Deps that are common to various different sets of tests below
-test-util-obj-y = libqemuutil.a
-tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
-tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
-
 tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
 tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test-crypto-obj-y)
 tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
diff --git a/tests/meson.build b/tests/meson.build
index 5fdca64e82..e97927d0be 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -4,6 +4,16 @@ qht_bench = executable('qht-bench',
                        sources: 'qht-bench.c',
                        dependencies: [qemuutil])
 
+executable('atomic_add-bench',
+           sources: files('atomic_add-bench.c'),
+           dependencies: [qemuutil],
+           build_by_default: false)
+
+executable('atomic64-bench',
+           sources: files('atomic64-bench.c'),
+           dependencies: [qemuutil],
+           build_by_default: false)
+
 test_qapi_outputs = [
   'qapi-builtin-types.c',
   'qapi-builtin-types.h',
-- 
2.26.2



