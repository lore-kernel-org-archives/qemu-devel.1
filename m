Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7039FC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53A12074B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETEVHW7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53A12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3PB-0000qb-Mm
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3LE-0004t5-Ug
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3LC-0003jt-Ma
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK29ox182264; Fri, 23 Oct 2020 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=P3TPXiTUGaxAmCIhw8Qg77Q02Z3Vw0oLUCLlve8GL20=;
 b=ETEVHW7Qz21JHrGVqjutzkK183XK2XVC5QOYN7MMUXDvrphqOH3WlHFQK1MfX8g6BV6U
 y69a+pFyRycHvsKjVJM2gVHMsG0NzIyuaoGGnjJk+VIHJF849w4619rWUi83R9YYjj3A
 GGtJHhuEPkr5k0jbW9zmsYuIM+Dt7UvMz8pFrcUaaMXKoMpcbswPl9A+RqU2HfAFVgl4
 b4Kc88daeOzodFzcc0jCGbCz1GYUtBo+JkxiKTxB6VbsO0MP65Ybdw57PBBW3Vqfa6lQ
 UxbBwKg5tlEoyLRxSoG0DCWeiOkCexcf2n/5UZHaP51jIkFW75S8XOXArkNhaq8Hh+CF RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c2j9dg1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:09 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK2IAh182894;
 Fri, 23 Oct 2020 16:07:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c2j9dg0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NJvKX1001629;
 Fri, 23 Oct 2020 20:07:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 347r89jw3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:07:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK767k32440650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:07:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97EBE6A054;
 Fri, 23 Oct 2020 20:07:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE3A76A04D;
 Fri, 23 Oct 2020 20:07:05 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:07:05 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] configure: add support for Control-Flow Integrity
Date: Fri, 23 Oct 2020 16:06:44 -0400
Message-Id: <20201023200645.1055-7-dbuono@linux.vnet.ibm.com>
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
 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230119
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

This patch adds a flag to enable/disable control flow integrity checks
on indirect function calls.
This feature only allows indirect function calls at runtime to functions
with compatible signatures.

This feature is only provided by LLVM/Clang, and depends on link-time
optimization which is currently supported only with LLVM/Clang >= 6.0

We also add an option to enable a debugging version of cfi, with verbose
output in case of a CFI violation.

CFI on indirect function calls does not support calls to functions in
shared libraries (since they were not known at compile time), and such
calls are forbidden. QEMU relies on dlopen/dlsym when using modules,
so we make modules incompatible with CFI.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure   | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build |  2 ++
 2 files changed, 86 insertions(+)

diff --git a/configure b/configure
index e964040522..f996c4462e 100755
--- a/configure
+++ b/configure
@@ -272,6 +272,8 @@ debug_info="yes"
 lto="false"
 stack_protector=""
 safe_stack=""
+cfi="no"
+cfi_debug="no"
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
@@ -1199,6 +1201,16 @@ for opt do
   ;;
   --disable-safe-stack) safe_stack="no"
   ;;
+  --enable-cfi)
+      cfi="yes" ;
+      lto="true" ;
+  ;;
+  --disable-cfi) cfi="no"
+  ;;
+  --enable-cfi-debug) cfi_debug="yes"
+  ;;
+  --disable-cfi-debug) cfi_debug="no"
+  ;;
   --disable-curses) curses="disabled"
   ;;
   --enable-curses) curses="enabled"
@@ -1772,6 +1784,13 @@ disabled with --disable-FEATURE, default is enabled if available:
   sparse          sparse checker
   safe-stack      SafeStack Stack Smash Protection. Depends on
                   clang/llvm >= 3.7 and requires coroutine backend ucontext.
+  cfi             Enable Control-Flow Integrity for indirect function calls.
+                  In case of a cfi violation, QEMU is terminated with SIGILL
+                  Depends on lto and is incompatible with modules
+                  Automatically enables Link-Time Optimization (lto)
+  cfi-debug       In case of a cfi violation, a message containing the line that
+                  triggered the error is written to stderr. After the error,
+                  QEMU is still terminated with SIGILL
 
   gnutls          GNUTLS cryptography support
   nettle          nettle cryptography support
