Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07423C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4DF21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4DF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp0w-0007xz-VY
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1izoxb-0002vk-Se
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1izoxZ-0007HY-Qm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1izoxZ-0007Dm-Fk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 016LicF4129010
 for <qemu-devel@nongnu.org>; Thu, 6 Feb 2020 16:45:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0mpnnsp3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:45:16 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Thu, 6 Feb 2020 21:45:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Feb 2020 21:45:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 016LjAZC66257012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 21:45:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC9AA52057;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 99B0B52054;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 169FFE027F; Thu,  6 Feb 2020 22:45:09 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: [RFC PATCH v2 5/7] vfio-ccw: Add support for the crw region
Date: Thu,  6 Feb 2020 22:45:07 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206214509.16434-1-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20020621-0016-0000-0000-000002E464CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020621-0017-0000-0000-000033474C4F
Message-Id: <20200206214509.16434-6-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=2 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060158
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

The crw region can be used to obtain information about
Channel Report Words (CRW) from vfio-ccw driver.

Currently only channel path related CRWs are passed to
QEMU from vfio-ccw driver.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v0->v1: [EF]
     - Fixed copy/paste error in error message (s/schib/CRW)

 hw/vfio/ccw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e31de3ffd7..d2408f3357 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -44,6 +44,9 @@ struct VFIOCCWDevice {
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
+    uint64_t crw_region_size;
+    uint64_t crw_region_offset;
+    struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -450,10 +453,24 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->schib_region = g_malloc(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_CRW, &info);
+
+    if (!ret) {
+        vcdev->crw_region_size = info->size;
+        if (sizeof(*vcdev->crw_region) != vcdev->crw_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the CRW region");
+            goto out_err;
+        }
+        vcdev->crw_region_offset = info->offset;
+        vcdev->crw_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -463,6 +480,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-- 
2.17.1


