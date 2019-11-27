Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A1A2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpT/20vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1uC-0007Dc-8J
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vy-0002JU-7q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vv-0006r3-Lt
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:08 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1Vv-0006nU-FH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so3129400wrn.7
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tDTdUQd5vkWPuMZ/GXNzU6PNW72O5RFbpFjZP11Qmw4=;
 b=HpT/20vmTIIiMWDhA+EIz3CTQz/6yKn5kAk8GiMBVa5Oy5cuURftIwLx17kKuEjeUO
 OlcF2Dkkla+El1atrMRfOwQcohcnCNbp6BeI2ZuV+DXfKjV41sGE1YZFDGI7MxyqLy7D
 u2RcmTgTtXGt0YhTVi7qwSZZeYpo3Yr5UKf3Hbrrqwnl9NcYukhOxdSyTcbzJmV0yavO
 r8jzhJME1nuTFgxyG3nYbg0Dkf+MrciD97WT07HFt+Xq9qrOrvqHJnFlB2g74v+z2BOS
 YIsbI+Lhux3hOXZHlWjQN6kS6BozrWAuNiVyWQADaU/PkjDkE/OMpwe9MRq3k5xyumgL
 GDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tDTdUQd5vkWPuMZ/GXNzU6PNW72O5RFbpFjZP11Qmw4=;
 b=tww/J5X9GLZqdppD+WU8IlJw8UV7JjSPBDXgOTgLNqv4wDCdJOrxOEFAOc3Z3wFEl4
 W16s/s7uiYRzmkvZExhRjLGDsYyr4rUIJW5Mp+kU3jlfP67FejWiqUJm/TmTDrKbAumm
 Tq5/O+jjTEMkMqRUROBDjpIYe7dEL//a+4NvxifHh9MVFtt/iGdB7n069uiP6uwp+Zkv
 1pAYhC/hFvwkWBOTFaxQ+NwyQJWdUe6NY0YR1Ppf97V61vSQpMpAJvtX2XRlPfpg+wmY
 kpBPDACi+8Dp8llWnGWla/8LzEi+T2y4DwArvWsFfWGP6VvIRGF40eyKKPz3sh9SpVnO
 clVg==
X-Gm-Message-State: APjAAAWIf6V1p9N9HnnS+cxMQICuXMyoNzhdeXdR0c3ZdC47iItUADkq
 wOVZhUwJzLtV4TI/w366iHtnyvHIyZEYeJdB
X-Google-Smtp-Source: APXvYqyK9pUwgk0SfEV7LwVbmENMi7gWI+9UjKFsy3O87+f08Itdnkfvs0d9VGY52pXpJFJgO4Fijg==
X-Received: by 2002:adf:e78d:: with SMTP id n13mr40718433wrm.59.1574877243243; 
 Wed, 27 Nov 2019 09:54:03 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:54:02 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 17/17] target/avr: Update MAINTAINERS file
Date: Wed, 27 Nov 2019 19:52:57 +0200
Message-Id: <20191127175257.23480-18-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include AVR maintaners in MAINTAINERS file

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..d7bfb62791 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,17 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: target/avr/
+F: hw/misc/avr_mask.c
+F: hw/char/avr_usart.c
+F: hw/timer/avr_timer16.c
+F: hw/avr/
+F: tests/acceptance/machine_avr6.py
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.17.2 (Apple Git-113)


