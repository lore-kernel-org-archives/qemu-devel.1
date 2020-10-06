Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08731206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnhGU7SD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08731206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpac-0005zd-34
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUb-0005l8-8l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUX-00040Y-MV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id k18so3673452wmj.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bWTdnvkMFZxMlTqwlnGSVEMobmPmo9SYknHZhze4QvI=;
 b=lnhGU7SDvx9sMLvcng5XA/kxp9Uongw+wuguFBEJaJP9CWzjKFNMbiMfqCiuiDvYuL
 8vWZHqfTv9Z5OcgDh0P4P9r239iJZvHooij7iyFhro4wHQMVUSOSXM9pAmx3pkrVEuQ0
 LyyFBqTyNcOsYsPNCp2YfFsLUdZ2y0Ua3dNvQK6i5RI81lbzvFUjTGFce4lvvz6VN71b
 7Ll1drQSRcHx6EleLBe32KSwQYtq64PB7CadMhWLVeXesvEkYfjzCG+dHnz5Dv7UGO15
 7a/kp6TknqZzeLtQuOXvhFGk7zW1Emz+JevbEbA2I8eyYEHYRzBAncDXhb3d+Jz7Xv4J
 NwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bWTdnvkMFZxMlTqwlnGSVEMobmPmo9SYknHZhze4QvI=;
 b=XQ/AYs53Mv3BxHSZTu3S1QD1hddy/UiCb/+Rus+BGHqCm9XOuLHYAWUPyRQf103OEi
 Pstall5lMvh1Haj15RIELg4TcsgNapry0/bRZWSuygdtNmW2OPKANkVznn2mCCWtu57x
 IL4mDpuRuHNSkmx6QDhCBeUFYu8lW4T1JXTjWZU16AbOQJiTNpNLlk1dO+FHDwPZd6QR
 9+Q7BUMvuOS5VsmFEKj0ly4mRUTTUavVbNcr/+H/F03rd0RCCvIqZvqi+PF+JuMux5X1
 k7vWDbpj57rYyHh8VmG940zwLTHhWzdbWrOFPYt1dsOmeHVUuCLRFOB0oOZCbH0JQ6IB
 MVAA==
X-Gm-Message-State: AOAM530kYYKWRdc7oYkb1THSxRi9z7tFA7QKemPBgIIK4vEs9ZTTi/WM
 KDhJm2yjl0CkopkbgPSfQEE=
X-Google-Smtp-Source: ABdhPJwIdTKUZ1uKrW653pTHZYVyBDeI/EPl9YMUAsBhAc/fQbdfR1MYKfqHSgz+X4PVIdLg+ugHuA==
X-Received: by 2002:a1c:9958:: with SMTP id b85mr5481445wme.108.1602000424432; 
 Tue, 06 Oct 2020 09:07:04 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 07/12] contrib/gitdm: Add Qualcomm to the domain map
Date: Tue,  6 Oct 2020 18:06:48 +0200
Message-Id: <20201006160653.2391972-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 14c0582060..6c5c92260d 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -22,6 +22,7 @@ nokia.com       Nokia
 nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
+quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
-- 
2.26.2


