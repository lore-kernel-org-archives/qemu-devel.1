Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDD52086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDD52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTz1-0008Hm-LZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsp-0002E9-4n
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsi-0002vs-ES
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsO-0001zF-HH; Tue, 01 Oct 2019 19:48:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlQrj107943; Tue, 1 Oct 2019 19:47:54 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcgaurpb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkKH027153;
 Tue, 1 Oct 2019 23:47:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:53 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlqXn36831542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:52 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C54C28058;
 Tue,  1 Oct 2019 23:47:52 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7033E28059;
 Tue,  1 Oct 2019 23:47:52 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:52 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/97] xen-bus: Fix backend state transition on device reset
Date: Tue,  1 Oct 2019 18:45:53 -0500
Message-Id: <20191001234616.7825-75-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthony PERARD <anthony.perard@citrix.com>

When a frontend wants to reset its state and the backend one, it
starts with setting "Closing", then waits for the backend (QEMU) to do
the same.

But when QEMU is setting "Closing" to its state, it triggers an event
(xenstore watch) that re-execute xen_device_backend_changed() and set
the backend state to "Closed". QEMU should wait for the frontend to
set "Closed" before doing the same.

Before setting "Closed" to the backend_state, we are also going to
check if there is a frontend. If that the case, when the backend state
is set to "Closing" the frontend should react and sets its state to
"Closing" then "Closed". The backend should wait for that to happen.

Fixes: b6af8926fb858c4f1426e5acb2cfc1f0580ec98a
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190823101534.465-2-anthony.perard@citrix.com>
(cherry picked from commit cb3231460747552d70af9d546dc53d8195bcb796)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/xen/xen-bus.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 49a725e8c7..0a1033d9a9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -515,6 +515,23 @@ static void xen_device_backend_set_online(XenDevice *xendev, bool online)
     xen_device_backend_printf(xendev, "online", "%u", online);
 }
 
+/*
+ * Tell from the state whether the frontend is likely alive,
+ * i.e. it will react to a change of state of the backend.
+ */
+static bool xen_device_state_is_active(enum xenbus_state state)
+{
+    switch (state) {
+    case XenbusStateInitWait:
+    case XenbusStateInitialised:
+    case XenbusStateConnected:
+    case XenbusStateClosing:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static void xen_device_backend_changed(void *opaque)
 {
     XenDevice *xendev = opaque;
@@ -538,11 +555,11 @@ static void xen_device_backend_changed(void *opaque)
 
     /*
      * If the toolstack (or unplug request callback) has set the backend
-     * state to Closing, but there is no active frontend (i.e. the
-     * state is not Connected) then set the backend state to Closed.
+     * state to Closing, but there is no active frontend then set the
+     * backend state to Closed.
      */
     if (xendev->backend_state == XenbusStateClosing &&
-        xendev->frontend_state != XenbusStateConnected) {
+        !xen_device_state_is_active(state)) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
 
-- 
2.17.1


