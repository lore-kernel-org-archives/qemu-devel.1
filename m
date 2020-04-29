Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAA52076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAA52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiaw-0000mQ-6W
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTiVc-0000sL-NO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTiVA-0001Be-4m
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:25911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jTiV9-0000gc-Hr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:31 -0400
IronPort-SDR: 1wlIdXL8mJxtI3qyfzb1NlYw/aQ9NbprN8kb/cR4BomJ4Y9hTDjM2Lip5cTlLq7RLfzjDVSXJL
 0Ztay3OAc/Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 01:55:31 -0700
IronPort-SDR: 6ooFJFD+nHmoB6ZMPhTg1hg9JHZMijx7fn1eAh+opWKS7WjN8vhmgaI+nlL+CwA1UnZe1OAfpj
 G2DhKIq10iNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,331,1583222400"; d="scan'208";a="459114658"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 01:55:29 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Joao Martins <joao.m.martins@oracle.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 3/3] configure: add libdaxctl support
Date: Wed, 29 Apr 2020 16:50:11 +0800
Message-Id: <20200429085011.63752-4-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429085011.63752-1-jingqi.liu@intel.com>
References: <20200429085011.63752-1-jingqi.liu@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=jingqi.liu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 04:55:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 configure | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..d2418084c1 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+libdaxctl=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-libdaxctl) libdaxctl=yes
+  ;;
+  --disable-libdaxctl) libdaxctl=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  libdaxctl       libdaxctl support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6190,6 +6196,24 @@ if test "$libpmem" != "no"; then
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
 
@@ -6767,6 +6791,7 @@ echo "parallels support $parallels"
 echo "sheepdog support  $sheepdog"
 echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
+echo "libdaxctl support $libdaxctl"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
@@ -7590,6 +7615,10 @@ if test "$libpmem" = "yes" ; then
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
2.17.1


