Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D914ECA9EB7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18AC21920
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18AC21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIIW-0006sf-42
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNI0B-0000qu-0y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNI09-0004Ok-1e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNI08-0004JJ-BS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9NEiuZo063546
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vtqypaw5k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:33 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 23 Oct 2019 15:52:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 15:52:28 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9NEqRtq58523898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 14:52:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2DB74C058;
 Wed, 23 Oct 2019 14:52:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A422D4C04A;
 Wed, 23 Oct 2019 14:52:27 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2019 14:52:27 +0000 (GMT)
Subject: [PATCH 6/6] xive: Don't use CPU_FOREACH() to perform CAM line matching
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Oct 2019 16:52:27 +0200
In-Reply-To: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102314-4275-0000-0000-00000376343F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102314-4276-0000-0000-000038895BE9
Message-Id: <157184234731.3053790.18369348907304339634.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230148
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the TCTX objects are children of the XIVE router, stop
using CPU_FOREACH() when looking for a matching VCPU target.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |  100 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 40ce43152456..ec5e7d0ee39a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1403,55 +1403,79 @@ typedef struct XiveTCTXMatch {
     uint8_t ring;
 } XiveTCTXMatch;
 
-static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
-                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                 bool cam_ignore, uint8_t priority,
-                                 uint32_t logic_serv, XiveTCTXMatch *match)
+typedef struct XivePresenterMatch {
+    uint8_t format;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool cam_ignore;
+    uint8_t priority;
+    uint32_t logic_serv;
+    XiveTCTXMatch *match;
+    int count;
+} XivePresenterMatch;
+
+static int do_xive_presenter_match(Object *child, void *opaque)
 {
-    CPUState *cs;
+    XiveTCTX *tctx = XIVE_TCTX(child);
+    XivePresenterMatch *xpm = opaque;
+    int ring;
 
     /*
      * TODO (PowerNV): handle chip_id overwrite of block field for
      * hardwired CAM compares
      */
 
-    CPU_FOREACH(cs) {
-        XiveTCTX *tctx = xive_router_get_tctx(xrtr, cs);
-        int ring;
+    /*
+     * HW checks that the CPU is enabled in the Physical Thread
+     * Enable Register (PTER).
+     */
 
-        /*
-         * Skip partially initialized vCPUs. This can happen when
-         * vCPUs are hotplugged.
-         */
-        if (!tctx) {
-            continue;
+    /*
+     * Check the thread context CAM lines and record matches. We
+     * will handle CPU exception delivery later
+     */
+    ring = xive_presenter_tctx_match(tctx, xpm->format, xpm->nvt_blk,
+                                     xpm->nvt_idx, xpm->cam_ignore,
+                                     xpm->logic_serv);
+
+    /*
+     * Save the context and follow on to catch duplicates, that we
+     * don't support yet.
+     */
+    if (ring != -1) {
+        if (xpm->match->tctx) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thread "
+                          "context NVT %x/%x\n", xpm->nvt_blk, xpm->nvt_idx);
+            return -1;
         }
 
-        /*
-         * HW checks that the CPU is enabled in the Physical Thread
-         * Enable Register (PTER).
-         */
+        xpm->match->ring = ring;
+        xpm->match->tctx = tctx;
+        xpm->count++;
+    }
 
-        /*
-         * Check the thread context CAM lines and record matches. We
-         * will handle CPU exception delivery later
-         */
-        ring = xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_idx,
-                                         cam_ignore, logic_serv);
-        /*
-         * Save the context and follow on to catch duplicates, that we
-         * don't support yet.
-         */
-        if (ring != -1) {
-            if (match->tctx) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thread "
-                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
-                return false;
-            }
-
-            match->ring = ring;
-            match->tctx = tctx;
-        }
+    return 0;
+}
+
+static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool cam_ignore, uint8_t priority,
+                                 uint32_t logic_serv, XiveTCTXMatch *match)
+{
+    XivePresenterMatch xpm = {
+        .format     = format,
+        .nvt_blk    = nvt_blk,
+        .nvt_idx    = nvt_idx,
+        .cam_ignore = cam_ignore,
+        .priority   = priority,
+        .logic_serv = logic_serv,
+        .match      = match,
+        .count      = 0,
+    };
+
+    if (object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
+                                  do_xive_presenter_match, &xpm) < 0) {
+        return false;
     }
 
     if (!match->tctx) {


