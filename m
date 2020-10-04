Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F9CC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AABD205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzs/aVNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AABD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8bs-0003GZ-7u
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nl-0002fw-0Z
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nj-0008L3-A8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id y15so6566226wmi.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FiPvds0GZI65W3L3Mb5GmUfpdCEo47q4dye+uQ26pTE=;
 b=Kzs/aVNLcaIU4MQwKO5v66644dGWUaoRnKK68vbNa/pF7NHgXqQPpEXJTXQLCdE7YC
 ay7e5GLvjUMdarZXnACb3keIdsg/4jYyOvnuHMSgYKCNeFwoOylAhiwzdvxmOjatSzLe
 QcuHJ51ZeL1QR/iJZwxJZESz5BAz6JjUek1zARkIY9oQm35i07AUquGk+PUFK94iXZGM
 JzzmLsCYcpkrfsVuETLKB3qmRi77VjwZg7mfi0e+hiYfqeGtXH0eGiVnmFmA/SNgZUY4
 A7R5XVzNqiEd3BUrVKrVdUCYI3JGrUq80/9aXRcz9BakmIUiIiI5w0lULInumqYa5iRx
 kgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FiPvds0GZI65W3L3Mb5GmUfpdCEo47q4dye+uQ26pTE=;
 b=Gusx/OBYtYhLncQyKZxGXtHFX7YbxnObXE9CpfDugnh7B16D2Bmhzhv5LcxSLrh+iZ
 5VaR/hFQu3WaIDnIFk+oNtJ+wEJmadN5aGTh0B1AV6t5K1KrYvguL7lkBbCkhZNpCL/2
 vb1b0NN5ya2G3ryrQctB/ka+mocJk5M9wLT81qdpOjIa7rY61IrPIwcopPVf1oxYhvox
 6+XWHJ4jtdNyQQd6i3xPonyrYaqeiALISym2hiOhwC1zGwoM2kw3pB4YLqnxGq3/rQ2j
 +k1wbHAsA3MXnZfgaTV4fLC8YqOZ0QFbO1R8ETHiF8InAqfDyQNRoWVpw5cxuT88rOyq
 jAnQ==
X-Gm-Message-State: AOAM5323cTDOePh8Xhq9+MKitYQ+cOszKTZGrdwv6FjXfTCmXbRUu1Ni
 fK4dhMJet0yzCCpPWp7DNYO0qvezeTDgzA==
X-Google-Smtp-Source: ABdhPJzhcIiv+0YyIauOyIOABaR5PR/3k799bW9Tq8W/daOC+ZQN1QjnkDQX6cVN5S8dOTzFaAtHkQ==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr13563792wmi.56.1601834709775; 
 Sun, 04 Oct 2020 11:05:09 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 17/21] contrib/gitdm: Simplify the Wavecomp domain group
Date: Sun,  4 Oct 2020 20:04:39 +0200
Message-Id: <20201004180443.2035359-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Dimitrije Nikolic <dnikolic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, YunQiang Su <ysu@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Neng Chen <nchen@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the domain matches for all the contributors,
we do not need to list them individually.

Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Dimitrije Nikolic <dnikolic@wavecomp.com>
Cc: Neng Chen <nchen@wavecomp.com>
Cc: Stefan Markovic <smarkovic@wavecomp.com>
Cc: YunQiang Su <ysu@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map         | 1 +
 contrib/gitdm/group-map-wavecomp | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 65a6dcb74e..9642fd44fc 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -37,5 +37,6 @@ sifive.com      SiFive
 suse.com        SUSE
 suse.de         SUSE
 virtuozzo.com   Virtuozzo
+wavecomp.com    Wavecomp
 wdc.com         Western Digital
 xilinx.com      Xilinx
diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
index c5c57f0eaf..414196f12e 100644
--- a/contrib/gitdm/group-map-wavecomp
+++ b/contrib/gitdm/group-map-wavecomp
@@ -7,10 +7,7 @@ aleksandar.markovic@imgtec.com
 aleksandar.markovic@mips.com
 alex.smith@imgtec.com
 andrew.bennett@imgtec.com
-amarkovic@wavecomp.com
-arikalo@wavecomp.com
 chris@mips.com
-dnikolic@wavecomp.com
 ericj@mips.com
 goran.ferenc@imgtec.com
 james.cowgill@mips.com
@@ -24,8 +21,5 @@ paul@archlinuxmips.org
 paul.burton@imgtec.com
 petar.jovanovic@imgtec.com
 petarj@mips.com
-pburton@wavecomp.com
-smarkovic@wavecomp.com
 yongbok.kim@imgtec.com
 yongbok.kim@mips.com
-ysu@wavecomp.com
-- 
2.26.2


