Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A414EC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74437214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLSSok3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74437214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgZe-0003bp-Ng
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53904)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRX-00064r-UI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRW-0008Tr-VH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRW-0008T1-NA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so694700wma.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6j/tPjZmC3evFe7OoozCDsXFpBZiOXO2+h6m9FK7slk=;
 b=yLSSok3Qvl8AOpn0jUmJuUibKEqNNfg7Ajqpfj1TysSe6Iu+h9YRJqi8YKz4N+wOs+
 6FOtT4zzkTT4AeFRGxSVrVmWSkYnsOamIZiSnNMaSJtmQ9qwqgNZHvcMqXJdQYrhiUBg
 5EgSEDWP2Ej6kLjmQbCGua8MvowKbv3o+PWNKphem6DwkWhYTggD2mjFXJF7oP2n+PDy
 Y5/0AOXiAZs5goOCQ5sSUjjsheY8h2IVTVjVv3SCwCkHliM6Ys/nb5PeT5wRDG25lcjw
 50V31RSA3stpqKLAxibaX5M0wvowAaqC1gXcPdTXr5e1DyvOJlyQ1lumENot1E96LRWF
 T4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6j/tPjZmC3evFe7OoozCDsXFpBZiOXO2+h6m9FK7slk=;
 b=L8zRUOCp6iT3cfse4ofnXT1APoTpSCoFeE6HgEjWMmUesBi122O9ScMEAisfT8YRud
 UrmO3NzkbpiZ+IVnsKe+YEjWyW2By3BTuAWroPWRzOM2MlJ1y1mOpbntsvCCohUvBlU5
 ZrcGZQxcyHcfCWGQD7EUNsaJA8Gx19V6bZ5A6y2lRpPGkt7pRbTX8caxprQpAqmfEq/v
 9JyJ+WpYvsp9OH5+BlqNHhcY8ym4o9mIWj2PAtWOjuq/jo1sujUXgeo9Q59Mg3sKxvRx
 eA2r7OubjzO75t03xVMC2RklGZAwP23wojzZF9Jp1R2wBpxPMeFyySyKsyMf44DS/pqc
 u/ZA==
X-Gm-Message-State: APjAAAU3N/OZQmp0i4l1U5/x8KtATOjhXAZ8vCWhsjPRX+Lux4+kJ6G0
 PlKVfouGRCSpyYIBIYNhe0Ckiw==
X-Google-Smtp-Source: APXvYqzjY6yaKnpsPn3Ou21UkSOrAVfEEZEp8n2C7Xmlg9gHc3ITAdGSDX7tGW7CrPKRoAaPyuj55g==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr9804067wmc.95.1560973225536; 
 Wed, 19 Jun 2019 12:40:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v65sm3571592wme.31.2019.06.19.12.40.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CADC71FF91;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:08 +0100
Message-Id: <20190619194021.8240-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 04/17] tests/vm: add source repos on
 ubuntu.i386
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

Possibly because of different behavior on the newly update
cloud-image, trying to run 'apt-get build-dep' results in:

   E: You must put some 'source' URIs in your sources.list

This enables all source repos (even though some are not
needed) for simplicity sake.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190613130718.3763-5-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/ubuntu.i386 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 7017e6d388..3ea459ee20 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -77,6 +77,7 @@ class UbuntuX86VM(basevm.BaseVM):
         time.sleep(5)
         self.wait_ssh()
         # The previous update sometimes doesn't survive a reboot, so do it again
+        self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
         self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
-- 
2.20.1


