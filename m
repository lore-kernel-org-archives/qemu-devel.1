Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F053DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC722073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHXMiL5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC722073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxoN-0007f9-0d
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkK-0007n9-2Z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkH-0007QZ-Ly
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=G0VCxaHbmkAYHRcbmzPgbufzvo9fZue2ro4Xn2Yl48k=;
 b=DHXMiL5k/7/jtplbo8g/dmnya41SZfACpOtqEGhivjjhHAwFRRlTRARC4SxxPnHSUotSyx
 lJunSOi7Qov8YpvkLZJiCBLheas02Rl1rNlYveKJR48X8EWzgIxxQ4lyBsjBHWMBlLjyVa
 ZlCoJZhOvkWdovGM4CFhK7LnXUbv4Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BDyhdEION1-L7r_HGPUBeg-1; Thu, 02 Jul 2020 07:51:11 -0400
X-MC-Unique: BDyhdEION1-L7r_HGPUBeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C97F186A201;
 Thu,  2 Jul 2020 11:51:10 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A25C160CD3;
 Thu,  2 Jul 2020 11:51:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 09/11] pc-bios: s390x: Make u32 ptr check
 explicit
Date: Thu,  2 Jul 2020 13:50:43 +0200
Message-Id: <20200702115045.6171-10-thuth@redhat.com>
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

Let's make it a bit more clear that we check the full 64 bits to fit
into the 32 we return.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200624075226.92728-11-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
index 32a453b634..dfcfea0ff0 100644
--- a/pc-bios/s390-ccw/helper.h
+++ b/pc-bios/s390-ccw/helper.h
@@ -19,7 +19,7 @@
 /* Avoids compiler warnings when casting a pointer to a u32 */
 static inline uint32_t ptr2u32(void *ptr)
 {
-    IPL_assert((uint64_t)ptr <= 0xffffffff, "ptr2u32: ptr too large");
+    IPL_assert((uint64_t)ptr <= 0xffffffffull, "ptr2u32: ptr too large");
     return (uint32_t)(uint64_t)ptr;
 }
 
-- 
2.18.1


