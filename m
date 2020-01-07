Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23769C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E444E208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSXNjrRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E444E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios35-0001MH-Ms
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlx-0000To-EZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlw-0005yN-9h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlw-0005xv-66
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9CW2f1wTLCUXOOV0nNq1e86u0ryEb/Y8cd2jez9DrU=;
 b=QSXNjrRyJXLeHIiU77RndLXVabQQAWgZ7n70KhGpfBoSYsC5bdkuSiSsqrpVR06Xqb89Ey
 5xw7BSqvya2jDoadRL/zbr1qGI3vF5HelSmzDRNUJOmCOodcIgj9UiaPqnzjNCAWPdx8Ae
 gBj/245FA0+kjFxjMSgQhVyse4WP02c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-9citjb5eOLGnegp1efK7iw-1; Tue, 07 Jan 2020 11:31:56 -0500
Received: by mail-qt1-f200.google.com with SMTP id d9so127803qtq.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pNIx/NiIdCE26OJhITv4+Fn8KZTuaXrKqh88qEn+vzc=;
 b=f6XOtqKRVpHlJnkoOK9t2pWagKRLJAk6Eme64wtFHUrPQWEUWUei9K43EEwcjAsjoP
 MhVf3CQm+7NAgINuMlpl7xAJc4dTRSVopCR2hul72rxa6JQfqHNzXWYAMAYPjZoarBU4
 nlNbxehdhs6bsxxB3uVxz8KujP4FrIQXAmKBGy6lLtMM8O5JTjvOZGjuItS+BoxRrrbJ
 5j9gZzaUBXwvJy25yoew+KW1YFNFN/F0J7PkrNbilimicu/tfzeZN4WY0UeYT/irFuC0
 JnsWe6QeQPfkaZ8YT432UWNY6AVfrEfbZO9q6xwIROTFPDTUO/eNPHlXoJC2PEecOY1g
 Q0mw==
X-Gm-Message-State: APjAAAVQZgjvs1mgrTTXFQ8ojnWsFToLzRH5uIx1E/Qi6jn4EM8AiUOh
 nn2/2y0V3nr1Mbkmfv4ms619s1Bd2iz/KRKgXq/u06KP3drGVqrFYBbCT6DJYqkmrjHtxF0n6iT
 t+9YQoTJkBOiyW+U=
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr141717qkd.412.1578414715055; 
 Tue, 07 Jan 2020 08:31:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkrThP5YQgrQvG0mYq1wmrd2uPHD2tITEVJ6fJjZFsHj53YEW+so06qTREo8UP4/vLl26CGA==
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr141690qkd.412.1578414714796; 
 Tue, 07 Jan 2020 08:31:54 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id h1sm111122qte.42.2020.01.07.08.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:54 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 31/32] intel_iommu: a fix to vtd_find_as_from_bus_num()
Message-ID: <20200107162850.411448-32-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 9citjb5eOLGnegp1efK7iw-1
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


