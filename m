Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04813C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C413E2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6Q++7Cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZds-00078V-Um
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZI-00026B-MO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZH-0003sd-Ha
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZZZH-0003rs-9w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id s5so22126255wrw.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4fkY7uIezaMzLwzsXnzip7ts7OOoXb8cNMacO4Cnpg=;
 b=o6Q++7CnsidIDhduYrrj4RhKHOv87ptszfmcjjbwEawsNxweOA7kvvlemAshDfEEiE
 x41ThWk9GiAZn2u8sdBEb2Nb3c6S/1IDDcyUy+/321RHN14LwIX36Xo7Ir1prvQd4FKQ
 oMsltkbG0joHzVTrMowfo6DqmQdKVvb9fGeFEA/KwaSkzz+3XPPnYwsPQQuJl2TUeZU7
 rmVb8CXhRZ2qtUQUf89Ocna0kLAZNQITOiEXS0gvJSfZ7Itya7ikZMn24XKR4vpWwFQ5
 OjzcPjGyA7FU8UCtHsuqOoTkbaipRfzTFV23vY/rEMLsgv/jMk/hVblyJ748TKgCAGqe
 XrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4fkY7uIezaMzLwzsXnzip7ts7OOoXb8cNMacO4Cnpg=;
 b=mzwv7sT55998V1w8ONCUArIlcQteaE/TN8ltySpWA7fIs8FDSvB61ElmFdgiMXOyFu
 8HvezZc5e46CsGwZP+3ZDVRWhI/sjSamMoJrZxGV07MQvgu1PsI4OIfmKGBReQwRKVLJ
 RyKWfZ40dKUoeT9o40kf3ekxMPBVwU70vkj7S/oWR/GHCfmKIIyuWsvhf1MP4MwmIE4N
 hU1WRzS31qyUtH8BxUNeWhPFmnDUVa6F7cXVyN3s0i7keaCk52DgOyUAMSEPEg8tJzD1
 AF7bqg8nTJi/Ek+GwQbpjzwZgeIKCNiTfLTH9vuzkhOHAO3ZiF4ozfI8saagGP5e7ojJ
 gcQA==
X-Gm-Message-State: APjAAAUCyqegxHQLA/E1Uofc0w1P5cXlv0V/HcSF2iCKcEf6ctOmqt4O
 iuM6vdyfYZPmgmQJl9DWTvR0Cw==
X-Google-Smtp-Source: APXvYqw/UewveFxvpJo8zqcTKdp1ApoVlIBS2oI6X3ABSZkGWs+G6hJQBMJX5whf2qYOHp+IhKNErg==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr467826wrt.41.1574769821275;
 Tue, 26 Nov 2019 04:03:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h140sm2898553wme.22.2019.11.26.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:03:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D03D1FF8C;
 Tue, 26 Nov 2019 12:03:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/3] tests/vm/centos: fix centos build target
Date: Tue, 26 Nov 2019 12:03:37 +0000
Message-Id: <20191126120339.18059-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126120339.18059-1-alex.bennee@linaro.org>
References: <20191126120339.18059-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to run the docker tests centos has here we have to install
python3 as well as the basic tools.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/centos b/tests/vm/centos
index 53976f1c4c9..b9e851f2d33 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -73,7 +73,7 @@ class CentosVM(basevm.BaseVM):
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("yum update -y")
-        self.ssh_root_check("yum install -y docker make git")
+        self.ssh_root_check("yum install -y docker make git python3")
         self.ssh_root_check("systemctl enable docker")
         self.ssh_root("poweroff")
         self.wait()
-- 
2.20.1


