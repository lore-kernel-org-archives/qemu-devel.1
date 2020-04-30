Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03209C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3172073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiS7HOZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3172073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUESb-0007sf-T9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUER5-00068h-CX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUER4-00036s-Oe
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUER4-00031l-9J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so8428943wrx.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yWh3aRGKef9xVplQd968UKYGmgCSPBAT3qOdlODDYkY=;
 b=NiS7HOZBmh9WbMbvRyw01RMvsslcTHr62j4nGPGx04j78hhA75P9Q69GqvBszN2WFj
 4SOWyLl+F9Z7qNRqZEuKjWmrJ4PLfDLTzyiWY4GpyLSEmZAl8Rr4Z9A6VtLuD0jCotQU
 H5p4lbO5QazuwEtTu/hAYCvkH1QTy0tF3khJ4681Es/4fu6OB+1BmlFaweDbfYJAexKm
 jUGImJW7KhWfid6Bk2exNpnzlrRgt8a7Ez7aq7bjlkp0paiqKe7rbbqkq26tBJPDs2jr
 /XrasTxQyXZDR+qF8++WdOh1rE/4OUXYM2xNPD6HNp8d/Zr1dSwauVSe6ofqJNgTGX4u
 NRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yWh3aRGKef9xVplQd968UKYGmgCSPBAT3qOdlODDYkY=;
 b=hvcWIQwBSBTqNEGbcZXZ52ZOeQTkR1mLq7m8Bpek0Bx+J7cIU/VNQt+HcgMxzjYl4I
 P148/1phtFUlO760d1CKwMcBzDV7xRc87dQCG6yIURxuYuyTEy9TaxTegirrpXv9scD2
 D9uHJQYzADy7gjuEKGAAfisv3uTW5RIi9kcGk0/0TKLHh9o6miZ6l+sgar9O+DQdaYQY
 DfQYyEOuZxgW/+HI8P2FEyY5KdQ9O77hNQcolB/naBHUyFqKICkk6aLjdKCdJqCNrT2s
 C5Q1xi/2MnW6G88lNAKYzY1sNzJyLbylEFLz89gSFKJVQ4f3dD7pZKX7fAPjcFclxeKr
 keuw==
X-Gm-Message-State: AGi0Pua6s2IhFEprBdSUr2+X3E6GSlsiGv0mZckAsSeEejqkpuoKmgE0
 +lcx7xW2v8Q6INVxswMjh1QM/FWTnZ0=
X-Google-Smtp-Source: APiQypIcbeARnCquFav+BAc18+7h/U4GJirQo2w27x9dbWamveneFoAalV3qSeGOpZOhJPFKzF7RXA==
X-Received: by 2002:adf:82c1:: with SMTP id 59mr3588975wrc.377.1588273284623; 
 Thu, 30 Apr 2020 12:01:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm692079wmi.22.2020.04.30.12.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE90C1FF87;
 Thu, 30 Apr 2020 20:01:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/9] configure: favour gdb-multiarch if we have it
Date: Thu, 30 Apr 2020 20:01:14 +0100
Message-Id: <20200430190122.4592-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As gdb will generally be talking to "foreign" guests lets use that if
we can. Otherwise the chances of gdb barfing are considerably higher.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 23b5e93752..c58787100f 100755
--- a/configure
+++ b/configure
@@ -303,7 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
-gdb_bin=$(command -v "gdb")
+gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
 if test -e "$source_path/.git"
 then
-- 
2.20.1


