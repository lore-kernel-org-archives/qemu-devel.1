Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE6C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D175721A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGPsmrXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D175721A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwIf-00081g-OR
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw61-0003Zo-T0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw60-0006h9-37
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:34827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5y-0006f2-I8
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id y10so1479372plp.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mTFuitZe7hi832mSOd5Lm6Rc+DkzGOsmyco0ZFUycTI=;
 b=qGPsmrXG54x+Oh96kLbPCff8uASvb7FkRmjJGHrM3YlW1HAhbxc4NzbdkbPU2H1Dln
 rRFZLEshhkmJk3PUgTZ20h8vVFo8cz8DJv5zU/zXz5ST0zwNJw6TJdJGUIqdQCBfYYZw
 7jGaEdRGVnENlNvdcUe/IxwGtvOnpzYICn6l/10WmiyKlO7qSDwgQui+V26O0erTF20D
 QDXDaRKF5+ClvSEF7SXVo6R9Yz4c4j6l0mryU8xgd4/+m6zHtrSBgCYtj7ip9DiiY1L5
 0n8KNI+K9C5AvB2BNayL4VlIipvkaeEj0FW6Ncf1bxyVYnxzC27i64CW4Ne9921xUQ4s
 GXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mTFuitZe7hi832mSOd5Lm6Rc+DkzGOsmyco0ZFUycTI=;
 b=FO7VaoJJjPvMTKJjDu2xTH0gGCB3Z84w2DDsbegIInoqjflowz4VflIfdXdtz21D6w
 SOFV0NFC3mLkeTseJZCp73qP3U+LbJfW0OMrUHvxr8VrJSPIpmhcBAB/VOQ4ICVF7uRE
 IunGRoII6PuffKNyWurVhZjfOEez900WeItqdSKP8hxmX8tbzo0OlTzhrG6kTr9c+PDx
 tSR4fXTGap1PI2zTAMycWbiErYqU6Whs/B3VvCKusXnpxCRItw8rsWBReyF07zC9qjOK
 2T0pqWtVRjjgUu+3lJqt8QOmVdGiq1v/rd2gRYSjtJ1y7vMAQVQ0KWPI0MrI2CiEmBti
 m83w==
X-Gm-Message-State: APjAAAVWtmM2dNvweimrttwVlHWHXC33hLeDZTDdhq5a2/OtypGpdSFu
 tQeqYvueZf1SnrnjKfTb+qrUh1MHEm4=
X-Google-Smtp-Source: APXvYqxqyr1a9cesbgZUjPzO/XJ0lQKjO/1tpyGA7dvk/nEMdjE8b3CAXR0uwYo1NriviHYS0CPeyA==
X-Received: by 2002:a17:902:7401:: with SMTP id
 g1mr6588734pll.20.1569613200545; 
 Fri, 27 Sep 2019 12:40:00 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/18] target/s390x: Remove ILEN_UNWIND
Date: Fri, 27 Sep 2019 12:39:25 -0700
Message-Id: <20190927193925.23567-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This setting is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 686cbe41e0..fe1bf746f3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -803,8 +803,6 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
-/* instruction length set by unwind info */
-#define ILEN_UNWIND                 0
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
-- 
2.17.1


