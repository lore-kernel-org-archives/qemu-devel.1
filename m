Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D73C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FA720B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjBnzlGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBhy-0000x2-IX
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42205)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Fc-BF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004zZ-Ta
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004sg-I6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id g135so1234190wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gTWlFdlFGB1B/zOTecn3xrnI8T6l9Vt1Y4CtKuUhYu8=;
 b=SjBnzlGNuYbKNmdtwI+EtCHS2epNn9/bnTSOYbbiJrXuZ4r6YGWsjr3NiHIpSX9X+s
 48+I3GTWU5lGNXW+fix8xHX917GJBe3DMRrKc/robCQLklm8B6dIy431i+f2TcwLU5GX
 KdurOgOybaHxPZYpzXu1kCKjSFdKa4Ui8Tx4DvAce3+sTNnOFvTT4V4yh3iwEubskUR3
 elecGW7JGDH8+ZX4ECBwDLbmpCBkj3111TsC6nm7UnCSikm29OCLyox8jVfI/4gd7CLh
 rp5b4gPaAkJMVVmqWRj8D/YeaczqwxiqP1I+BvjbhYhRoFtofZZPivlP36L5W++uAgid
 zajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gTWlFdlFGB1B/zOTecn3xrnI8T6l9Vt1Y4CtKuUhYu8=;
 b=GGFuy1RYy7FzKi9R/mVp9L1nmSyplKH61AnWonURQxDBR1PZ4fYwVSMDEK7HA6s5dg
 spTyvEO5qgR1nmWQzPlswBCYVwV6Sq5kl9CTU69GHOtdf2hRmi2PkDMz/7yDXfGocVr7
 Y2rrWWgvj/iu+Nfj3Vq77DlYRU5cyboETOAvAG7gN5zi4wboPjaGny5CKprLbCkF4uQl
 OLDMHuWdpXbnrWiInIYAsWP9Ac8jb8MOoob5FRSiOHcwFMV+ZvQ561aMvoygkvpPFRyG
 OVOAzSz4CRYe+0OQB5U3DZNZ8cLPoyEEmSU2HnhQSeV17kcaBwXCosedU0RWBVr4M9/+
 pG2A==
X-Gm-Message-State: APjAAAV0vW4NUisY4T7xvZfPHcOYg7DKw9D69jCKSYeEFW43RBNGssee
 qxsKNSwvZbxx8+9K/vIf/PFgmw==
X-Google-Smtp-Source: APXvYqxQxPzGUHWtbVtkdkKmMn2FldDD0XWXZewge2Pj7EqPZuf0Jt8A8B1i7VrsXP3JBuTuc1rH9Q==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr2801993wmr.174.1559898757664; 
 Fri, 07 Jun 2019 02:12:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a3sm1198915wmb.35.2019.06.07.02.12.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:34 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 07ADF1FFAE;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:24 +0100
Message-Id: <20190607090552.12434-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 25/52] tests/vm: ubuntu.i386: apt proxy setup
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Configure apt proxy so package downloads can be cached and can pass
firewalls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-15-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index a22d137e76..b869afd212 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
                           "    ssh-authorized-keys:\n",
                           "    - %s\n" % basevm.SSH_PUB_KEY,
                           "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
         udata.close()
         subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
                                "-volid", "cidata", "-joliet", "-rock",
-- 
2.20.1


