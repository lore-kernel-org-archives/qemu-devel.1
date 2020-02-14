Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0D6C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F77724649
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F77724649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cXF-00021k-U8
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2cWY-0001Xo-8w
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2cWX-0007px-4C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2cWW-0007pQ-TE
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:04:57 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EF0WPH116208
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:04:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y3u53tadf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:02:59 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 14 Feb 2020 15:01:32 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:01:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01EF0Ywv49611196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:00:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E70111C052;
 Fri, 14 Feb 2020 15:01:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB5AA11C04C;
 Fri, 14 Feb 2020 15:01:28 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.71.236])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:01:28 +0000 (GMT)
Subject: [PATCH v2 2/2] spapr: Fix handling of unplugged devices during CAS
 and migration
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Feb 2020 16:01:28 +0100
In-Reply-To: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
References: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0012-0000-0000-00000386D649
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0013-0000-0000-000021C35D55
Message-Id: <158169248798.3465937.1108351365840514270.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1034 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140119
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already detect if a device is being hot plugged before CAS to trigger
a CAS reboot and during migration to migrate the state of the associated
DRC. But hot unplugging a device is also an asynchronous operation that
requires the guest to take action. This means that if the guest is migrated
after the hot unplug event was sent but before it could release the device
with RTAS, the destination QEMU doesn't know about the pending unplug
operation and doesn't actually remove the device when the guest finally
releases it.

Similarly, if the unplug request is fired before CAS, the guest isn't
notified of the change, just like with hotplug. It ends up booting with
the device still present in the DT and configures it, just like it was
never removed. Even weirder, since the event is still queued, it will
be eventually processed when some other unrelated event is posted to
the guest.

Enhance spapr_drc_transient() to also return true if an unplug request is
pending. This fixes the issue at CAS with a CAS reboot request and
causes the DRC state to be migrated. Some extra care is still needed to
inform the destination that an unplug request is pending : migrate the
unplug_requested field of the DRC in an optional subsection. This might
break backwards migration, but this is still better than ending with
an inconsistent guest.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 4c35ce7c5c37..e373d342eb84 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -456,6 +456,22 @@ void spapr_drc_reset(SpaprDrc *drc)
     }
 }
 
+static bool spapr_drc_unplug_requested_needed(void *opaque)
+{
+    return spapr_drc_unplug_requested(opaque);
+}
+
+static const VMStateDescription vmstate_spapr_drc_unplug_requested = {
+    .name = "spapr_drc/unplug_requested",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_drc_unplug_requested_needed,
+    .fields  = (VMStateField []) {
+        VMSTATE_BOOL(unplug_requested, SpaprDrc),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 bool spapr_drc_transient(SpaprDrc *drc)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -471,9 +487,10 @@ bool spapr_drc_transient(SpaprDrc *drc)
     /*
      * We need to reset the DRC at CAS or to migrate the DRC state if it's
      * not equal to the expected long-term state, which is the same as the
-     * coldplugged initial state.
+     * coldplugged initial state, or if an unplug request is pending.
      */
-    return (drc->state != drck->ready_state);
+    return drc->state != drck->ready_state ||
+        spapr_drc_unplug_requested(drc);
 }
 
 static bool spapr_drc_needed(void *opaque)
@@ -489,6 +506,10 @@ static const VMStateDescription vmstate_spapr_drc = {
     .fields  = (VMStateField []) {
         VMSTATE_UINT32(state, SpaprDrc),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_spapr_drc_unplug_requested,
+        NULL
     }
 };
 