@@ -5312,6 +5331,64 @@ EOF
   CONFIGURE_CFLAGS="$QEMU_CFLAGS -flto"
   CONFIGURE_LDFLAGS="$QEMU_LDFLAGS -flto"
 fi
+
+########################################
+# cfi (Control Flow Integrity)
+
+if test "$cfi" = "yes"; then
+  # Compiler/Linker Flags that needs to be added for cfi:
+  # -fsanitize=cfi-icall to enable control-flow integrity checks on
+  #            indirect function calls.
+  # -fsanitize-cfi-icall-generalize-pointers to allow indirect function calls
+  #            with pointers of a different type (i.e. pass a void* to a
+  #            function that expects a char*). Used in some spots in QEMU,
+  #            with compile-time type checks done by macros
+  # -fno-sanitize-trap=cfi-icall, when debug is enabled, to display the
+  #            position in the code that triggered a CFI violation
+
+  # Make sure that LTO is enabled
+  if test "$lto" != "true"; then
+    error_exit "Control Flow Integrity requires Link-Time Optimization (LTO)"
+  fi
+
+  test_cflag="-fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers"
+  test_ldflag="-fsanitize=cfi-icall"
+
+  if test "$cfi_debug" = "yes"; then
+    # Disable the default trap mechanism so that a error message is displayed
+    # when a CFI violation happens. The code is still terminated after the
+    # message
+    test_cflag="${test_cflag} -fno-sanitize-trap=cfi-icall"
+    test_ldflag="${test_ldflag} -fno-sanitize-trap=cfi-icall"
+  fi
+
+  # Check that cfi is supported.
+  cat > $TMPC << EOF
+int main(int argc, char *argv[]) {
+  return 0;
+}
+EOF
+  # Manually add -flto because even if is enabled, flags for it will be
+  # set up later by meson
+  if ! compile_prog "-Werror $test_cflag" "$test_ldflag"; then
+    error_exit "Control Flow Integrity is not supported by your compiler"
+  fi
+
+  # Check for incompatible options
+  if test "$modules" = "yes"; then
+    error_exit "Control Flow Integrity is not compatible with modules"
+  fi
+
+  #### All good, add the flags for CFI to our CFLAGS and LDFLAGS
+  # Flag needed both at compilation and at linking
+  QEMU_CFLAGS="$QEMU_CFLAGS $test_cflag"
+  QEMU_LDFLAGS="$QEMU_LDFLAGS $test_ldflag"
+else
+  if test "$cfi_debug" = "yes"; then
+    error_exit "Cannot enable Control Flow Integrity debugging since CFI is not enabled"
+  fi
+fi
+
 # See if __attribute__((alias)) is supported.
 # This false for Xcode 9, but has been remedied for Xcode 10.
 # Unfortunately, travis uses Xcode 9 by default.
@@ -6972,6 +7049,13 @@ if test "$safe_stack" = "yes"; then
   echo "CONFIG_SAFESTACK=y" >> $config_host_mak
 fi
 
+if test "$cfi" = "yes"; then
+  echo "CONFIG_CFI=y" >> $config_host_mak
+  if test "$cfi_debug" = "yes"; then
+    echo "CONFIG_CFI_DEBUG=y" >> $config_host_mak
+  fi
+fi
+
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
diff --git a/meson.build b/meson.build
index 50e5c527df..be74a232a0 100644
--- a/meson.build
+++ b/meson.build
@@ -2071,6 +2071,8 @@ if targetos == 'windows'
   summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
 endif
 summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
+summary_info += {'cfi support':       config_host.has_key('CONFIG_CFI')}
+summary_info += {'cfi debug support': config_host.has_key('CONFIG_CFI_DEBUG')}
 summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
 summary_info += {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL'] == '1'}
 summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_USAGE')}
-- 
2.17.1


