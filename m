Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1032D2463C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L8o1eeXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1032D2463C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX44j-0007AY-3R
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kX42n-00060a-96
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:04:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6276
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kX42l-0004SC-71
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:04:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09QF2E7o040940; Mon, 26 Oct 2020 11:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fUo/CbtR93IWmloNEI5z8uaF6pZDm7C/WI3uoVXNMeY=;
 b=L8o1eeXNthEL9z0wM+EocFu3Kjumeji/VHhiZGasl/yvbA4q/F8H8W97UaLUwRrEwHPO
 jNjKm7/rhAnRiCqlrGyipHSh38fqNYc7slQYIvg3Sqd09h0MjizustyiebnldkLeDbto
 xRmqw0D2ykmWiUId5c7JwWzpaiUzc6mld+XAB3Jt9YD3dC4rXsqmdnBvbQu0INijQ+4N
 fY6bHFwfnWVlc62mktecLU6ksse4ndUug4L/Gs3Nr61vjm+VUnHoUr+mqFUjEy/IKDWm
 RPSnOukyVCpj2rdluKWkS2PL2po1LZQ5bzMDp64EotSka+vtmdElFg+7+RO3AvuTzbuz Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34duwd1bb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 11:03:38 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09QF2Lte041659;
 Mon, 26 Oct 2020 11:03:38 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34duwd1bap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 11:03:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QEwCPU029097;
 Mon, 26 Oct 2020 15:03:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 34cbw8vfqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 15:03:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09QF3Zxs25952734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 15:03:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6E016A051;
 Mon, 26 Oct 2020 15:03:35 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED9236A05F;
 Mon, 26 Oct 2020 15:03:34 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2020 15:03:34 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2020 11:03:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-26_06:2020-10-26,
 2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260106
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:03:39
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,
I reorganized UASStatus to put uas_iu at the end and it works fine.
Unfortunately, this uncovered another part of the code with a similar
issue (variable sized type not at the end of the struct), here:

In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable 
sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at 
the end of a struct or class is a GNU extension 
[-Werror,-Wgnu-variable-sized-type-not-at-end]
     IplParameterBlock iplb;
                       ^
../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with 
variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock') 
not at the end of a struct or class is a GNU extension 
[-Werror,-Wgnu-variable-sized-type-not-at-end]
     IplParameterBlock iplb_pv;

My understanding is that each of these IplParameterBlock may contain
either a IPLBlockPV or a IplBlockFcp, which both end with a variable
sized field (an array).

Adding maintainers of s390x to see if they have a suggested solution to
avoid disabling the warning.

On 10/26/2020 5:50 AM, Paolo Bonzini wrote:
> On 23/10/20 22:06, Daniele Buono wrote:
>> 1 error generated.
>>
>> The data structure is UASStatus, which must end with a QTAILQ_ENTRY, so
>> I believe we cannot have uas_iu at the end. Since this is a gnu
>> extension but CLANG supports it, just add
>> -Wno-gnu-variable-sized-type-not-at-end
> 
> This is potentially a real bug, in this case it works only because
> UASStatus's packet is never uas_iu_command (which has the variable sized
> type).
> 
> The QTAILQ_ENTRY need not be at the end, please rearrange UASStatus's
> field so that the "usb_ui status" field is the last.
> 
> Thanks,
> 
> Paolo
> 

