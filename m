Received: from eggs.gnu.org ([2001:4830:134:3::10]:41772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpVQI-0003Rl-V7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpVQD-0001zr-Sq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:10:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpVQD-0001zQ-L2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:10:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v868AHZU074445
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 04:10:52 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctckpswge-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 04:10:48 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 18:09:36 +1000
References: <20170905151614.31303-1-cohuck@redhat.com>
	<4af30c89-15a8-c3e6-3563-aa4c8e76c577@linux.vnet.ibm.com>
	<20170906095953.13d5fb01.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 16:09:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170906095953.13d5fb01.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <db715440-ebe4-1362-acf5-60e5a45491ee@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: cure s390x failures by
 switching to ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com



=E5=9C=A8 2017/9/6 =E4=B8=8B=E5=8D=883:59, Cornelia Huck =E5=86=99=E9=81=93=
:
> On Wed, 6 Sep 2017 14:57:48 +0800
> QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/9/5 23:16, Cornelia Huck =E5=86=99=E9=81=93:
>>> Recent changes in s390x made pci support dependant on the zpci cpu
>>> feature, which is not provided on all models (and not on by default).
>>> This means we cannot instatiate pci devices on a standard qemu
>>> invocation for s390x. Moreover, the zpci instructions are not even
>>> wired up for tcg yet, so actually doing anything with those pci devic=
es
>>> is bound to fail on tcg.
>>>
>>> Let's follow the existing example in 068 and switch to the (default)
>>> virtio-ccw transport on s390x. The changes for 051 and 067 are split
>>> out as they require adding an output file for s390x (the actual comma=
nd
>>> lines are part of the output).
>> We also found this error and YiMin suggested to change the code in ccw=
_init
>> as below:
>>
>> if (pci_available) {
>>   =C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_S390_=
PCI_HOST_BRIDGE);
>>   =C2=A0=C2=A0=C2=A0 ...
>> }
>> We tested it and it can make the 5 cases passed.
> OK, looked at this. This won't work: pci_available means "this qemu has
> pci support built in". _Working_ zpci, however, depends on the presence
> of the zpci feature bit: You'll have a host bridge and can define
> devices that have absolutely no chance of working, since all pci
> instruction will return errors. You will be in a similar situation
> under kvm as under tcg: you can specify virtio-pci devices on the
> command line, but they can't work.
Oh. Yes, that makes sense. Actually the first way we thought about was=20
change the code
not change the testcases. Thanks for your work.
>
> This probably makes the 5 cases pass as they only rely on the ability
> to create the device, not to do anything with them.
>
> So, I still think the right thing to do is to switch to ccw in the
> tests (and to wire up pci in tcg, but that's an orthogonal issue).
Agree.
>
>
