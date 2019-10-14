Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2982C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5AD20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5AD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5Ee-0000lA-U6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5Dt-00005o-Dz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5Ds-0003aZ-0v
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:37:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52954
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1iK5Dr-0003a3-Sy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:37:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9EIHu1X052190
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:37:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vmvajms6u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:37:31 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Mon, 14 Oct 2019 19:37:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Oct 2019 19:37:27 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9EIbQHe48562418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2019 18:37:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 542A1A405F;
 Mon, 14 Oct 2019 18:37:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F8BDA4054;
 Mon, 14 Oct 2019 18:37:25 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2019 18:37:25 +0000 (GMT)
Subject: [PATCH v3 0/3] ppc: spapr: virtual NVDIMM support
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 14 Oct 2019 13:37:24 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101418-0020-0000-0000-0000037901AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101418-0021-0000-0000-000021CF1BBF
Message-Id: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-14_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140150
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
Cc: sbhat@linux.vnet.ibm.com, qemu-devel@nongnu.org
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
virtual NVDIMM device is presented as separate region. There is no
way to configure the virtual NVDIMM interleaving for the guests today.
So, there is no way a partial bind/unbind request can come for the
vNVDIMM in a hcall for a subset of SCM blocks of a virtual NVDIMM.
Hence it is safe to do bind/unbind everything during the object_add/del.

The free device-memory region which is used for memory hotplug are
done using multiple LMBs of size(256MiB) and are expected to be
aligned to 256 MiB. As the SCM blocks are mapped to the same region,
the SCM blocks also need to be aligned to this size for the subsequent
memory hotplug to work. The minimum SCM block size is set to this size
for that reason and can be made user configurable in future if required.

The first patch moves around the existing static function to common
area for using it in the subsequent patches. Second patch adds the
FDT entries and basic device support, the third patch adds the hcalls
implementation.

The patches are also available at
https://github.com/ShivaprasadGBhat/qemu.git - pseries-nvdimm-v3 branch
and can be used with the upstream kernel. ndctl can be used for
configuring the nvdimms inside the guest.
This is how it can be used ..
Ex :
For coldplug, the device to be added in qemu command line as shown below
-object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
-device nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
device_add nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

---
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

Shivaprasad G Bhat (3):
      mem: move nvdimm_device_list to utilities
      spapr: Add NVDIMM device support
      spapr: Add Hcalls to support PAPR NVDIMM device


 default-configs/ppc64-softmmu.mak |    1 
 hw/acpi/nvdimm.c                  |   28 ---
 hw/mem/Kconfig                    |    2 
 hw/mem/nvdimm.c                   |   40 +++++
 hw/ppc/spapr.c                    |  218 +++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c                |   18 ++
 hw/ppc/spapr_events.c             |    4 
 hw/ppc/spapr_hcall.c              |  300 +++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h           |    7 +
 include/hw/ppc/spapr.h            |   19 ++
 include/hw/ppc/spapr_drc.h        |    9 +
 include/qemu/nvdimm-utils.h       |    7 +
 util/Makefile.objs                |    1 
 util/nvdimm-utils.c               |   29 ++++
 14 files changed, 638 insertions(+), 45 deletions(-)
 create mode 100644 include/qemu/nvdimm-utils.h
 create mode 100644 util/nvdimm-utils.c

--
Signature


