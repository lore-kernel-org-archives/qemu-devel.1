Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A5FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7314206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7314206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtBxT-00028x-VY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwJ-0000k3-SD
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwG-0003rj-Hd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:51 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryCb-1ke3Oi2Y9F-00nyk5; Wed, 08 Jul 2020 17:24:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: fix print_syscall_err() when syscall
 returned value is negative
Date: Wed,  8 Jul 2020 17:24:35 +0200
Message-Id: <20200708152435.706070-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708152435.706070-1-laurent@vivier.eu>
References: <20200708152435.706070-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SlgJvoPbMIPRGZqKxi52xr+quYCcDCXIErC0wCyf+Ir2Yr29VYo
 ZB3s7qqyzN5pgoXhvH+NvxR0KyVa/c2aKvYdUycjOEJ1DfeAMLAoFlpelJRuivwG1xElZW6
 RaMVWCw6DcaupVESJBY3EKA+Squ5xOEhlUY6hbDh8Ij8kqKJdXRCbMzi0bWKedXpgNwiaw/
 l4Oq+X95ZGoOzOxI1s7Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1yZvhYdCusY=:vgX2h1pxeyx/F85cGtE2on
 weLOe4HuP4FB1X+1OhsWitn/xUXABCOYWIOW8g6nc/2kW2D4do1fP0CUP7b2ClcztoV39ZJM7
 VL0zHBlSRfT73dchhfUBwNgcrvYV9oaT/8OH3/j9u4Tzi5an83RrtiHEcEe47wegLovIbVNPT
 I0AeRpQe9VA1PrLsZVrze5LOGleMy8oAiz3sLCJTMxZITzVUdtkf+Q64UmXYU0UGuQp8gLw3k
 WjzLzY3Be9VdkRS4f6ILN6aGTsvHtbOioQYjqi94PXi2GbB+4UlqWwUdBz+UIUnpZmYc0vUHU
 jIK0DZp+yeXIeUnWbvbsZWCn9LFutucDyimWwvdAx2nSgCz7vKGWlIcJjYThO5jRyzD6ZoDl9
 9J9eiKuNNXqJcIEne2XY5+2LjpgumuXS9wVOopyljU7/DYeYvTdxg/gmJUbDDlcyh0ucwA0f2
 LCC8AfUGwUOhVbLchv8nz/xVdGmaJz6rUd0ud2OHP5qq4/qycXJ8m9NhIcAabCvSApQnxBHy2
 FhGTsCP2gSXUM0xx7+ET1JYqXb/PPaOfbndG1lXJflsb69+9DUbmkpmtCvHQdwN5EzAwuccwR
 j+EWZizMRdKXAgM/Pu/r8affTjgWBPqfsBJdymTErmqs1UEwWEV87ydZAMVvvQRRIRwc1GRWi
 LM8/hG2UOYpiSLufbp1ESPfleAUn1YoKffCtv/S1EfOrd6kIMBPKgDTA5hxV9jCm8gMyEZ4Nf
 FgmGY6QZlGjHLTMFPmQDn1ygqojrztG/nrLH2MPu+RKWsO9IK3RBBYYJeJEAZmpy2UyAj0Rbm
 OxnWPVczpMnyWFWzihE+bqWYwqzeGN+iZG5J59yqzSv5SW2ckbYhNuTaI9bBV7xDgKspoJt
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:24:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

print_syscall_err() relies on the sign of the returned value to know
if it is an errno value or not.

But in some cases the returned value can have the most signicant bit
set without being an errno.

This patch restores previous behaviour that was also checking if
we can decode the errno to validate it.

This patch fixes this kind of problem (qemu-m68k):

  root@sid:/# QEMU_STRACE= ls
  3 brk(NULL) = -1 errno=21473607683 uname(0x407fff8a) = 0

to become:

  root@sid:/# QEMU_STRACE= ls
  3 brk(NULL) = 0x8001e000
  3 uname(0xffffdf8a) = 0

Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
Cc: Filip.Bozuta@syrmia.com
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b42664bbd180..17f2554643f0 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -724,19 +724,20 @@ print_ipc(const struct syscallname *name,
  * Variants for the return value output function
  */
 
-static void
+static bool
 print_syscall_err(abi_long ret)
 {
-    const char *errstr = NULL;
+    const char *errstr;
 
     qemu_log(" = ");
     if (ret < 0) {
-        qemu_log("-1 errno=%d", (int)-ret);
         errstr = target_strerror(-ret);
         if (errstr) {
-            qemu_log(" (%s)", errstr);
+            qemu_log("-1 errno=%d (%s)", (int)-ret, errstr);
+            return true;
         }
     }
+    return false;
 }
 
 static void
@@ -744,11 +745,10 @@ print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
                        abi_long arg0, abi_long arg1, abi_long arg2,
                        abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
-        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
+    if (!print_syscall_err(ret)) {
+        qemu_log("0x" TARGET_ABI_FMT_lx, ret);
     }
+    qemu_log("\n");
 }
 
 #if 0 /* currently unused */
@@ -765,9 +765,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
                             abi_long arg0, abi_long arg1, abi_long arg2,
                             abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
         print_fdset(arg0, arg1);
         qemu_log(",");
@@ -796,9 +794,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
                            abi_long arg0, abi_long arg1, abi_long arg2,
                            abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
@@ -833,9 +829,7 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
                             abi_long arg0, abi_long arg1, abi_long arg2,
                             abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         qemu_log(" (list = ");
         if (arg1 != 0) {
@@ -866,9 +860,7 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
                         abi_long arg0, abi_long arg1, abi_long arg2,
                         abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
 
         const IOCTLEntry *ie;
@@ -3189,9 +3181,7 @@ print_syscall_ret(int num, abi_long ret,
                                   arg1, arg2, arg3,
                                   arg4, arg5, arg6);
             } else {
-                print_syscall_err(ret);
-
-                if (ret >= 0) {
+                if (!print_syscall_err(ret)) {
                     qemu_log(TARGET_ABI_FMT_ld, ret);
                 }
                 qemu_log("\n");
-- 
2.26.2


