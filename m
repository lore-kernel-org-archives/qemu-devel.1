Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC98C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F66321744
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F66321744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6nW0-0005Fl-JY
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 22:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j6nVJ-0004M1-Sc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j6nVI-0001RJ-CO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:36:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:46405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j6nVI-0001K4-2P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:36:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2020 19:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; d="scan'208";a="231256487"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga008.jf.intel.com with ESMTP; 25 Feb 2020 19:36:52 -0800
From: Robert Hoo <robert.hu@linux.intel.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 laurent@vivier.eu, philmd@redhat.com, berrange@redhat.com
Subject: [PATCH v2 1/2] configure: introduce configure option avx512f
Date: Wed, 26 Feb 2020 11:35:41 +0800
Message-Id: <1582688142-113997-2-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582688142-113997-1-git-send-email-robert.hu@linux.intel.com>
References: <1582688142-113997-1-git-send-email-robert.hu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce {enable,disable}-avx512f configure option. It is by default disabled.
Only when user explicitly enable-avx512f and compiling environment supports
AVX512F, CONFIG_AVX512F_OPT will be defined.

AVX512F instruction set is available since Intel Skylake.
More info:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 configure | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/configure b/configure
index d57261e..a0b41ce 100755
--- a/configure
+++ b/configure
@@ -1395,6 +1395,11 @@ for opt do
   ;;
   --enable-avx2) avx2_opt="yes"
   ;;
+  --disable-avx512f) avx512f_opt="no"
+  ;;
+  --enable-avx512f) avx512f_opt="yes"
+  ;;
+
   --enable-glusterfs) glusterfs="yes"
   ;;
   --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)
@@ -1825,6 +1830,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   avx2            AVX2 optimization support
+  avx512f         AVX512F optimization support
   replication     replication support
   opengl          opengl support
   virglrenderer   virgl rendering support
@@ -5518,6 +5524,36 @@ EOF
   fi
 fi
 
+##########################################
+# avx512f optimization requirement check
+#
+# There is no point enabling this if cpuid.h is not usable,
+# since we won't be able to select the new routines.
+# by default, it is turned off.
+# if user explicitly want to enable it, check environment
+
+if test "$cpuid_h" = "yes" && test "$avx512f_opt" = "yes"; then
+  cat > $TMPC << EOF
+#pragma GCC push_options
+#pragma GCC target("avx512f")
+#include <cpuid.h>
+#include <immintrin.h>
+static int bar(void *a) {
+    __m512i x = *(__m512i *)a;
+    return _mm512_test_epi64_mask(x, x);
+}
+int main(int argc, char *argv[])
+{
+	return bar(argv[0]);
+}
+EOF
+  if ! compile_object "" ; then
+    avx512f_opt="no"
+  fi
+else
+  avx512f_opt="no"
+fi
+
 ########################################
 # check if __[u]int128_t is usable.
 
@@ -6650,6 +6686,7 @@ echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
+echo "avx512f optimization $avx512f_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "bochs support     $bochs"
@@ -7200,6 +7237,10 @@ if test "$avx2_opt" = "yes" ; then
   echo "CONFIG_AVX2_OPT=y" >> $config_host_mak
 fi
 
+if test "$avx512f_opt" = "yes" ; then
+  echo "CONFIG_AVX512F_OPT=y" >> $config_host_mak
+fi
+
 if test "$lzo" = "yes" ; then
   echo "CONFIG_LZO=y" >> $config_host_mak
 fi
-- 
1.8.3.1


