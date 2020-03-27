Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66876206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/RBkNR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66876206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqi6-0004KU-Gy
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jHqh4-0003p6-JA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jHqh1-0002kx-QW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:14:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jHqh1-0002Yr-HN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:14:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RFBTEn193357;
 Fri, 27 Mar 2020 15:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gO1NN8mZYVXj3V22/uOOljzOruo9HtA9uf/qRwMVaz4=;
 b=G/RBkNR7PRAYQ7EsyiGAPKKYrG0XjTVIMAY2OOMRgguMbfAd2165WgoKpcKy7ODJTyzQ
 VNVgfaTMchVfB/LRYJpxXoMU20XzYI613COAxI7cMkwUYr+NgvswUg+P5mX9VcE2qdFx
 JzP0LqOUchU8147TXrxi4EeareEPBnW31dsK8NtHXdx/RAEQj4lHkOo/9UIKBnU3+uWQ
 NKWb4/nokd73vnbHhwivhy8m9Zgbs0aBN9NBn0bqlehVbGOhruXRxcZ99cvLD+jBNXgX
 b8+txsmZniTN/WcbJB89k8JTu/rffDQbuKnU8013KzaUcrOljTnjFKybJio+ZwHUHfTC qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 3019veat3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2020 15:14:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RF6g4a132311;
 Fri, 27 Mar 2020 15:14:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 30073gxybx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2020 15:14:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02RFEY9n008674;
 Fri, 27 Mar 2020 15:14:34 GMT
Received: from [192.168.14.112] (/79.180.216.197)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 27 Mar 2020 08:14:34 -0700
Subject: Re: [PATCH v2 2/3] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: Igor Mammedov <imammedo@redhat.com>
References: <20200313145009.144820-1-liran.alon@oracle.com>
 <20200313145009.144820-3-liran.alon@oracle.com>
 <20200316112851.2364eb46@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <14ca89b0-b272-9efd-42f3-18d1224c679b@oracle.com>
Date: Fri, 27 Mar 2020 18:14:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200316112851.2364eb46@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As almost two weeks have passed since this Reviewed-By comment, can I 
assume this series is done from my perspective and ready to be merged?
As I haven't seen a Reviewed-By for the rest of the patches of this series.

Thanks,
-Liran

On 16/03/2020 12:28, Igor Mammedov wrote:
> On Fri, 13 Mar 2020 16:50:08 +0200
> Liran Alon <liran.alon@oracle.com> wrote:
>
>> Microsoft introduced this ACPI table to avoid Windows guests performing
>> various workarounds for device erratas. As the virtual device emulated
>> by VMM may not have the errata.
>>
>> Currently, WAET allows hypervisor to inform guest about two
>> specific behaviors: One for RTC and the other for ACPI PM timer.
>>
>> Support for WAET have been introduced since Windows Vista. This ACPI
>> table is also exposed by other common hypervisors by default, including:
>> VMware, GCP and AWS.
>>
>> This patch adds WAET ACPI Table to QEMU.
>>
>> We set "ACPI PM timer good" bit in "Emualted Device Flags" field to
>> indicate that the ACPI PM timer has been enhanced to not require
>> multiple reads to obtain a reliable value.
>> This results in improving the performance of Windows guests that use
>> ACPI PM timer by avoiding unnecessary VMExits caused by these multiple
>> reads.
>>
>> Co-developed-by: Elad Gabay <elad.gabay@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
>> ---
>>   hw/i386/acpi-build.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9c4e46fa7466..1c3a2e8fcb3c 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2512,6 +2512,34 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>>       build_header(linker, table_data, (void *)(table_data->data + dmar_start),
>>                    "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
>>   }
>> +
>> +/*
>> + * Windows ACPI Emulated Devices Table
>> + * (Version 1.0 - April 6, 2009)
>> + * Spec: https://urldefense.com/v3/__http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx__;!!GqivPVa7Brio!MpZ69-947P6dY4Rnd8Cvj0z_9yJ1QdS-SED39RJ5JvT7Rry_rwDpcLlUDJ_ZU7U$
>> + *
>> + * Helpful to speedup Windows guests and ignored by others.
>> + */
>> +static void
>> +build_waet(GArray *table_data, BIOSLinker *linker)
>> +{
>> +    int waet_start = table_data->len;
>> +
>> +    /* WAET header */
>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +    /*
>> +     * Set "ACPI PM timer good" flag.
>> +     *
>> +     * Tells Windows guests that our ACPI PM timer is reliable in the
>> +     * sense that guest can read it only once to obtain a reliable value.
>> +     * Which avoids costly VMExits caused by guest re-reading it unnecessarily.
>> +     */
>> +    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good */, 4);
> this should work but, I'd use (1UL << 1) if you'll need to respin
>
>
>> +
>> +    build_header(linker, table_data, (void *)(table_data->data + waet_start),
>> +                 "WAET", table_data->len - waet_start, 1, NULL, NULL);
>> +}
>> +
>>   /*
>>    *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
>>    *   accessible here https://urldefense.com/v3/__http://support.amd.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!MpZ69-947P6dY4Rnd8Cvj0z_9yJ1QdS-SED39RJ5JvT7Rry_rwDpcLlUNZTUAnw$
>> @@ -2859,6 +2887,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>                             machine->nvdimms_state, machine->ram_slots);
>>       }
>>   
>> +    acpi_add_table(table_offsets, tables_blob);
>> +    build_waet(tables_blob, tables->linker);
>> +
>>       /* Add tables supplied by user (if any) */
>>       for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
>>           unsigned len = acpi_table_len(u);

