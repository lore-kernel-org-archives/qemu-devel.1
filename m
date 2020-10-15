Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4FA2222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jp5zpgV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4FA2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3ld-00014C-L4
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kT3Zx-0003ru-QJ; Thu, 15 Oct 2020 09:46:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35866
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kT3Zv-0001Lq-4x; Thu, 15 Oct 2020 09:46:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09FDYRv0144725; Thu, 15 Oct 2020 09:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iUly4u6jTfYoXMN8raXkjuP+SD2uVZcCjkIOFUPWul8=;
 b=Jp5zpgV7dutJ2gP0I3igjukksSek7/2FXbgGfERcbQzw5kWYtgaO2Ui486QTh4KFLjG/
 gpZuIp3jOox9Yub/ieiVnhhHEBRlfd826iu9wDyEXCw8ueGQPGWza1YYLtiHBM36RcGx
 RJkR+BXd7Tq4REKp9nqJ4nJmPGA+SpItzuf2Gd8/ofCv6hLBX/JiFMCs7EbbN8/UPKEn
 s8p9WDq6IcBhPir3NyZYnc9NvH6QSe8RrJoNFORSqwIlc83gsniffN03V7PmMzOI28Du
 QoEdRnehQJm2+cWOlhdDPtAQDT0kC1x37VBry7BxlFNuGBQ/c+bFh0uLI0W+BZi4s8a/ KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 346q50136x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 09:45:56 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09FDZOB0149933;
 Thu, 15 Oct 2020 09:45:56 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 346q50136a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 09:45:55 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09FDgxG9010050;
 Thu, 15 Oct 2020 13:45:55 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma05wdc.us.ibm.com with ESMTP id 3434k9j4u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 13:45:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09FDjrBO15270824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 13:45:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6589B2068;
 Thu, 15 Oct 2020 13:45:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31C0BB205F;
 Thu, 15 Oct 2020 13:45:52 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.37.36])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 15 Oct 2020 13:45:52 +0000 (GMT)
Subject: Re: [PATCH] s390x/s390-virtio-ccw: Reset PCI devices during subsystem
 reset
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <1602767767-32713-1-git-send-email-mjrosato@linux.ibm.com>
 <e9a29f3a-5f15-aa36-f9aa-314bc56a3507@de.ibm.com>
 <d705b269-b001-f810-8629-7d64fb560ac5@de.ibm.com>
 <2dea575e-45cf-adc2-a0eb-61aaffbbaaec@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <58192dd4-70cf-7d2a-8f63-c60bf7b36622@linux.ibm.com>
Date: Thu, 15 Oct 2020 09:45:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2dea575e-45cf-adc2-a0eb-61aaffbbaaec@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-15_08:2020-10-14,
 2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150092
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:16:15
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

On 10/15/20 9:37 AM, Niklas Schnelle wrote:
> 
> 
> On 10/15/20 3:34 PM, Christian Borntraeger wrote:
>>
>>
>> On 15.10.20 15:32, Christian Borntraeger wrote:
>>>
>>>
>>> On 15.10.20 15:16, Matthew Rosato wrote:
>>>> Currently, a subsystem reset event leaves PCI devices enabled, causing
>>>> issues post-reset in the guest (an example would be after a kexec).  These
>>>> devices need to be reset during a subsystem reset, allowing them to be
>>>> properly re-enabled afterwards.  Add the S390 PCI host bridge to the list
>>>> of qdevs to be reset during subsystem reset.
>>>>
>>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> Reviewed-by: Eric Farman <farman@linux.ibm.com>
>>>
>>> Makese sense.
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> A question. Is this a stable candidate?
> 
> As this can prevent a SUSE guest (which does kexec during boot because of grub)
> from seeing any PCI devices I'd say yes.
> 

Yes, agreed.

>>
>>>
>>>
>>>> ---
>>>>   hw/s390x/s390-virtio-ccw.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index e52182f..2e90033 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -101,6 +101,7 @@ static const char *const reset_dev_types[] = {
>>>>       "s390-sclp-event-facility",
>>>>       "s390-flic",
>>>>       "diag288",
>>>> +    TYPE_S390_PCI_HOST_BRIDGE,
>>>>   };
>>>>   
>>>>   static void subsystem_reset(void)
>>>>


