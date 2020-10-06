Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076BB206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRY5uQof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076BB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPru9-0004u6-US
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkt-00038F-2h
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkq-0006SY-J6
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602009123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=EZv8pIPA7LU9OgUgEDUhL6HYRrYj/hNMme/Zf2EHFxk=;
 b=QRY5uQofXEITzxP5RtILCvdWFcK7DKWRjAIx0qJycMwSQ+7X9xJDNRmhs5y/+Ah2rk4Or5
 3cBYJTfUtI8PSD1JTfXvZL63+Yzxi97LzQJq4UFtc0QJZmmM5VhB6Wqxu0LibFd06nt2ke
 gl9bRXyfkZRBpLmPKKZaw1jyXHYCXyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-WxlLRyDaOmmZ1T9C-Y3thA-1; Tue, 06 Oct 2020 14:32:01 -0400
X-MC-Unique: WxlLRyDaOmmZ1T9C-Y3thA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239EB8018A1;
 Tue,  6 Oct 2020 18:32:00 +0000 (UTC)
Received: from thuth.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0B16EF43;
 Tue,  6 Oct 2020 18:31:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/16] pc-bios: s390x: Save PSW rework
Date: Tue,  6 Oct 2020 20:31:18 +0200
Message-Id: <20201006183122.155609-13-thuth@redhat.com>
In-Reply-To: <20201006183122.155609-1-thuth@redhat.com>
References: <20201006183122.155609-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

We don't need to save the ipl_continue variable in lowcore and have it
limited to 32 bits because of the lowcore layout. Let's move it to a
new 64 bit variable and get rid of the reset info struct.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201006094249.50640-3-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 767012bf0c..b6aad32def 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -13,20 +13,17 @@
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
-typedef struct ResetInfo {
-    uint64_t ipl_psw;
-    uint32_t ipl_continue;
-} ResetInfo;
+static uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
-static ResetInfo save;
-
-static void jump_to_IPL_2(void)
+static void jump_to_IPL_addr(void)
 {
-    ResetInfo *current = 0;
+    __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
+
+    /* Restore reset PSW */
+    *reset_psw = save_psw;
 
-    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
-    *current = save;
-    ipl(); /* should not return */
+    ipl();
+    /* should not return */
 }
 
 void jump_to_IPL_code(uint64_t address)
@@ -46,15 +43,11 @@ void jump_to_IPL_code(uint64_t address)
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
-    ResetInfo *current = 0;
-
-    save = *current;
-
-    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
-    current->ipl_psw |= RESET_PSW_MASK;
-    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
-
-    debug_print_int("set IPL addr to", current->ipl_continue);
+    save_psw = *reset_psw;
+    *reset_psw = (uint64_t) &jump_to_IPL_addr;
+    *reset_psw |= RESET_PSW_MASK;
+    ipl_continue = address;
+    debug_print_int("set IPL addr to", ipl_continue);
 
     /* Ensure the guest output starts fresh */
     sclp_print("\n");
-- 
2.18.2


