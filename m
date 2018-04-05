Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f45J4-0006es-RD
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f45J1-000350-HH
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:52:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f45J1-00033q-81
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:51:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35Dnufk058423
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 09:51:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5jjr7n7f-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 09:51:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 14:51:54 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<ce32e96c-f448-c375-cc25-96bb3cf35d69@linux.vnet.ibm.com>
	<3735c70a-2b6b-1962-08bb-8badcad7b487@linux.vnet.ibm.com>
	<4866a115-b34d-9a5c-6c73-0d066a9b09b8@linux.vnet.ibm.com>
	<1dc47cbd-876c-7fb4-defe-cefe95c16b41@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 15:51:49 +0200
MIME-Version: 1.0
In-Reply-To: <1dc47cbd-876c-7fb4-defe-cefe95c16b41@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <a028ee1e-acf4-0796-7aa5-adeb151c24c3@linux.vnet.ibm.com>
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
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 04/04/2018 10:12 PM, Tony Krowiak wrote:
> On 04/04/2018 09:43 AM, Pierre Morel wrote:
>> On 04/04/2018 15:33, Tony Krowiak wrote:
>>> On 04/04/2018 07:09 AM, Pierre Morel wrote:
>>>> On 02/04/2018 18:36, Tony Krowiak wrote:
>>>>> On 03/26/2018 05:03 AM, Pierre Morel wrote:
>>>>>> On 26/03/2018 10:32, David Hildenbrand wrote:
>>>>>>> On 16.03.2018 00:24, Tony Krowiak wrote:
>>>>>>>> If the CPU model indicates that AP facility is installed on
>>>>>>>> the guest (i.e., -cpu xxxx,ap=3Don), then the expectation is tha=
t
>>>>>>>> the AP bus running in the guest will initialize; however, if the
>>>>>>>> AP instructions are not being interpreted by the firmware, then
>>>>>>>> they will be intercepted and routed back to QEMU for handling.
>>>>>>>> If a handler is not defined to process the intercepted instrucit=
on,
>>>>>>>> t
>>>>>> ...snip...
>>>>>>>
>>>>>>>> +int ap_device_handle_nqap(S390CPU *cpu)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (s390_has_feat(S390_FEAT_AP)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x1=
0000;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int ap_device_handle_dqap(S390CPU *cpu)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (s390_has_feat(S390_FEAT_AP)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x1=
0000;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int ap_device_handle_pqap(S390CPU *cpu)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int fc =3D 4 & (env->regs[0] >> 24);
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The Query Configuration Information =
(QCI) function (fc =3D=3D 4) does not
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set a response code in reg 1, so che=
ck for that along with the
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * AP feature.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if ((fc !=3D 4) && s390_has_feat(S390_FEAT_A=
P)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->regs[1] =3D 0x1=
0000;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>> This would imply an operation exception in case fc=3D=3D4, which =
sounds very
>>>>>>> wrong.
>>>>>>
>>>>>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO mus=
t be tested
>>>>>> to know what to answer.
>>>>>> If the feature is there, QCI must be answered correctly.
>>>>> This is an interesting proposition which raises several issues that=
 will need to
>>>>> be addressed. The only time the PQAP(QCI) instruction is intercepte=
d is when:
>>>>> * A vfio-ap device is NOT defined for the guest because the vfio_ap=
 device driver
>>>>> =C2=A0 will set ECA.28 and the PQAP(QCI) instruction will be interp=
reted
>>>>> * STFLE.12 is set for the guest
>>>>>
>>>>> You say that the QCI must be answered correctly, but what is the co=
rrect response?
>>>>> If we return the matrix - i.e., APM, ADM and AQM - configured via t=
he mediated
>>>>> matrix device's sysfs attributes files, then if any APQNs are defin=
ed in the matrix,
>>>>> we will have to handle *ALL* AP instructions by executing them on b=
ehalf of the
>>>>> guest. I suppose we could return an empty matrix in which case the =
AP bus will come
>>>>> up without any devices on the guest, but what is the expectation of=
 an admin who
>>>>> deliberately configures the mediated matrix device? Should we foreg=
o handling interception
>>>>> of AP instructions and consider a guest configuration that turns on=
 S390_FEAT_AP but
>>>>> does not define a vfio-ap device to be erroneous and terminate star=
ting of the guest?
>>>>> Anybody have any thoughts?
>>>>>>
>>>>>>
>>>>>> there are also some error situations to handle in all three functi=
ons.
>>>>> To what error situations are you referring?
>>>>
>>>> program exceptions, like access, privilege or specification exceptio=
ns.
>>> Are you suggesting that these handlers need to verify that the instru=
ction
>>> specification is correct? For example, the NQAP instruction - NQAP r1=
,r2 -
>>> expects an even-odd pair of general registers in the r1 and r2 and mu=
st
>>> designate an even register; otherwise a specification exception is
>>> recognized. Are you saying that the handler for NQAP must verify this
>>> requirement and inject a specification exception if it is not met? If=
 not,
>>> then can you provide a specific example of what you are talking about=
?
>>
>> Yes I mean this.
>>
>> But one other thing.
>> Returning code 0x01 seems wrong for me, this is right if no AP card
>> are in the system but I do not thing that it is what we mean.
> I disagree .... for the guest, this is exactly what we mean. In my opin=
ion, assigning
> AP devices to the mediated matrix device is like assigning AP devices t=
o an LPAR.
> If no vfio-ap device is defined for the guest, then it is effectively t=
he same as
> starting a linux host in an LPAR without any AP devices assigned to it.
>>
>> I think we should return code 0x03 stating that the AP card is not in =
configured state
>=20
>>
>>
>> The difference is that we can get out of a not-configured state with a=
 SCLP command but
>> we can not recover from an un-existing APQN.
> Remember, this state will occur only when the AP feature of the CPU mod=
el is turned on for
> the guest and no vfio-ap device is defined, so there is no configuratio=
n to recover for
> the guest because no AP devices will be configured for the guest.

Spoke with Pierre and we agreed that the response code 01 is what
we need to do.

Regards,
Halil
