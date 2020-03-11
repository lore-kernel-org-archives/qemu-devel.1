Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B9C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F6A20751
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJwOyC4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F6A20751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAen-00022w-NO
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCAeC-0001Xs-IV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCAeA-0007qR-MB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:20:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCAeA-0007oT-EO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:20:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BNJUD5161026;
 Wed, 11 Mar 2020 23:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RMqeWaCnDoyCdT5IVWhg5vD+nugDF9iXOeluOoRwx40=;
 b=PJwOyC4KPluOO1U1wh8qLtyrVmvVj4Kxc5vaMFixspVV9nuOLdgGjAtDFuF+9emlYUTk
 warUUpcAWcWQ4L8v8KR/kdGGTJJuSyBmsvPpJC43u42nkOkWBxYAT7ljEnAE4/2SoP5u
 1uROuXH1wWOHciq4DTq8WaKO3o9E7A1txag9fPDNcwJXWJhKJDgMiuMTfqHARQdp99dU
 nTZdqkhI5Y10A3YAWmteybzGqDqCRPojMdEPBGZk+Y/av9DTBiNJJHQzj5Q7Pl8I2CTz
 ehRXZmyc7vwcMceMmf09xxuVkuhz9ZMjDC1VeaEQlvA9zTAI+zRUbJOLM8Pd6zcwQSP0 Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v69pj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 23:20:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BNKElD157948;
 Wed, 11 Mar 2020 23:20:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ypv9wexjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 23:20:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02BNK6UO018530;
 Wed, 11 Mar 2020 23:20:06 GMT
Received: from [192.168.14.112] (/109.66.218.218)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 11 Mar 2020 16:20:05 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
Date: Thu, 12 Mar 2020 01:20:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311162509-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/03/2020 22:36, Michael S. Tsirkin wrote:
> Thanks for the patch! Some questions/comments:
>
> On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
>> From: Elad Gabay <elad.gabay@oracle.com>
>>
>> Microsoft introduced this ACPI table to avoid Windows guests performing
>> various workarounds for device erratas. As the virtual device emulated
>> by VMM may not have the errata.
>>
>> Currently, WAET allows hypervisor to inform guest about two
>> specific behaviors: One for RTC and the other for ACPI PM Timer.
>>
>> Support for WAET have been introduced since Windows Vista. This ACPI
>> table is also exposed by other hypervisors, such as VMware, by default.
>>
>> This patch adds WAET ACPI Table to QEMU.
> Could you add a bit more info? Why is this so useful we are adding this
> by default? How does it change windows behaviour when present?
It changes behavior as documented in the WAET specification linked below 
(and the comments above the flags definitions).
Specifically for ACPI_WAET_PM_TIMER_GOOD (Which is the only bit we set), 
the guest performs only one read of ACPI PM Timer instead of multiple to 
obtain it's value.
Which improves performance as it removes unnecessary VMExits.
>
>> It also makes sure to introduce
>> the new ACPI table only for new machine-types.
> OK and why is that?
As ACPI tables are guest-visible, we should make sure to not change it 
between machine-types.
For example, a change in ACPI tables may invalidate a Windows guest 
license activation (As platform have changed).
But this is just a good practice in general and in the past it was said 
by maintainers that this is one of the main reasons that ACPI and SMBIOS 
generation have moved from SeaBIOS to QEMU.
>
>> Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
>> Co-developed-by: Liran Alon <liran.alon@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/acpi-build.c        | 18 ++++++++++++++++++
>>   hw/i386/pc_piix.c           |  2 ++
>>   hw/i386/pc_q35.c            |  2 ++
>>   include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
>>   include/hw/i386/pc.h        |  1 +
>>   5 files changed, 48 insertions(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9c4e46fa7466..29f70741cd96 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>>       build_header(linker, table_data, (void *)(table_data->data + dmar_start),
>>                    "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
>>   }
>> +
>> +static void
>> +build_waet(GArray *table_data, BIOSLinker *linker)
>> +{
>> +    AcpiTableWaet *waet;
>> +
>> +    waet = acpi_data_push(table_data, sizeof(*waet));
> Can combine with the previous line.
Ok. Will do in v2.
>
>> +    waet->emulated_device_flags = cpu_to_le32(ACPI_WAET_PM_TIMER_GOOD);
>> +
>> +    build_header(linker, table_data,
>> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
>> +}
>> +
>>   /*
>>    *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
>>    *   accessible here https://urldefense.com/v3/__http://support.amd.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_ma1nWLZU1aQhDozYgUlrqBZiz1vKdZgg-lTDMIj_5g$
>> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>                             machine->nvdimms_state, machine->ram_slots);
>>       }
>>   
>> +    if (!pcmc->do_not_add_waet_acpi) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_waet(tables_blob, tables->linker);
>> +    }
>> +
>>       /* Add tables supplied by user (if any) */
>>       for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
>>           unsigned len = acpi_table_len(u);
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 9088db8fb601..2d11a8b50a9c 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
>>   
>>   static void pc_i440fx_4_2_machine_options(MachineClass *m)
>>   {
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>       pc_i440fx_5_0_machine_options(m);
>>       m->alias = NULL;
>>       m->is_default = false;
>> +    pcmc->do_not_add_waet_acpi = true;
>>       compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>>       compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>>   }
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 84cf925cf43a..1e0a726b27a7 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
>>   
>>   static void pc_q35_4_2_machine_options(MachineClass *m)
>>   {
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>       pc_q35_5_0_machine_options(m);
>>       m->alias = NULL;
>> +    pcmc->do_not_add_waet_acpi = true;
>>       compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>>       compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>>   }
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index 57a3f58b0c9a..803c904471d5 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -634,4 +634,29 @@ struct AcpiIortRC {
>>   } QEMU_PACKED;
>>   typedef struct AcpiIortRC AcpiIortRC;
>>   
>> +/*
>> + * Windows ACPI Emulated Devices Table.
>> + * Specification:
>> + * https://urldefense.com/v3/__http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_ma1nWLZU1aQhDozYgUlrqBZiz1vKdZgg-lTY0xxqc8$
>> + */
>> +
>> +/*
>> + * Indicates whether the RTC has been enhanced not to require acknowledgment
>> + * after it asserts an interrupt. With this bit set, an interrupt handler can
>> + * bypass reading the RTC register C to unlatch the pending interrupt.
>> + */
>> +#define ACPI_WAET_RTC_GOOD      (1 << 0)
>> +/*
>> + * Indicates whether the ACPI PM timer has been enhanced not to require
>> + * multiple reads. With this bit set, only one read of the ACPI PM timer is
>> + * necessary to obtain a reliable value.
>> + */
>> +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
>> +
> ACPI spec is so huge we really can't add enums for all values,
> it just does not scale.
>
>
> So we switched to a different way to do this: you add e.g. 1 << 1
> in the code directly, and put the comments there.

Ok. I will change this as you say in v2.

BTW it seems other code in acpi-build.c still relies on flags 
definitions in acpi-defs.h (As I have done in this v1). E.g. 
ACPI_DMAR_TYPE_*, ACPI_APIC_*, ACPI_FADT_F_*.
I assume this is just code that wasn't changed yet to the new convention?

> Igor this is becoming a FAQ. Could you write up the way ACPI
> generation code should look?

+1.

Thanks for the review,
-Liran



