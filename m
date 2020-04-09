Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D8C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044342074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao5c+AdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044342074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeaT-0000HI-2N
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWV-00028t-Tt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWU-0005md-PS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWU-0005i7-JH
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id f20so329796wmh.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ziNKYsZMVifuVbLWk94SRoJmjJXfnyU9uE+FhQ5jb/Q=;
 b=ao5c+AdFy4Z91r5753lr0175eqQlPTmo3VUHIzu5J6q9Kuj/3+6zx+SYCh7twi0D01
 rQ/vjcw8AePtlkPVvvc2vr9iiSkIJq456ONd3hU8JcZlwvh1jWrNloqWqm5PYdK38p/v
 oir2d26AXKTN8NPaJX1Of77L2f6za/ghfpk8+Qfru10qTToQVxGZCsMZe5RZI40iRfp1
 l5FOzFt5MPluP2Ob7Vc/OcM825HP2/cgi8cTz5+8T1hof1neIVNWgFn4BT9RQF8qHTPl
 0/gvt1wmo1i7DfvVoBhf0Q2vbfeNLi8jckhtF9J823NMfsFiJsiUd3hJvLYROhMyHGf7
 XohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ziNKYsZMVifuVbLWk94SRoJmjJXfnyU9uE+FhQ5jb/Q=;
 b=CvrOR8EP5Rw3uNkRoQ5uJYS54Zm5gjEkUomaKNA73VW8LP7KnwottX6ppHmzmhOMn+
 mJRC1HSo/C8WHZ4KLouiPFAwh+RQfAaeTk8urDXDApZNuOoe8U9JvmS0/q1jYAXt785v
 hONyAdmBpwIqfCkDzVhAvIIVNzmmC5CSUJhYZwah/IMcTeWFKsFGEdS1zWf6/qnVR9Fs
 sdGIFzfJsbU1aqo8ym6NLJ9hCiODVr4uwINRdrnmcZl3ZqMMELHdKEGh8yTyvma84svK
 2ytaOOybr2qy+HpnTMqFNl6qJkpgM9j2vITIqKro2MvdLblJ6SO5uFvS6FXI2lrhhQ7a
 /Qew==
X-Gm-Message-State: AGi0PuaTZ8l7pgG2uysTkhhyAhxPqCV+A5Pa/BM6MBUM4TrD4MWHV51/
 L4yhphRzWbUmjcr5JMcdILEK3Q==
X-Google-Smtp-Source: APiQypJa6hEPuBlOx8kPCUvdPpqm5mmfN/uvQIxlsCX0OUe5apCxKV+WZnm+IcH2zsuQtltrXnS1gw==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1790328wmj.33.1586466940416; 
 Thu, 09 Apr 2020 14:15:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b85sm5443767wmb.21.2020.04.09.14.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA03F1FF93;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/11] configure: disable PIE for Windows builds
Date: Thu,  9 Apr 2020 22:15:25 +0100
Message-Id: <20200409211529.5269-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Bug 1871798 <1871798@bugs.launchpad.net>,
 James Le Cuirot <chewi@aura-online.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems on some compilers the test can pass but still give you
broken binaries.

[AJB untested - please could windows users test]

Fixes: d2cd29e30736
Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
Cc: Bug 1871798 <1871798@bugs.launchpad.net>
Cc: James Le Cuirot <chewi@aura-online.co.uk>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index a207cce82bc..e9c5f630c14 100755
--- a/configure
+++ b/configure
@@ -807,6 +807,7 @@ MINGW32*)
     audio_drv_list=""
   fi
   supported_os="yes"
+  pie="no"
 ;;
 GNU/kFreeBSD)
   bsd="yes"
-- 
2.20.1


