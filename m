Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90459C33C99
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFD62085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om2D03T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFD62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5Ya-00064E-MR
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Tg-0000vN-2A
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Te-0003n4-Tw
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Te-0003mt-QN
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8li2Tk9kJtAQIFMop0/eFLC5J5NJiOvfkc+z767fYRk=;
 b=Om2D03T8LZDHmmCrynVffr7ZrDYlJx7JIOeya99IZaQlVmBXBc2cxU6RM+nQ6mbrxu9N6T
 XN+jBS9DLzNIbBQk73FVxZRkphwJpZrab0ozWbJLVAmdAK3vCCjXrgqQ/OgL1ghlf72k+V
 Mh5KcJJpfg+LRhFj8/RZjwrXzsDfNjU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-fvuyiLjwO3ukQdOfKlzBgw-1; Sun, 05 Jan 2020 07:57:50 -0500
Received: by mail-qv1-f69.google.com with SMTP id e10so1733926qvq.18
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8e5zVSr3EGK6wfLcmhM6md/VpcFIAiAuGM2x/CJ8sg4=;
 b=S47lKfQ360j7i6+SUWLxhCkrvaKXhCRN9W+lcEr4rgJR/Yn5G2PzlkF0Jt0cgfyoP2
 5f8ELtn/eX7ZxxLfNA6zXdoV3DCH+9Biq+W5t5vIVqd2QMdhGy0ichSt93QRADWBAxa8
 uFWKSLTfM8tSBXCjsWIqYIB1p+brmkwlW3wETKjGbcWsBPHfx7OhHm3Frg9StdaMs8HL
 rebucqI71hf8JGrcU2S0iGAVDUdyE9r+H07EbQGH5NJaNU94KAT2TWcqCl1axj5wlId2
 xmxMdbg3ZmeeHi+KnGVG3bgNvHWEA+n7Ei+5gBJwVuzI2ptygkrN71TvhuxOKY6Vpq8N
 NeUg==
X-Gm-Message-State: APjAAAU6qFhT18jCaJML0H1mfI02GAcKGPt3rLpnC8Q/CrTWf05giWbN
 34X8ScfjoFzSOCLW9j2D6Eu/MLunO+IySad3hNemU3j4/kBT10iyG94Aa/yl1LNOa7b1RZemEl6
 RCrbqFFhHMsi1uOY=
X-Received: by 2002:ac8:64a:: with SMTP id e10mr70464921qth.292.1578229070065; 
 Sun, 05 Jan 2020 04:57:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMIga4L4/YEt0EtoelaucL7ilPDrNP7l7eXbJhX7lAbGrrA2Pza82yF6eidBq2Ke2DosDoww==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr70464911qth.292.1578229069917; 
 Sun, 05 Jan 2020 04:57:49 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r80sm19325029qke.134.2020.01.05.04.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:49 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/32] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20200105125622.27231-7-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: fvuyiLjwO3ukQdOfKlzBgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


