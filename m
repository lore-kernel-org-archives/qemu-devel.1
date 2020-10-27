Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1CCC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBF82225C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL0eVP4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBF82225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLmf-0008E7-4e
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlZ-0006eV-0p
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlX-0000OJ-4J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id n15so1174683wrq.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=34R6NI0WK0Vxw1MqeYCeWgrDTVopx//TkoJDjYqCmug=;
 b=RL0eVP4glzR6e3kTiU9PPSr3dDmKWpvYQbEJARcWksjxbtDHytl/mcvWOLeIvwUM4M
 yS8LWGjXvUjk2uMyTa13ECeUosiTDWYdN3Z7v8cce8KMFELdoThujyPqMZfJQkYtpLXj
 1tscs3NJwB0Sn8OfvBYFkfzT+8eL7nwv0HbC3tAHW21SQMPpIpTdJ9UqpORWNkg5efHv
 AK89Ew2mdSSm3Gc5F+gZAIWcpy2waZ7UKJfzKMc7cDopG2DyBHuqBk7YIFrSl/cEoRXw
 l/QZ6QfYMXWEG9SomH90KgUzsNXfa2T2wGrNjLwX2VP9wU/iGCQOUJ0carJbuvdjJ1Ju
 4pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=34R6NI0WK0Vxw1MqeYCeWgrDTVopx//TkoJDjYqCmug=;
 b=t1laXg587W1k9OoAki8jVyfG9aG3wVnDq9SKzWz2vkZ853UmIRJWl8jgqdNxhxB7dR
 Nu/BxPy2ySBE+EVfEJc0ax6xgkX+L2nxNaOCd01wT/+e0dGksRwTxWqpThYn2WYD2Nj5
 da27xxQQXnOlwwPUQXyu2SrtvFKI+QnTfZs8vTeM2+xMuOn3r4LtfrmIL1cIA3ylSIlv
 HR/TPTylAukcGTz+ICzdn8T1aMA6fkEAMIZDlLr81N2Bvj5C97rx2Nbj+RNq6eE/gW0f
 6CYmtwCX8/jsbxFt3pMH2vPxFhOBRJU8X3rjfuP9wZZXpyhRUhojhgFhZ4fR2Zi2Ts1b
 ZpSQ==
X-Gm-Message-State: AOAM530+Oq3puUVesQmEKFAF8INz8IT5wmWVU6n2wPeMIVC2LuLsyfCd
 lXf1ANxhw+CS+AO6ZD2MfHGTvQ==
X-Google-Smtp-Source: ABdhPJxTLwBw4nZx5uziwyvxxZEmUgMPv2O6QIgSeg22Q/hADGEHxw6+5/UrC0WbRQBMdkUpxNET5g==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr1810249wru.355.1603792781622; 
 Tue, 27 Oct 2020 02:59:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f139sm1338136wme.47.2020.10.27.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D185E1FF87;
 Tue, 27 Oct 2020 09:59:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/8] Adding ani's email as an individual contributor
Date: Tue, 27 Oct 2020 09:59:31 +0000
Message-Id: <20201027095938.28673-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Cc: Ani Sinha <ani@anisinha.ca>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

Ani is an individual contributor into qemu project. Adding my email into the
correct file to reflect so.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201007161940.1478-1-ani@anisinha.ca>
Message-Id: <20201021163136.27324-2-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 641169fa63..d135f4b143 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -23,3 +23,4 @@ vr_qemu@t-online.de
 nieklinnenbank@gmail.com
 devnexen@gmail.com
 pauldzim@gmail.com
+ani@anisinha.ca
-- 
2.20.1


