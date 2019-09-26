Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CAEC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0621207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xcDlj0To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0621207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRzq-0006fx-Px
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iDRyh-0005ti-Jx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iDRyd-0004qt-2z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:30:28 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iDRyZ-0004im-In
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:30:26 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E06BC2E1472;
 Thu, 26 Sep 2019 14:29:44 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net
 (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 mMUZQKPsCH-TilSHo6Y; Thu, 26 Sep 2019 14:29:44 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1569497384; bh=i2nnwIzg1nWTQQpv4RM8/xcu4nmDhVBtq8a3MW7sk1Q=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=xcDlj0TofvYMX3Th0LHHxgmy20R3NnL03LeeWVsOPaLDJtta5ADOpAQYIg3OshhwS
 5mMK3KYNsdoFHs4vL9c32Ui5ASWjwK9l3xO21G6rEX15Z3iWxpjoZ2NgvOzXYqDF5C
 Ohs1z0ZlWVyPcdrxgbLsFhwf5M8FEzUu8yaLDf04=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 V2xWpKE8dq-TiHaTgB6; Thu, 26 Sep 2019 14:29:44 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
To: alex.williamson@redhat.com
Subject: [PATCH] hw/vfio/pci: fix double free in vfio_msi_disable
Date: Thu, 26 Sep 2019 14:29:35 +0300
Message-Id: <1569497375-24633-1-git-send-email-wrfsh@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following guest behaviour patter leads to double free in VFIO PCI:

1. Guest enables MSI interrupts
vfio_msi_enable is called, but fails in vfio_enable_vectors.
In our case this was because VFIO GPU device was in D3 state.
Unhappy path in vfio_msi_enable will g_free(vdev->msi_vectors) but not
set this pointer to NULL

2. Guest still sees MSI an enabled after that because emulated config
write is done in vfio_pci_write_config unconditionally before calling
vfio_msi_enable

3. Guest disables MSI interrupts
vfio_msi_disable is called and tries to g_free(vdev->msi_vectors)
in vfio_msi_disable_common => double free

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/vfio/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c5e6fe6..12fac39 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -651,6 +651,7 @@ retry:
         }
 
         g_free(vdev->msi_vectors);
+        vdev->msi_vectors = NULL;
 
         if (ret > 0 && ret != vdev->nr_vectors) {
             vdev->nr_vectors = ret;
-- 
2.7.4


