Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D58C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221052227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SChqv4Uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221052227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvLS-000395-60
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJO-0000Ok-0X
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJM-0005BS-2X
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w5so10933337wrp.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gsDouCBVlFBVfNRF7cV6v+NhB9KLpFTT2Y32SQbVexw=;
 b=SChqv4UwGUYj1LkQtqcG6GnuvcJ8Ed31k4JLg9wsleaTElhqE6I5N6VhbWaaxtpVSJ
 TFOI+yh8ctd3fOzNB975zvZSQELLInpeL3I6Y3gE7tHcPQ+cm5kD3HlV9Elnsv7h0DRH
 XhjR5t0ndGq1H7CrStSPkUz95x3+EA6JkOLjPzDe7rXWIGf/c0bERA8UkFG0gfwogJ9W
 cm0npoqQZRzJGeWlFpIefj98iNRBqx12J2KZT5qQm91/fZkYVF5T8rtaeRIvOPhjO7Qa
 JqPBUGoBffGtjdXr+4xbG0qRrlL3PY4vxCklL7RnVduukav8Kgy4Xim1b3fEL0WDldAr
 8quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gsDouCBVlFBVfNRF7cV6v+NhB9KLpFTT2Y32SQbVexw=;
 b=XGpDPWn8t8R8zMVy4EEJ1h/OuEmVO0VLnekL3QIzn+VCaTFYD+ri0WGH2TmA57Ng8a
 lQ+BZkh+jnmVXODia0QUIVFLeDYZq7kQL3Kkph8l9NI8rkPiK6G7NBAyvl5QDGSWn8p7
 MUeF9ViWVEjUULnh7Fcew7QmzPig9KOlHyzn3lzzVweWWdSmen/xXwejzPHVCaScHjcE
 xOnuLMUGB8l9KZjhW5YLQziC+9y5lFJowc5b1bPmvJXJYYhEWeKZegLcHYGnBjJbhl03
 KlUxXtC2l13bprAv32eyTZPRzWn+j+JOfPtVhny+0m1B3MDCSbTCtB6Hfqtgzmqs5+G9
 tdBg==
X-Gm-Message-State: AOAM530/VnHEyDRZvj3gJ4HH5g3uV9VR47vrIlhgTx7/fw3iRPY6w/fk
 Z1+OTgB7s6LwlUlladwALJmzrQ==
X-Google-Smtp-Source: ABdhPJzQke/kmJgz/0dI00cbbBm0nSRBJd0TGDBTPMEAe90iDspLlwXuOZKSgY4Pf0EgtQPWvxLkhg==
X-Received: by 2002:adf:d849:: with SMTP id k9mr7030565wrl.332.1602261122728; 
 Fri, 09 Oct 2020 09:32:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n65sm12922807wmb.12.2020.10.09.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAFA81FF96;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/22] contrib/gitdm: Add more individual contributors
Date: Fri,  9 Oct 2020 17:31:33 +0100
Message-Id: <20201009163147.28512-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Carlier <devnexen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

These individual contributors have a number of contributions,
add them to the 'individual' group map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Acked-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Acked-by: David Carlier <devnexen@gmail.com>
Acked-by: Paul Zimmerman <pauldzim@gmail.com>
Acked-by: Volker Rümelin <vr_qemu@t-online.de>
Acked-by: Finn Thain <fthain@telegraphics.com.au>
Message-Id: <20201006160653.2391972-3-f4bug@amsat.org>
Message-Id: <20201007160038.26953-9-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index cf8a2ce367..641169fa63 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -16,3 +16,10 @@ aurelien@aurel32.net
 balaton@eik.bme.hu
 e.emanuelegiuseppe@gmail.com
 andrew.smirnov@gmail.com
+sw@weilnetz.de
+deller@gmx.de
+fthain@telegraphics.com.au
+vr_qemu@t-online.de
+nieklinnenbank@gmail.com
+devnexen@gmail.com
+pauldzim@gmail.com
-- 
2.20.1


