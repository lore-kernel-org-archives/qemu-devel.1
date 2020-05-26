Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A002C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91B32053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7i1DvLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91B32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXdj-0002Ip-58
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdXcw-0001Hg-WD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:20:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdXcw-0007Mr-1g
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590492008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VfYe3erQLI9NlxuT5QwYIt7bkNUp+Qn0Puxot75N2Hg=;
 b=B7i1DvLxZIPZFyneYlkek/0qbDe4nbQsazYpcxmhudzUcvArc5D2PeEsrY5dYF+nZcNiBR
 lgY7SZiFhLrxvz/AtrcQXSypOWpS8GpZuPjOqJ6X6703eZguCeuuWFKVvn8lAwiHEdA/DY
 pEmo2oYYUjqcMA7Uv7YYLhSzgMTaIqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-tM5TY2AlOkmVe-uZ_EMD4w-1; Tue, 26 May 2020 07:19:58 -0400
X-MC-Unique: tM5TY2AlOkmVe-uZ_EMD4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92FDA1005510;
 Tue, 26 May 2020 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 094B05C1BE;
 Tue, 26 May 2020 11:19:48 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4] exec: set map length to zero when returning NULL
Date: Tue, 26 May 2020 16:47:43 +0530
Message-Id: <20200526111743.428367-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ding Ren <rding@gatech.edu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
---
 exec.c                | 1 +
 include/exec/memory.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Update v4: update address_space_map API doc text
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07281.html

diff --git a/exec.c b/exec.c
index 5162f0d12f..4eea84bf66 100644
--- a/exec.c
+++ b/exec.c
@@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
+            *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..8fa2d3cab2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2303,7 +2303,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
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


