Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B16C73C60
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAFE20693
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAFE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkz4M-0001vh-HN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 18:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hkz1f-0001DP-Q4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 18:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hkz1U-0007sT-BO
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 18:55:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63318
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hkz1T-0007i1-6D
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 18:55:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x69Mpeqr084530
 for <qemu-devel@nongnu.org>; Tue, 9 Jul 2019 18:55:37 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tn1mbvw32-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 18:55:37 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
 Tue, 9 Jul 2019 23:55:37 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Jul 2019 23:55:35 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x69MtYIv54854030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jul 2019 22:55:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 442B4AC05F;
 Tue,  9 Jul 2019 22:55:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32F11AC059;
 Tue,  9 Jul 2019 22:55:34 +0000 (GMT)
Received: from [9.63.14.98] (unknown [9.63.14.98])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jul 2019 22:55:34 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
References: <20190708125433.16927-1-cohuck@redhat.com>
 <20190708125433.16927-2-cohuck@redhat.com>
 <58b28817-58e5-1cba-6f71-a35093be5cb6@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 9 Jul 2019 18:55:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <58b28817-58e5-1cba-6f71-a35093be5cb6@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070922-0060-0000-0000-0000035AEF10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011402; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01229888; UDB=6.00647759; IPR=6.01011147; 
 MB=3.00027659; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-09 22:55:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070922-0061-0000-0000-00004A12F2FF
Message-Id: <0dd71cfe-a9e9-7ac3-523e-065f05479a57@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-09_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090273
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.1 1/2] s390x/pci: add
 some fallthrough annotations
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/19 9:23 AM, Christian Borntraeger wrote:
> 
> 
> On 08.07.19 14:54, Cornelia Huck wrote:
>> According to the comment, the bits are supposed to accumulate.
>>
>> Reported-by: Stefan Weil <sw@weilnetz.de>
>> Fixes: 5d1abf234462 ("s390x/pci: enforce zPCI state checking")
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> 
> This patch does not change behaviour, so it is certainly not wrong.
> 
> So lets have a look at if the bug report was actually a real bug or
> just a missing annotation.
> 
>> ---
>>   hw/s390x/s390-pci-inst.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 61f30b8e55d2..00235148bed7 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -1209,8 +1209,10 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
>>        * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
>>       case ZPCI_FS_ERROR:
>>           fib.fc |= 0x20;
>> +        /* fallthrough */
> 
> This is correct, in case of an error we are also blocked.
> 

Agreed. This is definitely correct based on our architecture.

>>       case ZPCI_FS_BLOCKED:
>>           fib.fc |= 0x40;
>> +        /* fallthrough */
> 
> I think this is also correct, but  it would be good if Collin could verify.
> 

I failed to find anything to support setting the function control
enabled bit when the function state is in error / blocked. I'm
assuming this might be some QEMU hack to get things working? I'll have
to dive further to understand why this was done this way, as it doesn't
align with how the s390x architecture is documented. It's confusing.

Functionally, this doesn't change anything... so I'll at least give it
an ACK for now and investigate this further.

>>       case ZPCI_FS_ENABLED:
>>           fib.fc |= 0x80;
>>           if (pbdev->iommu->enabled) {
>>
> 
> 

Acked-by: Collin Walling <walling@linux.ibm.com>

Side note: is there somewhere that I could access this bug report? :)


