Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DCC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F7A208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F7A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j118a-00026C-PG
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 23:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1j1172-0008IB-M6
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1j1171-0002wx-2Z
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:56:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28152
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1j1170-0002vh-Sy
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:55:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01A4sI6w098939
 for <qemu-devel@nongnu.org>; Sun, 9 Feb 2020 23:55:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y1ufjxc7y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 23:55:58 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Mon, 10 Feb 2020 04:55:56 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Feb 2020 04:55:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01A4trdY38076774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2020 04:55:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AD33AE051;
 Mon, 10 Feb 2020 04:55:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67BBFAE045;
 Mon, 10 Feb 2020 04:55:52 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 10 Feb 2020 04:55:52 +0000 (GMT)
Subject: [PATCH v6 0/4] ppc: spapr: virtual NVDIMM support
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Sun, 09 Feb 2020 22:55:51 -0600
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021004-0016-0000-0000-000002E55593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021004-0017-0000-0000-000033484507
Message-Id: <158131055152.2897.1684848646085925139.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-09_08:2020-02-07,
 2020-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100039
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patchset attempts to implement the virtual NVDIMM for pseries.

PAPR semantics is such that each NVDIMM device is comprising of
multiple SCM(Storage Class Memory) blocks. The hypervisor is expected
to prepare the FDT for the NVDIMM device and send guest a hotplug
interrupt with new type RTAS_LOG_V6_HP_TYPE_PMEM currently handled by
the upstream kernel. In response to that interrupt, the guest requests
the hypervisor to bind each of the SCM blocks of the NVDIMM device
using hcalls. There can be SCM block unbind requests in case of driver
errors or unplug(not supported now) use cases. The NVDIMM label
read/writes are done through hcalls.

Since each virtual NVDIMM device is divided into multiple SCM blocks,
the bind, unbind, and queries using hcalls on those blocks can come
independently. This doesnt fit well into the qemu device semantics,
where the map/unmap are done at the (whole)device/object level
granularity. The patchset uses the existing NVDIMM class structures
for the implementation. The bind/unbind is left to happen at the
device_add/del phase itself instead of at hcalls on-demand.

The guest kernel makes bind/unbind requests for the virtual NVDIMM
device at the region level granularity. Without interleaving, each
virtual NVDIMM device is presented as separate region. Hence it is
safe to do bind/unbind everything during the object_add/del.

The free device-memory region which is used for memory hotplug are
done using multiple LMBs of size(256MiB) and are expected to be
aligned to 256 MiB. As the SCM blocks are mapped to the same region,
the SCM blocks also need to be aligned to this size for the subsequent
memory hotplug to work. The minimum SCM block size is set to this size
for that reason and can be made user configurable in future if required.

The first patch moves around the existing static function to common
area for using it in the subsequent patches. Second patch adds new uuid
property to the nvdimm device. Third patch adds FDT entries and basic
device support, the fourth patch adds the hcalls implementation.

The patches are also available at
https://github.com/ShivaprasadGBhat/qemu.git - pseries-nvdimm-v6 branch
and can be used with the upstream kernel. ndctl can be used for
configuring the nvdimms inside the guest.
This is how it can be used ..
Ex :
For coldplug, the device to be added in qemu command line as shown below
-object 
memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
-device 
nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add 
memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
device_add 
nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

---
v5: https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07472.html
Changes from v5:
     - Moved most of the nvdimm code from spapr.c to spapr_nvdimm.c
     - Addressed all style/logic comments.
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03455.html
Changes from v4:
     - The nvdimm occupied GPA area is marked as available for hotplug, the
       existing code takes care of if the dimm device is actually present there
       or used by nvdimm.
     - fixed all comments for hcall implementation code on style/logic issues.
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03452.html
Changes from v3:
     - Moved NVDIMM uuid property addition to new patch.
     - Moved the SCM hcalls to new file
     - Changed the metadata read/write hcalls to use st/ldX_be_p macros.
     - Fixed all comments on v3
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02785.html
Changes from v2:
     - Creating the drc indices for the nvdimm devices in advance as
       suggested based on the number of user specified max slots property.
     - Removed the hard dependency on -machine nvdimm=on, enabled by
       default on the current latest pseries machine version.
     - Renamed the functions to spapr_dt_X as suggested.
     - Metadata is byteswapped before read/write to take care of endianness
       semantics during the hcall.
v1 : http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01545.html
Changes from v1:
     - Rebased to upstream, this required required dt_populate implementation
       for nvdimm hotplug support
     - Added uuid option to nvdimm device
     - Removed the memory region sizing down code as suggested by Igor,
       now erroring out if NVDIMM size excluding the label area is not
       aligned to 256MB, so patch 2 from previous series no longer needed.
     - Removed un-implemented hcalls
     - Changed the hcalls to different kinds of checks and return
       different values.
     - Addressed comments for v1
---

Shivaprasad G Bhat (4):
      mem: move nvdimm_device_list to utilities
      nvdimm: add uuid property to nvdimm
      spapr: Add NVDIMM device support
      spapr: Add Hcalls to support PAPR NVDIMM device


 default-configs/ppc64-softmmu.mak |    1 
 hw/acpi/nvdimm.c                  |   28 --
 hw/mem/Kconfig                    |    2 
 hw/mem/nvdimm.c                   |   40 +++
 hw/ppc/Makefile.objs              |    2 
 hw/ppc/spapr.c                    |   69 +++++
 hw/ppc/spapr_drc.c                |   19 +
 hw/ppc/spapr_events.c             |    4 
 hw/ppc/spapr_nvdimm.c             |  475 +++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h           |    7 +
 include/hw/ppc/spapr.h            |    8 +
 include/hw/ppc/spapr_drc.h        |    9 +
 include/hw/ppc/spapr_nvdimm.h     |   37 +++
 include/qemu/nvdimm-utils.h       |    7 +
 util/Makefile.objs                |    1 
 util/nvdimm-utils.c               |   29 ++
 16 files changed, 699 insertions(+), 39 deletions(-)
 create mode 100644 hw/ppc/spapr_nvdimm.c
 create mode 100644 include/hw/ppc/spapr_nvdimm.h
 create mode 100644 include/qemu/nvdimm-utils.h
 create mode 100644 util/nvdimm-utils.c

--
Signature


