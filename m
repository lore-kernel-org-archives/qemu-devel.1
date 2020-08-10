Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E82C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ADE2065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLuc6djM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ADE2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BgX-0005an-0o
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJq-0008EN-MR
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJo-000301-FI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOsEBTNkKuEQxmw2J8FfhfR58sAy37Ne2eNjB4HMElE=;
 b=WLuc6djMVgJ9CrWoQEqQeblGI/C8c7Vabvu8DGmhvfjbXb+zW6kibesx4c8Y3VTmxUmRrn
 Gb9yKiz9ibIqzqcmq235Ztv0pl31ewnaqhovJYgDjPPC/CKy54GysHFKLBC2qVEy8aoq4e
 4ZggEmZokACbOz4mKuur4KbVdXmakEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-g3gjQ9M2NVSHP6qUZ3UzXw-1; Mon, 10 Aug 2020 13:10:37 -0400
X-MC-Unique: g3gjQ9M2NVSHP6qUZ3UzXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10338005B0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:36 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDF605F1E9;
 Mon, 10 Aug 2020 17:10:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 054/147] meson: convert crypto directory to Meson
Date: Mon, 10 Aug 2020 19:07:32 +0200
Message-Id: <1597079345-42801-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  1 -
 Makefile.objs        |  2 +-
 Makefile.target      |  2 +-
 crypto/Makefile.objs | 37 -------------------------------------
 crypto/meson.build   | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build          |  4 ++--
 qom/meson.build      |  2 +-
 7 files changed, 57 insertions(+), 43 deletions(-)
 delete mode 100644 crypto/Makefile.objs

diff --git a/Makefile b/Makefile
index 872f450..d26ad4c 100644
--- a/Makefile
+++ b/Makefile
@@ -230,7 +230,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-m \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
-                crypto-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
diff --git a/Makefile.objs b/Makefile.objs
index 0bc361d..018338d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -19,7 +19,7 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
-crypto-obj-y = crypto/
+crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/
 
diff --git a/Makefile.target b/Makefile.target
index 79b6e02..b213955 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -193,12 +193,12 @@ common-obj-m :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              crypto-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               crypto-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
deleted file mode 100644
index a988591..0000000
--- a/crypto/Makefile.objs
+++ /dev/null
@@ -1,37 +0,0 @@
-crypto-obj-y = init.o
-crypto-obj-y += hash.o
-crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
-crypto-obj-y += hmac.o
-crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
-crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
-crypto-obj-y += aes.o
-crypto-obj-y += desrfb.o
-crypto-obj-y += cipher.o
-crypto-obj-$(CONFIG_AF_ALG) += afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
-crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
-crypto-obj-y += tlscreds.o
-crypto-obj-y += tlscredsanon.o
-crypto-obj-y += tlscredspsk.o
-crypto-obj-y += tlscredsx509.o
-crypto-obj-y += tlssession.o
-crypto-obj-y += secret_common.o
-crypto-obj-y += secret.o
-crypto-obj-$(CONFIG_SECRET_KEYRING) += secret_keyring.o
-crypto-obj-y += pbkdf.o
-crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += pbkdf-stub.o
-crypto-obj-y += ivgen.o
-crypto-obj-y += ivgen-essiv.o
-crypto-obj-y += ivgen-plain.o
-crypto-obj-y += ivgen-plain64.o
-crypto-obj-y += afsplit.o
-crypto-obj-$(CONFIG_QEMU_PRIVATE_XTS) += xts.o
-crypto-obj-y += block.o
-crypto-obj-y += block-qcow.o
-crypto-obj-y += block-luks.o
diff --git a/crypto/meson.build b/crypto/meson.build
index 1b24431..7aab8db 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,3 +1,55 @@
+crypto_ss = ss.source_set()
+crypto_ss.add(genh)
+crypto_ss.add(files(
+  'afsplit.c',
+  'block-luks.c',
+  'block-qcow.c',
+  'block.c',
+  'cipher.c',
+  'desrfb.c',
+  'hash.c',
+  'hmac.c',
+  'ivgen-essiv.c',
+  'ivgen-plain.c',
+  'ivgen-plain64.c',
+  'ivgen.c',
+  'pbkdf.c',
+  'secret_common.c',
+  'secret.c',
+  'tlscreds.c',
+  'tlscredsanon.c',
+  'tlscredspsk.c',
+  'tlscredsx509.c',
+  'tlssession.c',
+))
+
+if 'CONFIG_GCRYPT' in config_host
+  wo_nettle = files('hash-gcrypt.c', 'pbkdf-gcrypt.c')
+else
+  wo_nettle = files('hash-glib.c', 'pbkdf-stub.c')
+endif
+if 'CONFIG_GCRYPT_HMAC' not in config_host
+  wo_nettle += files('hmac-glib.c')
+endif
+crypto_ss.add(when: [nettle, 'CONFIG_NETTLE'],
+             if_true: files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'),
+             if_false: wo_nettle)
+
+crypto_ss.add(when: 'CONFIG_SECRET_KEYRING', if_true: files('secret_keyring.c'))
+crypto_ss.add(when: 'CONFIG_QEMU_PRIVATE_XTS', if_true: files('xts.c'))
+crypto_ss.add(when: 'CONFIG_GCRYPT_HMAC', if_true: files('hmac-gcrypt.c'))
+crypto_ss.add(when: 'CONFIG_AF_ALG', if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
+crypto_ss.add(when: 'CONFIG_GNUTLS', if_true: files('tls-cipher-suites.c'))
+
+crypto_ss = crypto_ss.apply(config_host, strict: false)
+libcrypto = static_library('crypto', crypto_ss.sources(),
+                           dependencies: [crypto_ss.dependencies()],
+                           name_suffix: 'fa',
+                           build_by_default: false)
+
+crypto = declare_dependency(link_whole: libcrypto,
+                            dependencies: [authz, qom])
+
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
 if 'CONFIG_GCRYPT' in config_host
diff --git a/meson.build b/meson.build
index f8fd56a..8d46944 100644
--- a/meson.build
+++ b/meson.build
@@ -307,6 +307,8 @@ subdir('qobject')
 subdir('stubs')
 subdir('trace')
 subdir('util')
+subdir('qom')
+subdir('authz')
 subdir('crypto')
 subdir('storage-daemon')
 subdir('ui')
@@ -323,8 +325,6 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
-subdir('qom')
-subdir('authz')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/meson.build b/qom/meson.build
index 3c41ed3..4af044d 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -1,4 +1,5 @@
 qom_ss = ss.source_set()
+qom_ss.add(genh)
 qom_ss.add(files(
   'container.c',
   'object.c',
@@ -9,7 +10,6 @@ qom_ss.add(files(
 qom_ss = qom_ss.apply(config_host, strict: false)
 libqom = static_library('qom', qom_ss.sources(),
                         dependencies: [qom_ss.dependencies()],
-                        link_with: [libqemuutil],
                         name_suffix: 'fa')
 
 qom = declare_dependency(link_whole: libqom)
-- 
1.8.3.1



