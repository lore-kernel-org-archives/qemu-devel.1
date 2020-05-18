Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986A920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjfn+XEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986A920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaY9y-0004KA-Si
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwr-0008VT-OA
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwo-0004Me-2N
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsAv/bgnHykNzduPwvkuhFwRe3NU9ni7q/NMPUd4MVw=;
 b=Fjfn+XEV9eqz4yB0DPH1CS6TBuPUKGBfYTVW7ARSa2dItOkujO5j2JDVmuprztvCuQ90uC
 pqvYPYwZXiSWH5PB7moHXl9jix7mikFbsdJUd9Ejwpw4zbJxMvjxTLIqldTfPFr9XtCvqd
 DPGPuX7R2rrQ1UGaYV3Ew4saocuHZ24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-80zTJOd5PGW50U9P0ir-Dw-1; Mon, 18 May 2020 01:04:13 -0400
X-MC-Unique: 80zTJOd5PGW50U9P0ir-Dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A34A1054F90;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 186355D9E2;
 Mon, 18 May 2020 05:04:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F46C11358CA; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/24] ppc4xx: Drop redundant device realization
Date: Mon, 18 May 2020 07:03:57 +0200
Message-Id: <20200518050408.4579-14-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_set_bool(OBJECT(dev), true, "realized", ...) right
after qdev_init_nofail(dev) does nothing, because qdev_init_nofail()
already realizes.  Drop.

Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/ppc440_uc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b30e093cbb..dc318c7aa7 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1370,12 +1370,10 @@ void ppc460ex_pcie_init(CPUPPCState *env)
     dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
     qdev_init_nofail(dev);
-    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 
     dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
     qdev_init_nofail(dev);
-    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 }
-- 
2.21.1


