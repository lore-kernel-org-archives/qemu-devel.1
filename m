Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C04C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA43121556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoS63jTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA43121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z2s-0007mR-Tv
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z0W-00037F-6l
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z0V-000309-79
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z0V-0002zs-3P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kEgul7L6JaBdLS5nxEDOuGO0ikOJi+PGHq3Ia4gucw=;
 b=NoS63jTEuT3g1jPEjDP+VgZav6D1NJaPWGQTaRYezRbuLI3PaGfVMgWqX0KXTaViFl37uv
 4lSrT1P9wVzMNwDxTQUUWyCTyrUh9NK7Gi/5aY4/0sCRaVpMmJZUNSI7fforSYJcNo5nI/
 zcw36gJAj6nmLlPv1ieR+9tsFwUWLww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-1Jb_Mj-GNf6PvjhlYmzQBw-1; Wed, 26 Feb 2020 10:53:51 -0500
X-MC-Unique: 1Jb_Mj-GNf6PvjhlYmzQBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19605107ACC4;
 Wed, 26 Feb 2020 15:53:50 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66F8A100EBAF;
 Wed, 26 Feb 2020 15:53:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/13] exec: Relax range check in ram_block_discard_range()
Date: Wed, 26 Feb 2020 16:52:57 +0100
Message-Id: <20200226155304.60219-7-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to make use of ram_block_discard_range() in the RAM block resize
callback when growing a RAM block, *before* used_length is changed.
Let's relax the check. We always have a reserved mapping for the whole
max_length, so we cannot corrupt unrelated data.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index d30a5d297a..9d351a7492 100644
--- a/exec.c
+++ b/exec.c
@@ -3876,7 +3876,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t st=
art, size_t length)
         goto err;
     }
=20
-    if ((start + length) <=3D rb->used_length) {
+    if ((start + length) <=3D rb->max_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
             error_report("ram_block_discard_range: Unaligned length: %zx",
@@ -3943,7 +3943,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t st=
art, size_t length)
     } else {
         error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu=
64
                      "/%zx/" RAM_ADDR_FMT")",
-                     rb->idstr, start, length, rb->used_length);
+                     rb->idstr, start, length, rb->max_length);
     }
=20
 err:
--=20
2.24.1


