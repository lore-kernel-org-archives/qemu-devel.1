Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE376C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8A42075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XjeU19PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8A42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVgH-0002hN-U9
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <de48a58b7714b50df0f1ed5ec1b64e06a72e17ee@lizzy.crudebyte.com>)
 id 1kYVeI-0000X9-98
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:04 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:33331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <de48a58b7714b50df0f1ed5ec1b64e06a72e17ee@lizzy.crudebyte.com>)
 id 1kYVeF-00035Y-OK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=hlsm+wF9UFkXPwt1j9RFco/39Ps2eiDuJP+GLP7cLJs=; b=XjeU1
 9PHREX2H9nsTVGOIo9rKI0Qs7Tp1BYef19LQ+sHBmNzjbwos+iAccSfPIsSa99lycqW6AotiOFzay
 UMf+VWRHkByqCnnLbTiFzoshoIkIcddlpnhlfDospFZD2pRy6dT+00A5ruDCGnVRatj8fFvMTpez0
 rSRXZPKbYHyKh+XC2eGkfQGsfYqrfpeaDdDsjGathstmS8Q2GfefsmtKfVn0iHB5SuTH7wF98LbNM
 EK7BtM+e7+3bN9r3x8pBOmQevVGHeYo7LXErvPDAtJw2REFvPU15NPeOVsX4y5r8GRybPXlWQkQ0c
 Cn4SbMfuIQXSdfhjKI6rqjzYqHjFQ==;
Message-Id: <de48a58b7714b50df0f1ed5ec1b64e06a72e17ee.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 30 Oct 2020 13:07:03 +0100
Subject: [PULL v2 02/16] tests/9pfs: fix coverity error in
 create_local_test_dir()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=de48a58b7714b50df0f1ed5ec1b64e06a72e17ee@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

Coverity wants the return value of mkdir() to be checked:

  /qemu/tests/qtest/libqos/virtio-9p.c: 48 in create_local_test_dir()
  42     /* Creates the directory for the 9pfs 'local' filesystem driver to
  access. */
  43     static void create_local_test_dir(void)
  44     {
  45         struct stat st;
  46
  47         g_assert(local_test_path != NULL);
  >>> CID 1435963:  Error handling issues  (CHECKED_RETURN)
  >>> Calling "mkdir(local_test_path, 511U)" without checking return value.
  This library function may fail and return an error code.
  48         mkdir(local_test_path, 0777);
  49
  50         /* ensure test directory exists now ... */
  51         g_assert(stat(local_test_path, &st) == 0);
  52         /* ... and is actually a directory */
  53         g_assert((st.st_mode & S_IFMT) == S_IFDIR);

So let's just do that and log an info-level message at least, because we
actually only care if the required directory exists and we do have an
existence check for that in place already.

Reported-by: Coverity (CID 1435963)
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <03f68c7ec08064e20f43797f4eb4305ad21e1e8e.1604061839.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 6b22fa0e9a..8459a3ee58 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -48,9 +48,14 @@ static void init_local_test_path(void)
 static void create_local_test_dir(void)
 {
     struct stat st;
+    int res;
 
     g_assert(local_test_path != NULL);
-    mkdir(local_test_path, 0777);
+    res = mkdir(local_test_path, 0777);
+    if (res < 0) {
+        g_test_message("mkdir('%s') failed: %s", local_test_path,
+                       strerror(errno));
+    }
 
     /* ensure test directory exists now ... */
     g_assert(stat(local_test_path, &st) == 0);
-- 
2.20.1


