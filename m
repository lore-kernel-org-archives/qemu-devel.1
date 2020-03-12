Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA379C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5603D206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v9JRawGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5603D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNOY-000173-I4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCNNc-0008Bi-AW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCNNZ-0006qA-IY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCNNZ-0006pK-8L
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CCrNVc167503;
 Thu, 12 Mar 2020 12:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dWRkJh5rLOGEsDK/JlUB4jDFh1pTlF083d7SlQZroEo=;
 b=v9JRawGX2b4yZ9WMDuCou+OmIuP05E0iK6GQsAVFQDdBOMouEI6MZ5/XCC4rVwazlLEm
 IHgeM/7aWdb4pKlSUaX+q7iRnKj25ahcmX0qS8wsirtFyJ2CUnUfJ6tDEXPYdtyulixh
 wKD37o2YgLhf+3xEOhN/HVJtkCqrBk6qySBxBkj7lvjcUJBbXQ7bkQV8eRQZavc200hY
 t2BiTBWPvyIlVnngTTP9HQSQu3Ys1nAz/3xHVRC6/SLgnDLb4HPBABQ6DX7LoKcDI/fE
 +z3PkaSfh8//72+sWT7JRZxYp0e3pthpVt2wWZ1zILxtlbmO39Yz+92cCwywd5UOGko+ 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yqkg88kck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 12:55:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CCqAPS155204;
 Thu, 12 Mar 2020 12:55:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2yp8r0b4m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 12:55:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CCttGI025314;
 Thu, 12 Mar 2020 12:55:55 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 05:55:55 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
 <20200312012859-mutt-send-email-mst@kernel.org>
 <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
 <20200312080602-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <adbb172c-a6b2-f2a5-3f35-dbc353e4f716@oracle.com>
Date: Thu, 12 Mar 2020 14:55:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312080602-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120070
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 02CCrNVc167503
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


On 12/03/2020 14:19, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 01:30:01PM +0200, Liran Alon wrote:
>> On 12/03/2020 8:12, Michael S. Tsirkin wrote:
>>> On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:
>>>> On 11/03/2020 22:36, Michael S. Tsirkin wrote:
>>>>> Thanks for the patch! Some questions/comments:
>>>>>
>>>>> On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
>>>>>> From: Elad Gabay <elad.gabay@oracle.com>
>>>>>>
>>>>>> Microsoft introduced this ACPI table to avoid Windows guests perfo=
rming
>>>>>> various workarounds for device erratas. As the virtual device emul=
ated
>>>>>> by VMM may not have the errata.
>>>>>>
>>>>>> Currently, WAET allows hypervisor to inform guest about two
>>>>>> specific behaviors: One for RTC and the other for ACPI PM Timer.
>>>>>>
>>>>>> Support for WAET have been introduced since Windows Vista. This AC=
PI
>>>>>> table is also exposed by other hypervisors, such as VMware, by def=
ault.
>>>>>>
>>>>>> This patch adds WAET ACPI Table to QEMU.
>>>>> Could you add a bit more info? Why is this so useful we are adding =
this
>>>>> by default? How does it change windows behaviour when present?
>>>> It changes behavior as documented in the WAET specification linked b=
elow
>>>> (and the comments above the flags definitions).
>>>> Specifically for ACPI_WAET_PM_TIMER_GOOD (Which is the only bit we s=
et), the
>>>> guest performs only one read of ACPI PM Timer instead of multiple to=
 obtain
>>>> it's value.
>>>> Which improves performance as it removes unnecessary VMExits.
>>> Sounds excellent. Pls include this info in the commit log.
>> Ok. Will do in v2.
>>> As with any
>>> performance optimization, pls add a bit of info about how you tested
>>> and what kind of speedup was seen.
>> This is a quite an old patch of ours that I upstream now to contribute=
 to
>> community.
>> I will need to re-setup such environment for gathering exact performan=
ce
>> numbers.
>>
>> Having said that, note that there isn't really a trade-off here betwee=
n
>> better performance or something else.
> Well some guests are known to make crazy assumptions. E.g. they would
> see this bit and say "oh so I know this hyperv" or something to
> that end.
I agree some guests make crazy assumptions like this.
For this specific case, we haven't witnessed this in a very wide variety=20
of guests.
Another evidence that this is pretty much safe is that this is exposed=20
by default in VMware, Xen HVM, GCP and AWS.
>> We just expose a bit to guest that says to it: "You don't need to do t=
his
>> useless thing that cause unnecessary VMExits. You can just do this sim=
ple
>> operation which is always better because we support it".
>> Therefore, as long as other guests just ignore this ACPI table (Which =
they
>> do as far as I've seen from the vast variety of instances we have run =
on
>> production for over 5 years), exposing this just have positive effect.
>>
>> Also note that besides VMware which expose it by default, you can also=
 see
