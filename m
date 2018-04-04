Received: from eggs.gnu.org ([2001:4830:134:3::10]:56895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f3gHx-0006oQ-Va
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f3gHt-0006rp-S8
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:09:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1f3gHt-0006rZ-Jf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:09:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w34B7lK8077884
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 07:09:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4tkqgjs9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 07:09:07 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 12:09:05 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 13:09:00 +0200
MIME-Version: 1.0
In-Reply-To: <0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ce32e96c-f448-c375-cc25-96bb3cf35d69@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 02/04/2018 18:36, Tony Krowiak wrote:
> On 03/26/2018 05:03 AM, Pierre Morel wrote:
>> On 26/03/2018 10:32, David Hildenbrand wrote:
>>> On 16.03.2018 00:24, Tony Krowiak wrote:
>>>> If the CPU model indicates that AP facility is installed on
>>>> the guest (i.e., -cpu xxxx,ap=3Don), then the expectation is that
>>>> the AP bus running in the guest will initialize; however, if the
>>>> AP instructions are not being interpreted by the firmware, then
>>>> they will be intercepted and routed back to QEMU for handling.
>>>> If a handler is not defined to process the intercepted instruciton,
>>>> t
>> ...snip...
>>>
>>>> +int ap_device_handle_nqap(S390CPU *cpu)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (s390_has_feat(S390_FEAT_AP)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x10000=
;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +int ap_device_handle_dqap(S390CPU *cpu)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (s390_has_feat(S390_FEAT_AP)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x10000=
;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +int ap_device_handle_pqap(S390CPU *cpu)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>> +=C2=A0=C2=A0=C2=A0 int fc =3D 4 & (env->regs[0] >> 24);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The Query Configuration Information (QCI=
) function (fc =3D=3D=20
>>>> 4) does not
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set a response code in reg 1, so check f=
or that along with the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * AP feature.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if ((fc !=3D 4) && s390_has_feat(S390_FEAT_AP)) =
{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x10000=
;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>> This would imply an operation exception in case fc=3D=3D4, which soun=
ds=20
>>> very
>>> wrong.
>>
>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must=20
>> be tested
>> to know what to answer.
>> If the feature is there, QCI must be answered correctly.
> This is an interesting proposition which raises several issues that=20
> will need to
> be addressed. The only time the PQAP(QCI) instruction is intercepted=20
> is when:
> * A vfio-ap device is NOT defined for the guest because the vfio_ap=20
> device driver
> =C2=A0 will set ECA.28 and the PQAP(QCI) instruction will be interprete=
d
> * STFLE.12 is set for the guest
>
> You say that the QCI must be answered correctly, but what is the=20
> correct response?
> If we return the matrix - i.e., APM, ADM and AQM - configured via the=20
> mediated
> matrix device's sysfs attributes files, then if any APQNs are defined=20
> in the matrix,
> we will have to handle *ALL* AP instructions by executing them on=20
> behalf of the
> guest. I suppose we could return an empty matrix in which case the AP=20
> bus will come
> up without any devices on the guest, but what is the expectation of an=20
> admin who
> deliberately configures the mediated matrix device? Should we forego=20
> handling interception
> of AP instructions and consider a guest configuration that turns on=20
> S390_FEAT_AP but
> does not define a vfio-ap device to be erroneous and terminate=20
> starting of the guest?
> Anybody have any thoughts?
>>
>>
>> there are also some error situations to handle in all three functions.
> To what error situations are you referring?

program exceptions, like access, privilege or specification exceptions.


>>
>>
>>
>>>
>>> Hard to review without access to documentation. (hard to understand w=
hy
>>> such stuff is to be kept confidential for decades)
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> =C2=A0 static Property vfio_ap_properties[] =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_STRING("sysfsdev", VFIOAP=
Device, vdev.sysfsdev),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>>>> diff --git a/include/hw/s390x/ap-device.h=20
>>>> b/include/hw/s390x/ap-device.h
>>>> index 693df90..d45ae38 100644
>>>> --- a/include/hw/s390x/ap-device.h
>>>> +++ b/include/hw/s390x/ap-device.h
>>>> @@ -11,6 +11,8 @@
>>>> =C2=A0 #ifndef HW_S390X_AP_DEVICE_H
>>>> =C2=A0 #define HW_S390X_AP_DEVICE_H
>>>
>>
>
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
