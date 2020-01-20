Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91810C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2B320684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVn/wPA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2B320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU8c-0006CW-3v
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itU13-0005Sg-OD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itU0z-000347-1S
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itU0y-00033r-Um
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/+XJ49Tu7dfw8704LCB/a5N8PyvmwGwcwpzwkOaIEw=;
 b=YVn/wPA6QvL3TqP04tfwXLc5T5Zyztiz1X/AyuWe4hM50Hesoxbabz9wnvnHWLtr0NfRYy
 RDcW/7rPXACbCZRMvEb37SJIsCQl8bDpeYkF7/fp3rbXxxHysGcHsba/V1hFZ8t5/W650T
 yDIWIfmtFdsXBirGlo6X7NOXFTnmRf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-RQQpDBMSPtyfaDebCJnTtw-1; Mon, 20 Jan 2020 05:10:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050C0A0CBF;
 Mon, 20 Jan 2020 10:10:31 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 379BF87EDF;
 Mon, 20 Jan 2020 10:10:29 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v3 2/6] hw/arm/virt: Add missing 5.0 options call to 4.2
 options
Date: Mon, 20 Jan 2020 11:10:19 +0100
Message-Id: <20200120101023.16030-3-drjones@redhat.com>
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
References: <20200120101023.16030-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RQQpDBMSPtyfaDebCJnTtw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 39ab5f47e0bd..27ca26b05e27 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2153,6 +2153,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
=20
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    virt_machine_5_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_VIRT_MACHINE(4, 2)
--=20
2.21.1