>> this exposed by default by some cloud hypervisors, such as GCP:
>> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: WAET 0x00000000BFFF5CE0 000028 (v0=
1 Google GOOGWAET
>> 00000001 GOOG 00000001)
>>
>>>>>> It also makes sure to introduce
>>>>>> the new ACPI table only for new machine-types.
>>>>> OK and why is that?
>>>> As ACPI tables are guest-visible, we should make sure to not change =
it
>>>> between machine-types.
>>>> For example, a change in ACPI tables may invalidate a Windows guest =
license
>>>> activation (As platform have changed).
>>> I don't think there's something like this taken into account, no.
>> Windows measures at boot-time if the hardware have "changed too much" =
since
>> activation.
>> The way it does so, is calculating a "weighted diff score" based on a =
number
>> of hardware properties.
>>
>> It is at least documented internally in Ravello that some guests have =
been
>> witnessed to broke their license activation because of ACPI/SMBIOS cha=
nges.
> Any data on which changes exactly?
> All I know about is this list, though it's pretty old.
> https://urldefense.com/v3/__https://docs.microsoft.com/en-us/previous-v=
ersions/windows/it-pro/windows-xp/bb457054(v=3Dtechnet.10)?redirectedfrom=
=3DMSDN__;!!GqivPVa7Brio!Ib_edgcD6o9nJ4KPgv-iV660VzKRAUJUIuQvlr_RT0JRSZxe=
hpt37AmxFt84MtI$
This list is indeed very incomplete. For example, a simple change in=20
BIOS-UUID exposed via SMBIOS also breaks activation.
>
> Any chance it was actually to do with the EOM table that bypasses
> activation?

No, we never expose that table to guest in Ravello.

But anyway, this is kinda of a side-discussion...
My general argument is that we prefer that a guest running with=20
machine-type X won't be exposed with new hardware/bios properties.
>
>>>> But this is just a good practice in general and in the past it was s=
aid by
>>>> maintainers that this is one of the main reasons that ACPI and SMBIO=
S
>>>> generation have moved from SeaBIOS to QEMU.
>>> I think a flag to disable this might make sense though. For example,
>>> some guests might behave differently and get broken.
>> Right. That's why I think it's a good practice to have this flag and t=
ie it
>> to machine-type.
> Tying things to the machine type is not what I had in mind.
> A separate flag would also be helpful so users can tweak this
> for new machine types, too.
I think it's unnecessary, given how common WAET ACPI table is exposed by=20
default by other hypervisors.

But if you insist, I can add such flag on a separate commit in v2...
Where do you want to have such flag? It cannot be a property of some=20
qdev object.
So you want to add a new QEMU_OPTION_no_weat in vl.c?

>> Guest-visible changes shouldn't be exposed to old machine-types.
> Well almost any change in qemu is guest visible to some level.
> Even optimizations are guest visible.
> We made changes in ACPI without versioning in the past but I'm not
> opposed to versioning here. However in that case pls do add a bit
> of documentation about why this is done here.
I remember that maintainers have explicitly specified that ACPI/SMBIOS=20
should not be changed between machine-types.
This have been one of the reasons to move ACPI/SMBIOS generation from=20
SeaBIOS to QEMU control.

What can of documentation you want me to add and where?
The only thing I can say is that I tie it to machine-type because I do=20
not think a given machine-type should suddenly change BIOS exposed info=20
to guest.
But that's kinda generic. I haven't found similar documentation in other=20
ACPI-disable flags to copy from (E.g. do_not_add_smb_acpi).

> What I am asking about is whether we need a flag to disable
> this as part of the stable interface.
I personally think not. But if you think otherwise, can you provide=20
guidance of where you suggest to add this flag?
As the only place I see fit is adding a new QEMU_OPTION_no_weat.
>
>>>
>>>>>> Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
>>>>>> Co-developed-by: Liran Alon <liran.alon@oracle.com>
>>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>>> ---
>>>>>>     hw/i386/acpi-build.c        | 18 ++++++++++++++++++
>>>>>>     hw/i386/pc_piix.c           |  2 ++
>>>>>>     hw/i386/pc_q35.c            |  2 ++
>>>>>>     include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
>>>>>>     include/hw/i386/pc.h        |  1 +
>>>>>>     5 files changed, 48 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>>> index 9c4e46fa7466..29f70741cd96 100644
>>>>>> --- a/hw/i386/acpi-build.c
>>>>>> +++ b/hw/i386/acpi-build.c
>>>>>> @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLink=
er *linker)
>>>>>>         build_header(linker, table_data, (void *)(table_data->data=
 + dmar_start),
>>>>>>                      "DMAR", table_data->len - dmar_start, 1, NULL=
, NULL);
>>>>>>     }
>>>>>> +
>>>>>> +static void
>>>>>> +build_waet(GArray *table_data, BIOSLinker *linker)
>>> Add documentation that it's a Windows Emulated Device Flags table,
>>> helpful to speed up windows guests, and ignored by others.
>> Ok. Will do in v2.
>>>>>> +{
>>>>>> +    AcpiTableWaet *waet;
>>>>>> +
>>>>>> +    waet =3D acpi_data_push(table_data, sizeof(*waet));
>>>>> Can combine with the previous line.
>>>> Ok. Will do in v2.
>>>>>> +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIME=
R_GOOD);
>>>>>> +
>>>>>> +    build_header(linker, table_data,
>>>>>> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NU=
LL);
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      *   IVRS table as specified in AMD IOMMU Specification v2.62,=
 Section 5.2
