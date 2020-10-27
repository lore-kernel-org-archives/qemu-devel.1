Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CCC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7E021556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YeBdw+8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7E021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRgM-0007S8-Hc
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXRfP-000719-4B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:17:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXRfN-0008H5-1H
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:17:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09RG2mFE169852; Tue, 27 Oct 2020 12:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BV364MwLSwnvxVUmQhN5K4kSUio7tqzHcFVn9m8tT44=;
 b=YeBdw+8m7eITTkpYLosuZqKz7d6T1T6dz7d0kySKkTpCT9S+BviVZf/56S14a+qaSZ+M
 MCLVc7YSfJGHzJvRsQANkWXV/igSKcI3SgjU3xQddadjdSxMCOurJ36DH7+wV+5LZDa5
 cf9n+xt6mfykzGXAaYslbbj49x7RrJCDLiS976Rox+6HwrJh2I3+S5idGBApdyQnBgFM
 7ZJWcm1RhPSc/Q2Y0oP6l2G5vNpJIzmZx7idBTl5Cjo+Q/c4K48QEAJCF86bya4/GksJ
 rSoHA00hIp54qPUgUTepseJ2oGnmCrz8Xz4D+cj9TwBN/NKUu6McAwbAiZ1229E/tQku hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34emb4pg5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 12:17:41 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09RG32QO171567;
 Tue, 27 Oct 2020 12:17:41 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34emb4pg51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 12:17:40 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09RGHAw1005800;
 Tue, 27 Oct 2020 16:17:39 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 34cbw8h5fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 16:17:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09RGHXWK36831532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 16:17:33 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC1366A05D;
 Tue, 27 Oct 2020 16:17:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4B306A04F;
 Tue, 27 Oct 2020 16:17:37 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2020 16:17:37 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
 <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
 <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
 <4ca1ef0b-fe52-a5e5-485a-2827fda58f4d@redhat.com>
 <20201027123846.18dd5c91.cohuck@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <78237c80-3ac7-d567-1c54-17d74b4381fb@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2020 12:17:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201027123846.18dd5c91.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_08:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270097
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:57:35
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So what I would do for the warning in IplParameterBlock is the following
(if I got the comments right):

- Remove IplBlockFcp from IplParameterBlock
- Keep IPLBlockPV and, in its declaration, use
struct IPLBlockPVComp components[0];

Now for the IplBlockFcp struct declaration, it does not seem to be used
anywhere now.
I could either keep it as it was before (with the variable-size array)
or remove it entirely.
I guess this is more a question for the maintainers, what is your
preference here?

Daniele

On 10/27/2020 7:38 AM, Cornelia Huck wrote:
> On Tue, 27 Oct 2020 12:26:21 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 26/10/2020 16.12, Paolo Bonzini wrote:
>>> On 26/10/20 16:03, Daniele Buono wrote:
>>>> Hi Paolo,
>>>> I reorganized UASStatus to put uas_iu at the end and it works fine.
>>>> Unfortunately, this uncovered another part of the code with a similar
>>>> issue (variable sized type not at the end of the struct), here:
>>>>
>>>> In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
>>>> ../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable
>>>> sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at
>>>> the end of a struct or class is a GNU extension
>>>> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>>>      IplParameterBlock iplb;
>>>>                        ^
>>>> ../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with
>>>> variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock')
>>>> not at the end of a struct or class is a GNU extension
>>>> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>>>      IplParameterBlock iplb_pv;
>>>>
>>>> My understanding is that each of these IplParameterBlock may contain
>>>> either a IPLBlockPV or a IplBlockFcp, which both end with a variable
>>>> sized field (an array).
>>>>
>>>> Adding maintainers of s390x to see if they have a suggested solution to
>>>> avoid disabling the warning.
>>>
>>> This one seems okay because the union constrains the size to 4K. If
>>> "[0]" is enough to shut up the compiler, I'd say do that.
>>
>> The "IplBlockFcp fcp" part seems to be completely unused, so I think you
>> could even remove that IplBlockFcp struct. For IPLBlockPV I agree with
>> Paolo, it's likely easiest to use [0] for that struct.
> 
> The fcp block had probably been added for completeness' sake, but we do
> not support list-directed IPL anyway. Not sure if we actually want it,
> as we use a different mechanism for IPLing from SCSI devices. So yes,
> maybe we should just drop it.
> 
> 

