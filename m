Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4053C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3908F22265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdUYeQJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3908F22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvuY-0007f5-8G
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRI-0003Ey-FP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRG-0006IU-64
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id f21so10431379wml.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z81qFU9MDMz+ow4A3PTc5iA9Aj8adQBNAwreyQQkkos=;
 b=SdUYeQJPK5bA6H5D+mc+U8pu512UTsRBuu+5bP8asfBcuzFaINnOMmX9UZMNdJS1VF
 zU3rvuII2+iWST/SmHrTytlXS5mz/zUtTo579sxPsi9Gi3JpmYC8nqz+EYU3gEN6Qz7u
 59ytpN3p0B6wXKF+ZQfVuSddUlt+04klh7RoIunckVeJjgaXeA4xlMxL3oVV96xmFV/2
 Lsoq4AdRkwXiTmohow4jd9xfBPm3Aqv+87JBbI4z/nOZdd5Yc+ZBpi88R6kbQCzCKaHR
 lvKgquYYs+jVsmnOdajMtXrlytMsjbtY8lBE9NMEdE6pUAnk3B7xuqJBQw/wzqCrcEX4
 I5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z81qFU9MDMz+ow4A3PTc5iA9Aj8adQBNAwreyQQkkos=;
 b=qVDsJ8HAEAcJmWV3ySkf6Neh0jTucqpDm9XW9nC9jEz1zsYIdFdqjMudFQWH4T8Ia4
 l8vU3JSq/HZxXa1GXz7r1xPK7++Vd+Psi6MYWI/ckl/lfXt1Lcz1bBLcC48kkov22Pye
 gr0o/lGT4x9KfkIHya9h0gstWWfED1KSS7cnp+RZiKek6zHleQHijdEv3rCYhaNYP3zw
 SiwqLS0YY8obKzOlIR1vzptNh6l1knq5bRAgS/KWPtus+GOd49el6GHgWkzZK8OaltPc
 n04vA7W64bBc+Qjj2XqNYF2PBCCFHD2FfNsuSAjM7/Scula0Bu9h5mFdSH+3FCeJxpL4
 bvWQ==
X-Gm-Message-State: AOAM530Osn8znfkrwcYvOvymd+/uTn5zDzfpMBGTjEEtZLz+Lc12bjyK
 0mIAbfWjVrmv7xkT+burV22fDw==
X-Google-Smtp-Source: ABdhPJzIGV7UzXnE1VwqIEWE7uTAw/8eNjlYSsmr5jgYCrkkcPaLsjm28TJeALCyYTP1dHJDeAOFDw==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr14172224wme.132.1602261612875; 
 Fri, 09 Oct 2020 09:40:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm8790939wru.15.2020.10.09.09.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7CA021FF9F;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/22] contrib/gitdm: Add Yadro to the domain map
Date: Fri,  9 Oct 2020 17:31:41 +0100
Message-Id: <20201009163147.28512-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20201006160653.2391972-11-f4bug@amsat.org>
Message-Id: <20201007160038.26953-17-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index d767620837..1572070cf4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -32,3 +32,4 @@ suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
+yadro.com       YADRO
-- 
2.20.1


