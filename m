Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CBFC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D142D20780
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KmQoLplh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142D20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCtdp-0003am-VK
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kCtaf-0007R8-3b; Mon, 31 Aug 2020 19:51:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39469 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kCtab-0001lt-At; Mon, 31 Aug 2020 19:51:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BgRnJ3HlXz9sTS; Tue,  1 Sep 2020 09:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598917908;
 bh=MrGE/TpCR1qUcgPMnE2s3PEkLpFlXx8qX3wKLCtJ45w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KmQoLplhjSDGvc2pJDK1mlEcE9pGNruYViqDbO8AnJsF9buCY5773rObfg/1Ph52H
 N83TDPDF3o21uGHVB5dItlvTZDgAIxR/pBjSClXXBn3o13+fqyYwXc9jOVZvoxfyxA
 3VT1Urqf9Ng4VyOtrmyfODcs2m+t8ULluxJBq7YU=
From: David Gibson <david@gibson.dropbear.id.au>
To: ehabkost@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] adb: Correct class size on TYPE_ADB_DEVICE
Date: Tue,  1 Sep 2020 09:51:44 +1000
Message-Id: <20200831235146.36045-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831235146.36045-1-david@gibson.dropbear.id.au>
References: <20200831235146.36045-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 19:51:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TypeInfo incorrectly just lets the class size be inherited.  It won't
actually break things, since the class is abstract, but we should get it
right.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/input/adb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 013fcc9c54..84331b9fce 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -309,6 +309,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
 static const TypeInfo adb_device_type_info = {
     .name = TYPE_ADB_DEVICE,
     .parent = TYPE_DEVICE,
+    .class_size = sizeof(ADBDeviceClass),
     .instance_size = sizeof(ADBDevice),
     .abstract = true,
     .class_init = adb_device_class_init,
-- 
2.26.2


