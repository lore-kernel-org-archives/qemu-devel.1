Received: from eggs.gnu.org ([2001:4830:134:3::10]:48949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fIsNr-0005Ta-Fd
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fIsNm-0006Md-Cn
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fIsNm-0006Ia-4Q
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:06:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4G94dSD116571
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 05:05:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0fvddn70-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 05:05:57 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 16 May 2018 10:05:55 +0100
Reply-To: pmorel@linux.ibm.com
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<b43bdfdb-4c00-646d-efbd-1f411350929e@linux.ibm.com>
	<5b4c089d-a586-c76b-e1d7-6c2f2183b69b@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 16 May 2018 11:05:47 +0200
MIME-Version: 1.0
In-Reply-To: <5b4c089d-a586-c76b-e1d7-6c2f2183b69b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1442f59a-f422-c76e-f6dc-ea9d677d0202@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 15/05/2018 17:03, Tony Krowiak wrote:
> On 05/15/2018 08:00 AM, Pierre Morel wrote:
>> On 08/05/2018 14:25, Tony Krowiak wrote:
>>> A new CPU model feature and two new CPU model facilities are
>>> introduced to support AP devices for a KVM guest.
>>>
>>> CPU model features:
>>>
>>> 1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
>>> =C2=A0=C2=A0=C2=A0 AP facilities are installed. This feature will be =
enabled by
>>> =C2=A0=C2=A0=C2=A0 the kernel only if the AP facilities are installed=
 on the linux
>>> =C2=A0=C2=A0=C2=A0 host. This feature must be turned on from userspac=
e to access
>>> =C2=A0=C2=A0=C2=A0 AP devices from the KVM guest. The QEMU command li=
ne to turn
>>> =C2=A0=C2=A0=C2=A0 this feature looks something like this:
>>>
>>> =C2=A0=C2=A0=C2=A0 qemu-system-s390x ... -cpu xxx,ap=3Don
>>>
>>> =C2=A0=C2=A0=C2=A0 This feature will be supported for zEC12 and newer=
 CPU models.
>>> =C2=A0=C2=A0=C2=A0 The feature will not be supported for older models=
 due to
>>> =C2=A0=C2=A0=C2=A0 testability issues.
>>>
>>> CPU model facilities:
>>>
>>> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
>>> =C2=A0=C2=A0=C2=A0 Configuration Information (QCI) facility is instal=
led. This feature
>>> =C2=A0=C2=A0=C2=A0 will be enabled by the kernel only if the QCI is i=
nstalled on
>>> =C2=A0=C2=A0=C2=A0 the host.
>>>
>>> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
>>> =C2=A0=C2=A0=C2=A0 Facility Test (APFT) facility is installed. This f=
eature will
>>> =C2=A0=C2=A0=C2=A0 be enabled by the kernel only if the APFT facility=
 is installed
>>> =C2=A0=C2=A0=C2=A0 on the host.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 target/s390x/cpu_features.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 3 +++
>>> =C2=A0 target/s390x/cpu_features_def.h |=C2=A0=C2=A0=C2=A0 3 +++
>>> =C2=A0 target/s390x/cpu_models.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0=C2=A0 2 ++
>>> =C2=A0 target/s390x/gen-features.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 3 +++
>>> =C2=A0 target/s390x/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 5 files changed, 12 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.=
c
>>> index 3b9e274..f344323 100644
>>> --- a/target/s390x/cpu_features.c
>>> +++ b/target/s390x/cpu_features.c
>>> @@ -40,8 +40,10 @@ static const S390FeatDef s390_features[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("srs", S390_FEAT_TYPE_STFL, =
9, "Sense-running-status=20
>>> facility"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("csske", S390_FEAT_TYPE_STFL=
, 10, "Conditional-SSKE=20
>>> facility"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("ctop", S390_FEAT_TYPE_STFL,=
 11,=20
>>> "Configuration-topology facility"),
>>> +=C2=A0=C2=A0=C2=A0 FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Quer=
y AP=20
>>> Configuration facility"),
>>
>> Not a big deal, but why forget the I for "Information" in the long=20
>> description for APQCI
>
> I'll add 'Information'.
>
>>
>> Also why not just "QCI" (I think it was already asked)
>
> It was a suggestion from Reinhard with which I agreed. We may know=20
> that QCI is an AP function,
> but most administrators will have no idea. Prepending the 'ap' informs=20
> that QCI is an
> AP function related to the CPU model feature for AP.

QCI is the official name and will be refered as this in the official=20
documentation (if it is).
Most admin will use libvirt anyway and the one which will try to use=20
qemu will look for
apqci in the official documentation and will not find it.
I do not think it is a good idea, but technically does not change anythin=
g.
Keep my RB even you stay by apqci or change for qci.

>
>>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("ipter", S390_FEAT_TYPE_STFL=
, 13, "IPTE-range=20
>>> facility"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("nonqks", S390_FEAT_TYPE_STF=
L, 14, "Nonquiescing=20
>>> key-setting facility"),
>>> +=C2=A0=C2=A0=C2=A0 FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "Adjun=
ct Processor=20
>>> Facilities Test facility"),
>>
>> Not a big deal too, but you always use AP instead of Adjunct=20
>> Processor, why not here too?
>
> No reason, I can change it if you like.
>
>>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("etf2", S390_FEAT_TYPE_STFL,=
 16,=20
>>> "Extended-translation facility 2"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("msa-base", S390_FEAT_TYPE_S=
TFL, 17,=20
>>> "Message-security-assist facility (excluding subfunctions)"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL=
, 18, "Long-displacement=20
>>> facility"),
>>> @@ -129,6 +131,7 @@ static const S390FeatDef s390_features[] =3D {
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT_MISC("dateh2", "DAT-enhancem=
ent facility 2"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT_MISC("cmm", "Collaborative-m=
emory-management=20
>>> facility"),
>>> +=C2=A0=C2=A0=C2=A0 FEAT_INIT_MISC("ap", "AP instructions installed")=
,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO=
, 0, "PLO Compare and=20
>>> load (32 bit in general registers)"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("plo-clg", S390_FEAT_TYPE_PL=
O, 1, "PLO Compare and=20
>>> load (64 bit in parameter list)"),
>>> diff --git a/target/s390x/cpu_features_def.h=20
>>> b/target/s390x/cpu_features_def.h
>>> index 7c5915c..8998b65 100644
>>> --- a/target/s390x/cpu_features_def.h
>>> +++ b/target/s390x/cpu_features_def.h
>>> @@ -27,8 +27,10 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_SENSE_RUNNING_STATUS,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_CONDITIONAL_SSKE,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_CONFIGURATION_TOPOLOGY,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP_QUERY_CONFIG_INFO,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_IPTE_RANGE,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_NONQ_KEY_SETTING,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP_FACILITIES_TEST,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_EXTENDED_TRANSLATION_2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_MSA,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_LONG_DISPLACEMENT,
>>> @@ -118,6 +120,7 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Misc */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_DAT_ENH_2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_CMM,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PLO */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_PLO_CL,
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index e10035a..5d834b4 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -770,6 +770,8 @@ static void check_consistency(const S390CPUModel=20
>>> *model)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { S390_FEAT_PR=
NO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { S390_FEAT_PR=
NO_TRNG, S390_FEAT_MSA_EXT_5 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { S390_FEAT_SI=
E_KSS, S390_FEAT_SIE_F2 },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { S390_FEAT_AP_QUERY_CONF=
IG_INFO, S390_FEAT_AP },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { S390_FEAT_AP_FACILITIES=
_TEST, S390_FEAT_AP },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>
>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.=
c
>>> index 0cdbc15..0d5b0f7 100644
>>> --- a/target/s390x/gen-features.c
>>> +++ b/target/s390x/gen-features.c
>>> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_EDAT_2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP_QUERY_CONFIG_INFO,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP_FACILITIES_TEST,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_AP,
>>> =C2=A0 };
>>>
>>> =C2=A0 static uint16_t full_GEN12_GA2[] =3D {
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 12b90cf..4d8c344 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2082,6 +2082,7 @@ static int kvm_to_feat[][2] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEA=
T_SIE_PFMFI},
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FE=
AT_SIE_SIGPIF},
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_=
SIE_KSS},
>>> +=C2=A0=C2=A0=C2=A0 { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},
>>> =C2=A0 };
>>>
>>> =C2=A0 static int query_cpu_feat(S390FeatBitmap features)
>>
>>
>> LGTM despite the two little things with which I do not agree 100%
>
>>
>>
>> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
