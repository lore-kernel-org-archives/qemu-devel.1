Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BBDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6A8206FB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OyC5Xm3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6A8206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3Ty-00050Q-8D
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1kT3Sa-0003Vs-7a; Thu, 15 Oct 2020 09:38:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1kT3SX-0000Cv-K4; Thu, 15 Oct 2020 09:38:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09FDXCWt066689; Thu, 15 Oct 2020 09:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8UoulDETY06kmFw6hT+6HIrTxtXjhGFfMHxjJ0qSfuI=;
 b=OyC5Xm3RD8/ls3Mx6RyWd1JoCz4XEHtf5qUK4XUWM6pcFWIgTVieEyIK1WhnruBAE//N
 OI3NIVe1VWyHDuZI5VZ1r6NcI/aLqCywR94OID4XriQk9EwVQw4OhiKZHvPglZPuo4gf
 KBwtKP167XIm2rZSL4xj55sk0g/x1feAz4TsaAFRe1V3oHiUm5SllKl3H4euF1ZBFW+l
 2GpGd0z2NhN0QYEoWQ3a06GJek1xDmMtI44mSPx0EXTe4XqsV6uxNaz3FJmkxlZLaT7l
 mtZpTcp6lpuH6FQ6ME0EjqjEZ2bU5WnOd9d9o+8ryN0n4m6OZDbKNl8sI/3cM/VsmDbv Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 346pqghvs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 09:38:05 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09FDXrKh070228;
 Thu, 15 Oct 2020 09:38:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 346pqghvqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 09:38:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09FDWG3j026215;
 Thu, 15 Oct 2020 13:38:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 3434k7tqxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 13:38:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09FDbwWh30409134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 13:37:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92DC04204B;
 Thu, 15 Oct 2020 13:37:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F41CD42041;
 Thu, 15 Oct 2020 13:37:57 +0000 (GMT)
Received: from [9.145.144.150] (unknown [9.145.144.150])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 15 Oct 2020 13:37:57 +0000 (GMT)
Subject: Re: [PATCH] s390x/s390-virtio-ccw: Reset PCI devices during subsystem
 reset
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
References: <1602767767-32713-1-git-send-email-mjrosato@linux.ibm.com>
 <e9a29f3a-5f15-aa36-f9aa-314bc56a3507@de.ibm.com>
 <d705b269-b001-f810-8629-7d64fb560ac5@de.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <2dea575e-45cf-adc2-a0eb-61aaffbbaaec@linux.ibm.com>
Date: Thu, 15 Oct 2020 15:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d705b269-b001-f810-8629-7d64fb560ac5@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-15_08:2020-10-14,
 2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150096
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=schnelle@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:38:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.019,
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/15/20 3:34 PM, Christian Borntraeger wrote:
> 
> 
> On 15.10.20 15:32, Christian Borntraeger wrote:
>>
>>
>> On 15.10.20 15:16, Matthew Rosato wrote:
>>> Currently, a subsystem reset event leaves PCI devices enabled, causing
>>> issues post-reset in the guest (an example would be after a kexec).  These
>>> devices need to be reset during a subsystem reset, allowing them to be
>>> properly re-enabled afterwards.  Add the S390 PCI host bridge to the list
>>> of qdevs to be reset during subsystem reset.
>>>
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> Reviewed-by: Eric Farman <farman@linux.ibm.com>
>>
>> Makese sense. 
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> A question. Is this a stable candidate?

As this can prevent a SUSE guest (which does kexec during boot because of grub)
from seeing any PCI devices I'd say yes.

> 
>>
>>
>>> ---
>>>  hw/s390x/s390-virtio-ccw.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index e52182f..2e90033 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -101,6 +101,7 @@ static const char *const reset_dev_types[] = {
>>>      "s390-sclp-event-facility",
>>>      "s390-flic",
>>>      "diag288",
>>> +    TYPE_S390_PCI_HOST_BRIDGE,
>>>  };
>>>  
>>>  static void subsystem_reset(void)
>>>

