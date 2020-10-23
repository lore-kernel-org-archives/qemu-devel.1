Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60281C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591F120882
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/02+aEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591F120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3RB-0002YR-A1
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3LC-0004o4-Kd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3LA-0003jf-O7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK2K1V089487; Fri, 23 Oct 2020 16:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lH1vjam/uAwj77DuuJwX4duoeCbG9KbpZcBIQApIcck=;
 b=m/02+aEovCXl2AejaUP54JsKoFieGN6CyPiX7RgD4JkLjhT1QyxjPRPihrZ3ca6hFFK8
 XDno7annpEQAbkN+6YHCmRfNLuDxOBD9M1Zj5RQJawBpJN9mYDFlNi/ENKQWDfmT5eao
 TVOa+2sXIVzA0VvPANv2Psnp/S+NJ21c70PA5K6szQkdorkLAU9WBifCO3L28s+fFxle
 q0VfGt6mByXZIBk66EA9jWCzpDs9NAgz8MWfgggP12K6KlWs6t0VvzJ60PxCXUWMOy+h
 zPuo80Y2rf6f8xP7aHukxUob5Sgfrak3WBytW6AMTj1k4hoiTg9r+NunoMSSYNDw0sVa 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34bm6wbssq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:07 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK2Rfh089914;
 Fri, 23 Oct 2020 16:07:06 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34bm6wbsse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NJwATk003078;
 Fri, 23 Oct 2020 20:07:06 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 347r8a7wjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:07:05 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK6xJd24838414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:06:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABD8F6A04D;
 Fri, 23 Oct 2020 20:07:04 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01A256A047;
 Fri, 23 Oct 2020 20:07:04 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:07:03 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] check-block: enable iotests with cfi-icall
Date: Fri, 23 Oct 2020 16:06:43 -0400
Message-Id: <20201023200645.1055-6-dbuono@linux.vnet.ibm.com>
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
 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=626 mlxscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=1 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230119
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:06:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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


