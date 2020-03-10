Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0DFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B8A20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZziFfvhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B8A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi9i-0003f2-Cn
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi72-0007HY-2E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi71-0008Fq-0M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi70-0008CU-P2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGchjQ085365;
 Tue, 10 Mar 2020 16:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=JVq0kbYvEA5Tt3sWhXqA9LBeHXTQ571xOUNlOccljG4=;
 b=ZziFfvhxND95JtTGdq8yX/hsdIV3V5qUgtGaoSiCREAEA5uRUkjmreOiVIPLvJBBv63O
 uNptJ7cX/eWLk1jJ+7PV1ZhQ+AsKF8YTHiVhQ78ruMiewM3BzmPq/3ttdSMOSUr+ajUE
 3TkcYs3xiWqAcfVl3pmbgQMULCkcRN8+SOKOJFtU6gqHvIMTGM2BoiK9iNTo6kdIE0Zn
 gXC0INkMGYD85vzL2I8CyJgDdu+ZewdYgTLYleRiWf83uKcYCV2BupsfryCkNe7VR4Ff
 OH0nG8YJe8FLhROB30Qqcq5Gbe3s8hJ/KOA9psh919kX0eRDh7WD1r8JoAzvuCwvvBSh xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ym31uetjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbavJ030383;
 Tue, 10 Mar 2020 16:52:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yp8rjyjug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGq7BI030974;
 Tue, 10 Mar 2020 16:52:07 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:52:07 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] hw/i386/vmport: Assert vmport initialized before
 registering commands
Date: Tue, 10 Mar 2020 18:53:32 +0200
Message-Id: <20200310165332.140774-17-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 nikita.leshchenko@oracle.com, rth@twiddle.net
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
index 76fd49c52058..8d3d268bfd7e 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -72,6 +72,8 @@ static VMPortState *port_state;
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


