Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED56D20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHFBPzaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED56D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QvL-0006F2-V0
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqx-00074U-Ps
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqs-0000jJ-FD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqs-0000fQ-7n
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id e26so1184551wme.5
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F+qeDvKSj+We27wUg+J0wmja2pZqof4r3cIb7B1val8=;
 b=NHFBPzaTmHxruvrPcwNqfP5KmSfqAC4mnpGMA/Cr09jyyX+q/KY3aue07+8FuC/nTm
 x5xcnDd1Bbzc6A0cp8LmiBo6juzRQ+UlC+cGtLaOST2E10OC4Dtv7fhqilSjXnSgzVmr
 o28xxbIQbp9mbmi85d0jbtKOipiR7GAi+Js7zmdpo57R5GP4w402X9mOrGYQivuQbSlt
 DPNpCUWDXefedxVMf9R0fml/H/gpFkm+nIxbxoC+5VgBFIEhNGndrKh91RrLSpCuq10X
 HN7PDV1kXIqTOsf3eJ/WFzo5cs/LrmH7stiriqXoWTswr5Wf+O4ZxYYhzPDguvnSVUnR
 EHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F+qeDvKSj+We27wUg+J0wmja2pZqof4r3cIb7B1val8=;
 b=JSCgsiKLsNHeVpAjFBWblk7xpJdG6up7XIN/Dlhe//0mBerm1CEQTu3mnpToErhXnG
 0gqDj/j0b0pKC0pj80OUCDdNClsFRRUkN+cxwwivrSq4M92Uu3RBkdwbxq/YKarLqxtn
 5jIIWL3ydzALV2UHlMhYrkm2Z3op8+/aLSLLVUcaXFd4JgMSrbH1z9hKPJclDaFLrlfT
 +aEldLvAR+gGJXZTozdcTk0tlFKOtzjR56CsDLvHsbYosSc/AI8gHe5C11KEbvlkcvYW
 3HmI4/D5UzLKbEVcAohRHpFJ7hk8bvWGw9G6E09ukPxYy2+BsVMV9JPa78g5f0CMyupF
 +nBQ==
X-Gm-Message-State: ANhLgQ2+ykclUKozHMGy1DFyWV3t6Q6PR71EYeyMpFlYZRrg06VPjz2a
 Vvg3Cmj24yO9j9jVECfXRyGJh49lc80=
X-Google-Smtp-Source: ADFU+vuxyk8sc5NPbvdZund5aF4v0CNMhW8NgFQaaHVu3OPax4l7IvH6iuxIGCaRYsLrFw7wg+pQOw==
X-Received: by 2002:a7b:c74f:: with SMTP id w15mr2755402wmk.157.1583316124329; 
 Wed, 04 Mar 2020 02:02:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm3278583wmi.33.2020.03.04.02.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 982F91FF98;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 8/9] tests/acceptance: bump avocado requirements to 76.0
Date: Wed,  4 Mar 2020 10:01:53 +0000
Message-Id: <20200304100154.14822-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to use @skipUnless decorations on the class we need a
newer version of avocado.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200303150622.20133-9-alex.bennee@linaro.org>

diff --git a/tests/requirements.txt b/tests/requirements.txt
index a2a587223a9..f4f1736a086 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework==72.0
+avocado-framework==76.0
-- 
2.20.1


