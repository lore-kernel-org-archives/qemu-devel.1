Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFDBC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26CF206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffgHi83A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26CF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6Q5-00032x-Ro
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6Nh-00009g-Dl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:31:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6Ne-000788-EA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598967080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IO3TFqPoX/OLObMBa229BdOGTxQ5xorxsF85TszboI=;
 b=ffgHi83AyBpF11LP7buw3k0h6FWaHUz7ITnUf2MhPfq0tQ9jaFjmmtmypEfzVlIqKj18y3
 s5WiyGpRPUs1aP8p+VK06Ve9qSGP0GdO3nm9x8D/5OzepBfrJ9B+dyUl3r9Fo6xl24utMR
 hEeC8Sk/RF1Q93jnCDzx3BSd6/caklg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-4qYGgUZfOC2boxFdmSVJ0Q-1; Tue, 01 Sep 2020 09:31:15 -0400
X-MC-Unique: 4qYGgUZfOC2boxFdmSVJ0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A739425D0;
 Tue,  1 Sep 2020 13:31:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-215.ams2.redhat.com
 [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA6DD5D9CC;
 Tue,  1 Sep 2020 13:30:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] crypto: fix build with gcrypt enabled
Date: Tue,  1 Sep 2020 14:30:49 +0100
Message-Id: <20200901133050.381844-2-berrange@redhat.com>
In-Reply-To: <20200901133050.381844-1-berrange@redhat.com>
References: <20200901133050.381844-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Gnutls was also not added as a dependancy when gcrypt is enabled.

Attempting to add the library dependencies at the same time as the
source dependencies is error prone, as there are alot of different
rules for picking which sources to use, and some of the source files
use code level conditionals intead. It is thus clearer to add the
library dependencies separately.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure          |  2 ++
 crypto/meson.build | 42 +++++++++++++++++++++++++++++++-----------
 meson.build        |  5 +++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 8dc981684b..3dc2431722 100755
--- a/configure
+++ b/configure
@@ -6979,6 +6979,8 @@ if test "$gcrypt" = "yes" ; then
   if test "$gcrypt_hmac" = "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
   fi
+  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
+  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
 fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
diff --git a/crypto/meson.build b/crypto/meson.build
index 18da7c8541..f6f5ce1ecd 100644
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
index 1e7aee85e3..bc6aac4ce7 100644
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


