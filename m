Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A1C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FE520760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMBl5qJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEnz-00048j-6Q
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEjk-0007dA-Qv; Wed, 07 Oct 2020 15:04:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25726
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEjg-0004bL-Tx; Wed, 07 Oct 2020 15:04:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 097J2fIA010981; Wed, 7 Oct 2020 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=UOaDIPUYd9d53EGnjMoc+nuXYhpqeBpClS36ypy/+fw=;
 b=gMBl5qJt2Ds3APOZasJVONoTVGQLqmlRLIlVRE3GluZuINe0PIn29VOPfpX+MMXTL+Vr
 QN1HcpEY+XRsVQBA35CfbAjYIDuH+6CLE50V/r6Sh/j+L6XSzHDxUaA0GXpfRH4kmCzq
 2QNtgaLBteMj7b8KgfjvjySiiEqaAN90troGiUpwHuSuiHrtbdmHzpekFXdc2Lj5FBoq
 vRaEo4UqAue3x3A0W96WbvhiQdeTbYno8+962UqiHSWyqkiHtff9ns46HT7SUmL7q9ax
 lT/U0CpyurVovF4xQ9p9r0yh9jalhOKUvTuERbAT4o/lW8Xgu0G3alLh4JZHmMDD5CKn VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341k938be1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:21 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097J3QdM014045;
 Wed, 7 Oct 2020 15:04:21 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341k938bdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:21 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097IkpgP005207;
 Wed, 7 Oct 2020 19:04:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01wdc.us.ibm.com with ESMTP id 33xgx99a45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 19:04:20 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 097J4Jcb52232498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2020 19:04:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB2C7AC060;
 Wed,  7 Oct 2020 19:04:19 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B99F3AC05B;
 Wed,  7 Oct 2020 19:04:17 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.60.106])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2020 19:04:17 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH v3 00/10] Retrieve zPCI hardware information from VFIO
Date: Wed,  7 Oct 2020 15:04:05 -0400
Message-Id: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_10:2020-10-07,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070118
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:04:22
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
Cc: kvm@vger.kernel.org, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset adds code to s390 pci to examine the VFIO_DEVICE_GET_INFO 
capability chain, looking for capabilities that describe the underlying
hardware and features of the passed-through device.

The retrieval of this information is done once per function (and for a
subset of data, once per function group) and is performed at time of device
plug.  Some elements provided via the capability chain must still be forced
to default values for now to reflect what QEMU actually provides support
for.

The original work for this feature was done by Pierre Morel.

Associated kernel patchset:
https://lkml.org/lkml/2020/10/7/813

Tested using a host kernel with/without the VFIO_DEVICE_GET_INFO changes
and a QEMU with/without the VFIO_DEVICE_GET_INFO changes to validate
VFIO_DEVICE_GET_INFO remains backwards-compatible.


Changes since v2:
- Added ACKs/RBs (thanks!)
- Squashed the first 2 patches, and tried again using by formatting the 
  set with --find-renames / diff.renames.  (Thanks Richard and Paolo!)
  As before, this first patch can be applied separately but is included
  here for the sake of simplicity.
- Copied patch 'vfio: Create shared routine for scanning info capabilities'
  from the 'Accomodate vfio DMA limiting' set, as it's now needed here too.
  We can drop it from this set later once the former is applied.
- Refresh the linux-header placeholder.  Manually omit the qatomic->atomic
  pvrdma revert for now.
- New patch to add a helper function for finding VFIO_DEVICE_GET_INFO
  capabilities.  Depends on 'vfio: Create shared routine for scanning info
  capabilities'
- re-write the last patch to use VFIO_DEVICE_GET_INFO capabilities instead
  of a vfio device region

Matthew Rosato (7):
  s390x/pci: Move header files to include/hw/s390x
  vfio: Create shared routine for scanning info capabilities
  update-linux-headers: Add vfio_zdev.h
  linux-headers: update against 5.9-rc8
  s390x/pci: clean up s390 PCI groups
  vfio: Add routine for finding VFIO_DEVICE_GET_INFO capabilities
  s390x/pci: get zPCI function info from host

Pierre Morel (3):
  s390x/pci: create a header dedicated to PCI CLP
  s390x/pci: use a PCI Group structure
  s390x/pci: use a PCI Function structure

 MAINTAINERS                                        |   1 +
 hw/s390x/meson.build                               |   1 +
 hw/s390x/s390-pci-bus.c                            |  86 ++++++++-
 hw/s390x/s390-pci-inst.c                           |  33 ++--
 hw/s390x/s390-pci-vfio.c                           | 197 +++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c                         |   2 +-
 hw/vfio/common.c                                   |  31 +++-
 {hw => include/hw}/s390x/s390-pci-bus.h            |  13 ++
 .../hw/s390x/s390-pci-clp.h                        | 123 ++-----------
 include/hw/s390x/s390-pci-inst.h                   | 116 ++++++++++++
 include/hw/s390x/s390-pci-vfio.h                   |  19 ++
 include/hw/vfio/vfio-common.h                      |   2 +
 linux-headers/linux/kvm.h                          |   6 +-
 linux-headers/linux/vfio.h                         |  11 ++
 linux-headers/linux/vfio_zdev.h                    |  78 ++++++++
 scripts/update-linux-headers.sh                    |   2 +-
 16 files changed, 575 insertions(+), 146 deletions(-)
 create mode 100644 hw/s390x/s390-pci-vfio.c
 rename {hw => include/hw}/s390x/s390-pci-bus.h (96%)
 rename hw/s390x/s390-pci-inst.h => include/hw/s390x/s390-pci-clp.h (59%)
 create mode 100644 include/hw/s390x/s390-pci-inst.h
 create mode 100644 include/hw/s390x/s390-pci-vfio.h
 create mode 100644 linux-headers/linux/vfio_zdev.h

-- 
1.8.3.1


