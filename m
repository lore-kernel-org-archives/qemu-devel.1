Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C92DC5ACC0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDA4206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wv0FIzbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDA4206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOtg-00021Z-C5
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOr7-00076p-Bn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOr6-0006Qc-79
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:46739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOr6-0006OW-1Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id c19so3346573pfo.13
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PSWsHdPBUl+o86ngz+CHW38RdycFivwM+vzJP6Xfyog=;
 b=wv0FIzbJEPyCv1yZrPo+729Au61CA2reHfcpHul9GRl1A0vkUePVz02W+6B0Ijk/0C
 f7Eu1qssnHlyrDbXso+9DUfZzCRLX3S0mZZEfPiqB+vMQ/NjQIRx49Ly7A1L4eILKlO1
 n6gPVC0LtUkXFeWriyNCwLAfGRqJLFJlsJ0V6J0qc17DUW2UWk8t4rT/VqkkESh66H0f
 jBj38N5930aOCDmyjLvH7ys9iyPpo81OnhWZ3su/T5xKRMWYF7plG9P4R42JFacq9MBP
 f/6Tc1aBBC6jZmujfzh0Z64+WbQg1H6rV7ab0ZE0c5FJxsn8ZOU0MkC/GIMOMyFh8ewd
 lDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PSWsHdPBUl+o86ngz+CHW38RdycFivwM+vzJP6Xfyog=;
 b=sgykw8yfe/saS8C9WI/FHN6TOQRoSzT3JGaRaUeq7cp+wenrzUiIMb/dkuLKATwopA
 e7OAkxxRIOWYUDOeiJCr28a65Jmxyd7W1+E7Rsxt5574WsbJz2Aj1jq7kNpRo+qAr0NW
 MNF5l9vw5/fS45TfyveenTDeC0evNb7QlOBEPt5ywpO9onx4mx39a8/BYkqit7Ed8b6H
 P+w/S/2zJQffHC2CYr6eqVhPFnksuFa/be9EC7mptNq+HY0z9KpMjswfuC+KpQZv7+4j
 7wwvXrMUU84KzUIBESqLY/5ZwoyCeabGUJPa0r3ZM7GvAFu0xJ15hx29JxxiqV3kBchb
 i9gQ==
X-Gm-Message-State: ANhLgQ0ULGqcFUYQhL3bS2lrL7Z/Uh7tif5WTO4XwgM2h2oc9/z6r66h
 DUBBkDt0wDO5aHM7Z2t+BOoWj3c1Hnw=
X-Google-Smtp-Source: ADFU+vtWUlH2ppAgbSUCRHc3qW5hRiUTZE9rDwpY9GCmWQT5AotRRvwlJ8rKJHNl4L570vO+Evdq2Q==
X-Received: by 2002:a63:7c1d:: with SMTP id x29mr7694926pgc.197.1584023434454; 
 Thu, 12 Mar 2020 07:30:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:30:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/10] tests/vm: Fix issues in gen_cloud_init_iso
Date: Thu, 12 Mar 2020 10:27:19 -0400
Message-Id: <20200312142728.12285-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142728.12285-1-robert.foley@linaro.org>
References: <20200312142728.12285-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed issue caused by dependencies on a later
set of patches that have not been merged yet.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 8400b0e07f..db479a65fd 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -353,23 +353,23 @@ class BaseVM(object):
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
+                          "    - %s\n" % SSH_PUB_KEY.rstrip(),
                           "  - name: root\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "    - %s\n" % SSH_PUB_KEY.rstrip(),
                           "locale: en_US.UTF-8\n"])
         proxy = os.environ.get("http_proxy")
         if not proxy is None:
-- 
2.17.1


