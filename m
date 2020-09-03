Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54AC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962352078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6GtVzYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962352078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnLY-0006Zp-Me
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIp-0002Rq-UD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIo-0007ZB-0G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id a65so2459391wme.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z5RvT4eB7MnQELSA2qZHA1d+KPyyThIlq3rK75djlgU=;
 b=X6GtVzYWz+SPJh7EUuaGmaf+o6y55m2OL85XdfGSbHoDWVCmjqRCS+CJGFQ3P0v4RO
 pzc4mogmTeB/dmYuIghrn/jj50TuOVpnsLCt6Okkbvd9i3cCQRY5ljPJjPhURM+n56TG
 tkk/g+mdtmAeC6JRtmvUDhHCkc8/S0HYj2kvG41rxVr3dN0ysAiTl+gzwjYqBrZtojST
 f1CYO8qtQc+q+hGKBIgMubSYbPt1JkoxBPZs4Cjbqitx3k3hO2KQf8eRx0yW/f4rwvVl
 LXmtNDV7hrZ2+OBZiIoJ+EnD3vf23s/8qOWYWWdbEY9qs+RwgOH5HLQc99Ce2ddlqG2C
 ARNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z5RvT4eB7MnQELSA2qZHA1d+KPyyThIlq3rK75djlgU=;
 b=Yp1JUvRz3P/79JVUo9sf4U7zoMcORPnjVU/H/oPOYf3yw8M079p3S5INJihYw3CY1M
 wSR6uEhquNhVFPPNT1/aX3HbQuHfp3Ap738qksugzZ1Cn2Znf4lXRjqsYYFPJHJytnwP
 jLfxOjd4LCR1p4X4IzQeGaJ32ddTGFbx+8FAwr5QFTg1dmEdmOEIiEtlZ+aeKIOd/oMN
 X7OnsPE1pZR7S2qmSjRjtNV5YOawpCblP0ARMHg51IcdmQ2Ro/SFwTdB3kkDMD1tUJ1a
 4aOg+o4vcd3HWtJyp+kJSn4TnUtgcPwb/rhggehkUvv7/1jJZPk1BcBCWP7KkAsXutXM
 gzwA==
X-Gm-Message-State: AOAM532OcmnW5TY9nSHpuQYBvMV4DPLwOs8veJP23NfCuaCCu9ZMCWN/
 iffR+qT4jtwh73iYpeR+1ruSHA==
X-Google-Smtp-Source: ABdhPJzWm7qfKOzIy664GYBOjoFdbO+bHQDkNr+UHuGRaehhEupT3OyKica6/5qp/62buULw6G9rQw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr963802wmj.16.1599132072571;
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm3977022wrx.50.2020.09.03.04.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2F161FF8C;
 Thu,  3 Sep 2020 12:21:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/8] crypto: fix build with gcrypt enabled
Date: Thu,  3 Sep 2020 12:21:01 +0100
Message-Id: <20200903112107.27367-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

If nettle is disabled and gcrypt enabled, the compiler and linker flags
needed for gcrypt are not passed.

Gnutls was also not added as a dependancy when gcrypt is enabled.

Attempting to add the library dependencies at the same time as the
source dependencies is error prone, as there are alot of different
rules for picking which sources to use, and some of the source files
use code level conditionals intead. It is thus clearer to add the
library dependencies separately.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200901133050.381844-2-berrange@redhat.com>
---
 configure          |  2 ++
 crypto/meson.build | 42 +++++++++++++++++++++++++++++++-----------
 meson.build        |  5 +++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index cc9af723580..1f61e363a18 100755
--- a/configure
+++ b/configure
@@ -6953,6 +6953,8 @@ if test "$gcrypt" = "yes" ; then
   if test "$gcrypt_hmac" = "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
   fi
+  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
+  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
 fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
