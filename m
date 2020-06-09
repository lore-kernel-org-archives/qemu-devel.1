Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5C62081A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7hL/u46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5C62081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiblz-0001i6-Ci
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjb-0007QE-3l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibja-0005E7-8D
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id u26so2002243wmn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q/cIVEFMns0y995uacfy4Wuc44iRJxogb4f61BUR9ZE=;
 b=G7hL/u46oa8A4ZPdPTwn1D6jleXAYWcexfpHDJcVqHn0w96Ts9UC7vdbsPhNvUHmSp
 0S7Cg0dPqxz/26Onpn56XNakQtzT73t5mRGFVk6f1kVDqSGW/Nre6oinjXIl3P4+7bYd
 sx8vCyCarR3fSvk4eQW7QdtY+KWd4cGgqJWcmoMT7NLLsppIoSVYPny2XL+hxZsyvzdm
 zPbF18S8gPqZY0Poizr2jTNyv//YdoU7lpT9sNYQja0gUAB6J9OPSRfrkr4649d2vWLg
 OBNPzfGE5FW7YrMnz6YcPQM+NpsfHrJynfsBKTDEToRNYuPjf8PwbC9OkPFWzko/tASi
 MtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q/cIVEFMns0y995uacfy4Wuc44iRJxogb4f61BUR9ZE=;
 b=plg9edsMwRAAB8OIAhOGc5lHDBwGeHkd87bSQuLKEfDUht3KXiv9nEKm411mK612jn
 h5nY+6ZCiOSD++FjZpo1TY0jqUA73pMujTyD6L/0sOOslESqQxjZXaMFphoJbUTdJS+p
 G8SJ8m4f4b8YJdlq1lmdB1nDXCTzXodo4YZAwqn5es+6NW9rbX8sUf7ilHlJ6pswpW0N
 BO0U2F1hjdH7VPveOeuwRNLDjwxJsFjCYcSlO1JnXLvwYaXIgcwqUXoZ4PzO7C7yWhfc
 oRNZLmRhvWVxUlG8AJExzBByh7VULfq+75uU1D1pc//3xc4NFl0Z83Jz3FW2iTa6yixP
 9c4w==
X-Gm-Message-State: AOAM530gs+Od2FFKZ9U/Y+MmVjtKYXCQD4zL7fhqIf3UEJdplBvBl28I
 Akqd1nacOU8GXX4PfAcKC6QRbQ==
X-Google-Smtp-Source: ABdhPJx65YT1m3OsVV/+khmmnXacY9jrnz4bfcU14gSqDmFkcRmUIyJ/o66HpkMPb/husuVcAc4vMg==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr3531369wmk.90.1591699436920;
 Tue, 09 Jun 2020 03:43:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u3sm2486289wmg.38.2020.06.09.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:43:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C48E11FF9E;
 Tue,  9 Jun 2020 11:38:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/17] cirrus-ci: Remove flex/bison packages
Date: Tue,  9 Jun 2020 11:38:08 +0100
Message-Id: <20200609103809.23443-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200515163029.12917-5-philmd@redhat.com>

diff --git a/.cirrus.yml b/.cirrus.yml
index de0727cb097..ce7850a320e 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -7,7 +7,7 @@ freebsd_12_task:
     cpu: 8
     memory: 8G
   install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash bison curl cyrus-sasl git glib gmake gnutls gsed
+    bash curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
-- 
2.20.1


