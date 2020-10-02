Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF6AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A676206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bQRIGI8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A676206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKZP-0001uv-GM
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <813e27cea046e75b0c8a249637a4ebf20d687d02@lizzy.crudebyte.com>)
 id 1kOKYQ-0001FS-S6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:52:54 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <813e27cea046e75b0c8a249637a4ebf20d687d02@lizzy.crudebyte.com>)
 id 1kOKYP-0008Q6-Ac
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=iovGPj5Q92eV7i24vjrQeAdFBH4d8kiFupqK9XpeZzs=; b=bQRIG
 I8CdoDpZkhpZnGOVGeDZstJRMUzzuBJhAWzWi0J4/bP/r+oCstfOlA0Fy7FkoG78hHrWcQS3Wv5Ix
 72p6+dvc1BmXx21dtwFea7WQLZKrBuPvLZZX4y7/mHNsFKXZxKBkn4QFaUdk3lwPHHjm8QRfjCF0c
 P2RDIIrEEzxJNSh2HJzLS9JRv3Y3m1q8EN8PYsVtm7tE0azKqRKaTouJ5gWVTLmuzL55iAYU1VbrY
 k3hAI0wUgAr8xK2sxgBfTxdds9iQKj9GQMoPHElCv+fZbSZCSNM84M3soJS8Va2wvazgjxYV1Xgzx
 INFHJw++hVU9sGa6Bm3TNP72emLDA==;
Message-Id: <813e27cea046e75b0c8a249637a4ebf20d687d02.1601639563.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601639563.git.qemu_oss@crudebyte.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 13:51:54 +0200
Subject: [PATCH v2 06/11] tests/qtest/qos-test: dump QEMU command if verbose
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=813e27cea046e75b0c8a249637a4ebf20d687d02@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 08:18:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

If qtests are run in verbose mode (i.e. if --verbose CL argument
was provided) then print the assembled qemu command line for each
test.

Instead of using g_test_message() rather use printf() in combination
with g_test_verbose(), to avoid g_test_message() cluttering the
output.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/qos-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index fe240b32a7..b9f0942386 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
 
 static void restart_qemu_or_continue(char *path)
 {
+    if (g_test_verbose()) {
+        printf("Run QEMU with: '%s'\n", path);
+    }
     /* compares the current command line with the
      * one previously executed: if they are the same,
      * don't restart QEMU, if they differ, stop previous
-- 
2.20.1


