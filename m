Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA975C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E55D247C5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TWglWBv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55D247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnLp-0003ZB-3C
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kXnGQ-0004VD-Ra
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kXnGN-0006iL-A0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:26 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09SF2d8c165046; Wed, 28 Oct 2020 11:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IXjdoRI80trmiDqhtIzu5GcLNGrkytTBYC6o9lPqCqw=;
 b=TWglWBv996cZPqlNb3rpjCoXa+p114QmnifLp67EthCSedacDvGT3hRpNX6P+MLZ75eQ
 bMqaxy92s2+TuJGfeB4sy0S1sJKcJMukMp9ecGAUUCbQyIiJm4pQSg2dSHkh6FsInT/A
 XURGHnYfJWmMfcO5UQw4ew2nVln3ckp7wex3xDgXh4HYZnsFN3IRkbJmnJRDIThkj7SL
 W3qOViIMi6GGaj1/TcrYeCUoVhyTGC3m+1hLmx15fWJaj48hnwto4cygAJZ3xdb3/gfN
 bESZ5vAoRwrV4A5kj/cnr7mFev6C1em8byUoidXNROzQpuLEDwot0n8X9oMtULWBGGsD Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqfmuk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 11:21:01 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09SF2rZh165436;
 Wed, 28 Oct 2020 11:20:53 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqfmuea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 11:20:53 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SF9jUZ013898;
 Wed, 28 Oct 2020 15:20:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01wdc.us.ibm.com with ESMTP id 34cbw90rh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 15:20:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09SFKXnT23724296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2020 15:20:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0486D7805E;
 Wed, 28 Oct 2020 15:20:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8950C78069;
 Wed, 28 Oct 2020 15:20:37 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.49.29])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2020 15:20:37 +0000 (GMT)
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA9pgxKY7Q8bHRR0MXvYkWAWjakJS=uo4V_Bs14zLLc-Jw@mail.gmail.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <ad19996f-b2fc-c8aa-2bc4-40b5b0cfb91c@linux.ibm.com>
Date: Wed, 28 Oct 2020 11:20:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pgxKY7Q8bHRR0MXvYkWAWjakJS=uo4V_Bs14zLLc-Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-28_07:2020-10-28,
 2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280102
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 11:21:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Neo Jia <cjia@nvidia.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 11:07 AM, Peter Maydell wrote:
> On Mon, 26 Oct 2020 at 19:39, Alex Williamson
> <alex.williamson@redhat.com> wrote:
>>
>> The following changes since commit a5fac424c76d6401ecde4ecb7d846e656d0d6e89:
>>
>>    Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pull-request' into staging (2020-10-26 10:33:59 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201026.0
>>
>> for you to fetch changes up to 5219bf8e0fa86573427aa8812bbfe93d83c3d664:
>>
>>    vfio: fix incorrect print type (2020-10-26 12:07:46 -0600)
>>
>> ----------------------------------------------------------------
>> VFIO update 2020-10-26
>>
>>   * Migration support (Kirti Wankhede)
>>   * s390 DMA limiting (Matthew Rosato)
>>   * zPCI hardware info (Matthew Rosato)
>>   * Lock guard (Amey Narkhede)
>>   * Print fixes (Zhengui li)
>>
> 
> I retried the merge of this after the revert from Max, and it
> no longer gives merge conflicts, but it has compile errors:
> 
> On FreeBSD, OpenBSD, NetBSD, OSX and Windows:
> 
> In file included from ../src/hw/arm/sysbus-fdt.c:35:
> In file included from
> /usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-platform.h:20:
> /usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-common.h:201:37:
> warning: declaration of 'struct vfio_iommu_type1_info' will not be
> visible outside of this function [-Wvisibility]
> bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>                                      ^

Alex, for this one I think the definition of
bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
                              unsigned int *avail);

in vfio-common.h needs to be behind the #ifdef CONFIG_LINUX as that's 
the only case where we include vfio.h where vfio_iommu_type1_info is 
defined.


> 
> On clang x86-64 Linux:
> 
> ../../hw/vfio/migration.c:737:42: error: equality comparison with
> extraneous parentheses [-Werror,-Wparentheses-equality]
>      if ((vbasedev->migration->vm_running == running)) {
>           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> ../../hw/vfio/migration.c:737:42: note: remove extraneous parentheses
> around the comparison to silence this warning
>      if ((vbasedev->migration->vm_running == running)) {
>          ~                                ^         ~
> ../../hw/vfio/migration.c:737:42: note: use '=' to turn this equality
> comparison into an assignment
>      if ((vbasedev->migration->vm_running == running)) {
>                                           ^~
>                                           =
> 
> On AArch32:
> 
> ../../hw/vfio/migration.c: In function 'vfio_mig_access':
> ../../hw/vfio/migration.c:58:68: error: format '%lx' expects argument
> of type 'long unsigned int', but argument 5 has type 'off_t {aka long
> long int}' [-Werror=format=]
>           error_report("vfio_mig_%s %d byte %s: failed at offset 0x%lx, err: %s",
>                                                                    ~~^
>                                                                    %llx
> cc1: all warnings being treated as errors
> 
> 
> On PPC64:
> 
> ../../hw/vfio/common.c: In function ‘vfio_dma_unmap_bitmap’:
> ../../hw/vfio/common.c:400:9: error: format ‘%llx’ expects argument of
> type ‘long long unsigned int’, but argument 2 has type ‘__u64’
> [-Werror=format=]
>           error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->size);
>           ^
> ../../hw/vfio/common.c: In function ‘vfio_get_dirty_bitmap’:
> ../../hw/vfio/common.c:1003:17: error: format ‘%llx’ expects argument
> of type ‘long long unsigned int’, but argument 2 has type ‘__u64’
> [-Werror=format=]
>                   range->iova, range->size, errno);
>                   ^
> ../../hw/vfio/common.c:1003:17: error: format ‘%llx’ expects argument
> of type ‘long long unsigned int’, but argument 3 has type ‘__u64’
> [-Werror=format=]
> 
> thanks
> -- PMM
> 


