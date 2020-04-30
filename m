Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E8CC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FE420873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGbak7jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FE420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC1w-0007LR-0m
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC00-0004tb-2i
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzP-0002Gb-RQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:19 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzP-0002Bh-EL; Thu, 30 Apr 2020 12:24:43 -0400
Received: by mail-lj1-x242.google.com with SMTP id a21so7127547ljb.9;
 Thu, 30 Apr 2020 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjpYghyNqmUax0+ufzqkeCRlXZXVmlpA7XromECBQGI=;
 b=mGbak7jqnfbHDXFv5lgjGr85HKqA2Vr4yi4NIMvsin3yyprfFiY90YNbCP85gtxdv5
 klkXw9jOlJGa0okJ7FZdOSdFDt6XjxO0Z8u5j6korc6B/tZ+1EHskjUyotcKHMtjfFi3
 t3oBewqEvLFSVUcr26RR8vE6RM+m/aamB7HcQBclGzTiYTwgxFQCbLdcwdep4bkzBbN0
 TDOvhtavHJjccHGke0PTR/990nXUN7Xzn5UdHRKFyJyUobDdVAQwK3lI5znLJ/+CJ5Q9
 ruw4NMcNajwkjR5ggP7TqnWKsQrH4O7EtkjkGqYqffqcYpUG0pF5WmWUBUvwy7xx5UF1
 KDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjpYghyNqmUax0+ufzqkeCRlXZXVmlpA7XromECBQGI=;
 b=IWtVEB0ipxiQzSrFvSlBnY/rWlbZ4829L+MQZoY+lIvnIJUvwKcpi/PQJmAc13ZdFX
 MY+Jrqr2T5/+GFV7coFlEHAGK/0iIZjuuEOrPvEj+Blqlt52Eho4XlHmeorL5uFSKLWs
 3NcAcEJXLLnfdwptkTPDO4UICIcSm7hQeGqCUI8J9coSmMOAG9sCrgaJLEAhH8er2QpY
 XRR0MCkz04nUSGEEYHuIp579jBNmglPe/0E53PhS5ySAQJaoRgdjwzwD2Ji5MwayB9HB
 OszwWp3z63oTuYuiCmy04sMiB0gX3GqIZPJx2FiFBsfbSJglgSeYklLXeBRHgsztlytC
 3n+Q==
X-Gm-Message-State: AGi0PuYCbzPI+y4/676bkxKl2Ov8gpgRnPfXYMeg3d+V55/QLp0P3ivt
 o+V41zO6QKFP6U8kMoUwIkkC5Wq1XYw=
X-Google-Smtp-Source: APiQypJGvlx2RF4Qxo2E7DEjGSszwwM504lyJX5M7fuSMa1+oONRLCtuek0UtHIs+2mMpId6e7mzRg==
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr83830ljc.48.1588263880943;
 Thu, 30 Apr 2020 09:24:40 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id g3sm160825ljj.13.2020.04.30.09.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:40 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/9] hw/core: stream: Add end-of-packet flag
Date: Thu, 30 Apr 2020 18:24:30 +0200
Message-Id: <20200430162439.2659-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

When modeling pipelines of processing nodes that communicate
through streaming interfaces (e.g AXI-Stream), some of these
nodes send packets while others may just stream unpacketized data.

The purpose of this series is to add an end-of-packet flag, e.g
what AXI-Stream calls tlast. This is in preparation for modeling
future nodes that may use huge packets that we wouldn't be able
to buffer and also to handle nodes that don't use packets.

Along the way I fixed a few things in the petalinux-ml605 eth setup.

Cheers,
Edgar

Edgar E. Iglesias (9):
  hw/net/xilinx_axienet: Auto-clear PHY Autoneg
  hw/net/xilinx_axienet: Cleanup stream->push assignment
  hw/net/xilinx_axienet: Remove unncessary cast
  hw/dma/xilinx_axidma: Add DMA memory-region property
  hw/core: stream: Add an end-of-packet flag
  hw/net/xilinx_axienet: Handle fragmented packets from DMA
  hw/dma/xilinx_axidma: mm2s: Stream descriptor by descriptor
  hw/dma/xilinx_axidma: s2mm: Support stream fragments
  MAINTAINERS: Add myself as streams maintainer

 include/hw/stream.h     |  5 +--
 hw/core/stream.c        |  4 +--
 hw/dma/xilinx_axidma.c  | 75 ++++++++++++++++++++++++++---------------
 hw/net/xilinx_axienet.c | 63 ++++++++++++++++++++++++----------
 hw/ssi/xilinx_spips.c   |  2 +-
 MAINTAINERS             |  6 ++++
 6 files changed, 106 insertions(+), 49 deletions(-)

-- 
2.20.1


