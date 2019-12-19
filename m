Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8469BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A3B2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5Wb8uBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A3B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvrU-0002mK-Tg
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvq1-00014K-9v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvq0-0003Ql-70
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvq0-0003OA-0m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8li2Tk9kJtAQIFMop0/eFLC5J5NJiOvfkc+z767fYRk=;
 b=X5Wb8uBZjwivh4h7GGrxb2SyOlUxqQiWeXvQPwY8efpPPtb14jimgTYdYVLZcBaiqp+X4c
 SwkLsTC6xAicOnr1bKSGUDDFOtl0p/PY4wcpuzmN1XKqjvmnrFN0kxVUuyo8JcaIZJZ223
 qGxRFgsl95DcA321LLROT6cbCwNbkoM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-EdhtTpk2PRen4Wjf8miTww-1; Thu, 19 Dec 2019 08:27:30 -0500
Received: by mail-qk1-f200.google.com with SMTP id g28so3594405qkl.6
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8e5zVSr3EGK6wfLcmhM6md/VpcFIAiAuGM2x/CJ8sg4=;
 b=GnCNplev8y1iOJtboiaqXKxjBgX1/0RMOrRRkSF+hIZ4lgP3dtfW8Gm4o5qMQ9Vhbq
 tmj2ZHjX1d5t65S4binR4+6KeJxU5m2sr1f1jAsajL1RLqqFWlFG2FBIwBkNRVHG8fc8
 5T0YoMdLjupBGqk4HPt7TqIGeyda1S/jRGQe0f3K7/tu6+WC4kmx1ZIIrPYVGaRkIshP
 FzQnJinnbQyMxPp8Sp8UHziaRNL32mfwrAWfgtYn5Gh2snMWk4JhRnAYbGqN9ygWSSYV
 iEhsNzYVQf8/SlS/pzVT36FVmiLJhM45KNn+AZJEze/FPMtlB4Lz1jFFHBCm4Wf6vQKF
 jjSQ==
X-Gm-Message-State: APjAAAUGWh7iGkXojHjwhr4dxV9OtazgJlvzuStgXZNuhDFmCJRQMBII
 bXyfao2zJsrYCDa8/jjWSxNqExpyfYUWo52oB3dfVylmoM1O+F0u4kDiQNSO7u0lwuYofKODISE
 wUq6fSVrryJBOYcY=
X-Received: by 2002:a37:644:: with SMTP id 65mr8220441qkg.309.1576762048196;
 Thu, 19 Dec 2019 05:27:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxTFTstNlGaO4audt9RA8wrjhpPEXetF06giI138x7OWlyriFVhBuUmIPpiFETxDTxKaimRw==
X-Received: by 2002:a37:644:: with SMTP id 65mr8220410qkg.309.1576762047917;
 Thu, 19 Dec 2019 05:27:27 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id m27sm1879294qta.21.2019.12.19.05.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:27 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20191219132621.16595-7-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: EdhtTpk2PRen4Wjf8miTww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yi Sun <yi.y.sun@linux.intel.com>

Should directly read DMAR_RTADDR_REG but not using 's->root'.
Because 's->root' is modified in 'vtd_root_table_setup()' so
that the first 12 bits are omitted. This causes the guest
iommu debugfs cannot show pasid tables.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Message-Id: <20191205095439.29114-1-yi.y.sun@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b993b..ee06993675 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2610,16 +2610,15 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr a=
ddr, unsigned size)
     switch (addr) {
     /* Root Table Address Register, 64-bit */
     case DMAR_RTADDR_REG:
+        val =3D vtd_get_quad_raw(s, DMAR_RTADDR_REG);
         if (size =3D=3D 4) {
-            val =3D s->root & ((1ULL << 32) - 1);
-        } else {
-            val =3D s->root;
+            val =3D val & ((1ULL << 32) - 1);
         }
         break;
=20
     case DMAR_RTADDR_REG_HI:
         assert(size =3D=3D 4);
-        val =3D s->root >> 32;
+        val =3D vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
=20
     /* Invalidation Queue Address Register, 64-bit */
--=20
MST


