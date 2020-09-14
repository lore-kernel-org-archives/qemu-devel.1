Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D0C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B51208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XLEWOVqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B51208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHx1r-000621-QV
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 18:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kHwym-0003cu-Iq; Mon, 14 Sep 2020 18:29:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57784
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kHwyi-0002rS-Qv; Mon, 14 Sep 2020 18:29:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08EM2DjO033141; Mon, 14 Sep 2020 18:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=cGZJ/0iytUlMfqDpbCgfHroWZdrcz/O3xfiX9pmXLSg=;
 b=XLEWOVqYybAE8Wy6cGIsvk0k3wHzKlZZu187C15W5SI9bdh0MXVuG797Xq6oVKMrmm1V
 xfdURWfPxespRZpppKBZe2nuvAa/Fw3yJh7XFFOr6LMI+jY2nbaFpqx4pS4xP+0GsmXs
 SdvGIa2YAhfPOacpme0zhTDfQTczF5OrdXtSuLlEfiDVZYr8Md/KvzPSd3EWWJptl4d/
 kb3OStdaJWZBmr6tLvVnfcVVfv4BotZsq6I/OTUl6RFvDgGPD6Qb1+GeB0Q+nML5G9vK
 nxIR14Gffz6Y2VCe262dLVGc63nwPzh2lV7bJ99ry0ik1bpceDyXDd3oiYZb/pPBg3GQ gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jgp1h1cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 18:29:38 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EM2TPK034842;
 Mon, 14 Sep 2020 18:29:37 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jgp1h1ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 18:29:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EMQSS6016085;
 Mon, 14 Sep 2020 22:29:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 33gny8yse6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 22:29:37 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08EMTZxI66453806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 22:29:35 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72CF1BE04F;
 Mon, 14 Sep 2020 22:29:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5372ABE051;
 Mon, 14 Sep 2020 22:29:34 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 22:29:34 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH v2 0/3] s390x/pci: Accomodate vfio DMA limiting
Date: Mon, 14 Sep 2020 18:29:27 -0400
Message-Id: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-14_09:2020-09-14,
 2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140166
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 18:29:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kernel commit 492855939bdb added a limit to the number of outstanding DMA
requests for a type1 vfio container.  However, lazy unmapping in s390 can 
in fact cause quite a large number of outstanding DMA requests to build up
prior to being purged, potentially the entire guest DMA space.  This
results in unexpected 'VFIO_MAP_DMA failed: No space left on device'
conditions seen in QEMU.

This patchset adds support to qemu to retrieve the number of allowable DMA
requests via the VFIO_IOMMU_GET_INFO ioctl.  The patches are separated into
vfio hits which add support for reading in VFIO_IOMMU_GET_INFO capability
chains and getting the per-container dma_avail value, and s390 hits to 
track DMA usage on a per-container basis.

Associated kernel patch:
https://marc.info/?l=kvm&m=160012235303068&w=2

Changes from v2:
- Renamed references of dma_limit to dma_avail based on kernel change as
  the ioctl now reports the amount currently available vs the supposed
  limit.
- Because the ioctl now provides a 'living value' vs the limit, it doesn't
  seem appropriate to put it in the VFIOConatiner structure without
  doing the dma_avail tracking there.  So patch 1 shrinks to vfio helper
  routines to find the capability and leaves vfio_connect_container alone. 
- Subsequently, in patch 2 s390-pci issues its own VFIO_IOMMU_GET_INFO to
  read the dma_avail value and use it.

Matthew Rosato (3):
  vfio: Find DMA available capability
  s390x/pci: Honor DMA limits set by vfio
  vfio: Create shared routine for scanning info capabilities

 hw/s390x/s390-pci-bus.c       | 99 ++++++++++++++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-bus.h       |  9 ++++
 hw/s390x/s390-pci-inst.c      | 29 ++++++++++---
 hw/s390x/s390-pci-inst.h      |  3 ++
 hw/vfio/common.c              | 50 ++++++++++++++++++----
 include/hw/vfio/vfio-common.h |  2 +
 6 files changed, 173 insertions(+), 19 deletions(-)

-- 
1.8.3.1


