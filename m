Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DCC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB6B20578
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MgXT8Ip8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB6B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2p7-0000pd-4P
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 23:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hV-0002T2-El; Thu, 03 Sep 2020 23:47:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42773 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hT-0004uP-9N; Thu, 03 Sep 2020 23:47:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNsp0VV5z9sVb; Fri,  4 Sep 2020 13:47:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191246;
 bh=ugr0WxY1CRWShk3/UQfX+l/l8XSozOlyduL+5OhU5iA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MgXT8Ip8E4/cQUgLRsWWMm3Fl4c16h3xB9yafwj/uZ7rNePBi/9MsemqpZY5socG1
 uZrvURPR3UH/8+pFSQo0GtfuLMmciTqlZfnrYfiWVsFpBaYC05UUmTw7h+nP6xfWl2
 0l64BgXObT9d7h8kXX1A7JoKYQwe6RxJA8StJRUU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/30] spapr_vscsi: do not allow device hotplug
Date: Fri,  4 Sep 2020 13:46:55 +1000
Message-Id: <20200904034719.673626-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

We do not implement hotplug in the vscsi bus, but we forgot to
tell qdev about it. The result is that users are able to hotplug
devices in the vscsi bus, the devices appear in qdev, but they
aren't usable by the guest OS unless the user reboots it first.

Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
qbus_is_hotpluggable(), that we do not support hotplug operations
in spapr_vscsi.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200820190635.379657-1-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index d17dc03c73..57f0a1336f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
 
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &vscsi_scsi_info, NULL);
+
+    /* ibmvscsi SCSI bus does not allow hotplug. */
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
 }
 
 void spapr_vscsi_create(SpaprVioBus *bus)
-- 
2.26.2


