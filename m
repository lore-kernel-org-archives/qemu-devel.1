Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC8C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8BE20659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuFZp6ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8BE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sFP-0001Jf-12
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBy-0002HF-GQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBx-0006M6-Hr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBx-0006LU-E0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMZ5CHimy2pMVf1DZMbDkZ5p4+sNSYTUkI8optPBc4w=;
 b=TuFZp6agYwQVP2QwnQD7leJuGwOXRqx2fGDP+oXneLTSsk/A9te2OpodFC4epkAjIUou4y
 PsiUQSkdvlN3mM6txwcpcGkdu/6troLT8gffT/qlU/dz6r27GuC7dCcQwutUaiTxMvQ4Ad
 Weml91PJkvKWFqwg5dHDTeCIwsvVf7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-jAM5I1DbOG2TGDWoZlJ4Pw-1; Wed, 12 Feb 2020 08:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E1CB19057A5;
 Wed, 12 Feb 2020 13:36:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D632119C69;
 Wed, 12 Feb 2020 13:36:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/16] memory-device: properly deal with resizable memory
 regions
Date: Wed, 12 Feb 2020 14:35:54 +0100
Message-Id: <20200212133601.10555-10-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jAM5I1DbOG2TGDWoZlJ4Pw-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case we are dealing with resizable memory regions, we always have to
assign space in the physical address space which can fit the maximum
region size.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 4bc9cf0917..32d0c5d334 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -269,7 +269,7 @@ void memory_device_pre_plug(MemoryDeviceState *md, Mach=
ineState *ms,
     align =3D legacy_align ? *legacy_align : memory_region_get_alignment(m=
r);
     addr =3D mdc->get_addr(md);
     addr =3D memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
-                                       memory_region_size(mr), &local_err)=
;
+                                       memory_region_max_size(mr), &local_=
err);
     if (local_err) {
         goto out;
     }
@@ -329,7 +329,7 @@ uint64_t memory_device_get_region_size(const MemoryDevi=
ceState *md,
         return 0;
     }
=20
-    return memory_region_size(mr);
+    return memory_region_max_size(mr);
 }
=20
 static const TypeInfo memory_device_info =3D {
--=20
2.24.1


