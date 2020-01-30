Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18391C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43A4206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6IwLRQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43A4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCgP-0002Gr-1Y
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU6-0005mY-W4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU5-00037f-Q6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:02 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU5-00036W-IU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:01 -0500
Received: by mail-wr1-x42f.google.com with SMTP id t2so4820547wrr.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aB8sogKHzqSo+5j5JJF7r8R8zdumzJOaE75J49k/efw=;
 b=s6IwLRQHFNAyMMZuzbcLOY6WLQGB9B1kyq4dyaiH3rsHxUI6RUA3sKinBGzUN4jr+M
 14inPlUQe+UqNJ1r8F4/W/krG7qPkKlfbpuS/9G4rnHu6scw4SoXET7s030o3tMB5zsv
 lSoxd7favoVl3fvWzb0USLomV665bOK2/zzX6p7RiZFe5ohsv29xNZSyWgSgpo7Axc0T
 ULMJwPlmFDzE1OZDY0KrBklQ8evBV21XNxnTJqrZLrWYmAV4CjRybeT8qJBUyhQKfH8H
 pr9ds+KrXL+PeNC8krqAdseOean0g9TGn647KTfNaxOO1daoK6fHo2HnFvCAN18IqmWF
 lwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aB8sogKHzqSo+5j5JJF7r8R8zdumzJOaE75J49k/efw=;
 b=Ej2K+Z+8hTPXuYctPC5BGqtegD2Y/atWPQVkLdsFKzBbYikRLSEFT+DeTfN07HqCg9
 hyeqcOdLblmP97QLZ5zKH8uYQXct9ljkuUeKc/jIJso1NBsUX/h9Xq1rOtz/5OgUKNze
 3yARF2mK3fjA+9UvB0LVkmBMWs5MQPelnS8lOuHWIPoAS0fY3A0zZhifeGX4P6MfmSvQ
 J/GyCt2yW+oiTK10QPNeu93YrKwKg71Ixi8Z4bTPTGQAXQsCrQsOlfZGaruy9pCElmk6
 EeqAPo2wkwRKErTl+KdItd5jzbofB46jF9zjDuyfT++W57Z/bT5NagTVga0cTMtm2XiC
 z88g==
X-Gm-Message-State: APjAAAULEUUsDOan72iK/g0rDDnfI/u14rMro9MK41BPfugW4EDxBG7f
 1mNzw5tZC9jn7zPKJTzrBLu+bHweQZxwWw==
X-Google-Smtp-Source: APXvYqwBSaBMT7SHiU3SiAe6Qhe/eHUNKbA7fcUyorCIvmd5T+XfQp9R83E7AD0oqP+nghFrHuGjLw==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr6474203wrv.108.1580400959993; 
 Thu, 30 Jan 2020 08:15:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] hw/s390x/ipl: replace deprecated qdev_reset_all
 registration
Date: Thu, 30 Jan 2020 16:15:26 +0000
Message-Id: <20200130161533.8180-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

From: Damien Hedde <damien.hedde@greensocs.com>

Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
the ipl registration in the main reset handlers.

This does not impact the behavior for the following reasons:
+ at this point resettable just call the old reset methods of devices
  and buses in the same order than qdev/qbus.
+ resettable handlers registered with qemu_register_reset are
  serialized; there is no interleaving.
+ eventual explicit calls to legacy reset API (device_reset or
  qdev/qbus_reset) inside this reset handler will not be masked out
  by resettable mechanism; they do not go through resettable api.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200123132823.1117486-12-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ca8e7db4672..7773499d7f7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -237,7 +237,15 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
      */
     ipl->compat_start_addr = ipl->start_addr;
     ipl->compat_bios_start_addr = ipl->bios_start_addr;
-    qemu_register_reset(qdev_reset_all_fn, dev);
+    /*
+     * Because this Device is not on any bus in the qbus tree (it is
+     * not a sysbus device and it's not on some other bus like a PCI
+     * bus) it will not be automatically reset by the 'reset the
+     * sysbus' hook registered by vl.c like most devices. So we must
+     * manually register a reset hook for it.
+     * TODO: there should be a better way to do this.
+     */
+    qemu_register_reset(resettable_cold_reset_fn, dev);
 error:
     error_propagate(errp, err);
 }
-- 
2.20.1