>>>>>>      *   accessible here https://urldefense.com/v3/__http://suppor=
t.amd.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_=
ma1nWLZU1aQhDozYgUlrqBZiz1vKdZgg-lTDMIj_5g$
>>>>>> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Ma=
chineState *machine)
>>>>>>                               machine->nvdimms_state, machine->ram=
_slots);
>>>>>>         }
>>>>>> +    if (!pcmc->do_not_add_waet_acpi) {
>>>>>> +        acpi_add_table(table_offsets, tables_blob);
>>>>>> +        build_waet(tables_blob, tables->linker);
>>>>>> +    }
>>>>>> +
>>>>>>         /* Add tables supplied by user (if any) */
>>>>>>         for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)=
) {
>>>>>>             unsigned len =3D acpi_table_len(u);
>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>> index 9088db8fb601..2d11a8b50a9c 100644
>>>>>> --- a/hw/i386/pc_piix.c
>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>> @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", =
NULL,
>>>>>>     static void pc_i440fx_4_2_machine_options(MachineClass *m)
>>>>>>     {
>>>>>> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>>>>         pc_i440fx_5_0_machine_options(m);
>>>>>>         m->alias =3D NULL;
>>>>>>         m->is_default =3D false;
>>>>>> +    pcmc->do_not_add_waet_acpi =3D true;
>>>>>>         compat_props_add(m->compat_props, hw_compat_4_2, hw_compat=
_4_2_len);
>>>>>>         compat_props_add(m->compat_props, pc_compat_4_2, pc_compat=
_4_2_len);
>>>>>>     }
>>>>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>>>>> index 84cf925cf43a..1e0a726b27a7 100644
>>>>>> --- a/hw/i386/pc_q35.c
>>>>>> +++ b/hw/i386/pc_q35.c
>>>>>> @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
>>>>>>     static void pc_q35_4_2_machine_options(MachineClass *m)
>>>>>>     {
>>>>>> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>>>>         pc_q35_5_0_machine_options(m);
>>>>>>         m->alias =3D NULL;
>>>>>> +    pcmc->do_not_add_waet_acpi =3D true;
>>>>>>         compat_props_add(m->compat_props, hw_compat_4_2, hw_compat=
_4_2_len);
>>>>>>         compat_props_add(m->compat_props, pc_compat_4_2, pc_compat=
_4_2_len);
>>>>>>     }
>>>>>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-de=
fs.h
>>>>>> index 57a3f58b0c9a..803c904471d5 100644
>>>>>> --- a/include/hw/acpi/acpi-defs.h
>>>>>> +++ b/include/hw/acpi/acpi-defs.h
>>>>>> @@ -634,4 +634,29 @@ struct AcpiIortRC {
>>>>>>     } QEMU_PACKED;
>>>>>>     typedef struct AcpiIortRC AcpiIortRC;
>>>>>> +/*
>>>>>> + * Windows ACPI Emulated Devices Table.
>>>>>> + * Specification:
>>>>>> + * https://urldefense.com/v3/__http://download.microsoft.com/down=
load/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx____;!!GqivPVa7B=
rio!MX1Hzr4X9NtS4pcT1Kb4VlDoV-pobn4n6YYQCkU3U-7imIaxXmu_ZsQzPB0e2Tc$
>>> Please include
>>> - name of the spec
>> The name of the spec is "Windows ACPI Emulated Devices Table".
>> You can see this by entering above link...
> Links go stale. Then someone will have to dig to find the new location.
> Name of the document will be helpful for that.
I don't get what you wish to add. The name of the document is "Windows=20
ACPI Emulated Device Table"...
It's reasonable to expect someone which encounters this link to be=20
broken to search Google for "Windows ACPI Emulated Device Table=20
specification".
>>> - earliest revision that includes the relevant bits
>> The above link is to version 1.0 of the document (Which as far as I kn=
ow, is
>> the only version ever released).
>> So the bits exists in all revisions. Which documentation do you want m=
e to
>> add then?
> 1. name of the document
> 2. revision of the document that includes the bit (if multiple,
> include the earliest revision)

I have added on top of build_waet() the following comment in v2:

+/*
+ * Windows ACPI Emulated Devices Table
+ * (Version 1.0 - April 6, 2009)
+ *
+ * Helpful to speedup Windows guests and ignored by others.
+ */

I hope this match to what you are looking for...

-Liran



