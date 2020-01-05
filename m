Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0511C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2D32072C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adeg4H9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2D32072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5tw-0007Of-PJ
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Vu-0003yb-LE
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Vt-0005Ru-EF
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Vt-0005Rd-AN
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9CW2f1wTLCUXOOV0nNq1e86u0ryEb/Y8cd2jez9DrU=;
 b=adeg4H9fCNd9GFf5q42EKg/OdcN3yfY4muJAHf1zG2nH9aBrKbN3T6KzfMaAapjasStNAR
 BEQFtc2IB8ojB1KJ5HFtstxtCSc7EqkPth//Qrv0TG68jw15Dwi+B5EuExaggDRKEsRRqL
 xmECrj0p67djJMaaR6DhyHd90hjrgKY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-CFWs4czvNCC8Nve4bMLopg-1; Sun, 05 Jan 2020 08:00:07 -0500
Received: by mail-qt1-f199.google.com with SMTP id e37so32589460qtk.7
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 05:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pNIx/NiIdCE26OJhITv4+Fn8KZTuaXrKqh88qEn+vzc=;
 b=rCzX4CMQjz8gu9qd8R/tLwXsI/TI0z/07Z5WYu/xpBBB5dpQRZHXmQ/zuTT5L4nwWM
 Zvf/wFlgZWSvu/zPrN42jKZdtPWUK/82m1E1BKcC8p+RV+6NQppvXcFC66HieAfIFc0S
 iW0Jeo7IFKu1K4uyaUKdCfJ7xNbV5o+Axt40RRi+wzf0iqCoxmjlAKnIey6Htzm6GBIT
 h3sBclruYPfVHvLfSLLsi+cX+VIkcGTIFBM4AWFiuTw8kt7pTZas2beOG2hJ8mfFiX+n
 AMbcw6uxxI8DJBI8kd6czAaYEjKFeAof4j/SUR2eB8+8rN5zi8S2cCFnDK6AFuHcTRye
 Vv7g==
X-Gm-Message-State: APjAAAXB+mXXr6n/m6w0Hstz0yjgggQWdU604mu4GA+/mgqfQnKN7o7Y
 kRmJ4bJh4Oz85VNK+sp5iaGmlqXBzzblZyyoFT/QXktU7KhvxAthPY2MScAPlEKk83aHYETvT1u
 qOyRYMzym3VzLtb4=
X-Received: by 2002:aed:2a87:: with SMTP id t7mr59400344qtd.384.1578229205355; 
 Sun, 05 Jan 2020 05:00:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzmhbBoRU0CKNJ7Jwdq4kaoke+znnw9ZVMiFTafmdUCOiILtGzMv9d8B6A27Lcb5YPRoeVeA==
X-Received: by 2002:aed:2a87:: with SMTP id t7mr59400328qtd.384.1578229205200; 
 Sun, 05 Jan 2020 05:00:05 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id y18sm19181850qki.0.2020.01.05.05.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 05:00:04 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 31/32] intel_iommu: a fix to vtd_find_as_from_bus_num()
Message-ID: <20200105125622.27231-32-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: CFWs4czvNCC8Nve4bMLopg-1
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


