Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE87C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E9D2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHNyTPBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E9D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZtd-0001Oe-Gl
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsC-0008JQ-Su
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsB-0005c9-BZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595505530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzDoCvg9nLyfzOPU0R2wSrPPyi2ccYi5UrlWBzflzTY=;
 b=BHNyTPBvTyQOTo/IDqwbHTqc7yGscMjeOW6XrKggMVojZy3p8yz/qncVo9ApjrNKo+8jwS
 RP/ISAQGbkRY3mdmQI5Y2uG1v9SQnk6dr1F9zJ58WdvDQErOiqSzjVOzoTy5F/M7zOsuTG
 MBs5hZdJczigYjQEKbz0CEwLHhGckBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368--Zs-FgOqMWaGcIecrmpCsg-1; Thu, 23 Jul 2020 07:58:48 -0400
X-MC-Unique: -Zs-FgOqMWaGcIecrmpCsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C4A19067E0;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F836FEF4;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAAF110F5AF1; Thu, 23 Jul 2020 13:58:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/2] tpm: Improve help on TPM types when none are
 available
Date: Thu, 23 Jul 2020 13:58:45 +0200
Message-Id: <20200723115845.1865886-3-armbru@redhat.com>
In-Reply-To: <20200723115845.1865886-1-armbru@redhat.com>
References: <20200723115845.1865886-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Help is a bit awkward when no TPM types are built into QEMU:

    $ upstream-qemu -tpmdev nonexistent,id=tpm0
    upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
    Supported TPM types (choose only one):

Improve to

    upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
    No TPM backend types are available

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tpm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tpm.c b/tpm.c
index f6045bb6da..cab206355a 100644
--- a/tpm.c
+++ b/tpm.c
@@ -47,18 +47,23 @@ tpm_be_find_by_type(enum TpmType type)
  */
 static void tpm_display_backend_drivers(void)
 {
+    bool got_one = false;
     int i;
 
-    fprintf(stderr, "Supported TPM types (choose only one):\n");
-
     for (i = 0; i < TPM_TYPE__MAX; i++) {
         const TPMBackendClass *bc = tpm_be_find_by_type(i);
         if (!bc) {
             continue;
         }
-        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
+        if (!got_one) {
+            error_printf("Supported TPM types (choose only one):\n");
+            got_one = true;
+        }
+        error_printf("%12s   %s\n", TpmType_str(i), bc->desc);
+    }
+    if (!got_one) {
+        error_printf("No TPM backend types are available\n");
     }
-    fprintf(stderr, "\n");
 }
 
 /*
-- 
2.26.2


