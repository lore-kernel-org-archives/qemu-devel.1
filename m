Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F6C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412BD222E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cuddfWxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412BD222E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkQv-0002kR-63
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGkPg-0001PP-WF; Fri, 11 Sep 2020 10:52:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53526
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGkPc-0007xG-FU; Fri, 11 Sep 2020 10:52:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BEXOW1039752; Fri, 11 Sep 2020 10:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W/H828r0/iXrjj3ISYFPbKwUcnkJ7OvsIduB3XtFVAE=;
 b=cuddfWxTRvwuCacTGcd2iVfRPlTO++j55SRB6lw5/yS4ak8RHbixO1DfIb2DlzeTpYZ9
 E4msIz2q1bq4PVV9J8n2ITwp5sLikcCApXZ7I0pJhfE13bx8clt2Sdxa+xzVatTU/2eD
 DkpMOW+oLL6/jZTtlu5Lx8cojqZlbnVKMRcMuSXR8AjtN15645US3E0dv9O3NF6bHHDQ
 oa3444yXFiYbzCgqYVv+flBqAP3s7FZczSBnb09ZtfN3TqHPe5Ojq1kix+p8/WxvwOdg
 FCnh10Ji00WPZIyzNMUlyhTZGTo9wHs4nJ+4lzIA4ih2v0gzLhnvxzcPknOdio6DJvn0 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33g99bvday-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 10:52:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BEYJ3m043540;
 Fri, 11 Sep 2020 10:52:26 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33g99bvdah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 10:52:26 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BElWkV011376;
 Fri, 11 Sep 2020 14:52:25 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma05wdc.us.ibm.com with ESMTP id 33c2a9rk5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 14:52:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08BEqPCV30671262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 14:52:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FB7228059;
 Fri, 11 Sep 2020 14:52:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1988228058;
 Fri, 11 Sep 2020 14:52:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.6])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2020 14:52:25 +0000 (GMT)
Subject: Re: [PATCH v5 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-7-walling@linux.ibm.com>
 <43af1e04-b9c9-2704-9cef-735a9b283be7@redhat.com>
 <c5663f7b-0799-eddd-bae8-26cb08d6eca7@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <aab2d6ad-9675-6a13-1d8e-a4d5256138d5@linux.ibm.com>
Date: Fri, 11 Sep 2020 10:52:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5663f7b-0799-eddd-bae8-26cb08d6eca7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_05:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:50:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
 sumanthk@linux.ibm.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 9:54 AM, Thomas Huth wrote:
> On 11/09/2020 15.41, Thomas Huth wrote:
>> On 10/09/2020 11.36, Collin Walling wrote:
>>> As more features and facilities are added to the Read SCP Info (RSCPI)
>>> response, more space is required to store them. The space used to store
>>> these new features intrudes on the space originally used to store CPU
>>> entries. This means as more features and facilities are added to the
>>> RSCPI response, less space can be used to store CPU entries.
>>>
>>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
>>> the RSCPI command and determine if the SCCB is large enough to store a
>>> complete reponse. If it is not large enough, then the required length
>>> will be set in the SCCB header.
>>>
>>> The caller of the SCLP command is responsible for creating a
>>> large-enough SCCB to store a complete response. Proper checking should
>>> be in place, and the caller should execute the command once-more with
>>> the large-enough SCCB.
>>>
>>> This facility also enables an extended SCCB for the Read CPU Info
>>> (RCPUI) command.
>>>
>>> When this facility is enabled, the boundary violation response cannot
>>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>>>
>>> In order to tolerate kernels that do not yet have full support for this
>>> feature, a "fixed" offset to the start of the CPU Entries within the
>>> Read SCP Info struct is set to allow for the original 248 max entries
>>> when this feature is disabled.
>>>
>>> Additionally, this is introduced as a CPU feature to protect the guest
>>> from migrating to a machine that does not support storing an extended
>>> SCCB. This could otherwise hinder the VM from being able to read all
>>> available CPU entries after migration (such as during re-ipl).
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>> [...]
>>>  /* Provide information about the configuration, CPUs and storage */
>>>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>>  {
>>> @@ -89,10 +112,15 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>>      int rnsize, rnmax;
>>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>>      int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
>>> -    int offset_cpu = offsetof(ReadInfo, entries);
>>> +    int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
>>> +                     offsetof(ReadInfo, entries) :
>>> +                     SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
>>
>> Sorry, but I'm having somewhat trouble to understand this...
>> What's the difference between offsetof(ReadInfo, entries) and
>> SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET ? Aren't both terms resulting in the
>> value 128 ?
> 
> Ah, well, the answer is clear after looking at patch 8/8 ... ReadInfo is
> extended there, so offsetof(ReadInfo, entries) will result in a
> different value.
> Might have been better to move the above hunk into patch 8/8, but if you
> want to keep it here, that's now ok for me, too.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

I see your point. In retrospect, it might've been better to include it
in patch 8/8 so it's more clear why these features are introduced within
the same patch set.

If there are any requests to change / fixup this patch in any other
regard, then I'll consider moving the offset_cpu calculation to 8/8.

Otherwise, I'll leave it here :)

Thanks!

-- 
Regards,
Collin

Stay safe and stay healthy

