Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2685C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69642083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6cSY60O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69642083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtWp-0006Cw-Mz
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU5-0001wh-3m
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU3-0000nP-QR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU3-0000mk-KR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id b12so12404407wmj.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l7mM2oj13ibfp0JE0ahAZG76SnCWxFa0MFbX0Uuu7f8=;
 b=U6cSY60OvvSW+ZuiJYUQU7R9lac4nTOUAZZmelcA/r2coyS1rQ8G3XOUlFXI2twgOC
 RQ4IgVtl5G6ZAV2XH5sLFohSBHIQrS/sX+mNs1mS1SO0uXgHmQcI4aRr+m//b58HhOAD
 ZXwHD85x8NEdyULRQnPY2kIb8XmazrZ8QMHbZ+3x3j72XRCa5do6BxgybHEcnMj5LIXV
 JJz72Lu1/0Mf5551sfkB/cQrzv6D5SNs71Wx7nA3TCBVy4riqrs/ez4a4+hyvOvkWTmB
 NRQKfpd7txNFxd9e5n9eZj/kukz4+I4wJLgpJS8xs65734oosGWEEwG/ViX3CjpUeQ+L
 52xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l7mM2oj13ibfp0JE0ahAZG76SnCWxFa0MFbX0Uuu7f8=;
 b=NmYDr4LPgcdzTsbRaylZZfdrFmaXxgJguJheld0mr+qb3CmOye5FdybCvL7gVOfUvu
 q1u0ei2/1NcjFMVF8wDKaJMHy1+jLWKzyCvSaquwEdPAYynM/iPvL/jyFbDba7QTBrwr
 seC+bAoBcSu3db1o4VR1yxTprsjHxNzlAiozrLgsz8r3XzMnktjLRh6hg7GkGEjdkhvh
 Bok1/bfl4KOaF2ZQN7yNqJ66WB5kOpvcssvmuT9dJgnounhVIBAu+37zw/tCyOu8TAgA
 PVvwvqLDJCxM+Hd9Pb6ofILgMKsdhsEJMga/I/QiKFm5B/HeAbizY16hUaoNPcO6j+e3
 nqhg==
X-Gm-Message-State: ANhLgQ25Vb5CgaJUE47QMhxg7konMvF4pJ/b7oocYVX0FPJb8PTUJHrs
 saf3MmgPwiZ5iEwz6WiIQ+ESoA==
X-Google-Smtp-Source: ADFU+vu5/mv9Q/2aSD0f97lALJQf1XmvpI92BuPQekk0hX2FxpxCWVVupEnYYLE0YGoTQeHbLyrNSw==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr970618wmg.11.1585332810461;
 Fri, 27 Mar 2020 11:13:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm6018729wrs.20.2020.03.27.11.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D046E1FF92;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 06/12] tests/vm: fix basevm config
Date: Fri, 27 Mar 2020 18:13:14 +0000
Message-Id: <20200327181320.23329-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the patch was merged it was part of a longer series which had
already merged the config changes. Semu-revert the config related
changes for now so things will build.

Fixes: b081986c85fd2
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200323161514.23952-6-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index cffe7c4600e..756ccf7acae 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -358,23 +358,23 @@ class BaseVM(object):
                           "local-hostname: {}-guest\n".format(name)])
         mdata.close()
         udata = open(os.path.join(cidir, "user-data"), "w")
-        print("guest user:pw {}:{}".format(self._config['guest_user'],
-                                           self._config['guest_pass']))
+        print("guest user:pw {}:{}".format(self.GUEST_USER,
+                                           self.GUEST_PASS))
         udata.writelines(["#cloud-config\n",
                           "chpasswd:\n",
                           "  list: |\n",
-                          "    root:%s\n" % self._config['root_pass'],
-                          "    %s:%s\n" % (self._config['guest_user'],
-                                           self._config['guest_pass']),
+                          "    root:%s\n" % self.ROOT_PASS,
+                          "    %s:%s\n" % (self.GUEST_USER,
+                                           self.GUEST_PASS),
                           "  expire: False\n",
                           "users:\n",
-                          "  - name: %s\n" % self._config['guest_user'],
+                          "  - name: %s\n" % self.GUEST_USER,
                           "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "    - %s\n" % SSH_PUB_KEY,
                           "  - name: root\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "    - %s\n" % SSH_PUB_KEY,
                           "locale: en_US.UTF-8\n"])
         proxy = os.environ.get("http_proxy")
         if not proxy is None:
-- 
2.20.1


