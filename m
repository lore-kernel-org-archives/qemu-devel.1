Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5890C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F65208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRV0yCBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F65208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNEmm-0004Lu-QE
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 06:54:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNElw-00045K-Mj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNElv-00013d-Q9
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNElv-00012w-Fv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45AnOM8126153; Sun, 5 May 2019 10:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-transfer-encoding; 
	s=corp-2018-07-02; bh=/d2rAYGT3w3bvZy938iecFcqOY9ki9FWRk1WE9coh8o=;
	b=lRV0yCBgFXVLDDg1ClyVnVh8BDhFLvoYOwzyEWj8rkihdYnmv5iodGkFBsNGqMSmNCSm
	SIqDdBOs9QgchDWwGZR2/iT0S69qElWd56mhWkrF32e9DmmkiIWRv/dH9RAMmM9kOKyt
	e9cbRd++1ld67QllyWIg2oQAlGysR3Tl71o/OZ20iFpbf3rZkIl5g2EkqPvNqiAm5GOo
	WpCXm+rTajRLajExPRVmBSU1VRUmukOsI+5QZpIckBHOShoFZPmsutD63R1BTAoXxRXV
	sPAIalJnnAcLlwSMrvglUGfoQM4RzKcBOCUpRQBQDHCTybHAasz42+7d3E/kZwfTZg/s
	PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2s94bfjnr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:53:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45Ap6E0180174; Sun, 5 May 2019 10:51:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2s9aydy5g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:51:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x45ApP9t015232;
	Sun, 5 May 2019 10:51:25 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 05 May 2019 10:51:25 +0000
From: Yuval Shaia <yuval.shaia@oracle.com>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Date: Sun,  5 May 2019 13:51:12 +0300
Message-Id: <20190505105112.22691-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905050098
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905050098
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH] hw/rdma: Delete unused headers inclusion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190505105112.YMr50GicBgGEvzAcydlhPHUeWenA00je8dwK96pyNg0@z>

This is a trivial cleanup patch.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d1660b6474..05f6b03221 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -14,16 +14,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
 #include "qapi/qapi-events-rdma.h"
 
 #include <infiniband/verbs.h>
-#include <infiniband/umad_types.h>
-#include <infiniband/umad.h>
-#include <rdma/rdma_user_cm.h>
 
 #include "contrib/rdmacm-mux/rdmacm-mux.h"
 #include "trace.h"
-- 
2.20.1


