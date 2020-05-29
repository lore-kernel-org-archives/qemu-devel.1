Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4430D20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOahBAHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4430D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecPS-0003Nk-EL
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMz-00076g-JW
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMv-0004vx-D0
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590748564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Srt2E4rIe68S0L/yuU2VQaao8920BbTl5J1CL/gpBek=;
 b=KOahBAHNPpreswz/L2RXOYwnANGn/uzhubezH32LDZnMwncc0l0S3HsiuXdr5XdiKMK+TG
 RVs1jVvVH+Tg02GcxJFiw+HoLsQeKpjN0FglW+PI4WzM2Jy8zNjWmNC3kFuU/XSYjHk0zD
 SItZnWVMMClPv7yNpZBp4EgABeNSGz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-0LVftmqCNZ-C-hw1TWZ7ew-1; Fri, 29 May 2020 06:36:00 -0400
X-MC-Unique: 0LVftmqCNZ-C-hw1TWZ7ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB9C0872FEE;
 Fri, 29 May 2020 10:35:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C56371A7C8;
 Fri, 29 May 2020 10:35:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] crypto: add "none" random provider
Date: Fri, 29 May 2020 11:35:51 +0100
Message-Id: <20200529103555.2759928-2-berrange@redhat.com>
In-Reply-To: <20200529103555.2759928-1-berrange@redhat.com>
References: <20200529103555.2759928-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

In case of not using random-number needing feature, it makes sense to
skip RNG init too. This is especially helpful when QEMU is sandboxed in
Stubdomain under Xen, where there is very little entropy so initial
getrandom() call delays the startup several seconds. In that setup, no
random bytes are needed at all.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure            | 11 +++++++++++
 crypto/Makefile.objs |  3 ++-
 crypto/random-none.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 crypto/random-none.c

diff --git a/configure b/configure
index b969dee675..2ffe365e2c 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+rng_none="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-rng-none) rng_none=yes
+  ;;
+  --disable-rng-none) rng_none=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6749,6 +6755,7 @@ echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
 echo "gdb               $gdb_bin"
+echo "rng-none          $rng_none"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7722,6 +7729,10 @@ if test "$edk2_blobs" = "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
 fi
 
+if test "$rng_none" = "yes"; then
+  echo "CONFIG_RNG_NONE=y" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index c2a371b0b4..cdee92b4e5 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -35,5 +35,6 @@ crypto-obj-y += block-luks.o
 
 util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
 util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(CONFIG_RNG_NONE))) += random-none.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(if $(CONFIG_RNG_NONE),n,y))) += random-platform.o
 util-obj-y += aes.o init.o
diff --git a/crypto/random-none.c b/crypto/random-none.c
new file mode 100644
index 0000000000..102f8a4dce
--- /dev/null
+++ b/crypto/random-none.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU Crypto "none" random number provider
+ *
+ * Copyright (c) 2020 Marek Marczykowski-Górecki
+ *                      <marmarek@invisiblethingslab.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "crypto/random.h"
+#include "qapi/error.h"
+
+int qcrypto_random_init(Error **errp)
+{
+    return 0;
+}
+
+int qcrypto_random_bytes(void *buf,
+                         size_t buflen,
+                         Error **errp)
+{
+    error_setg(errp, "Random bytes not available with \"none\" rng");
+    return -1;
+}
-- 
2.26.2


