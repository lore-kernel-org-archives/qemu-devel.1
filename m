Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECFCC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C22820716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTs3Uz0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C22820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCM3F-0003HH-KT
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCM2Z-0002m4-77
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCM2W-0007eM-Oc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:30:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCM2W-0007YC-EB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:30:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBRkTK108836;
 Thu, 12 Mar 2020 11:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=11axi8Lm1PG1JQHHd+dfLkStsLRSL1Pygc+K4NQ0wmo=;
 b=NTs3Uz0FLbgFIg6nvgag4+TE6sishp7axvk9OpPrbjcJQwf6YC7Hv4qsR+0KuHR5fXhv
 37j+kdKkcWyOCoZCd0KZepP68sbJQW8cmsSwDnfi6ci+oF84KHnRCJAHTREAFPQO9lVm
 d9P+Bd+qAjHTGSjjw+xt32UPEoHtxh9uiG3pbHyaAiGluOMoLvSknWx/LWBU4rnx29v5
 6MFbpYWl6W0NcNg4IhB46HnLtd+pZIbuSgdWtj2i/wZN0f8RdOuOIZuPK37UipV+8cNM
 qmDfjnYFLbITbaaWyestL3s/760uwCjic+Si3MLkLk2N6CJU2kPSPQjmH0hmCCVXX/Vi tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yqkg886y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 11:30:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBMApO080788;
 Thu, 12 Mar 2020 11:30:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yp8r06fxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 11:30:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CBU6TT004514;
 Thu, 12 Mar 2020 11:30:06 GMT
Received: from [192.168.14.112] (/109.66.218.218)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 04:30:06 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
 <20200312012859-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
Date: Thu, 12 Mar 2020 13:30:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312012859-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120062
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 02CBRkTK108836
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/03/2020 8:12, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:
>> On 11/03/2020 22:36, Michael S. Tsirkin wrote:
>>> Thanks for the patch! Some questions/comments:
>>>
>>> On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
>>>> From: Elad Gabay <elad.gabay@oracle.com>
>>>>
>>>> Microsoft introduced this ACPI table to avoid Windows guests perform=
ing
>>>> various workarounds for device erratas. As the virtual device emulat=
ed
>>>> by VMM may not have the errata.
>>>>
>>>> Currently, WAET allows hypervisor to inform guest about two
>>>> specific behaviors: One for RTC and the other for ACPI PM Timer.
>>>>
>>>> Support for WAET have been introduced since Windows Vista. This ACPI
>>>> table is also exposed by other hypervisors, such as VMware, by defau=
lt.
>>>>
>>>> This patch adds WAET ACPI Table to QEMU.
>>> Could you add a bit more info? Why is this so useful we are adding th=
is
>>> by default? How does it change windows behaviour when present?
>> It changes behavior as documented in the WAET specification linked bel=
ow
>> (and the comments above the flags definitions).
>> Specifically for ACPI_WAET_PM_TIMER_GOOD (Which is the only bit we set=
), the
>> guest performs only one read of ACPI PM Timer instead of multiple to o=
btain
>> it's value.
>> Which improves performance as it removes unnecessary VMExits.
> Sounds excellent. Pls include this info in the commit log.
Ok. Will do in v2.
> As with any
> performance optimization, pls add a bit of info about how you tested
> and what kind of speedup was seen.
This is a quite an old patch of ours that I upstream now to contribute=20
to community.
I will need to re-setup such environment for gathering exact performance=20
numbers.

Having said that, note that there isn't really a trade-off here between=20
better performance or something else.
We just expose a bit to guest that says to it: "You don't need to do=20
this useless thing that cause unnecessary VMExits. You can just do this=20
simple operation which is always better because we support it".
Therefore, as long as other guests just ignore this ACPI table (Which=20
they do as far as I've seen from the vast variety of instances we have=20
run on production for over 5 years), exposing this just have positive=20
effect.

Also note that besides VMware which expose it by default, you can also=20
see this exposed by default by some cloud hypervisors, such as GCP:
[=C2=A0=C2=A0=C2=A0 0.000000] ACPI: WAET 0x00000000BFFF5CE0 000028 (v01 G=
oogle GOOGWAET=20
00000001 GOOG 00000001)

>>>> It also makes sure to introduce
>>>> the new ACPI table only for new machine-types.
>>> OK and why is that?
>> As ACPI tables are guest-visible, we should make sure to not change it
>> between machine-types.
>> For example, a change in ACPI tables may invalidate a Windows guest li=
cense
>> activation (As platform have changed).
> I don't think there's something like this taken into account, no.
Windows measures at boot-time if the hardware have "changed too much"=20
since activation.
The way it does so, is calculating a "weighted diff score" based on a=20
number of hardware properties.

It is at least documented internally in Ravello that some guests have=20
been witnessed to broke their license activation because of ACPI/SMBIOS=20
changes.

>> But this is just a good practice in general and in the past it was sai=
d by
>> maintainers that this is one of the main reasons that ACPI and SMBIOS
>> generation have moved from SeaBIOS to QEMU.
> I think a flag to disable this might make sense though. For example,
> some guests might behave differently and get broken.
Right. That's why I think it's a good practice to have this flag and tie=20
it to machine-type.
Guest-visible changes shouldn't be exposed to old machine-types.
>
>
>>>> Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
>>>> Co-developed-by: Liran Alon <liran.alon@oracle.com>
>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>> ---
>>>>    hw/i386/acpi-build.c        | 18 ++++++++++++++++++
>>>>    hw/i386/pc_piix.c           |  2 ++
>>>>    hw/i386/pc_q35.c            |  2 ++
>>>>    include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
>>>>    include/hw/i386/pc.h        |  1 +
>>>>    5 files changed, 48 insertions(+)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 9c4e46fa7466..29f70741cd96 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker=
 *linker)
