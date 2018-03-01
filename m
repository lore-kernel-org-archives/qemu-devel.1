Received: from eggs.gnu.org ([2001:4830:134:3::10]:56034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1erOwx-00059c-5d
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1erOwt-0005wu-4x
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49120
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1erOws-0005wL-Vv
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21E8YGZ052665
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 09:12:41 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gejr2h0c9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:12:40 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 14:12:36 -0000
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 15:12:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180228124058.6166d957.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 28/02/2018 12:40, Cornelia Huck wrote:
> On Wed, 28 Feb 2018 11:26:30 +0100
> David Hildenbrand <david@redhat.com> wrote:
>
>> Then I request the following change in KVM:
>>
>> If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
>> (not just if an AP device is configured). This especially makes things=
 a
>> lot easier when it comes to handling hotplugged CPUs and avoiding race
>> conditions when enabling these bits as mentioned in the KVM series.
>>
>> KVM_S390_VM_CPU_FEAT_AP =3D=3D AP instructions available for the guest
>> (don't throw an operation exception).
>>
>> So this feature then really is guest ABI. The instructions are
>> available. If there is no device configured, bad luck.
> Sounds sensible from my POV.
>

I have a concern with this proposition and with the original code:

1) ap=3Don is a guest ABI feature saying to the guest you can use AP=20
instructions

2) How we provide AP instructions to the guest can be done in three=20
different ways:
 =C2=A0- SIE Interpretation
 =C2=A0- interception with VFIO
 =C2=A0- interception with emulation

3) We implement this with a device in QEMU and a certain level kernel=20
support.

It seems possible to set or not ECA.28 , based on the type of kernel devi=
ce:
- SIE interpretation -> MATRIX KVM device -> ECA.28
- Interception with VFIO and virtualization -> no ECA.28
- interception with emulation -> no ECA.28

I understand the concern with the vCPU but I think we can handle it with=20
an indirect variable
like:

SIE interpretation Device + KVM_S390_VM_CPU_FEAT_AP -> set the variable=C2=
=A0=20
ap_to_be_sie_interpreted=3D1
Then in vCPU initialization set ECA.28 based on this variable.

I think it let us more doors open, what is your opinion?

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
