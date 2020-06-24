Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E402084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGuSqoCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E402084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo395-0003I9-Ds
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zm-00018y-BF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zh-0001I8-Bd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUafodrZTh6XTGE3AIrW/S+LSHYlA5hmP9UIvv9Y6EA=;
 b=GGuSqoCxVTsFW+jlVL0JMOzwkSNEmrl32UCepRpsdWDUbjrkR1U4w+3DNCP4J5lh4YFWmX
 MEeoZ37imQyygl33MUAVOmY0dzd88kNMo0RE0JvgngfCtiPJ/W0PPICKMZF+yHnLIZBk25
 rNGfFJqO7lw51mvNdp3vC3UHAo18QdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-iWUIKhqqN4i-0fph_RysWg-1; Wed, 24 Jun 2020 06:51:01 -0400
X-MC-Unique: iWUIKhqqN4i-0fph_RysWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BCBD87950B;
 Wed, 24 Jun 2020 10:51:00 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EDB71DC;
 Wed, 24 Jun 2020 10:50:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/31] configure: add libdaxctl support
Date: Wed, 24 Jun 2020 06:50:25 -0400
Message-Id: <20200624105048.375353-8-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Joao Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jingqi Liu <jingqi.liu@intel.com>

Add a pair of configure options --{enable,disable}-libdaxctl to control
whether QEMU is compiled with libdaxctl [1]. Libdaxctl is a utility
library for managing the device dax subsystem.

QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
address to the page size (getpagesize(2)) by default. However, some
types of backends may require an alignment different than the page
size. The 'align' option is provided to memory-backend-file to allow
users to specify the proper alignment.

For device dax (e.g., /dev/dax0.0), the 'align' option needs to match
the alignment requirement of the device dax, which can be fetched
through the APIs of libdaxctl version 57 or up.

[1] Libdaxctl is a part of ndctl project.
The project's repository is: https://github.com/pmem/ndctl

For more information about libdaxctl APIs, you can refer to the
comments in source code of: pmem/ndctl/daxctl/lib/libdaxctl.c.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Message-Id: <20200429085011.63752-4-jingqi.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/configure b/configure
index ba88fd1824..8d9435a0e0 100755
--- a/configure
+++ b/configure
@@ -517,6 +517,7 @@ plugins="no"
 fuzzing="no"
 rng_none="no"
 secret_keyring=""
+libdaxctl=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1621,6 +1622,10 @@ for opt do
   ;;
   --disable-keyring) secret_keyring="no"
   ;;
+  --enable-libdaxctl) libdaxctl=yes
+  ;;
+  --disable-libdaxctl) libdaxctl=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1920,6 +1925,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libpmem         libpmem support
   xkbcommon       xkbcommon support
   rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
+  libdaxctl       libdaxctl support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6292,6 +6298,24 @@ if test "$libpmem" != "no"; then
 	fi
 fi
 
+##########################################
+# check for libdaxctl
+
+if test "$libdaxctl" != "no"; then
+	if $pkg_config --atleast-version=57 "libdaxctl"; then
+		libdaxctl="yes"
+		libdaxctl_libs=$($pkg_config --libs libdaxctl)
+		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
+		libs_softmmu="$libs_softmmu $libdaxctl_libs"
+		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
+	else
+		if test "$libdaxctl" = "yes" ; then
+			feature_not_found "libdaxctl" "Install libdaxctl"
+		fi
+		libdaxctl="no"
+	fi
+fi
+
 ##########################################
 # check for slirp
 
@@ -6898,6 +6922,7 @@ echo "parallels support $parallels"
 echo "sheepdog support  $sheepdog"
 echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
+echo "libdaxctl support $libdaxctl"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
@@ -7731,6 +7756,10 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$libdaxctl" = "yes" ; then
+  echo "CONFIG_LIBDAXCTL=y" >> $config_host_mak
+fi
+
 if test "$bochs" = "yes" ; then
   echo "CONFIG_BOCHS=y" >> $config_host_mak
 fi
-- 
2.26.2



