Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093E32074B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KNM/HMlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3N7-0007KA-1T
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L8-0004hG-7Y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L6-0003is-2G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK1hed099395; Fri, 23 Oct 2020 16:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZLhWKIOW7+EclO3pqiAO+l1ZilF2Tr2SDwD3dq/QbWI=;
 b=KNM/HMlPfDr5NzLTygwWk5vylwX3BN+vm9CoraTzcOOL66VeR5FRysA7n0MHgON2P15m
 h6w6tDqDCmT/1K8q1OPYZOqJkKDzgOcezSoVlfzHd3VdmWCfTtOLsaoZjIpiNqjV9IxK
 TLWJVNU7zUupFwqeN1CdnBovhWn60Xko65/twDaRuUKgoKVBdEBunZeM6zkOjpwvxCmu
 cRKnHNpai9oHgQMXQjLjDiNkZEo6Kl/r6tb2Z7/iTjcGRkNuA7ZKGMWptjqxChVf9XMS
 /v3YhMbR2SQ4ZkOwLsKPI4vxSem6g+wl5oPhtrx62tqYv/+giEEXSFWrFG7xUuYJJREe FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c4t9hthk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:02 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK31QA106964;
 Fri, 23 Oct 2020 16:07:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c4t9hth5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NJv1PY014288;
 Fri, 23 Oct 2020 20:07:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 347r89txpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:07:00 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK6xOO62456192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:06:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA2786A047;
 Fri, 23 Oct 2020 20:06:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12D746A04D;
 Fri, 23 Oct 2020 20:06:59 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:06:58 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] configure: add option to enable LTO
Date: Fri, 23 Oct 2020 16:06:41 -0400
Message-Id: <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-23_14:2020-10-23,
 2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=1 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230119
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:06:56
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch allows to compile QEMU with link-time optimization (LTO).
Compilation with LTO is handled directly by meson. This patch adds checks
in configure to make sure the toolchain supports LTO.

Currently, allow LTO only with clang, since I have found a couple of issues
with gcc-based LTO.

In case fuzzing is enabled, automatically switch to llvm's linker (lld).
The standard bfd linker has a bug where function wrapping (used by the fuzz*
targets) is used in conjunction with LTO.

Tested with all major versions of clang from 6 to 12

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure   | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build |   1 +
 2 files changed, 129 insertions(+)

diff --git a/configure b/configure
index 9dc05cfb8a..e964040522 100755
--- a/configure
+++ b/configure
@@ -76,6 +76,7 @@ fi
 TMPB="qemu-conf"
 TMPC="${TMPDIR1}/${TMPB}.c"
 TMPO="${TMPDIR1}/${TMPB}.o"
+TMPA="${TMPDIR1}/lib${TMPB}.a"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPTXT="${TMPDIR1}/${TMPB}.txt"
@@ -180,6 +181,32 @@ compile_prog() {
       $LDFLAGS $CONFIGURE_LDFLAGS $QEMU_LDFLAGS $local_ldflags
 }
 
+do_run_filter() {
+    # Run a generic program, capturing its output to the log,
+    # but also filtering the output with grep.
+    # Returns the return value of grep.
+    # First argument is the filter string.
+    # Second argument is binary to execute.
+    local filter="$1"
+    local filter_pattern=""
+    if test "$filter" = "yes"; then
+      shift
+      filter_pattern="$1"
+    fi
+    shift
+    local program="$1"
+    shift
+    echo $program $@ >> config.log
+    $program $@ >> config.log 2>&1 || return $?
+    if test "$filter" = "yes"; then
+      $program $@ 2>&1 | grep "${filter_pattern}" >> /dev/null || return $?
+    fi
+}
+
+create_library() {
+  do_run_filter "no" "$ar" -rc${1} $TMPA $TMPO
+}
+
 # symbolically link $1 to $2.  Portable version of "ln -sf".
 symlink() {
   rm -rf "$2"
@@ -242,6 +269,7 @@ host_cc="cc"
 audio_win_int=""
 libs_qga=""
 debug_info="yes"
+lto="false"
 stack_protector=""
 safe_stack=""
 use_containers="yes"
@@ -1159,6 +1187,10 @@ for opt do
   ;;
   --disable-werror) werror="no"
   ;;
+  --enable-lto) lto="true"
+  ;;
+  --disable-lto) lto="false"
+  ;;
   --enable-stack-protector) stack_protector="yes"
   ;;
   --disable-stack-protector) stack_protector="no"
@@ -1735,6 +1767,8 @@ disabled with --disable-FEATURE, default is enabled if available:
   module-upgrades try to load modules from alternate paths for upgrades
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
+  lto             Enable Link-Time Optimization.
+                  Depends on clang/llvm >=6.0
   sparse          sparse checker
   safe-stack      SafeStack Stack Smash Protection. Depends on
                   clang/llvm >= 3.7 and requires coroutine backend ucontext.
@@ -5222,6 +5256,62 @@ if  test "$plugins" = "yes" &&
 fi
 
 ########################################
