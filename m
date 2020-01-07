Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278EC33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309962073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XklovNJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309962073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokwc-0005HL-L8
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojR4-00087R-OS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojR3-0000UA-D1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojR3-0000Ty-9U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9CW2f1wTLCUXOOV0nNq1e86u0ryEb/Y8cd2jez9DrU=;
 b=XklovNJUDxm3oN1jFm4oY7G9eZKkSf2RydtN+8cJrZnCzS8lUEH9NQv1zkwJJ3zJ1Bg9yv
 NH89VpdKhWl0SOSMpSLphcwSIACO0E36+IQ1sA8wWHP87E+RGYpObKJEDvKKWrc0/qg16j
 55ptChwUUuMcn07Ok1xGu0MGZr+J1UM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-9xiM6zbuMO-cKVfxZz6BQQ-1; Tue, 07 Jan 2020 02:37:51 -0500
Received: by mail-qt1-f197.google.com with SMTP id o24so30926973qtr.17
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pNIx/NiIdCE26OJhITv4+Fn8KZTuaXrKqh88qEn+vzc=;
 b=qWjBjIuvLlKodFuc/x9DwNfrEZzYCvtDavzefzhOKdkuP3U1z2h7cIrc4ZZAE09PMX
 POIuX/cMOOe1HnBAiVr8pkdmBLzNqATEFDp4N9ERZpw/xZZCeLCjkSFvrlsLSEYLsA3o
 lXLkrH7RL/bxP3badkRnNtRdBsAoJ3y/HBHNG61Zsg2BGDByQQuQZe1Ut/Ukyi19sZRc
 Q1mvybtcWl+ZHIjxWIplM2dhUGwcbjRjuSUTuDFxhi3yOjvPpJcZ6BvwgNTfRwcu3+sm
 TK5lgmt4fnWc7neRse1W3zxsHE9BM4N1Fz5VKVgepDFivuJ2DemT7wiRy3lBmRg3I2yn
 I/Kg==
X-Gm-Message-State: APjAAAUKGgdIbxZwbc6cNtHiUssN/14IbKeCE/86eLQ6/TPzXOFFPqHQ
 d6O1fl/8wVgKiJjS5dt3W1PdiUdTVidazxLQ3uMYPAlaWHFNF+ytryKsAbvcFtm/Q14aN7sryBg
 4yWsnCegu+iBCogk=
X-Received: by 2002:a0c:c542:: with SMTP id y2mr8192839qvi.225.1578382670544; 
 Mon, 06 Jan 2020 23:37:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgYOWgdZPNRKFI/m8rAelRQ8xkjuX4GuLjRjJZ3OrZEWiR6go3CWQki2q9x5DhlL4L0NsH8Q==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr8192821qvi.225.1578382670343; 
 Mon, 06 Jan 2020 23:37:50 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id x19sm24688703qtm.47.2020.01.06.23.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:49 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 31/32] intel_iommu: a fix to vtd_find_as_from_bus_num()
Message-ID: <20200107073451.298261-32-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 9xiM6zbuMO-cKVfxZz6BQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

Ensure the return value of vtd_find_as_from_bus_num() is NULL by
enforcing vtd_bus=3DNULL. This would help caller of vtd_find_as_from_bus_nu=
m()
to decide if any further operation on the returned vtd_bus.

Cc: qemu-stable@nongnu.org
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Message-Id: <1578058086-4288-2-git-send-email-yi.l.liu@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ee06993675..609b80750a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -948,6 +948,7 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState=
 *s, uint8_t bus_num)
                 return vtd_bus;
             }
         }
+        vtd_bus =3D NULL;
     }
     return vtd_bus;
 }
--=20
MST


