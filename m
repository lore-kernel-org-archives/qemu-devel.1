Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC1ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E61C2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/LcaqaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E61C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0z3-0008Dl-TC
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sX-0002W6-CX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sQ-0007CV-8D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sP-0007BM-IJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id y135so87585wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RaAJNqxtyR8aXLKVw5sbQf31Y/61mB+VHzB3rmm6EQE=;
 b=s/LcaqaVn/HURVo2YXHm3wgYBiMrx66NIVGTD/0w0TIVJ7clOpbNO2+nKu8IBn+axh
 k3FHg4RrNz8K/PbUsD1GPLF0LdigmaBdR8Sl08ynsT6HqnTpi8EmQH6jrwnjUNSKvzjK
 6rmQNdUeqqFY/DFityUCpZdTwVAKgf7hZ4aAxH9xG8ObmW+BFG/AMCdbQH0KMBcCMWb0
 cBrYo39DJyF5dpBzYU8ULoQTlSfcWNsFD+omW/uUiEI6/PwUhMeOaoK2cCa5jkZ/qRLX
 PfJfd4r9Dh8GO7sj0JlnQn3N2XX0EAUXynShIomg2+LTC+Tplc6on/N4xnm/iBnGVjGR
 jEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RaAJNqxtyR8aXLKVw5sbQf31Y/61mB+VHzB3rmm6EQE=;
 b=kT0JoAIcl2W0NVOOLAKn0oGdZzZCqbLGOsG+6pFCERhAa9QyH9ltYP9jMgZmr/CxfL
 q2ot1pmJ6xPeJT/gQVzFFBGYZ6hLcGA/TDPYgtRkFr1C89qrpFDDJGCTBMPxWlefq6Kq
 HOVerKH5GI6L/oIv0Ouah/fZ5FFv2GSMszzkINdqXatBXVCz1AkfRTLqDPB9KJFv2PtR
 sWrZeDOXaHQBZ3zaPce4H52yKAnhD5fJjzlObQ+zziyIuxSznA7lYZrlW0bYKE6iQAKe
 eM0ZTEKJmWiSUxGDa66pO3lv9S0jMZAawEHJYUvVgxyX0Tn+nho0N6y2KDJG2tnAh64q
 rFiA==
X-Gm-Message-State: APjAAAXouRP690MB3kiOPxmC4vlqC/QMPEL8IUTuQlioWj+NW8RY0x2W
 fF3xZb6gzP1lCinLBRSv/wKGxw==
X-Google-Smtp-Source: APXvYqyrWqL1kD4rzjIcUNj7cCVYqlTr0jRwSeJ8xWxaRte/H0gUiAY/1vXGjohT7ZY7KISWIsYyMQ==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr14773657wmk.135.1571061547835; 
 Mon, 14 Oct 2019 06:59:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm17443220wml.26.2019.10.14.06.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 600CC1FF8F;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] contrib/gitdm: add MontaVista to the domain map
Date: Mon, 14 Oct 2019 14:59:02 +0100
Message-Id: <20191014135905.24364-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014135905.24364-1-alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Corey Minyard <minyard@mvista.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Corey Minyard <minyard@mvista.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 9efe066ec9..304e91010a 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -14,6 +14,7 @@ igalia.com      Igalia
 intel.com       Intel
 linaro.org      Linaro
 microsoft.com   Microsoft
+mvista.com      MontaVista
 nokia.com       Nokia
 oracle.com      Oracle
 proxmox.com     Proxmox
-- 
2.20.1


