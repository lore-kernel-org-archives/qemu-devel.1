Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81309C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F8C2222C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m7q5jypX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8C2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX733-0003Cj-Qp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX6U9-0001fK-Hw; Mon, 26 Oct 2020 13:40:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX6U6-0002xu-Gx; Mon, 26 Oct 2020 13:40:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09QHWItv074816; Mon, 26 Oct 2020 13:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=N8x87jjoTsSE/CXSSyEMfSvl2TFRL8kektPyYonN0kQ=;
 b=m7q5jypXsgEcpA9sODfiRlQP2X+DtS6lP3/0DehppPMwd2fmSVnAFTGmFm2fzqvQvx/a
 lLY7KcijCq8p9Euko0brGPw68k0ZKG4B0Yw3DTkB2kQKVg7zX+AnLJZWuos7e2IAv8hZ
 QGsg9nzF2lBHpD8D9tsP4attFVclLLcbRaZfSkfj/hhSNOJqDTmtndmE1DnBIyRH0+Z/
 fB8mGQlu5upfMJ+S6zJrFXu50wDWhge1WuYmoeLoFa+7/0LUCu2zYVXhy0tIw2fbR9f0
 AzZUZlB+z64qvpisqtC9k2ukSZskHV+3DA0CfR5drkERAEZ+lJWmyWSpqotlEpy479AA Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dq9fn5p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 13:40:40 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09QHWJNx074931;
 Mon, 26 Oct 2020 13:40:40 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dq9fn5nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 13:40:40 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QHcJxr017804;
 Mon, 26 Oct 2020 17:40:39 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 34cbw8wsre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 17:40:39 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09QHeWKW63963536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 17:40:32 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E45A5BE056;
 Mon, 26 Oct 2020 17:40:37 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D00BE05A;
 Mon, 26 Oct 2020 17:40:36 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.49.29])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2020 17:40:36 +0000 (GMT)
Subject: Re: [PATCH 02/13] linux-headers: update against 5.10-rc1
To: Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
 <1603726481-31824-3-git-send-email-mjrosato@linux.ibm.com>
 <20201026113716.2c67aec6@w520.home>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <5ef1a7c9-66a1-8e88-7f29-1109d41e2bd0@linux.ibm.com>
Date: Mon, 26 Oct 2020 13:40:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026113716.2c67aec6@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-26_08:2020-10-26,
 2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260115
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:40:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 david@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 1:37 PM, Alex Williamson wrote:
> On Mon, 26 Oct 2020 11:34:30 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h | 14 ++--
>>   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |  2 +-
>>   include/standard-headers/linux/ethtool.h           |  2 +
>>   include/standard-headers/linux/fuse.h              | 50 +++++++++++++-
>>   include/standard-headers/linux/input-event-codes.h |  4 ++
>>   include/standard-headers/linux/pci_regs.h          |  6 +-
>>   include/standard-headers/linux/virtio_fs.h         |  3 +
>>   include/standard-headers/linux/virtio_gpu.h        | 19 ++++++
>>   include/standard-headers/linux/virtio_mmio.h       | 11 +++
>>   include/standard-headers/linux/virtio_pci.h        | 11 ++-
>>   linux-headers/asm-arm64/kvm.h                      | 25 +++++++
>>   linux-headers/asm-arm64/mman.h                     |  1 +
>>   linux-headers/asm-generic/hugetlb_encode.h         |  1 +
>>   linux-headers/asm-generic/unistd.h                 | 18 ++---
>>   linux-headers/asm-mips/unistd_n32.h                |  1 +
>>   linux-headers/asm-mips/unistd_n64.h                |  1 +
>>   linux-headers/asm-mips/unistd_o32.h                |  1 +
>>   linux-headers/asm-powerpc/unistd_32.h              |  1 +
>>   linux-headers/asm-powerpc/unistd_64.h              |  1 +
>>   linux-headers/asm-s390/unistd_32.h                 |  1 +
>>   linux-headers/asm-s390/unistd_64.h                 |  1 +
>>   linux-headers/asm-x86/kvm.h                        | 20 ++++++
>>   linux-headers/asm-x86/unistd_32.h                  |  1 +
>>   linux-headers/asm-x86/unistd_64.h                  |  1 +
>>   linux-headers/asm-x86/unistd_x32.h                 |  1 +
>>   linux-headers/linux/kvm.h                          | 19 ++++++
>>   linux-headers/linux/mman.h                         |  1 +
>>   linux-headers/linux/vfio.h                         | 29 +++++++-
>>   linux-headers/linux/vfio_zdev.h                    | 78 ++++++++++++++++++++++
>>   29 files changed, 301 insertions(+), 23 deletions(-)
>>   create mode 100644 linux-headers/linux/vfio_zdev.h
>>
>> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
>> index 7b4062a..acd4c83 100644
>> --- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
>> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
>> @@ -68,7 +68,7 @@ static inline int pvrdma_idx_valid(uint32_t idx, uint32_t max_elems)
>>   
>>   static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
>>   {
>> -	const unsigned int idx = qatomic_read(var);
>> +	const unsigned int idx = atomic_read(var);
>>   
>>   	if (pvrdma_idx_valid(idx, max_elems))
>>   		return idx & (max_elems - 1);
>> @@ -77,17 +77,17 @@ static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
>>   
>>   static inline void pvrdma_idx_ring_inc(int *var, uint32_t max_elems)
>>   {
>> -	uint32_t idx = qatomic_read(var) + 1;	/* Increment. */
>> +	uint32_t idx = atomic_read(var) + 1;	/* Increment. */
>>   
>>   	idx &= (max_elems << 1) - 1;		/* Modulo size, flip gen. */
>> -	qatomic_set(var, idx);
>> +	atomic_set(var, idx);
>>   }
>>   
>>   static inline int32_t pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
>>   					      uint32_t max_elems, uint32_t *out_tail)
>>   {
>> -	const uint32_t tail = qatomic_read(&r->prod_tail);
>> -	const uint32_t head = qatomic_read(&r->cons_head);
>> +	const uint32_t tail = atomic_read(&r->prod_tail);
>> +	const uint32_t head = atomic_read(&r->cons_head);
>>   
>>   	if (pvrdma_idx_valid(tail, max_elems) &&
>>   	    pvrdma_idx_valid(head, max_elems)) {
>> @@ -100,8 +100,8 @@ static inline int32_t pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
>>   static inline int32_t pvrdma_idx_ring_has_data(const struct pvrdma_ring *r,
>>   					     uint32_t max_elems, uint32_t *out_head)
>>   {
>> -	const uint32_t tail = qatomic_read(&r->prod_tail);
>> -	const uint32_t head = qatomic_read(&r->cons_head);
>> +	const uint32_t tail = atomic_read(&r->prod_tail);
>> +	const uint32_t head = atomic_read(&r->cons_head);
>>   
>>   	if (pvrdma_idx_valid(tail, max_elems) &&
>>   	    pvrdma_idx_valid(head, max_elems)) {
> 
> 
> The above is clearly just going to revert Stefan's changes to this file
> via:
> 
> d73415a31547 )"qemu/atomic.h: rename atomic_ to qatomic_")
> 
> For now I'm just going to drop these changes (with comment) to avoid
> that.  I'll leave it to others to fix the header update script to either
> reimplement the s/atomic_/qatomic_/ conversion or remove these code
> blocks altogether.  Sound ok?  Thanks,
> 
> Alex

Yes, this makes sense to me.


