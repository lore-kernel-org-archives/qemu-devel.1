Received: from eggs.gnu.org ([2001:4830:134:3::10]:44851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f0O2S-0006Wg-7e
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f0O2N-0003b4-A1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:03:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1f0O2N-0003a9-4m
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:03:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2Q8wt2B016109
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 05:03:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gxw25tk9r-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 05:03:29 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 26 Mar 2018 10:03:27 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 11:03:22 +0200
MIME-Version: 1.0
In-Reply-To: <4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 26/03/2018 10:32, David Hildenbrand wrote:
> On 16.03.2018 00:24, Tony Krowiak wrote:
>> If the CPU model indicates that AP facility is installed on
>> the guest (i.e., -cpu xxxx,ap=3Don), then the expectation is that
>> the AP bus running in the guest will initialize; however, if the
>> AP instructions are not being interpreted by the firmware, then
>> they will be intercepted and routed back to QEMU for handling.
>> If a handler is not defined to process the intercepted instruciton,
>> t
...snip...
>
>> +int ap_device_handle_nqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env =3D &cpu->env;
>> +
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] =3D 0x10000;
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +int ap_device_handle_dqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env =3D &cpu->env;
>> +
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] =3D 0x10000;
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +int ap_device_handle_pqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env =3D &cpu->env;
>> +    int fc =3D 4 & (env->regs[0] >> 24);
>> +
>> +    /*
>> +     * The Query Configuration Information (QCI) function (fc =3D=3D =
4) does not
>> +     * set a response code in reg 1, so check for that along with the
>> +     * AP feature.
>> +     */
>> +    if ((fc !=3D 4) && s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] =3D 0x10000;
>> +
>> +        return 0;
>> +    }
> This would imply an operation exception in case fc=3D=3D4, which sounds=
 very
> wrong.

It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must be=20
tested
to know what to answer.
If the feature is there, QCI must be answered correctly.

there are also some error situations to handle in all three functions.


>
> Hard to review without access to documentation. (hard to understand why
> such stuff is to be kept confidential for decades)
>
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static Property vfio_ap_properties[] =3D {
>>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>>       DEFINE_PROP_END_OF_LIST(),
>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device=
.h
>> index 693df90..d45ae38 100644
>> --- a/include/hw/s390x/ap-device.h
>> +++ b/include/hw/s390x/ap-device.h
>> @@ -11,6 +11,8 @@
>>   #ifndef HW_S390X_AP_DEVICE_H
>>   #define HW_S390X_AP_DEVICE_H
>>  =20
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
