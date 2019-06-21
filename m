Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE3BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40329208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Wuu7xjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40329208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heRXK-00014k-VY
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 17:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heRFj-0003wS-5z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heRFi-0003Iy-7n
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:39:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heRFh-0003IO-V1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:39:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLd9os171477;
 Fri, 21 Jun 2019 21:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=hjpzk+u9EvxnXtiAAqBD1jfdWQnXFOkL4pTJ5dszO5M=;
 b=1Wuu7xjQV3r/9VMHLByidZmyZ0bQnZ1CUZ1GF7rg/oZ2VsO8UEdrroP072jfCTWH1kGq
 uP/YucgnqQBC7UjxobCcN5KYzc+1e/vz0+H6o5XdOHUE5gdc/pp1jln2DLKLIxZAbZTH
 /N526jtwwwbEqJdRvqiytHuaouJTAE6SgFCljRPmQU32sDY5MDZBpIm/B/CctTVyWG1+
 ES2ArDZEVezKrc7MpbEHV+VQeh4ngHePesec/xC1UDqeXxPDAaRErtJiYvj01qvuTeMx
 MBm6b8RQcVfnzB4t7SzonNaQpEo9nLBsxlvq986E0CqritMGkepZWAFcBsnTPzENfa2c yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t7809rfkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 21:39:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLbFH0064966;
 Fri, 21 Jun 2019 21:37:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t77ypdmcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 21:37:20 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LLbJu1019246;
 Fri, 21 Jun 2019 21:37:19 GMT
Received: from Lirans-MBP.Home (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 14:37:19 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Sat, 22 Jun 2019 00:37:10 +0300
Message-Id: <20190621213712.16222-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210165
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of AMD SVM
 in nested migration
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, maran.wilson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This patch series aims to fix the recent patch-series that was just merged to
upstream QEMU master branch which adds support for nested migration.

The already merged patch-series was modified during merge to allow migration of vCPU
exposed with SVM even though kernel does not support save/restore of required nested state.
This was done because of considering backwards-compatability.

However, during discussion made after merge, it was realised that since QEMU commit
75d373ef9729 ("target-i386: Disable SVM by default in KVM mode"), an AMD vCPU that
is virtualized by KVM doesn't expose SVM by default, even if you use "-cpu host".
Therefore, it is unlikely that vCPU expose SVM CPUID flag when user is not running
an SVM workload inside guest.

Therefore, this patch series change code back to original intent to block migration
in case of vCPU exposed with SVM if kernel does not support required capabilities
tos ave/restore nested-state.

Regards,
-Liran


