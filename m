Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A3C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26B824650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMte7PXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BQh-0003su-Vj
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j5BOc-0008LF-GJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j5BOb-0006wl-JA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j5BOb-0006wH-Fb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582303401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJq972UhjpkmcHCdnxALNgVTNAc8KQY0NgduEwRuRMw=;
 b=TMte7PXMRgeBvjjqGpkijBcwBVNomDC4irfCe/ZZvKj7ddEM2kb4MUBPlUiLyVepAZMURl
 XUXxDYf6gaiYsAu5BNl2H9W7hEEH6Z3PR3OKWZkA4HTqr7QExubEq58/CIQUAtTKGoIVB1
 /AA/uLKrOFkBdwvIXdVv84g2oKd6Yd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-yv3BARUZPWKVHwrPkxlv-w-1; Fri, 21 Feb 2020 11:43:19 -0500
X-MC-Unique: yv3BARUZPWKVHwrPkxlv-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72924800D4E;
 Fri, 21 Feb 2020 16:43:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B3055C105;
 Fri, 21 Feb 2020 16:43:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] exec: Relax range check in ram_block_discard_range()
Date: Fri, 21 Feb 2020 17:41:57 +0100
Message-Id: <20200221164204.105570-7-david@redhat.com>
In-Reply-To: <20200221164204.105570-1-david@redhat.com>
References: <20200221164204.105570-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 8b015821d6..8737acedab 100644
--- a/exec.c
+++ b/exec.c
@@ -3915,7 +3915,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t st=
art, size_t length)
         goto err;
     }
=20
-    if ((start + length) <=3D rb->used_length) {
+    if ((start + length) <=3D rb->max_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
             error_report("ram_block_discard_range: Unaligned length: %zx",
@@ -3982,7 +3982,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t st=
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


