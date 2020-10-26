Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B74C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B05620791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxSVDo5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B05620791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Z2-0006GO-Jc
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX5WJ-0003Ts-Q0; Mon, 26 Oct 2020 12:38:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX5WH-0002tu-0e; Mon, 26 Oct 2020 12:38:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09QGVvt5169333; Mon, 26 Oct 2020 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mdYqDhKT6bY1Mq1aEk6Cgpey4X5hSmJoAFAa8I+U4Sw=;
 b=hxSVDo5hvrTMILMPjffe+jclYfyBw/j62FR6x45GizdI9AXJABEAferr0K3EE9vGKTDW
 OfOK8Iustj8qPbT44nYGRUHCoq/NGOEqkOkAyTfu4OD4xuxxO6KUlFlk7Xx44uv5LKKP
 d2t+Dmqc9hpAr9FiRg6HsUaTSo9S7l2yVZu3EQCGnnSGuXAHmwbN5qby2u7JhmFxhylU
 qFK9PuF7/Xt76GdCIitGOWQtQhiVOH9t0Z3qwtMfhf/7S2SmaB56wIA+kTO8v7s19WBX
 kQ3fl66hqiVnuo4LtG/R76B1QDY0Ft9reOjSoPMp2lTiv03ekXnEGdaz/Ex/x0YcCohJ Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dp1qvhp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 12:38:50 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09QGZHHG182558;
 Mon, 26 Oct 2020 12:38:50 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dp1qvhnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 12:38:50 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QGbYVB027277;
 Mon, 26 Oct 2020 16:38:49 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 34cbw910we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 16:38:48 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09QGclRi39387646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 16:38:47 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87E36BE04F;
 Mon, 26 Oct 2020 16:38:47 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 249FDBE051;
 Mon, 26 Oct 2020 16:38:46 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.49.29])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2020 16:38:45 +0000 (GMT)
Subject: Re: [PATCH 00/13] s390x/pci: s390-pci updates for kernel 5.10-rc1
To: Cornelia Huck <cohuck@redhat.com>
References: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
 <20201026171947.0f302dcc.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <e319cda2-e061-947c-f2c8-1990db589096@linux.ibm.com>
Date: Mon, 26 Oct 2020 12:38:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026171947.0f302dcc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-26_08:2020-10-26,
 2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:35:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 12:19 PM, Cornelia Huck wrote:
> On Mon, 26 Oct 2020 11:34:28 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> Combined set of patches that exploit vfio/s390-pci features available in
>> kernel 5.10-rc1.  This patch set is a combination of
>>
>> [PATCH v4 0/5] s390x/pci: Accomodate vfio DMA limiting
>>
>> and
>>
>> [PATCH v3 00/10] Retrieve zPCI hardware information from VFIO
>>
>> with duplicate patches removed and a single header sync.  All patches have
>> prior maintainer reviews except for:
>>
>> - Patch 1 (update-linux-headers change to add new file)
> 
> That one has ;)
> 
>> - Patch 2 (header sync against 5.10-rc1)
> 
> I'm still unsure about the rdma/(q)atomic stuff -- had we reached any
> conclusion there?

Ugh, I forgot about this...  I had CC'd the associated maintainers a few 
times but never heard back from anyone on how to resolve this.

Paolo said previously this stuff should not have been imported by a 
header sync in the first place 
(https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00734.html), 
so I would guess that the proper fix is to stop importing the rdma stuff 
and (re)define it somewhere in QEMU.

We could just drop the rmda file hit from this sync, but it's going to 
keep happening until the code is removed from the kernel header.

