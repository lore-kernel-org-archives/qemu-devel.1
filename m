Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D540C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 02:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325122089C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 02:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325122089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJTTN-0000u7-Aw
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 22:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJTPr-0006JO-H2
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 22:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJTPq-00028u-CQ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 22:15:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:56369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJTPq-00020i-4J; Sat, 12 Oct 2019 22:15:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Oct 2019 19:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,290,1566889200"; d="scan'208";a="346407424"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga004.jf.intel.com with ESMTP; 12 Oct 2019 19:15:18 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: pbonzini@redhat.com, ehabkost@redhat.com, imammedo@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 den@openvz.org, marcandre.lureau@redhat.com, kraxel@redhat.com,
 mst@redhat.com, rth@twiddle.net, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mark.cave-ayland@ilande.co.uk,
 david@gibson.dropbear.id.au, yuval.shaia@oracle.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, armbru@redhat.com, sw@weilnetz.de
Subject: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Date: Sun, 13 Oct 2019 10:11:44 +0800
Message-Id: <20191013021145.16011-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013021145.16011-1-richardw.yang@linux.intel.com>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use ROUND_UP() to define, which is a little bit easy to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/exec/cpu-all.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ad9ab85eb3..255bb186ac 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -220,7 +220,7 @@ extern int target_page_bits;
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
-#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
@@ -228,9 +228,8 @@ extern int target_page_bits;
 extern uintptr_t qemu_host_page_size;
 extern intptr_t qemu_host_page_mask;
 
-#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
-#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
-                                    qemu_real_host_page_mask)
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
 
 /* same as PROT_xxx */
 #define PAGE_READ      0x0001
-- 
2.17.1


