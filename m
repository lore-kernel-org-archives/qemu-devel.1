Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67346206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoePp8UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67346206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxLP-00083c-DE
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH7-0002dG-Au
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH6-0001Io-95
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH6-0001EX-3f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpyLmBYXbHHno355Cd3qs+A0HW7Dz+VqgNCky54LzlY=;
 b=LoePp8UD5C1j+y8QImUF409E1UQL2C3cNqE7TA8sqleX45+O8PglI+R1BiuuZJtGq9IcCi
 KOp7pl0RbyGyxBPjj6yUgwu7+yqVMlsLDXuKHo98quKv+zmfUDD3yr/IqbLR2abt9Og6WR
 MQD4bGqEUfzk4smseyLYUvHcyIMKOwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-WUsJ2d4FP6q6JSS1iG2SjA-1; Mon, 16 Mar 2020 17:27:49 -0400
X-MC-Unique: WUsJ2d4FP6q6JSS1iG2SjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91BC61804540;
 Mon, 16 Mar 2020 21:27:48 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A081C19C4F;
 Mon, 16 Mar 2020 21:27:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/61] hw/i386/intel_iommu: Fix out-of-bounds access on guest
 IRT
Date: Mon, 16 Mar 2020 22:26:37 +0100
Message-Id: <1584394048-44994-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

vtd_irte_get failed to check the index against the configured table
size, causing an out-of-bounds access on guest memory and potentially
misinterpreting the result.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <4b15b728-bdfe-3bbe-3a5c-ca3baeef3c5c@siemens.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/intel_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 204b684..df7ad25 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3094,6 +3094,12 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint=
16_t index,
     uint16_t mask, source_id;
     uint8_t bus, bus_max, bus_min;
=20
+    if (index >=3D iommu->intr_size) {
+        error_report_once("%s: index too large: ind=3D0x%x",
+                          __func__, index);
+        return -VTD_FR_IR_INDEX_OVER;
+    }
+
     addr =3D iommu->intr_root + index * sizeof(*entry);
     if (dma_memory_read(&address_space_memory, addr, entry,
                         sizeof(*entry))) {
--=20
1.8.3.1



