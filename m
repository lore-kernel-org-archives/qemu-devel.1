Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FCDC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF2C2064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLHZIbZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF2C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCNT-0005Pl-Fg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC11-0004Wd-Em
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0v-0003GD-FE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so2879003wrv.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6QR5ktGyFX5rvyGdWXPqnVhoToO6cz5c2yp2SybGLtw=;
 b=FLHZIbZnXLZnQvx8VHNI3ElbyRo0BPYS8/PbpOWcvHvzSSx3RTtVWhxOdg1ZkcSH9k
 2WHzAcrUJAR8uW8ME7dDjlvDJJk1esqK79J0VgfwXUkxuIl/TdKJy9OHKBh08au2hymF
 9AJDqnF9lNN1Yoyg/TDzPF3dUp7fhOeKer+lpNzaEBDiWxHHJ90Gm5dr7NWpsCIE+nhy
 qxkjy195C5a7Pkk4pFBohdW+MyX5QLK73vhZozWA0CVTqKhrumQXXU8BMa1KqmZWZ1tQ
 4QuJU19JzXse2wbrqtJwPG+cC/OL1hg39ac86jzdyYB5lHxD9jXMNYdqxGeFi7iogXvu
 bbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6QR5ktGyFX5rvyGdWXPqnVhoToO6cz5c2yp2SybGLtw=;
 b=GaH3WuAoF1jZaZEssxn65a7BY45jqawQB4PSv3pRl6Dd42/QQEz9F9NRW05D0FJd0M
 xJ/UmVtGh9YMC1HDrUohCBuLy38HbmEM0u15J6EhMVYBN42YaQ7UbLz2rMkFT1zZ95pY
 pxZ3N7QAabz6i20i8VRMylchYy/130SXyaaRtQFXs34P7pbEWOUAv4/H+4XJA7aaxwLy
 27W+oY5tNHrpVszrMsO8hrOgVF4pUxMas8UlKgfeg3k0dVWO/tccUt+X3XMcRhxzg1Db
 ZIyVaxKhmzdGpC9bB5xso2SJDSjMdTSe6B0sFku3ag4HpIMAdCG7ubZ+ZFdx5QwrFByD
 gFHw==
X-Gm-Message-State: AOAM531+ARB7+SIG60v4VkEfNdC2C3o6hTPN+7Hg/xDo+ENDN/21qdua
 jJHPcyMaAsv3mArrg+XG5899xQ==
X-Google-Smtp-Source: ABdhPJzmQU6imC/YZGCunad3A6oKHc7ilKCfxSiIICQiYarFWggZ2R3IlY0NIX7QdUC/E14y6omiCA==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr4443468wro.135.1602086999182; 
 Wed, 07 Oct 2020 09:09:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm3250847wma.0.2020.10.07.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF8031FFA6;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 18/22] .mailmap: Fix more contributor entries
Date: Wed,  7 Oct 2020 17:00:34 +0100
Message-Id: <20201007160038.26953-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Erik Smit <erik.lucas.smit@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

These authors have some incorrect author email field.
For each of them, there is one commit with the replaced
entry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Erik Smit <erik.lucas.smit@gmail.com>
Message-Id: <20201006160653.2391972-13-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index b914c9e290..663819fb01 100644
--- a/.mailmap
+++ b/.mailmap
@@ -85,6 +85,7 @@ Christophe Lyon <christophe.lyon@st.com>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
 Eduardo Otubo <otubo@redhat.com>
+Erik Smit <erik.lucas.smit@gmail.com>
 Fabrice Desclaux <fabrice.desclaux@cea.fr>
 Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
 Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp>
@@ -142,6 +143,7 @@ Roger Pau Monné <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
 Sochin Jiang <sochin.jiang@huawei.com>
+Stefan Berger <stefanb@linux.vnet.ibm.com> <stefanb@linux.ibm.com>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
-- 
2.20.1


