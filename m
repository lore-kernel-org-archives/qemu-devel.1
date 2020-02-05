Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E54C352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9014E21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CwoTmWI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9014E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM7W-0007GN-N6
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6Y-0005h7-TQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6X-00057A-Sp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izM6X-0004nC-Ja
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErMPV164944;
 Wed, 5 Feb 2020 14:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=944UcjO2I/pv72T/OAJrlXdTeg/JyrAktvdNeSTEef4=;
 b=CwoTmWI7SVEAmwTikutoZHcx2ZZJOkYiqwjRuxHr0ZX7BNzwvZNkOUFbP6Pg4/1gMtm8
 025FKLEuK0MsQx/5Tm5PCMJ6aZBBMHr9fJmAgW+6sCuS7Ai29WhINel+oIhE1HBwB2ve
 uagcPz9MZgmQUkQAk+ABMgdCOSU2iyQBobNvhfp2NeuOVMeShHxF/6u/HjmP/QivG5GJ
 mBNdYbFmkWszw2mdfEI5ndzNQ1Xb/ed9sxJuu9g/zosvz/SuqKRT/0VFoFs2hb7utLxr
 Eokj6+1L8itkasXIsr8q6GH9MsMP0CS2GCVQlL8TA8rA8q2bexbvPiN7QUetZ5ihk7/2 bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2xykbp3h99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015EsCEX158884;
 Wed, 5 Feb 2020 14:56:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2xykc31wtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015EuQeI029164;
 Wed, 5 Feb 2020 14:56:26 GMT
Received: from ol7.uk.oracle.com (/10.175.206.136)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 06:56:25 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: alex.bennee@linaro.org, fam@euphon.net, philmd@redhat.com
Subject: [PATCH v2 6/6] tests/boot_linux_console: use os.path for filesystem
 paths
Date: Wed,  5 Feb 2020 14:56:05 +0000
Message-Id: <1580914565-19675-7-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=618
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=688 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: slp@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 pbonzini@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change extract_from_deb() to use os.path routines to manipulate the
filesystem path returned when extracting a file.

Suggested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 tests/acceptance/boot_linux_console.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 9c55218cb5bb..434608f12027 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -49,7 +49,12 @@ class BootLinuxConsole(Test):
         process.run("ar x %s %s" % (deb, file_path))
         archive.extract(file_path, self.workdir)
         os.chdir(cwd)
-        return self.workdir + path
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_deb() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir,
+                                             os.path.relpath(path, '/')))
 
     def extract_from_rpm(self, rpm, path):
         """
-- 
1.8.3.1


