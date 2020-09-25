Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D4EC4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB89D20936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mdctBbfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB89D20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoa1-0000bM-W4
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kLoXk-0007Bx-MA; Fri, 25 Sep 2020 10:17:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25428
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kLoXf-0004XT-TH; Fri, 25 Sep 2020 10:17:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PE1rJ7092711; Fri, 25 Sep 2020 10:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r4ytxljVcFk8tfnFEZjUaqsj76LHVaQQWIvo1cQWIAM=;
 b=mdctBbfzSB1BNcakdHbHVs//Q3VDoyihziye5nQiateoTjtq3ur7s4YGfW5HhMkLY8ih
 NBj/6EV856UJsx1bIpzTeEaanRYZcjlEWJZrF5ij2mTc5weUVyXLV3exZrGy9NeIRib4
 LDkK01PNcgA3LI+pjtExsGGYY1O3MHobiGxChS5stQzv/ewx8FZC39OB6bCkH1qlPKJh
 QFL5XqesdQy8JIRmE8fl602u3qNFtsnV6z7pTRd6GuUYz1al+VgL7chbcqm9VboIfyWr
 RjJTF3HFYi6dAHDVtmlKaVkqueQq1YvZEJ3rUW+mBc5j2Rf6u4FQa04KnfKDcuXIrPG/ ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33se5arbnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:17:42 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PE2Bk9094185;
 Fri, 25 Sep 2020 10:17:42 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33se5arbn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:17:41 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PEC95g030614;
 Fri, 25 Sep 2020 14:17:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma05wdc.us.ibm.com with ESMTP id 33n9m9sn1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 14:17:41 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08PEHe8K50463228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 14:17:40 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF0D1124052;
 Fri, 25 Sep 2020 14:17:40 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68003124053;
 Fri, 25 Sep 2020 14:17:38 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.16.144])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2020 14:17:38 +0000 (GMT)
Subject: Re: [PATCH 4/7] s390x/pci: use a PCI Group structure
To: Cornelia Huck <cohuck@redhat.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529672-10243-5-git-send-email-mjrosato@linux.ibm.com>
 <20200925114105.439c1c7d.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <c2f37fd9-780d-ba14-08a3-797b826ddd3a@linux.ibm.com>
Date: Fri, 25 Sep 2020 10:17:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925114105.439c1c7d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_11:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=2 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250095
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:17:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 5:41 AM, Cornelia Huck wrote:
> On Sat, 19 Sep 2020 11:34:29 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> We use a S390PCIGroup structure to hold the information related to a
>> zPCI Function group.
>>
>> This allows us to be ready to support multiple groups and to retrieve
>> the group information from the host.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/s390x/s390-pci-bus.h  | 10 ++++++++++
>>   hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
>>   3 files changed, 65 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 92146a2..3015d86 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -737,6 +737,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>>       object_unref(OBJECT(iommu));
>>   }
>>   
>> +static S390PCIGroup *s390_grp_create(int ug)
> 
> I think you made the identifiers a bit too compact :)
> s390_group_create() is not that long, and I have no idea what the 'ug'
> (ugh :) parameter is supposed to mean.
> 

Ha :)  Message received, something like s390_group_create(int id) is 
probably more appropriate.

>> +{
>> +    S390PCIGroup *grp;
> 
> group?
> 
>> +    S390pciState *s = s390_get_phb();
>> +
>> +    grp = g_new0(S390PCIGroup, 1);
>> +    grp->ug = ug;
>> +    QTAILQ_INSERT_TAIL(&s->zpci_grps, grp, link);
> 
> zpci_groups? I think you get the idea :)
> 

Yep, thanks!

>> +    return grp;
>> +}
> 
> (...)
> 
> No objection to the patch in general.
> 