> 
>> - Patch 13 - contains a functional (debug) change; I switched from using
>>    DPRINTFs to using trace events per Connie's request.
>>
>>
>>
>> Matthew Rosato (10):
>>    update-linux-headers: Add vfio_zdev.h
>>    linux-headers: update against 5.10-rc1
>>    s390x/pci: Move header files to include/hw/s390x
>>    vfio: Create shared routine for scanning info capabilities
>>    vfio: Find DMA available capability
>>    s390x/pci: Add routine to get the vfio dma available count
>>    s390x/pci: Honor DMA limits set by vfio
>>    s390x/pci: clean up s390 PCI groups
>>    vfio: Add routine for finding VFIO_DEVICE_GET_INFO capabilities
>>    s390x/pci: get zPCI function info from host
>>
>> Pierre Morel (3):
>>    s390x/pci: create a header dedicated to PCI CLP
>>    s390x/pci: use a PCI Group structure
>>    s390x/pci: use a PCI Function structure
>>
>>   MAINTAINERS                                        |   1 +
>>   hw/s390x/meson.build                               |   1 +
>>   hw/s390x/s390-pci-bus.c                            |  91 ++++++-
>>   hw/s390x/s390-pci-inst.c                           |  78 ++++--
>>   hw/s390x/s390-pci-vfio.c                           | 276 +++++++++++++++++++++
>>   hw/s390x/s390-virtio-ccw.c                         |   2 +-
>>   hw/s390x/trace-events                              |   6 +
>>   hw/vfio/common.c                                   |  62 ++++-
>>   {hw => include/hw}/s390x/s390-pci-bus.h            |  22 ++
>>   .../hw/s390x/s390-pci-clp.h                        | 123 +--------
>>   include/hw/s390x/s390-pci-inst.h                   | 119 +++++++++
>>   include/hw/s390x/s390-pci-vfio.h                   |  23 ++
>>   include/hw/vfio/vfio-common.h                      |   4 +
>>   .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h |  14 +-
>>   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |   2 +-
>>   include/standard-headers/linux/ethtool.h           |   2 +
>>   include/standard-headers/linux/fuse.h              |  50 +++-
>>   include/standard-headers/linux/input-event-codes.h |   4 +
>>   include/standard-headers/linux/pci_regs.h          |   6 +-
>>   include/standard-headers/linux/virtio_fs.h         |   3 +
>>   include/standard-headers/linux/virtio_gpu.h        |  19 ++
>>   include/standard-headers/linux/virtio_mmio.h       |  11 +
>>   include/standard-headers/linux/virtio_pci.h        |  11 +-
>>   linux-headers/asm-arm64/kvm.h                      |  25 ++
>>   linux-headers/asm-arm64/mman.h                     |   1 +
>>   linux-headers/asm-generic/hugetlb_encode.h         |   1 +
>>   linux-headers/asm-generic/unistd.h                 |  18 +-
>>   linux-headers/asm-mips/unistd_n32.h                |   1 +
>>   linux-headers/asm-mips/unistd_n64.h                |   1 +
>>   linux-headers/asm-mips/unistd_o32.h                |   1 +
>>   linux-headers/asm-powerpc/unistd_32.h              |   1 +
>>   linux-headers/asm-powerpc/unistd_64.h              |   1 +
>>   linux-headers/asm-s390/unistd_32.h                 |   1 +
>>   linux-headers/asm-s390/unistd_64.h                 |   1 +
>>   linux-headers/asm-x86/kvm.h                        |  20 ++
>>   linux-headers/asm-x86/unistd_32.h                  |   1 +
>>   linux-headers/asm-x86/unistd_64.h                  |   1 +
>>   linux-headers/asm-x86/unistd_x32.h                 |   1 +
>>   linux-headers/linux/kvm.h                          |  19 ++
>>   linux-headers/linux/mman.h                         |   1 +
>>   linux-headers/linux/vfio.h                         |  29 ++-
>>   linux-headers/linux/vfio_zdev.h                    |  78 ++++++
>>   scripts/update-linux-headers.sh                    |   2 +-
>>   43 files changed, 961 insertions(+), 173 deletions(-)
>>   create mode 100644 hw/s390x/s390-pci-vfio.c
>>   rename {hw => include/hw}/s390x/s390-pci-bus.h (94%)
>>   rename hw/s390x/s390-pci-inst.h => include/hw/s390x/s390-pci-clp.h (59%)
>>   create mode 100644 include/hw/s390x/s390-pci-inst.h
>>   create mode 100644 include/hw/s390x/s390-pci-vfio.h
>>   create mode 100644 linux-headers/linux/vfio_zdev.h
>>
> 


