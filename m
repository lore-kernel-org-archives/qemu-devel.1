Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD092C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E93920702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5XWmuJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E93920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iws5E-00035J-Oc
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 13:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iws4T-0002Yx-LR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iws4S-0003zH-F0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iws4S-0003x8-8R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:12 -0500
Received: by mail-wr1-x441.google.com with SMTP id g17so668550wro.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mhydg9H+UrBYe0Wv7cIxL2QNKweFLuMU15nhuD+KCHs=;
 b=y5XWmuJc5w2+67Q8EI89jxA8LXhTqCf0uXhBaZ2uVwQLfpBUyjnhBnx/Ptww5GwOzh
 12SFyPyqsmscW1tKI3Fh+gt0SkjXrNFY+I2l75mDb3smlm4YhAwSe1O5epsMnoQqwgxk
 MUg4DQmD6nlaOdmPOsTlmwBboBZ5mG0KPJgI1IlCMDf54vgOr3FHKP0FuPwayS+k8hEl
 KWJ9ZXCd4VTOeQUrmO6aXdpJcwKnwmzMBdfrhGZVeezBVntGft3NXpEKQIhRMTYjB/3+
 YN3xSTLGXWXeQc56o8lYTqcVPnhfbFR4pWbGbilA/CA8WlF67rbVRwFyqD7jzm2Ai4WH
 4uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mhydg9H+UrBYe0Wv7cIxL2QNKweFLuMU15nhuD+KCHs=;
 b=VedmDPcG3hg9PXPBau0WEtcI2qH9xR4RytwJORAhxOnsY1vn741yN7kUtxqkD7bq8M
 Rh3MkQTA1WVu8bS1iAIkgzphP/h8ktlez3NtbXZZrD04/MUtyHYhOkI86vbC7JWrwy4w
 x0R7v6wn/M8COuDOFu/Dh3E4CStLg/kpevQ1ea+uzn1xQ/VoQLJlEQJqmYr7cBxuqJbu
 4AVE1TmLAdpey97/FeCjwjH74esEK/pL68GSX3DNaZht7w0zex+6df/hOC3kCtLTrkB3
 m7EH+0QzyATAK4j/z5f4s4bEgNSa1lMJxZMzJVJXm2i5OP5sjknvnBsF3OLWSDBLkU0A
 /YIg==
X-Gm-Message-State: APjAAAW9vuzk0KGVtaP5IlmDGOxTVmWY7lN+kVcOqcxFdCUsFHeOUmSv
 l3SRLWqlXMa5rf6t1CQ9Ikf7uA==
X-Google-Smtp-Source: APXvYqx04ZQ4lR90nPahjO6GnkTFYc0llEmB8UxQznk9TQHXTZ4Wde6mil9QXyjq+Du8vAFeVJBqNA==
X-Received: by 2002:adf:a141:: with SMTP id r1mr91421wrr.285.1580322490299;
 Wed, 29 Jan 2020 10:28:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm3665354wrt.37.2020.01.29.10.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 10:28:09 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 552191FF87;
 Wed, 29 Jan 2020 18:28:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] default-configs: add CONFIG_PARALLEL to hppa-softmmu
Date: Wed, 29 Jan 2020 18:28:04 +0000
Message-Id: <20200129182804.19284-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PARISC Lasi chipset emulation requires some of the common parallel
support and fails to build on a --without-default-devices. I am
assuming the chipset emulation is non-optional for the HPPA case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 default-configs/hppa-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index b64c5eb3ff..9083ce8634 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -3,6 +3,7 @@
 # Uncomment the following lines to disable these optional devices:
 #
 #CONFIG_PCI_DEVICES=n
+CONFIG_PARALLEL=y
 
 # Boards:
 #
-- 
2.20.1


