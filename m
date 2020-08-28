Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB132C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8FF207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdRaDjMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8FF207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeRZ-0006li-Tf
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBePo-0004b6-I8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:27:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBePl-0005mX-Fl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598621252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHhkmQT738b36n/I9miam6iem1Ql8/lR5LsmxD0SNAQ=;
 b=BdRaDjMmLQsVr88ie8E8xvm6mkeQzUJJTtJcVkTB6+Yhzx1TixzGy0b7NTEdWG/QVDv3oW
 MQr3VbBpUkSpFfPjC5ApRQ7Jh2IZ5HSQqgffvKpeBVQ8zCRgPQLGZ+q59QaYR1Mofo04KS
 6xNqNFmQX5Mr8tLS7QOjhLuvC5Skl1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316--9dWk6gANCytwfHMTL8FDQ-1; Fri, 28 Aug 2020 09:27:28 -0400
X-MC-Unique: -9dWk6gANCytwfHMTL8FDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1812B18B633B;
 Fri, 28 Aug 2020 13:27:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-167.ams2.redhat.com
 [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023D57A1C1;
 Fri, 28 Aug 2020 13:27:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] crypto: fix build without gcrypt and gnutls
Date: Fri, 28 Aug 2020 14:27:15 +0100
Message-Id: <20200828132716.279782-2-berrange@redhat.com>
In-Reply-To: <20200828132716.279782-1-berrange@redhat.com>
References: <20200828132716.279782-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 07:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If nettle is disabled and gcrypt enabled, the compiler and linker flags
needed for gcrypt are not passed.

Gnutls was also not added as a dependancy wen gcrypt is enabled.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure          |  2 ++
 crypto/meson.build | 24 ++++++++++++------------
 meson.build        |  5 +++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 6ecaff429b..4effe769c9 100755
--- a/configure
+++ b/configure
@@ -6973,6 +6973,8 @@ if test "$gcrypt" = "yes" ; then
   if test "$gcrypt_hmac" = "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
   fi
+  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
+  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
 fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
diff --git a/crypto/meson.build b/crypto/meson.build
index 18da7c8541..af12b85aae 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -23,23 +23,23 @@ crypto_ss.add(files(
   'tlssession.c',
 ))
 
-if 'CONFIG_GCRYPT' in config_host
-  wo_nettle = files('hash-gcrypt.c', 'pbkdf-gcrypt.c')
+if 'CONFIG_NETTLE' in config_host
+  crypto_ss.add(files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'), nettle)
+elif 'CONFIG_GCRYPT' in config_host
+  crypto_ss.add(files('hash-gcrypt.c', 'pbkdf-gcrypt.c'), gcrypt)
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
-crypto_ss.add(when: 'CONFIG_GNUTLS', if_true: files('tls-cipher-suites.c'))
+crypto_ss.add(when: [gnutls, 'CONFIG_GNUTLS'], if_true: files('tls-cipher-suites.c'))
 
 crypto_ss = crypto_ss.apply(config_host, strict: false)
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
@@ -53,7 +53,7 @@ crypto = declare_dependency(link_whole: libcrypto,
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
 if 'CONFIG_GCRYPT' in config_host
-  util_ss.add(files('random-gcrypt.c'))
+  util_ss.add(files('random-gcrypt.c'), gcrypt)
 elif 'CONFIG_GNUTLS' in config_host
   util_ss.add(files('random-gnutls.c'), gnutls)
 elif 'CONFIG_RNG_NONE' in config_host
diff --git a/meson.build b/meson.build
index 74f8ea0c2e..c5f672028f 100644
--- a/meson.build
+++ b/meson.build
@@ -114,6 +114,11 @@ urcubp = not_found
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
2.26.2


