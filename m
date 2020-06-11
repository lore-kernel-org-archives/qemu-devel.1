Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E91C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B38A207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KghfFvdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B38A207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU68-0007jc-Uz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAL-0001md-Ln
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAI-0001PF-NE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdY3ERWTiaZOd3Bn0BxtqRsKwTUqDQ8SFHOZ6ljXqek=;
 b=KghfFvdOfa7FxJejRrVbm/gfSqy8g9eytkOgQDw/IIib2xzCko+0m8g9dTh2sNjQPxJWkm
 Rb+XQRU6oQmJr0JSF1lo0e/+3ObiZIMzh429Z5G2XpCw9HF/P7Y2hK8CWs6mdhwzr0AgVy
 Ii7WMY5u0i+g6QdE5c0P2l2fYFJzzb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-q4dJ48Q4NRykTeqRCBR8Rw-1; Thu, 11 Jun 2020 15:46:53 -0400
X-MC-Unique: q4dJ48Q4NRykTeqRCBR8Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB708B8C61;
 Thu, 11 Jun 2020 19:46:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C740E60CC0;
 Thu, 11 Jun 2020 19:46:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 080/115] exec: set map length to zero when returning NULL
Date: Thu, 11 Jun 2020 15:44:14 -0400
Message-Id: <20200611194449.31468-81-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When mapping physical memory into host's virtual address space,
'address_space_map' may return NULL if BounceBuffer is in_use.
Set and return '*plen = 0' to avoid later NULL pointer dereference.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20200526111743.428367-1-ppandit@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 1 +
 include/exec/memory.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 9cbde85d8c..778263f1c6 100644
--- a/exec.c
+++ b/exec.c
@@ -3540,6 +3540,7 @@ void *address_space_map(AddressSpace *as,
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
+            *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index bd7fdd6081..af8ca7824e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2314,7 +2314,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
- * May return %NULL if resources needed to perform the mapping are exhausted.
+ * May return %NULL and set *@plen to zero(0), if resources needed to perform
+ * the mapping are exhausted.
  * Use only for reads OR writes - not for read-modify-write operations.
  * Use cpu_register_map_client() to know when retrying the map operation is
  * likely to succeed.
-- 
2.26.2



