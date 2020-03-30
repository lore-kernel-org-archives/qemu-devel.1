Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ED620716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptlpOOYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ED620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIudm-0000Bw-Fr
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub3-0004P8-Ai
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub2-0001Ax-7m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIub2-00019e-1f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id b12so19982479wmj.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Tzhpk4dwyOYNDStF5ysavvxsRESBLzN5HDwrZYha4/8=;
 b=ptlpOOYvB6mk+eUKfTcGMEBgkex5Epg44mYPWz5XwqxkoYN8NSQtgjHDF5Ri9ay+gh
 6uhIjifZkJ+twuHQdcyEBVG1axq+UErn9iSFqFsj3q3Vo3gwRV8oVzp0zicvAuTdfz/t
 AZjVezs5rsn/u3cTz1hcRb2/waQeP9jHDhgzu61FBkNi7VB3i4Rhd/kBoh99SDg0jEqr
 Kve7T3/myuAb+yvogFtSTDGFqch3gROgU8PVnQoBdgxeDWr4vy+RMJasrvX2upXWeqNk
 k538NHl1WQHwFVeqS0ZqgibxQwXxzqMrgWGQpVZ5BepfaTTgflv8Z0S+sgaIo1oyd6eZ
 jETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tzhpk4dwyOYNDStF5ysavvxsRESBLzN5HDwrZYha4/8=;
 b=spqThEpR2NIvw5gmvfTAyRWxdPO3qrbPQxRhQJQkrH+GaO7X7AVppb1Zc2qI5uJS5S
 TNpuy+GZMx2HN4nqYJUXkpn2zDvuAtqrmdvNSHgi+lWK99ay92vhUzUujFD5Ta9JRkVJ
 t32CHRsguXvt1rNqwEv2L80vqXi/W6U85H6vZbFJyq3LSgI/gau2vnejuLbAx/j3ywFJ
 Vm9ufMqU3+IE5h9+HziRycIeCSfNTAB5y2enzIGS98EWaJPpuEWzdm/miKnZI1Rp1AwU
 aUe7J3sRGhiB5PxnjQwl2cMP98jirY/haTAhEO8HvUKCiPk9Hg5mFG5a4QPP51aJ5JNh
 Fn7g==
X-Gm-Message-State: ANhLgQ0ikw1fTE7QPh+j/PxxDciJUg+pg1GWpY2E4tysmAU+IFa/mYUs
 io9CaXzFEUojqI39taNx2gqRQVFbV/tZxw==
X-Google-Smtp-Source: ADFU+vvifE/z7h0dd5bnLo/nUC2assBgq6XxlAV4AHHcEG9zgCh4cCGL8cEh/ByBhlPRpxJ+lmqg9w==
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr13047793wmn.161.1585575414767; 
 Mon, 30 Mar 2020 06:36:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return
 path
Date: Mon, 30 Mar 2020 14:36:46 +0100
Message-Id: <20200330133648.22297-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In xlnx_zynqmp_realize() if the attempt to realize the SD
controller object fails then the error-return path will leak
the 'bus_name' string. Fix this by deferring the allocation
until after the realize has succeeded.

Fixes: Coverity CID 1421911
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200324134947.15384-2-peter.maydell@linaro.org
---
 hw/arm/xlnx-zynqmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 49f1c8d0de2..a13dbeeacec 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -520,7 +520,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
-        char *bus_name = g_strdup_printf("sd-bus%d", i);
+        char *bus_name;
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->sdhci[i]);
         Object *sdhci = OBJECT(&s->sdhci[i]);
 
@@ -541,6 +541,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
 
         /* Alias controller SD bus to the SoC itself */
+        bus_name = g_strdup_printf("sd-bus%d", i);
         object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
                                   &error_abort);
         g_free(bus_name);
-- 
2.20.1


