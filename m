Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586EC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9386E206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="BAHxp4/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386E206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=forissier.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQVQM-00033g-Nn
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46274 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jQVPW-0001kL-1J
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:26 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jQVPV-00010J-Mv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39408)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerome@forissier.org>)
 id 1jQVPV-0000wn-9a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id b11so11860865wrs.6
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JiGmGsPkvQNSd6NC+nKiNxF/ISFZKcmrsOBoVkLlC7Y=;
 b=BAHxp4/LBr74hRz9+uwNPUHildoOuEJ9OK1Vsd1m/ZVIL4ybzBvorPxWKShksm7lnM
 rreTmsFpXjOL12U/6WLIiDqBBGS/PisqUq3gUKaUY9U+veKTf6V8kFMBOEE3ozHC4Y0N
 NVyxpHShqnVpSRFGF6SK5d/aX15sSOghndDRnrLapOVom6C3PilMhgsxk+I2gMjteFwq
 TsmIoFMXSEjOWa+1ry2+mMBpoctCQsWx+7mArc1Ys//uxaREPz2txbB0GAHZGQ6dYh0F
 acysbX0G7ylxsPk0973K5jbbm4CNFrxndPtMSR+3DLWoWMuDQry6+SzuG6JT0t3JIZ9y
 bbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JiGmGsPkvQNSd6NC+nKiNxF/ISFZKcmrsOBoVkLlC7Y=;
 b=NH7M4LH0be8Hz7Cxr6in5mBekejF3OT8OTMr7RYDlgyN40cYYyEWn71Pgx97WRxmg2
 ZyR+6hn39x2kpAsVFWipYxyPx6QLVMAgLU1hHVEJLSiwF9PYRDNTWpDgklUjMJyvPmpK
 fclpkHD62CzmxElr1ClMNNc2w5a0at2WLMrjJwuPIz7h57ZoyTQAjreTAdTDVDW/KATz
 wIN8n0BpHjRiT5B79NIA450m3UsAA66zn8dzkAdjQdxnx40uJWGsmrF0Qa9iXBWe3E3a
 ZpZR8QxGThyzvS0DayU1eIyQtLlB31guDpknv9gzNrxByrxA5wc3vR9TgxvYENAikcV9
 Gcsg==
X-Gm-Message-State: AGi0Pub4Trb++epkzq1v7a7I3Fugwu1C7r4ZLqVaeYQMLw3yvQuCxy7a
 8XFCj+G/gkIJJdgfAxP+ylzWzQ==
X-Google-Smtp-Source: APiQypJrej0pRbeG6EuXVtUh/6466du5QhatNbrLMD3jqUPJIgOgM9ChwzD27vD3Z8Oq5wbwsUGsCQ==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr18431335wrw.412.1587385222733; 
 Mon, 20 Apr 2020 05:20:22 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:4826:2464:6688:71f6])
 by smtp.gmail.com with ESMTPSA id v16sm1127132wml.30.2020.04.20.05.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 05:20:21 -0700 (PDT)
From: Jerome Forissier <jerome@forissier.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] hw/arm/virt: dt: add kaslr-seed property
Date: Mon, 20 Apr 2020 14:18:05 +0200
Message-Id: <20200420121807.8204-1-jerome@forissier.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=jerome@forissier.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: tee-dev@lists.linaro.org, op-tee@lists.trustedfirmware.org,
 Jerome Forissier <jerome@forissier.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset creates the DT property /chosen/kaslr-seed which is used
by the OS for Address Space Layout Randomization. If the machine is
secure, a similar property is created under /secure-chosen.

Changes since v1:
 - Move creation of /secure-chosen to create_fdt()
 - Use qemu_guest_getrandom() instead of qcrypto_random_bytes()
 - Create kaslr-seed for the non-secure OS too

Jerome Forissier (2):
  hw/arm/virt: dt: move creation of /secure-chosen to create_fdt()
  hw/arm/virt: dt: add kaslr-seed property

 hw/arm/virt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.20.1


