Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83438C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBFD20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/OIViaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBFD20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxqS-0001pn-HI
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkA-0007Yn-Sb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxk8-0007Mr-37
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=VG0svflMGCYKdjl1nfOsKNim2IDeoAw/rNa1GCUj8tI=;
 b=W/OIViaSYcijfrCrH2Sw1m8sGH6sQ5Wpf2EDy1bMzqy24s6GGtHK/9Gies5DGNrqqL1r/a
 KWeCkL46a9A6Vj9o7VR1N20kEHfa9bQs1ZOyDFOqm0EX2mg0D6srYCvErUdci3dgAFgcAy
 8rYWuTv1fQFFakmR8AXxjrzYIOGuiM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-lj4LYaw9PpqCsIfh7XaCzw-1; Thu, 02 Jul 2020 07:51:01 -0400
X-MC-Unique: lj4LYaw9PpqCsIfh7XaCzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D42E186A200;
 Thu,  2 Jul 2020 11:51:00 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B32DF60CD3;
 Thu,  2 Jul 2020 11:50:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 06/11] pc-bios: s390x: Use PSW masks where
 possible and introduce PSW_MASK_SHORT_ADDR
Date: Thu,  2 Jul 2020 13:50:40 +0200
Message-Id: <20200702115045.6171-7-thuth@redhat.com>
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
References: <20200702115045.6171-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's move some of the PSW mask defines into s390-arch.h and use them
in jump2ipl.c. Also let's introduce a new constant for the address
mask of 8 byte (short) PSWs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200624075226.92728-8-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/jump2ipl.c  | 10 ++++------
 pc-bios/s390-ccw/s390-arch.h |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 4eba2510b0..767012bf0c 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -8,12 +8,10 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
 
 #define KERN_IMAGE_START 0x010000UL
-#define PSW_MASK_64 0x0000000100000000ULL
-#define PSW_MASK_32 0x0000000080000000ULL
-#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
-#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
+#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
 typedef struct ResetInfo {
     uint64_t ipl_psw;
@@ -54,7 +52,7 @@ void jump_to_IPL_code(uint64_t address)
 
     current->ipl_psw = (uint64_t) &jump_to_IPL_2;
     current->ipl_psw |= RESET_PSW_MASK;
-    current->ipl_continue = address & 0x7fffffff;
+    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
 
     debug_print_int("set IPL addr to", current->ipl_continue);
 
@@ -86,7 +84,7 @@ void jump_to_low_kernel(void)
 
     /* Trying to get PSW at zero address */
     if (*((uint64_t *)0) & RESET_PSW_MASK) {
-        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
+        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
     }
 
     /* No other option left, so use the Linux kernel start address */
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 73852029d4..6da44d4436 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -26,9 +26,11 @@ _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
 
 /* s390 psw bit masks */
 #define PSW_MASK_IOINT      0x0200000000000000ULL
+#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
 #define PSW_MASK_WAIT       0x0002000000000000ULL
 #define PSW_MASK_EAMODE     0x0000000100000000ULL
 #define PSW_MASK_BAMODE     0x0000000080000000ULL
+#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
 #define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
 
 /* Low core mapping */
-- 
2.18.1


