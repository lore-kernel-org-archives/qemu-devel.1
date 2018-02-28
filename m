Received: from eggs.gnu.org ([2001:4830:134:3::10]:58480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqywy-0003ER-LD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqywv-0006ZX-Fy
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:27:04 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
Date: Wed, 28 Feb 2018 11:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
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
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

> KVM detects whether the AP instructions are installed on the host. If
> the instructions are installed, the feature is allowed (enabled) and
> can be turned on by userspace (QEMU).

As mentioned in the KVM thread, I'd like to verify if there is not a AP
interpretation facility.

>>
>> IOW: is this really a CPU model feature?
> I believe it is a necessary feature and came about due to review commen=
ts
> from Christian and Connie in v1.

Yes, I can see how this is guest ABI. But we always have to take care of
ever potentially wanting to emulate this in QEMU. But if we can turn
interpretation on/off using the feature flag, I am happy.

>>
>>>  =20
>>>       FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and loa=
d (32 bit in general registers)"),
>>>       FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and lo=
ad (64 bit in parameter list)"),
>>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_featu=
res_def.h
>>> index 7c5915c..8998b65 100644
>>> --- a/target/s390x/cpu_features_def.h
>>> +++ b/target/s390x/cpu_features_def.h
>>> @@ -27,8 +27,10 @@ typedef enum {
>>>       S390_FEAT_SENSE_RUNNING_STATUS,
>>>       S390_FEAT_CONDITIONAL_SSKE,
>>>       S390_FEAT_CONFIGURATION_TOPOLOGY,
>>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>>>       S390_FEAT_IPTE_RANGE,
>>>       S390_FEAT_NONQ_KEY_SETTING,
>>> +    S390_FEAT_AP_FACILITIES_TEST,
>>>       S390_FEAT_EXTENDED_TRANSLATION_2,
>>>       S390_FEAT_MSA,
>>>       S390_FEAT_LONG_DISPLACEMENT,
>>> @@ -118,6 +120,7 @@ typedef enum {
>>>       /* Misc */
>>>       S390_FEAT_DAT_ENH_2,
>>>       S390_FEAT_CMM,
>>> +    S390_FEAT_AP,
>>>  =20
>>>       /* PLO */
>>>       S390_FEAT_PLO_CL,
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 1d5f0da..35f91ea 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -770,6 +770,8 @@ static void check_consistency(const S390CPUModel =
*model)
>>>           { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>>>           { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
>>>           { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
>>> +        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
>>> +        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },

Saw this way too late :)

>>
>>>  =20
>>>   static uint16_t full_GEN12_GA2[] =3D {
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index e13c890..ae20ed8 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2105,6 +2105,7 @@ static int kvm_to_feat[][2] =3D {
>>>       { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>>>       { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
>>>       { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
>>> +    { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},
>> Nothing speaks against the STFL bits, want to learn more about the
>> S390_FEAT_AP feature :)
> There are a couple of primary reasons for the addition of this feature.
>=20
> * Let's start with the fact that AP instructions absolutely must be=20
> installed on the host in order to virtualize
>    AP devices for a guest using this patch series. There is a bit in th=
e=20
> in the SIE block (ECA.28) that controls
>    whether AP instructions executed on the guest are interpreted by SIE=
=20
> or intercepted by KVM. This patch series sets
>    this bit so that AP instructions executed on the guest are=20
> interpreted by the firmware passed directly through
>    to the AP devices configured for the guest in the CRYCB- a satellite=
=20
> control block of the SIE block to configure
>    the AP facilities for the guest. If the AP instructions are not=20
> installed, the AP bus running in the guest will
>    not initialize and the guest will not have access to any AP devices.=
=20
> So, the primary reason for the S390_FEAT_AP
>    feature is to protect against this scenario.

Then I request the following change in KVM:

If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
(not just if an AP device is configured). This especially makes things a
lot easier when it comes to handling hotplugged CPUs and avoiding race
conditions when enabling these bits as mentioned in the KVM series.

KVM_S390_VM_CPU_FEAT_AP =3D=3D AP instructions available for the guest
(don't throw an operation exception).

So this feature then really is guest ABI. The instructions are
available. If there is no device configured, bad luck.

>=20
> * In the review of v1, Christian suggested creating a feature to preven=
t=20
> migration of a guest with AP devices
>    to a system without AP support, or a system without AP instructions.=
=20
> In order to migrate to another system,
>    the S390_FEAT_AP feature must be available on the target system.

I wonder if it would make sense to split this even further up.

E.g. to be able to differentiate between format0 and format2 crycb
format support. (which is necessary to properly migrate guests with
vSIE) But these would then be SIE specific CPU features in addition most
properly. But also depend if there is a AP interpretation facility :)

>=20
> I hope this clears things up for you.

Yes, very helpful, thanks a lot!


--=20

Thanks,

David / dhildenb