>>>>        build_header(linker, table_data, (void *)(table_data->data + =
dmar_start),
>>>>                     "DMAR", table_data->len - dmar_start, 1, NULL, N=
ULL);
>>>>    }
>>>> +
>>>> +static void
>>>> +build_waet(GArray *table_data, BIOSLinker *linker)
> Add documentation that it's a Windows Emulated Device Flags table,
> helpful to speed up windows guests, and ignored by others.
Ok. Will do in v2.
>
>>>> +{
>>>> +    AcpiTableWaet *waet;
>>>> +
>>>> +    waet =3D acpi_data_push(table_data, sizeof(*waet));
>>> Can combine with the previous line.
>> Ok. Will do in v2.
>>>> +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_=
GOOD);
>>>> +
>>>> +    build_header(linker, table_data,
>>>> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL=
);
>>>> +}
>>>> +
>>>>    /*
>>>>     *   IVRS table as specified in AMD IOMMU Specification v2.62, Se=
ction 5.2
>>>>     *   accessible here https://urldefense.com/v3/__http://support.a=
md.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_ma1=
nWLZU1aQhDozYgUlrqBZiz1vKdZgg-lTDMIj_5g$
>>>> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Mach=
ineState *machine)
>>>>                              machine->nvdimms_state, machine->ram_sl=
ots);
>>>>        }
>>>> +    if (!pcmc->do_not_add_waet_acpi) {
>>>> +        acpi_add_table(table_offsets, tables_blob);
>>>> +        build_waet(tables_blob, tables->linker);
>>>> +    }
>>>> +
>>>>        /* Add tables supplied by user (if any) */
>>>>        for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
>>>>            unsigned len =3D acpi_table_len(u);
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index 9088db8fb601..2d11a8b50a9c 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NU=
LL,
>>>>    static void pc_i440fx_4_2_machine_options(MachineClass *m)
>>>>    {
>>>> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>>        pc_i440fx_5_0_machine_options(m);
>>>>        m->alias =3D NULL;
>>>>        m->is_default =3D false;
>>>> +    pcmc->do_not_add_waet_acpi =3D true;
>>>>        compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_=
2_len);
>>>>        compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_=
2_len);
>>>>    }
>>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>>> index 84cf925cf43a..1e0a726b27a7 100644
>>>> --- a/hw/i386/pc_q35.c
>>>> +++ b/hw/i386/pc_q35.c
>>>> @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
>>>>    static void pc_q35_4_2_machine_options(MachineClass *m)
>>>>    {
>>>> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>>        pc_q35_5_0_machine_options(m);
>>>>        m->alias =3D NULL;
>>>> +    pcmc->do_not_add_waet_acpi =3D true;
>>>>        compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_=
2_len);
>>>>        compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_=
2_len);
>>>>    }
>>>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs=
.h
>>>> index 57a3f58b0c9a..803c904471d5 100644
>>>> --- a/include/hw/acpi/acpi-defs.h
>>>> +++ b/include/hw/acpi/acpi-defs.h
>>>> @@ -634,4 +634,29 @@ struct AcpiIortRC {
>>>>    } QEMU_PACKED;
>>>>    typedef struct AcpiIortRC AcpiIortRC;
>>>> +/*
>>>> + * Windows ACPI Emulated Devices Table.
>>>> + * Specification:
>>>> + * https://urldefense.com/v3/__http://download.microsoft.com/downlo=
ad/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx____;!!GqivPVa7Bri=
o!MX1Hzr4X9NtS4pcT1Kb4VlDoV-pobn4n6YYQCkU3U-7imIaxXmu_ZsQzPB0e2Tc$
> Please include
> - name of the spec
The name of the spec is "Windows ACPI Emulated Devices Table".
You can see this by entering above link...
> - earliest revision that includes the relevant bits
The above link is to version 1.0 of the document (Which as far as I=20
know, is the only version ever released).
So the bits exists in all revisions. Which documentation do you want me=20
to add then?

Also, according to your previous comment, I'm removing these bits=20
definitions from here and just putting (1 << 1)
directly in build_waet() code with a comment of what is the bit I'm=20
signaling there (i.e. PM_TIMER_GOOD).

>
>
>>>> + */
>>>> +
>>>> +/*
>>>> + * Indicates whether the RTC has been enhanced not to require ackno=
wledgment
>>>> + * after it asserts an interrupt. With this bit set, an interrupt h=
andler can
>>>> + * bypass reading the RTC register C to unlatch the pending interru=
pt.
>>>> + */
>>>> +#define ACPI_WAET_RTC_GOOD      (1 << 0)
> Include the name of the field exactly as it appears in the spec pls.
> "RTC good"?
Yes, it's named "RTC good" in spec.
Anyway, I removed this bit and it's documentation from v2 as you asked=20
in previous reply.
>
> So if you feel you need to document that this bit is clear, you can do =
it
> like this:
>
> 	 /* Bit 0 - PV RTC which doesn't need an acknowledgment after an inter=
rupt assert.
> 	    Clear since our RTC behaves like the hardware one. */
>
>>>> +/*
>>>> + * Indicates whether the ACPI PM timer has been enhanced not to req=
uire
>>>> + * multiple reads. With this bit set, only one read of the ACPI PM =
timer is
>>>> + * necessary to obtain a reliable value.
>>>> + */
>>>> +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
> Go easy on what we do, and harder on why please:
>
> 	/* ACPI PM timer good - tells windows guests our PM timer is reliable =
-
> 	 * guests then avoid re-reading it.
> 	 */
> should be enough.

Ok... Will change to your phrasing in v2.

-Liran



