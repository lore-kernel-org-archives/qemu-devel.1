Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5DC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5592520863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijMilGlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5592520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LWQ-00074s-IY
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LVW-000676-4K
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LVU-0006kx-Je
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:23:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7LVU-0006kF-Dy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:23:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id g207so14378680wmg.5
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=53+ZE7md1EfvE6qaLbMI9oIc95rFUpm8x8sn5i1pNLs=;
 b=ijMilGlfChpJQf4Of4JmFty6LrfHE2HVdRuvx49kW7Vm0mJR/M/TTitK6W5Z5hq21z
 nhWLVaESmEaJTGtW8BjdnwhwvxfBM38uHjYWzNA/ukTCyCBQn8pHn+bRNCXNjtyz9BN8
 R92SGM+88qW3a/JusbrCoulG8vSvG5+LmE/OIaJZIHqN8rqvKMkTD2VJu86Noxne2+KC
 fyIWrgU0x7W83wQ2xExVdcE4CtQe6z73lKA2OZyg114D9LeCMUBQwL8o1WRmSZyARhcz
 XK4fnxAEeuqSbnZVRd4e87Ayo6VZ1L2Hxy935I51oz7L7c5uPJlAh/Cq7axYTGHrO3+D
 2H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=53+ZE7md1EfvE6qaLbMI9oIc95rFUpm8x8sn5i1pNLs=;
 b=jSfuTzcJ0WfPBDxtMBU9RL2wa0murpmlC/Zu2TEmCrm3waIfHAXZc3FYHknGnRBX/7
 SyKZCd5Enno5vBfof5tQShYmXCSPd48hha3sHUCmQW/iAHOcNv/JmM2d3YOxfjEliGPY
 gD2UwcoqRhVOEFdC7RTJx3efzGfS4Cupfrph3xZDVJhhZgb5pdyQTmkEsojdNpz0ua3Q
 8C4hzzZaNeRIt1XYhaCQhvo2VlpUNTLyvaNSMV6apt+yUiHwhW27hBteDWM0Vpk4fzbo
 AHnyMlaWDKprUi3rnSdfrslltMU8iHo+CRfyRDGAvpLLtMPOQu9U1XWDtym51b5l3oNm
 KkKQ==
X-Gm-Message-State: APjAAAWUv356Q9gpHecMia8VrVsQvcwCSWx4Duwj8ET41MsDRTUsc61e
 5P7dPAeymrPVo1K0w/vyhDBYLA==
X-Google-Smtp-Source: APXvYqzoxDMKEixacLe18qirkYChQLyWPdalv+gD+9I7K3KXiI1gsUeF2acPGWCgfFU/ONfwbk6qLQ==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr14516602wmc.94.1568042587101; 
 Mon, 09 Sep 2019 08:23:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g24sm23159251wrb.35.2019.09.09.08.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 08:23:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56C3B1FF87;
 Mon,  9 Sep 2019 16:23:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 16:23:02 +0100
Message-Id: <20190909152302.19016-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [qemu-web PATCH v4] add support page
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is intended to be a useful page we can link to in the banner of
the IRC channel explaining the various support options someone might
have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2
  - add cleanups suggested by Stefan
v3
  - add link to nav bar
v4
  - add glue sentence and .'s as suggested by Thomas
---
 _includes/nav.html |  1 +
 support.md         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 support.md

diff --git a/_includes/nav.html b/_includes/nav.html
index 241d83e..0c81e24 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -4,6 +4,7 @@
 			{% assign current = page.url | downcase | split: '/' %}
 			<li class='{% if page.url == '/' %}not-desktop {%endif %}home'><a href="/">Home</a>
 			</li><li {% if current[1] == 'download' %}class='current'{% endif %}><a href="/download">Download</a>
+			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="/support">Support</a>
 			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="/contribute">Contribute</a>
 			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="/documentation">Documentation</a>
 			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="/blog">Blog</a></li>
diff --git a/support.md b/support.md
new file mode 100644
index 0000000..031f045
--- /dev/null
+++ b/support.md
@@ -0,0 +1,43 @@
+---
+title: Support
+permalink: /support/
+---
+
+If you have a support question that is not answered by our
+[documentation](/documentation) you have a number of options available
+to you.
+
+If the question is specifically about the integration of QEMU with the
+rest of your Linux distribution you may be better served by asking
+through your distribution's support channels. This includes questions
+about a specifically packaged version of QEMU. The QEMU developers are
+generally concerned with the latest release and the current state of
+the [master branch](https://git.qemu.org/?p=qemu.git) and do not
+provide support for QEMU binaries shipped by Linux distributions.
+
+Questions about complex configurations of networking and storage are
+usually met with a recommendation to use management tools like
+[virt-manager](https://virt-manager.org/) from the [libvirt
+project](https://libvirt.org/) to configure and run QEMU. Management
+tools handle the low-level details of setting up devices that most
+users should not need to learn.
+
+To get in touch with the people from the QEMU project, you have the
+following options:
+
+* There is a
+[qemu-discuss@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-discuss)
+mailing list for user focused questions.<br>
+If your question is more technical or architecture specific you may
+want to send your question to another of [QEMU's mailing
+lists](https://wiki.qemu.org/MailingLists)
+
+* A lot of developers hang around on IRC (network: irc.oftc.net,
+channel #qemu).<br> QEMU developers tend to hold normal office hours
+and are distributed around the world. Please be patient as you may
+have to wait some time for a response. If you can't leave IRC open and
+wait you may be better served by a mailing list.
+
+* If you think you have found a bug you can report it on [our bug
+  tracker](https://bugs.launchpad.net/qemu/).<br>
+Please see our guide on [how to report a bug](/contribute/report-a-bug/)
-- 
2.20.1


