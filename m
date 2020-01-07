Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15762070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqqDcswQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15762070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorpj-0004QW-95
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iork7-0006ll-33
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iork5-0004oO-P1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iork5-0004n8-La
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8li2Tk9kJtAQIFMop0/eFLC5J5NJiOvfkc+z767fYRk=;
 b=IqqDcswQ5LJekmJzKD7SmznLQGFMNd7mdc5hAiQ+EEb+15+foFuJp5Zt9YQIKcDfrYyK9A
 zBR3YcfSaaQF7tksvM4o8e16Zm+Dm0UO6Z2EkAYHPvO1RqvV48q8Y46lqP8rxibLc8hd1y
 wnTTfaNGFGZbr0ELb1LyFMUTl0EQFpk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-jNf8x8eXPM6aGBn2PTOMVA-1; Tue, 07 Jan 2020 11:30:03 -0500
Received: by mail-qt1-f197.google.com with SMTP id 38so119402qty.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8e5zVSr3EGK6wfLcmhM6md/VpcFIAiAuGM2x/CJ8sg4=;
 b=Us5eidCCa4iATM9YZk0TWXpk9rj0QiyagTT+b8l2dSOG4Ss0BcBU3IMZ78purgorUR
 lL0MSGlKJanl4Nr82pUrIu56IaNORIIY0uZJJMYM+qNtFaMhwYvSOnwYZAGcZE/8Gc1q
 biSroE5inl9xdw5FQDjLgWJoeEZXMFKlVPRcZ6zxJeiTTTZ8aO9y1840hzE3BYfbhIPM
 dRSCkyulxt1ovwdcBW0tSLl+iXjEPmzr/Fof9Ws/r4lHL47gieEDWAHLLj7up11wrl6T
 tIQOVEMfbvI0QLNuC3BDR3b+4N2aAKoHJw7wazdK0qmgzrFGfEr3gi/AG4yIelB4OAi4
 ewvQ==
X-Gm-Message-State: APjAAAVbVW3Wjsx1nFMZCJVAEcyFkAwbTqHCA7y1qGe2vBwngsb/XZih
 W1nr0ihMuWMT/Gh9vSylZsK7LHu+tOgD20fdKMckY3U0avwJyCca3O/MA66EFzaBxhaZY3tP3bT
 zvfrsqx6YyRIPeNk=
X-Received: by 2002:ac8:5205:: with SMTP id r5mr80592118qtn.230.1578414601888; 
 Tue, 07 Jan 2020 08:30:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7denVb6FnL6CyNmr9HRL88W34YZ1uYt5Vk1Ih+YlmixmJuBsw9l4fVUIU3dt2p0mRkh0kJA==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr80592084qtn.230.1578414601445; 
 Tue, 07 Jan 2020 08:30:01 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 24sm42544qka.32.2020.01.07.08.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:00 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/32] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20200107162850.411448-7-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: jNf8x8eXPM6aGBn2PTOMVA-1
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


