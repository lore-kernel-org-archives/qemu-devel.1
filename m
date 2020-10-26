Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF31E2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVI0rmRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF31E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAUQ-0008MH-41
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXAEG-0008Q9-Vh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:40:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXAE8-000245-8t
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:40:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09QLWIlj039993; Mon, 26 Oct 2020 17:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2zmftz9LLZVz3OQxnyydJlEXqtlvpDqudSSi69Aliy8=;
 b=LVI0rmRF0M39OLUe5UrJntzHpaZIB8LR8SEBokwHS7OAjpGEAPMnk5Hx51U0/NiTt/uB
 /LWOk3GnxCuDZbClx0rne16vE5Fi0nXwZnFELdhaSrN8iXmj1luCJwBJPGBS8GqOVb7H
 jwcsUUud8evG20lplWAXLAmtXq55SMNYwPz16LEm3K/ylWMkZL2lJneqyo170xZDb4cq
 3KoL1MEWA0gzNYxX+MpwuxZaxLros9FNrvo5Yj4wZLX0I9+fogbjq8JpXTjelJTg+ONj
 3EbERZcBZTksYZdijU8IkPwR6ycPv17rPyqC5ZW+r1bfQnc6SOvfO2ldSxYDXsQ97gpS rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dydsnc2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 17:40:23 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09QLdHwm054853;
 Mon, 26 Oct 2020 17:40:23 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dydsnc2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 17:40:23 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QLWF69024451;
 Mon, 26 Oct 2020 21:40:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 34cbw8ydp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 21:40:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09QLeDoc50266436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 21:40:13 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B2A96A051;
 Mon, 26 Oct 2020 21:40:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D270C6A04D;
 Mon, 26 Oct 2020 21:40:20 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2020 21:40:20 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
 <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
 <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <22deebcf-f5f0-8151-eea9-7acab98da952@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2020 17:40:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-26_17:2020-10-26,
 2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260138
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 17:40:25
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using an array of length 0 seems to be enough to avoid the warning
Will use that solution in v3.

Thanks,
Daniele

On 10/26/2020 11:12 AM, Paolo Bonzini wrote:
> On 26/10/20 16:03, Daniele Buono wrote:
>> Hi Paolo,
>> I reorganized UASStatus to put uas_iu at the end and it works fine.
>> Unfortunately, this uncovered another part of the code with a similar
>> issue (variable sized type not at the end of the struct), here:
>>
>> In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
>> ../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable
>> sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at
>> the end of a struct or class is a GNU extension
>> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>      IplParameterBlock iplb;
>>                        ^
>> ../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with
>> variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock')
>> not at the end of a struct or class is a GNU extension
>> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>      IplParameterBlock iplb_pv;
>>
>> My understanding is that each of these IplParameterBlock may contain
>> either a IPLBlockPV or a IplBlockFcp, which both end with a variable
>> sized field (an array).
>>
>> Adding maintainers of s390x to see if they have a suggested solution to
>> avoid disabling the warning.
> 
> This one seems okay because the union constrains the size to 4K. If
> "[0]" is enough to shut up the compiler, I'd say do that.
> 
> Paolo
> 

