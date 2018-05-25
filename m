Received: from eggs.gnu.org ([2001:4830:134:3::10]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fMI7t-0004Iy-R3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 15:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fMI7p-0000r4-QD
	for qemu-devel@nongnu.org; Fri, 25 May 2018 15:11:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fMI7p-0000pW-IP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 15:11:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4PJ9Ecp122117
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 15:11:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6qvx16qa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 15:11:40 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 May 2018 20:11:37 +0100
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
	<20180525114033.3c514091.cohuck@redhat.com>
	<c1c246bd-c0a8-7e30-dd0c-ba99c2346d15@linux.ibm.com>
	<0787e807-53c3-7288-6d3f-e354f7fb4db9@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 25 May 2018 21:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <0787e807-53c3-7288-6d3f-e354f7fb4db9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <eb287a06-4f7a-9ac9-c09b-869a123db385@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 05/25/2018 08:08 PM, Eric Blake wrote:
> On 05/25/2018 12:46 PM, Halil Pasic wrote:
>=20
>>>> +static inline void warn_once(bool *warned, const char *fmt, ...)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 va_list ap;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!warned || *warned) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 *warned =3D true;
>>>> +=C2=A0=C2=A0=C2=A0 va_start(ap, fmt);
>>>> +=C2=A0=C2=A0=C2=A0 warn_vreport(fmt, ap);
>>>> +=C2=A0=C2=A0=C2=A0 va_end(ap);
>>>> +}
>>>> +
>>>> +static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *s=
ch,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *msg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (de=
vno %x.%x.%04x): %s",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sch->cssid, sch->ssid, sch->devno, msg);
>>>> +}
>>>> +
>>>
>>> While I still think we want warn_once() in common error handling code=
,
>>> this looks reasonable enough. We can still move it later.
>>>
>>
>> I agree. I was a bit surprised to not find any warn_once functionality.
>=20
> That has been proposed:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05457.html
>=20

Thanks! I was not aware of this. If we were to use that we would
AFAIU have to transition to once-once instead of once per device
as done in my patch based on Connie's request.

Regards,
Halil
