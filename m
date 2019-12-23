Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50ED2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbOtevfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50ED2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijQtZ-00043s-NN
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQlw-0003VL-Nj
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQlv-0005PZ-N8
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQlv-0005PP-JE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8li2Tk9kJtAQIFMop0/eFLC5J5NJiOvfkc+z767fYRk=;
 b=hbOtevfjTt47U6EzshZVD+ws+knCq4sU7S413fLkXPsNV4Ij0qe5hSGwPoS/lMTnvsvlEp
 rJkkIWGa7cU2ltpedoDT3CHrbR+/7Z+6vo0gLhZBy/fRTJ2bSr0CHAAV1TwSGqsYKNxuil
 PRXSvhhaskYxzlS/ESKjcyp5X3rIlZk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-SyJrTI7CO660Fn_AfyQ6Ww-1; Mon, 23 Dec 2019 11:41:29 -0500
Received: by mail-qk1-f198.google.com with SMTP id u30so11537085qke.13
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8e5zVSr3EGK6wfLcmhM6md/VpcFIAiAuGM2x/CJ8sg4=;
 b=dzNHuWleuMyKEDTXg/ihhuvfZ2ZclBji3R/2xR6PnTOrHS+nDaDurP/mEeEwaIEXRR
 mqyGoNTT3UWDTCQ6x/RSeCIooDcgeMKkRfhypM8awITFpI+L3rHL9oLGN2OHLBv6bGOl
 AzSXV6QfGEyY1qoC19/tVDxPdb8NmsQ0Bv3VeLf+ojJ7+LDw6m98XRH5Uazosz19Kswq
 Z7DQK38K9KGYpeXi0QRvu2HXJs196xC54uq6p/v/w0ypZFIxQuzC0lKGqH/19I+rpCdR
 Ai8gESxiuNjv5hjC6E6+nLp/q1n7j8fFudmWLheG8ap6q5j9AqC8rwI1fFcMQTH+0NyN
 bY1Q==
X-Gm-Message-State: APjAAAVu9N8hqXE7LqZIKPQoymiDVo/EBTZXkEm3twLuBbDhZ393WlEi
 5Zd9jX7tJ4RdIqlFUYMfG4k/ktcf7t/NNMv52hBPGP51DFxe3EReB99KNgWbe+uynqo8opPMi1O
 AEgu5nJdXAmrY9Ks=
X-Received: by 2002:a37:a9d1:: with SMTP id
 s200mr27094368qke.110.1577119288293; 
 Mon, 23 Dec 2019 08:41:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5sXItuOpvHG6323vHGFR7mDt4BQ+fGfrFmZZkDD6vhMF/HEK/MWepceEoy14qfDI35Rsk6A==
X-Received: by 2002:a37:a9d1:: with SMTP id
 s200mr27094353qke.110.1577119288091; 
 Mon, 23 Dec 2019 08:41:28 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 i6sm5889478qkk.7.2019.12.23.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:41:27 -0800 (PST)
Date: Mon, 23 Dec 2019 11:41:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/27] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20191223141536.72682-7-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: SyJrTI7CO660Fn_AfyQ6Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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


