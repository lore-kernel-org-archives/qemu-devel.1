Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3926E2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vsmsNX9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3926E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRPi-0003kD-Ew
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR52-0003ci-VD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR51-0000uE-Uw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR51-0000s7-MJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnM3H189395;
 Thu, 12 Mar 2020 16:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=T6OnfM9mL8bKwZsAlqcLm3VW6a+DTWH7PmxEcV69qx8=;
 b=vsmsNX9eCAz28YML9diqq+Tv5+MaM2tpFOFHnnF9oX9cTwfcgrt0guAY23hHO+kEUjCw
 hdBXnUaOCyRRs05ZpgO0BlXnLuaKqIyp+U8KkGHov25PT75NSljWfjR4kP/fULPHf9vq
 wLDvB4DRr5uQ6mFRBKgb8JUm+yYatLmT8H0NHi0eTp8lHYH+O3cXrGTuB6TBan5+H7nh
 oBJpWZNs9MgIRx8Ri04AJs6Hplhy6/kYCkdzzkx3Ki9DVUg7e4wrnZjmSTRhBu1QjuJK
 RtCw6Me17ouD4t6Mzs3Icm2mpdptyx1d1dtNfC5+b7uqT/2Gizb3KGFrzGLJv8YVJ6kS 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yqkg8a04w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:53:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGofOF055780;
 Thu, 12 Mar 2020 16:53:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yqgvdb1cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:53:05 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGr4Cl001027;
 Thu, 12 Mar 2020 16:53:04 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:53:04 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/16] hw/i386/vmport: Assert vmport initialized before
 registering commands
Date: Thu, 12 Mar 2020 18:54:31 +0200
Message-Id: <20200312165431.82118-17-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmport_register() is also called from other modules such as vmmouse.
Therefore, these modules rely that vmport is realized before those call
sites. If this is violated, vmport_register() will NULL-deref.

To make such issues easier to debug, assert in vmport_register() that
vmport is already realized.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 9d3921cf418d..134d793a4c65 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -83,6 +83,8 @@ static VMPortState *port_state;
 void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque)
 {
     assert(command < VMPORT_ENTRIES);
+    assert(port_state);
+
     trace_vmport_register(command, func, opaque);
     port_state->func[command] = func;
     port_state->opaque[command] = opaque;
-- 
2.20.1


