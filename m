Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002AEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B185821929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B185821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6Gj-0002UW-DR
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pm-0001XY-4R
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pk-0002Xl-3Z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38592
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pf-0002C5-Ns; Tue, 05 Nov 2019 15:53:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KqTkx100535; Tue, 5 Nov 2019 15:53:22 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3frwheb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:22 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5Knv3J006016;
 Tue, 5 Nov 2019 20:53:21 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 2w11e7hgex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:21 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrKom46268730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B84F124058;
 Tue,  5 Nov 2019 20:53:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78EA1124064;
 Tue,  5 Nov 2019 20:53:20 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:20 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/55] xen-bus: check whether the frontend is active during
 device reset...
Date: Tue,  5 Nov 2019 14:51:55 -0600
Message-Id: <20191105205243.3766-8-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Paul Durrant <paul.durrant@citrix.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <paul.durrant@citrix.com>

...not the backend

Commit cb323146 "xen-bus: Fix backend state transition on device reset"
contained a subtle mistake. The hunk

@@ -539,11 +556,11 @@ static void xen_device_backend_changed(void *opaque)

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

mistakenly replaced the check of 'xendev->frontend_state' with a check
(now in a helper function) of 'state', which actually equates to
'xendev->backend_state'.

This patch fixes the mistake.

Fixes: cb3231460747552d70af9d546dc53d8195bcb796
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190910171753.3775-1-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
(cherry picked from commit df6180bb56cd03949c2c64083da58755fed81a61)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/xen/xen-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 5929aa4b2e..10b7e02b5c 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -560,7 +560,7 @@ static void xen_device_backend_changed(void *opaque)
      * backend state to Closed.
      */
     if (xendev->backend_state == XenbusStateClosing &&
-        !xen_device_state_is_active(state)) {
+        !xen_device_state_is_active(xendev->frontend_state)) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
 
-- 
2.17.1


