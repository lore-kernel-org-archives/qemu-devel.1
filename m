Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB12C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B25D206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oz9/dR1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B25D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kanfv-0003t4-VX
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbe-0007HY-K4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbc-00042i-29
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:46 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M38DF097775
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lH1vjam/uAwj77DuuJwX4duoeCbG9KbpZcBIQApIcck=;
 b=Oz9/dR1gQH5T552h3bP3V2RvlUSj5y/yyxm6e17Qx/b0Q9NgKTGQQia7I2H6QeqjUJWf
 Ko2juqViwwSI6ODdKCms8PqN/znurn3jfUCRKqI9IbmbHSJRllxzT78Cn5s4YYyv4GQw
 IElYCEzx86pHhRPZrVMLQcWxo/4FFluJjpNYyaTIr6KT6fG9zBntRiZs/YEg3R5/FF10
 DtafQ+swLQmfqnbO2fKbwQQbyhv9An6H6jjFmlw35npsgIDuE/UZEFZPkD3VuQUxHgjK
 x2NiTE/JteCj/G2Crl+crpmzne1eOADBt8ZWpguumXguGOfdm6TgpLgIqfgQJ2rtBRp3 MA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m7re72pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 17:19:42 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M3AAw097860
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:42 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m7re72p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:42 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MC2jC017652;
 Thu, 5 Nov 2020 22:19:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 34h0s801v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:41 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJV5l8192366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:31 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4F1D6A047;
 Thu,  5 Nov 2020 22:19:39 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62A486A04F;
 Thu,  5 Nov 2020 22:19:39 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:39 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] check-block: enable iotests with cfi-icall
Date: Thu,  5 Nov 2020 17:19:04 -0500
Message-Id: <20201105221905.1350-9-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=676 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cfi-icall is a form of Control-Flow Integrity for indirect function
calls implemented by llvm. It is enabled with a -fsanitize flag.

iotests are currently disabled when -fsanitize options is used, with the
exception of SafeStack.

This patch implements a generic filtering mechanism to allow iotests
with a set of known-to-be-safe -fsanitize option. Then marks SafeStack
and the new options used for cfi-icall safe for iotests

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 tests/check-block.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index f6b1bda7b9..fb4c1baae9 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -21,14 +21,18 @@ if grep -q "CONFIG_GPROF=y" config-host.mak 2>/dev/null ; then
     exit 0
 fi
 
-# Disable tests with any sanitizer except for SafeStack
-CFLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
-SANITIZE_FLAGS=""
-#Remove all occurrencies of -fsanitize=safe-stack
-for i in ${CFLAGS}; do
-        if [ "${i}" != "-fsanitize=safe-stack" ]; then
-                SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
+# Disable tests with any sanitizer except for specific ones
+SANITIZE_FLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
+ALLOWED_SANITIZE_FLAGS="safe-stack cfi-icall"
+#Remove all occurrencies of allowed Sanitize flags
+for j in ${ALLOWED_SANITIZE_FLAGS}; do
+    TMP_FLAGS=${SANITIZE_FLAGS}
+    SANITIZE_FLAGS=""
+    for i in ${TMP_FLAGS}; do
+        if ! echo ${i} | grep -q "${j}" 2>/dev/null; then
+            SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
         fi
+    done
 done
 if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
     # Have a sanitize flag that is not allowed, stop
-- 
2.17.1


