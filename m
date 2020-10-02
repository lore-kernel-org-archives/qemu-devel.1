Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CFC47427
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC25206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OjdH+HiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC25206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKfY-00084V-71
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <07adc676da3e54a43dce2de8d03b3ce0a15e0d8f@lizzy.crudebyte.com>)
 id 1kOKbT-0003vl-7a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:56:03 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:37777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <07adc676da3e54a43dce2de8d03b3ce0a15e0d8f@lizzy.crudebyte.com>)
 id 1kOKbR-0000DM-K6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=44zIO6oSJBtCMtx0lPpF1Gk4m8vRKjg9xvEFAgJFrqw=; b=OjdH+
 HiDUurSIZel5kN1R2xaHfSPNR/RoDk6pP3cnLY5j1p2qQZ6eTUO/5G9cPMpYtmx2CZWqTZgAgYmSQ
 ANxHxvHY3klWG9L4/nkdDr17UU92jcONxLXAT0XiL7Zc4y3TNdMuqayQPHvnKoQS/vevLFeLj9EHD
 kKTEp9voTSZz98D/C7cdRyacLHebd0tpuQx13glHWefHSvx9LJePlDZ4+0TYsrumcDuTiwq8Ror4c
 tLx50XFElQ146vBVyPt8aEeWozExirqT7gM0FnD9yBAEH3ttq3bXuCSqB7NrZq24e62ulYQ4TSS/3
 Fj9Rs0iguTe6ILMn3DqwVXgy3XJIg==;
Message-Id: <07adc676da3e54a43dce2de8d03b3ce0a15e0d8f.1601639563.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601639563.git.qemu_oss@crudebyte.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 13:51:54 +0200
Subject: [PATCH v2 05/11] tests/qtest/qos-test: dump environment variables if
 verbose
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=07adc676da3e54a43dce2de8d03b3ce0a15e0d8f@lizzy.crudebyte.com;
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
was provided) then print all environment variables to stdout
before running the individual tests.

Instead of using g_test_message() rather use printf() in combination
with g_test_verbose(), to avoid g_test_message() cluttering the
output.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/qos-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index d98ef78613..fe240b32a7 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -313,9 +313,16 @@ static void walk_path(QOSGraphNode *orig_path, int len)
  *   machine/drivers/test objects
  * - Cleans up everything
  */
-int main(int argc, char **argv)
+int main(int argc, char **argv, char** envp)
 {
     g_test_init(&argc, &argv, NULL);
+    if (g_test_verbose()) {
+        printf("ENVIRONMENT VARIABLES: {\n");
+        for (char **env = envp; *env != 0; env++) {
+            printf("\t%s\n", *env);
+        }
+        printf("}\n");
+    }
     qos_graph_init();
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.20.1


