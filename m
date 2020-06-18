Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B45C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23A3207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23A3207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm1bj-0006Ao-8J
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jm1b9-0005jF-WE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:57:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64774
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jm1b7-0000it-Va
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:57:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05IKXROn085775
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:57:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31repa1st3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:57:18 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IKobio131813
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:57:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31repa1ssx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 16:57:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IKolNT013250;
 Thu, 18 Jun 2020 20:57:17 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 31rd9595kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 20:57:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05IKvG6V53346778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 20:57:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6AFBB2065;
 Thu, 18 Jun 2020 20:57:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B54DEB205F;
 Thu, 18 Jun 2020 20:57:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2020 20:57:16 +0000 (GMT)
Subject: Re: [PATCH v3 5/8] acpi: Enable TPM IRQ
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
 <6b3b7b49-02e6-9d2d-91ad-65a5ea6d2244@redhat.com>
 <0069a66e-474e-21b9-84ce-36a552cc7b98@linux.ibm.com>
 <20200618161045-mutt-send-email-mst@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b339f310-a54c-7816-e5d1-f8183b3aaa0d@linux.ibm.com>
Date: Thu, 18 Jun 2020 16:57:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200618161045-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_21:2020-06-18,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 cotscore=-2147483648 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 16:57:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 4:12 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 07:59:51AM -0400, Stefan Berger wrote:
>> On 6/17/20 4:22 AM, Auger Eric wrote:
>>> Hi Stefan,
>>>
>>> On 6/16/20 10:57 PM, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
>>>> Windows. Query for the TPM's irq number and enable the TPM IRQ unless
>>>> TPM_IRQ_DISABLED is returned.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>    hw/i386/acpi-build.c  | 11 +++++------
>>>>    include/hw/acpi/tpm.h |  2 +-
>>>>    2 files changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 900f786d08..bb9a7f8497 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>>                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>>>>                if (TPM_IS_TIS_ISA(tpm)) {
>>>> +                int8_t irq = tpm_get_irqnum(tpm);
>>>>                    if (misc->tpm_version == TPM_VERSION_2_0) {
>>>>                        dev = aml_device("TPM");
>>>>                        aml_append(dev, aml_name_decl("_HID",
>>>> @@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>>                    crs = aml_resource_template();
>>>>                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>>>>                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>>>> -                /*
>>>> -                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
>>>> -                    Rewrite to take IRQ from TPM device model and
>>>> -                    fix default IRQ value there to use some unused IRQ
>>>> -                 */
>>>> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>>>> +
>>>> +                if (irq != TPM_IRQ_DISABLED) {
>>> Out of curiosity what is the goal to expose the irq num as a property
>>> settable by the end-user if only 13 is known to work in all cases. At
>>> least shouldn't we warn the end-user in case he attempts to change the
>>> default value?
>> For Windows only IRQ 13 works (and I am not sure whether this has always
>> been like this), Linux accepts several other ones. As for exposing it to the
>> end-user, I may have taken this from soundblaster (sb16.c), which also
>> exposes it. If someone plays around with the irq numbers I would say they
>> must have some more Pc knowledge thanÂ  just trying random numbers.
>>
>>
>> Â Â  Stefan
> So is this useful to anyone? If no I'd say drop it.


So we can remove command line options?


> I'm guessing sb16 has it since it is useful for running extremely old OSes which might
> have weird quirks for a specific hardware.
>


