Received: from eggs.gnu.org ([2001:4830:134:3::10]:53311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsf9-0003tW-Ds
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsf5-00062A-DW
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:23:59 -0400
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<b43bdfdb-4c00-646d-efbd-1f411350929e@linux.ibm.com>
	<5b4c089d-a586-c76b-e1d7-6c2f2183b69b@linux.vnet.ibm.com>
	<1442f59a-f422-c76e-f6dc-ea9d677d0202@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7c2a81a7-2e01-7265-6071-8958901b38db@redhat.com>
Date: Wed, 16 May 2018 11:23:43 +0200
MIME-Version: 1.0
In-Reply-To: <1442f59a-f422-c76e-f6dc-ea9d677d0202@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 16.05.2018 11:05, Pierre Morel wrote:
> On 15/05/2018 17:03, Tony Krowiak wrote:
>> On 05/15/2018 08:00 AM, Pierre Morel wrote:
>>> On 08/05/2018 14:25, Tony Krowiak wrote:
>>>> A new CPU model feature and two new CPU model facilities are
>>>> introduced to support AP devices for a KVM guest.
>>>>
>>>> CPU model features:
>>>>
>>>> 1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
>>>> =C2=A0=C2=A0=C2=A0 AP facilities are installed. This feature will be=
 enabled by
>>>> =C2=A0=C2=A0=C2=A0 the kernel only if the AP facilities are installe=
d on the linux
>>>> =C2=A0=C2=A0=C2=A0 host. This feature must be turned on from userspa=
ce to access
>>>> =C2=A0=C2=A0=C2=A0 AP devices from the KVM guest. The QEMU command l=
ine to turn
>>>> =C2=A0=C2=A0=C2=A0 this feature looks something like this:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 qemu-system-s390x ... -cpu xxx,ap=3Don
>>>>
>>>> =C2=A0=C2=A0=C2=A0 This feature will be supported for zEC12 and newe=
r CPU models.
>>>> =C2=A0=C2=A0=C2=A0 The feature will not be supported for older model=
s due to
>>>> =C2=A0=C2=A0=C2=A0 testability issues.
>>>>
>>>> CPU model facilities:
>>>>
>>>> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
>>>> =C2=A0=C2=A0=C2=A0 Configuration Information (QCI) facility is insta=
lled. This feature
>>>> =C2=A0=C2=A0=C2=A0 will be enabled by the kernel only if the QCI is =
installed on
>>>> =C2=A0=C2=A0=C2=A0 the host.
>>>>
>>>> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
>>>> =C2=A0=C2=A0=C2=A0 Facility Test (APFT) facility is installed. This =
feature will
>>>> =C2=A0=C2=A0=C2=A0 be enabled by the kernel only if the APFT facilit=
y is installed
>>>> =C2=A0=C2=A0=C2=A0 on the host.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>> =C2=A0 target/s390x/cpu_features.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 3 +++
>>>> =C2=A0 target/s390x/cpu_features_def.h |=C2=A0=C2=A0=C2=A0 3 +++
>>>> =C2=A0 target/s390x/cpu_models.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 2 ++
>>>> =C2=A0 target/s390x/gen-features.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 3 +++
>>>> =C2=A0 target/s390x/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>>> =C2=A0 5 files changed, 12 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features=
.c
>>>> index 3b9e274..f344323 100644
>>>> --- a/target/s390x/cpu_features.c
>>>> +++ b/target/s390x/cpu_features.c
>>>> @@ -40,8 +40,10 @@ static const S390FeatDef s390_features[] =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("srs", S390_FEAT_TYPE_STFL,=
 9, "Sense-running-status=20
>>>> facility"),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("csske", S390_FEAT_TYPE_STF=
L, 10, "Conditional-SSKE=20
>>>> facility"),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_INIT("ctop", S390_FEAT_TYPE_STFL=
, 11,=20
>>>> "Configuration-topology facility"),
>>>> +=C2=A0=C2=A0=C2=A0 FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Que=
ry AP=20
>>>> Configuration facility"),
>>>
>>> Not a big deal, but why forget the I for "Information" in the long=20
>>> description for APQCI
>>
>> I'll add 'Information'.
>>
>>>
>>> Also why not just "QCI" (I think it was already asked)
>>
>> It was a suggestion from Reinhard with which I agreed. We may know=20
>> that QCI is an AP function,
>> but most administrators will have no idea. Prepending the 'ap' informs=
=20
>> that QCI is an
>> AP function related to the CPU model feature for AP.
>=20
> QCI is the official name and will be refered as this in the official=20
> documentation (if it is).
> Most admin will use libvirt anyway and the one which will try to use=20
> qemu will look for
> apqci in the official documentation and will not find it.
> I do not think it is a good idea, but technically does not change anyth=
ing.
> Keep my RB even you stay by apqci or change for qci.
>=20

For the SIE features I decided to not name them sie_$feat

So we have e.g. siif instead of sie_siif. I primarily did this to have
shorter feature names and the rational was that the short version (siif)
was sufficient to guess the full name and where it belongs to.

e.g. siif =3D=3D "Shared IPTE-interlock facility" (we sticked to the f in
there, as siif was a commonly used term if I remember correctly). There
is only one shared ipte-interlock facility.

"qci" (or Query Configuration facility) does _not_ indicate to which
part of the system this belongs. zPCI? sclp? ap?

This should be "apqci" or "qapcf". Or "ap_qci". "qci", on its own is not
sufficient in my opinion.

--=20

Thanks,

David / dhildenb
