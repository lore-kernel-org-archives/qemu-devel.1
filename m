Received: from eggs.gnu.org ([2001:4830:134:3::10]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1elyfD-0001pf-SL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1elyex-0003aW-Mo
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:08:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1elyex-0003aG-Dw
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:07:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EF0I0U109536
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:07:46 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4nw6cypg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:07:45 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 14 Feb 2018 15:07:44 -0000
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
	<0c40e592-32e7-315e-fbad-1969c90b9b01@redhat.com>
	<60be1af6-ab00-5425-1cac-edb722dfcc1a@linux.vnet.ibm.com>
	<5d52424e-c6ee-2c0a-a8ee-14f01bc25747@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Feb 2018 16:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <5d52424e-c6ee-2c0a-a8ee-14f01bc25747@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <397ebf58-05df-f56d-c05f-4fd5eb1ac6d2@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com



On 02/14/2018 03:51 PM, Collin L. Walling wrote:
> On 02/06/2018 05:13 AM, Viktor Mihajlovski wrote:
>> On 06.02.2018 10:23, Thomas Huth wrote:
>>> On 05.02.2018 21:57, Collin L. Walling wrote:
>>> [...]
>>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>>> index e857ce4..825a1a3 100644
>>>> --- a/pc-bios/s390-ccw/main.c
>>>> +++ b/pc-bios/s390-ccw/main.c
>>>> @@ -16,6 +16,7 @@ char stack[PAGE_SIZE * 8] __attribute__((__aligned=
__(PAGE_SIZE)));
>>>> =C2=A0 static SubChannelId blk_schid =3D { .one =3D 1 };
>>>> =C2=A0 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE))=
);
>>>> =C2=A0 static char loadparm[8] =3D { 0, 0, 0, 0, 0, 0, 0, 0 };
>>>> +QemuIplParameters qipl;
>>>> =C2=A0 =C2=A0 /*
>>>> =C2=A0=C2=A0 * Priniciples of Operations (SA22-7832-09) chapter 17 r=
equires that
>>>> @@ -81,6 +82,7 @@ static void virtio_setup(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t dev_no;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char ldp[] =3D "LOADPARM=3D[________]=
\n";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VDev *vdev =3D virtio_get_device();
>>>> +=C2=A0=C2=A0=C2=A0 QemuIplParameters *early_qipl =3D (QemuIplParame=
ters *)204;
>>> Could you please introduce a proper #define for that magic 204 value
>>> (and use it in s390_ipl_prepare_qipl, too)? ... so that it is later
>>> easier to grep for this.
>>>
>> Hm ... I was following the pattern established in
>> write_subsystem_identification(). Christian, what is your opinion?
>=20
> Any updates on this?=C2=A0 Last change I need to make before the next p=
ost.

Let's use a magic number. It is the preferred way in QEMU.
