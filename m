Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B731C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8182217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG4ATBNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8182217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfEx-0003Gr-9c
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0001av-J2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005rc-Mi
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005pc-3t
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:22 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so933183wmf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ghWaCjCti0TY76Vco8TfPl0YwPAyikexg28ipljmVM=;
 b=eG4ATBNesK65nVRXR0PUrHjpelQPk6NvSzOWnWvDEtnXrRQ8bontwzvc1ZiEfNsm+S
 +jfhqqMeI7rzL2CtivvmaWC3odD++zjUATkf0ZIwQf3Gk50jfhkk8/Eb7XalP11h9+GC
 8VVBXkvhFbpzfQud1OdkmXS/j1TyMXfZPR2JCjRnad1B3aBlTiT6qd8sWtf/o8nZhzVi
 0eTG2+RCMDH+kSpkluLTMqU4XTiQfgMgpubkJr2qmqjq13ooBNBejHfFIUGowjmB350i
 O+31Z3+CUhoV3+3zxBW2CR/gxmq7TpODSSIEP9sLuNuBitfqvrwcUKvgsDA6XYNjgf9j
 qgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2ghWaCjCti0TY76Vco8TfPl0YwPAyikexg28ipljmVM=;
 b=az6WCYf+T7vip9ixA3SO3SdSAJrcnvrn36egGlCBX3+ZjeHm23QDRKkDxLv1Aia8UA
 knTshNq1pS7gpHgRAhetkg0eY5SuhXfO8U5UVUw5Xk8qZg+1HwQrNdVHMWendvX+ZGb2
 FmygI/Ro/Fv5sT/Og3C/ssGEcdot9VJ679vn2zffYMRTyX1k5+c9xL/3fBtrytKteDna
 N7Kn9OwFrTrRIcKWPK93UZJUPWjcjmmlkyrVRI8nw2Rq2hmthPMup6k/MnA2BElOc1Ez
 NB7JaCzMkAP/DUpUqKFDPCunM1pG0OJ787E+9K8Xwbq0WxX/sfC5LRDIEN3yo8LVBNfX
 lhSg==
X-Gm-Message-State: APjAAAWbYhzCwKYKhhgDvQ+6P1BsI1D5PUGDMyefhzjYs4hIZoJDXTYj
 O8Bf3z67mUo3JBw5dPCCd6bAVECW
X-Google-Smtp-Source: APXvYqyIOzAuDj5wUROQWgQWQIF48khrRUMGJfOxU/C/Cwi5NpAFH+meIkhPOCcWs+31WYdnP6FvqQ==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr812621wmn.47.1579557679264; 
 Mon, 20 Jan 2020 14:01:19 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/18] hw/misc/avr_mask: Remove unused include
Date: Mon, 20 Jan 2020 23:00:56 +0100
Message-Id: <20200120220107.17825-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/avr_mask.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h
index d3e21972d8..5f95e1081d 100644
--- a/include/hw/misc/avr_mask.h
+++ b/include/hw/misc/avr_mask.h
@@ -26,7 +26,6 @@
 #define HW_avr_mask_H
 
 #include "hw/sysbus.h"
-#include "chardev/char-fe.h"
 #include "hw/hw.h"
 
 
-- 
2.21.1