+# lto (Link-Time Optimization)
+
+if test "$lto" = "true"; then
+  # Test compiler/ar/linker support for lto.
+  # compilation with lto is handled by meson. Just make sure that compiler
+  # support is fully functional, and add additional compatibility flags
+  # if necessary.
+
+  if ! echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
+    # LTO with GCC and other compilers is not tested, and possibly broken
+    error_exit "QEMU only supports LTO with CLANG"
+  fi
+
+  # Check that lto is supported.
+  # Need to check for:
+  # - Valid compiler, that supports lto flags
+  # - Valid ar, able to support intermediate code
+  # - Valid linker, able to support intermediate code
+
+  #### Check for a valid *ar* for link-time optimization.
+  # Test it by creating a static library and linking it
+  # Compile an object first
+  cat > $TMPC << EOF
+int fun(int val);
+
+int fun(int val) {
+    return val;
+}
+EOF
+  if ! compile_object "-Werror -flto"; then
+    error_exit "LTO is not supported by your compiler"
+  fi
+  # Create a library out of it
+  if ! create_library "s" ; then
+    error_exit "LTO is not supported by ar. This usually happens when mixing GNU and LLVM toolchain."
+  fi
+  # Now create a binary using the library
+  cat > $TMPC << EOF
+int fun(int val);
+
+int main(int argc, char *argv[]) {
+  return fun(0);
+}
+EOF
+  if ! compile_prog "-Werror" "$test_ldflag -flto ${TMPA}"; then
+    error_exit "LTO is not supported by ar or the linker. This usually happens when mixing GNU and LLVM toolchain."
+  fi
+
+  #### All good, add the flags for CFI to our CFLAGS and LDFLAGS
+  # Flag needed both at compilation and at linking
+  QEMU_LDFLAGS="$QEMU_LDFLAGS $test_ldflag"
+  # Add -flto to CONFIGURE_*FLAGS since we need it in configure,
+  # but will be added by meson later
+  CONFIGURE_CFLAGS="$QEMU_CFLAGS -flto"
+  CONFIGURE_LDFLAGS="$QEMU_LDFLAGS -flto"
+fi
 # See if __attribute__((alias)) is supported.
 # This false for Xcode 9, but has been remedied for Xcode 10.
 # Unfortunately, travis uses Xcode 9 by default.
@@ -5532,6 +5622,43 @@ if test "$fuzzing" = "yes" && test -z "${LIB_FUZZING_ENGINE+xxx}"; then
     error_exit "Your compiler doesn't support -fsanitize=fuzzer"
     exit 1
   fi
+  # Make sure that the linker supports a custom linker script
+  # If LTO is enabled, switch linker to lld, since at the moment
+  # it is the only linker that works with lto and fuzzing:
+  # - gold does not support a custom script
+  # - bfd does not support wrapping functions with LTO
+  cat > $TMPC << EOF
+#include <stdlib.h>
+#include <stdio.h>
+void* __real_malloc(size_t size);
+void* __wrap_malloc(size_t size);
+
+void* __wrap_malloc(size_t size){
+  printf("Inside wrap_malloc\n");
+  return __real_malloc(size);
+}
+
+int main(int argc, char *argv[]) {
+  int *myint = (void*) malloc(sizeof(int));
+  *myint = 0;
+  return *myint;
+}
+EOF
+  extra_cflags="$CPU_CFLAGS -Werror"
+  extra_ldflags="-Wl,-T,${source_path}/tests/qtest/fuzz/fork_fuzz.ld"
+  extra_ldflags="${extra_ldflags} -Wl,--wrap,malloc"
+  if test "$lto" = "true"; then
+     extra_ldflags="${extra_ldflags} -fuse-ld=lld"
+  fi
+  if ! compile_prog "$extra_cflags" "$extra_ldflags"; then
+    error_exit "Your linker does not support our linker script"
+  fi
+  if ! do_run_filter "yes" "Inside wrap_malloc" ${TMPE} ""; then
+    error_exit "Your linker does not support our linker script"
+  fi
+  if test "$lto" = "true"; then
+     QEMU_LDFLAGS="${QEMU_LDFLAGS} -fuse-ld=lld"
+  fi
 fi
 
 # Thread sanitizer is, for now, much noisier than the other sanitizers;
@@ -7018,6 +7145,7 @@ NINJA=$ninja $meson setup \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
         -Ddocs=$docs -Dsphinx_build=$sphinx_build \
+        -Db_lto=$lto \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 7627a0ae46..50e5c527df 100644
--- a/meson.build
+++ b/meson.build
@@ -1959,6 +1959,7 @@ summary_info += {'gprof enabled':     config_host.has_key('CONFIG_GPROF')}
 summary_info += {'sparse enabled':    sparse.found()}
 summary_info += {'strip binaries':    get_option('strip')}
 summary_info += {'profiler':          config_host.has_key('CONFIG_PROFILER')}
+summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
 if targetos == 'darwin'
   summary_info += {'Cocoa support': config_host.has_key('CONFIG_COCOA')}
-- 
2.17.1


