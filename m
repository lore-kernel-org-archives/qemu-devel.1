Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE5C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73392075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/568LfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73392075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG67-0006DZ-Sl
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFG00-0004Iw-6Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzy-0007wl-5B
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVs3jEQVMpxHjQaVcw0d5wtkBSNPsFa3uu5iv4I8tHM=;
 b=F/568LfOM8ernVxSUVMkO9L0oom9VuY2WYaFntLQu5YteTgLT/TH5zJBmQ/OUJYuaA0nN/
 S/06bxfVo3R4v93w9pN6j7PuYOUTEaOAvXA/qB3F0CfmhtWEJT+wY0MAcv+8QRUN1e3iMo
 shqV7Yki2lAzH4NrUHZzq6fqE56MPGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-iRjFqzZ-MH2P6JNnFGLhpw-1; Mon, 07 Sep 2020 08:11:47 -0400
X-MC-Unique: iRjFqzZ-MH2P6JNnFGLhpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AC0F640C3;
 Mon,  7 Sep 2020 12:11:46 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3C95C1BB;
 Mon,  7 Sep 2020 12:11:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/14] crypto: fix build with gcrypt enabled
Date: Mon,  7 Sep 2020 14:11:24 +0200
Message-Id: <20200907121127.136243-12-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
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
Message-Id: <20200901133050.381844-2-berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure          |  2 ++
 crypto/meson.build | 42 +++++++++++++++++++++++++++++++-----------
 meson.build        |  5 +++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 086c6d3197..166193cef9 100755
--- a/configure
+++ b/configure
@@ -6963,6 +6963,8 @@ if test "$gcrypt" = "yes" ; then
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
index 5aaa364730..04e070bb3b 100644
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
2.18.2


