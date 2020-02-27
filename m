Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDAC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F1D24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyjKUCAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1D24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GEi-0006w7-UG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GB0-0003BH-Iv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GAy-0006sV-Te
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GAy-0006mi-Lk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u46KdImnOG4gKtgSS+ImhxFoNGYibfq/noWFfJOPceI=;
 b=PyjKUCAIcLOZX7DyNppnuH1Kjg4rH+kna2RkfPSCPIoWTQK/ApX81e9mQma8u5zwEMD0yb
 skDZ2O+W2m+S9zoRav7W3elDyYK6N3PwOyzR9bogQMv8GGCriDuC09dxOL3sd6VWuO5Lzz
 hGCU17E7XEScojpjUeACvh+0VW8nerQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-wqQjZaXpPRCkwSNjRp-8rw-1; Thu, 27 Feb 2020 05:13:47 -0500
X-MC-Unique: wqQjZaXpPRCkwSNjRp-8rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51068800D48;
 Thu, 27 Feb 2020 10:13:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 380E59079D;
 Thu, 27 Feb 2020 10:13:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/15] exec: Drop "shared" parameter from ram_block_add()
Date: Thu, 27 Feb 2020 11:11:56 +0100
Message-Id: <20200227101205.5616-7-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Properly store it in the flags of the ram block instead (and the flag
even already exists and is used).

E.g., qemu_ram_is_shared() now properly succeeds on all ram blocks that are
actually shared.

Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 1fc1fa237e..cdf962a936 100644
--- a/exec.c
+++ b/exec.c
@@ -2211,7 +2211,7 @@ static void dirty_memory_extend(ram_addr_t old_ram_si=
ze,
     }
 }
=20
-static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
+static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     RAMBlock *block;
     RAMBlock *last_block =3D NULL;
@@ -2234,7 +2234,8 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
             }
         } else {
             new_block->host =3D phys_mem_alloc(new_block->max_length,
-                                             &new_block->mr->align, shared=
);
+                                             &new_block->mr->align,
+                                             qemu_ram_is_shared(new_block)=
);
             if (!new_block->host) {
                 error_setg_errno(errp, errno,
                                  "cannot set up guest memory '%s'",
@@ -2339,7 +2340,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, Mem=
oryRegion *mr,
         return NULL;
     }
=20
-    ram_block_add(new_block, &local_err, ram_flags & RAM_SHARED);
+    ram_block_add(new_block, &local_err);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2401,10 +2402,13 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, =
ram_addr_t max_size,
     if (host) {
         new_block->flags |=3D RAM_PREALLOC;
     }
+    if (share) {
+        new_block->flags |=3D RAM_SHARED;
+    }
     if (resizeable) {
         new_block->flags |=3D RAM_RESIZEABLE;
     }
-    ram_block_add(new_block, &local_err, share);
+    ram_block_add(new_block, &local_err);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
--=20
2.24.1


