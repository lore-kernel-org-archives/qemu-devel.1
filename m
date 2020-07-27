Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C719CC43445
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9323B206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O08TvgJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9323B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Df-0008Kf-Pu
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04B6-0003aq-Qk
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04B3-0001HI-PD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXITvKmBNRuCK1oQcQxl+D6gdJLR2Jn4LOvKMTH1JwU=;
 b=O08TvgJc6nKNnoCH2Xj5atHouM1/2E7lPCizsaYSP3BaZnYzBFBbIT+hn9IgtVQSyjt95u
 /E5FP08i9x7ixbjuXn1bk74A/0hOHTXMl62Em+S9y+QCwSiup/gmOFqVMb8A2k3uWNkfBL
 QNTT4W1x50oVGCuqJXp83h8c2ubZiig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NQrOIrtkO9-DpG22NoFh8A-1; Mon, 27 Jul 2020 10:32:26 -0400
X-MC-Unique: NQrOIrtkO9-DpG22NoFh8A-1
Received: by mail-wr1-f71.google.com with SMTP id f7so4000586wrs.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uXITvKmBNRuCK1oQcQxl+D6gdJLR2Jn4LOvKMTH1JwU=;
 b=UVePNdOfhT5+r8lX36BunrxVaAnJvmCpPa6RpcTUEn0gZcI/bZ0ZOyS2pkdZmnQPaM
 T2Y4fk0k23TAmcZP6qKf0X8+hnciTCNzzzMluFhKWSmNb/DV+WkUSNnKBLHloUIichKR
 g9XbCvSF7DoypflGK1uBRRJrbakTu9iCp5bNTaSxTViA1f87r247OqKJ3dllXkLBlwg9
 l/tR7rL1Q5fgXxi5M75LN9sFcwgErXjmDPnZz1DNja/72QDZZffLM/3OPiVWrc4HjH8P
 W5pHSvo8ShPpaYGaGneF0exjwYmOJqpGf2inkxeEUMEA8xa9ll1qZ0JTO1n+Y2bzp4Dl
 1WTg==
X-Gm-Message-State: AOAM533KRnJjjM/FG48oQXHLER8ykWfLdd9Xztuwla5gHN5235Y2VXDW
 JLvZl9/UmNOezY5Uxwk1T2PKN/j5ZBgF3TZlI857PIWQNJ7zOwH1jFTdyKkmVu4hauLzm/WUG8r
 y4dErnIf19jfxcuo=
X-Received: by 2002:a1c:a590:: with SMTP id o138mr20556057wme.4.1595860344731; 
 Mon, 27 Jul 2020 07:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnyDHnxSfz+q2pY+M48DicdOBknT09CJVyLud4rXI7HIR7g6ywnP++PxohDaQIXTJ9yU0AbQ==
X-Received: by 2002:a1c:a590:: with SMTP id o138mr20556039wme.4.1595860344564; 
 Mon, 27 Jul 2020 07:32:24 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t202sm18517187wmt.20.2020.07.27.07.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:24 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 6/6] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200727143104.97776-7-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add an entry to cover firmware.json (see commit 3a0adfc9bf:
schema that describes the different uses and properties of
virtual machine firmware).

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200703183450.32398-1-philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3395abd4e1..0886eb3d2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2667,6 +2667,14 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
 
+Firmware schema specifications
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daudé <philmd@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+R: Kashyap Chamarthy <kchamart@redhat.com>
+S: Maintained
+F: docs/interop/firmware.json
+
 EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@redhat.com>
-- 
MST


