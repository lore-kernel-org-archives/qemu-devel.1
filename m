Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79020C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDEB2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDEB2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsD1s-00084m-Km
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsD0H-0005uD-Qq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsD0G-0003jl-Mj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:21 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsD0G-0003jZ-JD
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:20 -0400
Received: by mail-qt1-f173.google.com with SMTP id w17so16623080qto.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qNyxluckYNXjX0PviQMIN4Hjjd/tW1RorHrzwXKNic0=;
 b=YXCabN4v+vFndbgr3CdIbguu2YmQ5vZkpdoxFr3rCZv5S6nRK7fZky6Cn8GU96lNOk
 khYBw42Akt4UYBWbAaPsMgtYj6qlq6NFhYbuJ8FqA5fuEQCnmgjrpuFC/Q8Qebn4T6Yy
 R/3eHnjXTkty5CDepES3agQW5zh82IEgcRedW88UPAfqgXaBuYknvE9kmkfFiVmexrzp
 wwdT1PiT72rqfrrlVbRSX9GiDxLvbiByzz2gfsInC3/NLhLRvX5l6K9AkjpjjEKuyRa5
 Or/M23B3BILNC9sxrkJtD/xAx1yqqxrY+d+QadrTDowpEem99baO5WjeySa44yByAdYL
 8afw==
X-Gm-Message-State: APjAAAXp+4IcGu1VDxfOf8aqOa85+KxzXzliiitINXbaPPB3yYLLLvT2
 Vlm+xEmRm9ZtvvogJ68O2JnkAoLx5IcGPA==
X-Google-Smtp-Source: APXvYqwoU/egkdex8u6mxc9FsYJMsUwNUUJAJoao73k/ZNmzDvjN/rmkCY5pjfiiTN0jOI0myzeT/A==
X-Received: by 2002:a0c:ad7a:: with SMTP id v55mr78346444qvc.130.1564434979765; 
 Mon, 29 Jul 2019 14:16:19 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 g2sm27478762qkf.32.2019.07.29.14.16.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 14:16:19 -0700 (PDT)
Date: Mon, 29 Jul 2019 17:16:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190723160859.27250-1-imammedo@redhat.com>
References: <20190729211404.1533-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729211404.1533-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 3/3] pc-dimm: fix crash when invalid slot number
 is used
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Pankaj Gupta <pagupta@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, &lt@redhat.com, Mammedov@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190729211614.e_nKAiNoJDhFUCrBz2F3QmB-D-U_dpE2MFddBp6-Tng@z>

From: Igor Mammedov <imammedo@redhat.com>

QEMU will crash with:
  Segmentation fault (core dumped)
when negative slot number is used, ex:
  qemu-system-x86_64 -m 1G,maxmem=20G,slots=256 \
      -object memory-backend-ram,id=mem1,size=1G \
      -device pc-dimm,id=dimm1,memdev=mem1,slot=-2

fix it by checking that slot number is within valid range.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190723160859.27250-1-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Igor Mammedov &lt;<a href="mailto:imammedo@redhat.com" target="_blank">imammedo@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Li Qiang &lt;<a href="mailto:liq3ea@gmail.com">liq3ea@gmail.com</a>&gt;<br></div><div> </div><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
---
 hw/mem/pc-dimm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index b1239fd0d3..29c785799c 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -38,6 +38,13 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
 
     slot = object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
                                    &error_abort);
+    if ((slot < 0 || slot >= machine->ram_slots) &&
+         slot != PC_DIMM_UNASSIGNED_SLOT) {
+        error_setg(&local_err, "invalid slot number, valid range is [0-%"
+                   PRIu64 "]", machine->ram_slots - 1);
+        goto out;
+    }
+
     slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
                                  machine->ram_slots, &local_err);
     if (local_err) {
-- 
MST