diff --git a/crypto/meson.build b/crypto/meson.build
index 18da7c8541d..f6f5ce1ecd0 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -23,24 +23,35 @@ crypto_ss.add(files(
   'tlssession.c',
 ))
 
-if 'CONFIG_GCRYPT' in config_host
-  wo_nettle = files('hash-gcrypt.c', 'pbkdf-gcrypt.c')
+if 'CONFIG_NETTLE' in config_host
+  crypto_ss.add(files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
+elif 'CONFIG_GCRYPT' in config_host
+  crypto_ss.add(files('hash-gcrypt.c', 'pbkdf-gcrypt.c'))
+  if 'CONFIG_GCRYPT_HMAC' in config_host
+    crypto_ss.add(files('hmac-gcrypt.c'))
+  else
+    crypto_ss.add(files('hmac-glib.c'))
+  endif
 else
-  wo_nettle = files('hash-glib.c', 'pbkdf-stub.c')
-endif
-if 'CONFIG_GCRYPT_HMAC' not in config_host
-  wo_nettle += files('hmac-glib.c')
+  crypto_ss.add(files('hash-glib.c', 'hmac-glib.c', 'pbkdf-stub.c'))
 endif
-crypto_ss.add(when: [nettle, 'CONFIG_NETTLE'],
-             if_true: files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'),
-             if_false: wo_nettle)
 
 crypto_ss.add(when: 'CONFIG_SECRET_KEYRING', if_true: files('secret_keyring.c'))
 crypto_ss.add(when: 'CONFIG_QEMU_PRIVATE_XTS', if_true: files('xts.c'))
-crypto_ss.add(when: 'CONFIG_GCRYPT_HMAC', if_true: files('hmac-gcrypt.c'))
 crypto_ss.add(when: 'CONFIG_AF_ALG', if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
 crypto_ss.add(when: 'CONFIG_GNUTLS', if_true: files('tls-cipher-suites.c'))
 
+if 'CONFIG_NETTLE' in config_host
+  crypto_ss.add(nettle)
+elif 'CONFIG_GCRYPT' in config_host
+  crypto_ss.add(gcrypt)
+endif
+
+if 'CONFIG_GNUTLS' in config_host
+  crypto_ss.add(gnutls)
+endif
+
+
 crypto_ss = crypto_ss.apply(config_host, strict: false)
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
@@ -52,12 +63,21 @@ crypto = declare_dependency(link_whole: libcrypto,
 
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
+
 if 'CONFIG_GCRYPT' in config_host
   util_ss.add(files('random-gcrypt.c'))
 elif 'CONFIG_GNUTLS' in config_host
-  util_ss.add(files('random-gnutls.c'), gnutls)
+  util_ss.add(files('random-gnutls.c'))
 elif 'CONFIG_RNG_NONE' in config_host
   util_ss.add(files('random-none.c'))
 else
   util_ss.add(files('random-platform.c'))
 endif
+
+if 'CONFIG_GCRYPT' in config_host
+  util_ss.add(gcrypt)
+endif
+
+if 'CONFIG_GNUTLS' in config_host
+  util_ss.add(gnutls)
+endif
diff --git a/meson.build b/meson.build
index 55c7d2318cd..9b5076452b2 100644
--- a/meson.build
+++ b/meson.build
@@ -116,6 +116,11 @@ urcubp = not_found
 if 'CONFIG_TRACE_UST' in config_host
   urcubp = declare_dependency(link_args: config_host['URCU_BP_LIBS'].split())
 endif
+gcrypt = not_found
+if 'CONFIG_GCRYPT' in config_host
+  gcrypt = declare_dependency(compile_args: config_host['GCRYPT_CFLAGS'].split(),
+                              link_args: config_host['GCRYPT_LIBS'].split())
+endif
 nettle = not_found
 if 'CONFIG_NETTLE' in config_host
   nettle = declare_dependency(compile_args: config_host['NETTLE_CFLAGS'].split(),
-- 
2.20.1


