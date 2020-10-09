Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC32C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491F122251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWxx/eib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491F122251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvix-0002sE-7U
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJJ-0000FQ-Ij
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJH-00059x-GE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id i1so4812948wro.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4s/DC9K20J4PURKx++oqfL/G3nyvyK1t76R0TE5S4GY=;
 b=eWxx/eibltajkIGk+ZMNrXKVdeZZmRfP3/Dez4Zu5GurmTgddCoWsjzo0oeDoqkcCU
 0f6+8icUxCzmB6e8wFKumsTnN6x2MdruVmEAby08p/b7FTB3ZPnrdyTmMYvuOzmzKXIi
 ApPyDbjeB+wb+tTPTJxm8vlvSlOL6WA+FUYe4s8uvRbSvA6MVsMacafoArcZ/KIsAi6d
 N2SKBQpIN2hxB2za8UgteNrJEuEk/vxJGmQMQVzyXkrrOZhsuvnb/RyuoYHtgXqQMrLF
 QGuXn+mHKeoYPxSTxrGbxIqOGQ14v0FH0KPVKRAxhQF9VH/cP40ERJcCieX7J6Q5eU9r
 hzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4s/DC9K20J4PURKx++oqfL/G3nyvyK1t76R0TE5S4GY=;
 b=fZMKhIugRFr1cS6cDKw+C6jmE0SBH+AMyQHDVRd90MjKZpBGS3RQ6S368XbilFn/1x
 Nm1CFYiLcpwEIihR018tuW7SEibIlxOBADuv85Gd5Eb/FG+Pu6KAoNlRqF47AHtpNwgj
 aRfJmjElAT+FPL3YTD9IlZpeVddyEux7HMXPhv1btxBXQlEEVhTEVVhVVbPILQ9wVYaw
 ywqkJDpYPhYFZAVtpWXs83E/MzQxBeEQfEDcq/kK5tsICyfzMbQxJoKUQSFeJuO1jlsW
 l1xbOfhrycdf0q4HVm727TVWQivjbSRzS2bhNjPLbu7fizean7OXI0qNVEJ2aw9BcMVw
 g8Fg==
X-Gm-Message-State: AOAM5324Ss8kklgYZleW4GQKytR7zTdEMHq/TcsYNYRbhN85PvFYW7R2
 8gOYV155YqrSc02m10yg8i+lBQ==
X-Google-Smtp-Source: ABdhPJy/7awmRtVZybU2LL/wxmJGcZfQRmWICv7wU/EklIKJxXXxfLmnB6MOww2bZJrj5iM6jotqnQ==
X-Received: by 2002:adf:9e91:: with SMTP id a17mr6853741wrf.228.1602261117996; 
 Fri, 09 Oct 2020 09:31:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t202sm13067824wmt.14.2020.10.09.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4C861FF93;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/22] contrib/gitdm: Add more academic domains
Date: Fri,  9 Oct 2020 17:31:32 +0100
Message-Id: <20201009163147.28512-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dayeol Lee <dayeol@berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Xinyu Li <precinct@mail.ustc.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Fan Yang <Fan_Yang@sjtu.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from these academic domains.
Add the entries to the gitdm 'academic' domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Dayeol Lee <dayeol@berkeley.edu>
Acked-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Acked-by: Xinyu Li <precinct@mail.ustc.edu.cn>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20201006160653.2391972-2-f4bug@amsat.org>
Message-Id: <20201007160038.26953-8-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 08f9d81d13..bf3c894821 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -12,3 +12,7 @@ ispras.ru
 # Columbia University
 cs.columbia.edu
 cota@braap.org
+
+uni-paderborn.de
+edu
+edu.cn
-- 
2.20.1


