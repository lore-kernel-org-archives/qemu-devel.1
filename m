Received: from eggs.gnu.org ([2001:4830:134:3::10]:46462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1eHWIA-0000Yx-8u
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1eHWI4-0005Oq-AM
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:46:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fiuczy@linux.vnet.ibm.com>)
	id 1eHWI4-0005OG-1q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:46:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEjZKV073101
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:46:12 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2edaqxa4w5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:46:08 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <fiuczy@linux.vnet.ibm.com>;
	Wed, 22 Nov 2017 14:45:59 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
From: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 15:45:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171122131343.26da0482.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 11/22/2017 01:13 PM, Cornelia Huck wrote:
>>>>>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
>>>>>> +                                   prop_get_true, NULL, NULL);
>>>>> This looks really, really strange. This is a property that is alway=
s
>>>>> true if it exists.
>>>>>     =20
>>>> Won't argue about that. The libvirt guys are actually not interested
>>>> int he value at all: only that there is such a property.
>>> So what about a machine property? Wouldn't that help as well?
>>>   =20
>> Technically it is doable. The property would be still a weird
>> one, but from QEMU perspective in a less weird place. I was also
>> arguing that from OO perspective this kind of a don't care about
>> it's value property is weird, but AFAIK not having the info if
>> we can do something with a device at the device is weird from
>> Libvirt perspective. I'm really uncomforble with speaking for
>> Libvirt/Boris. Hope he will make his point tomorrow.
>>
>>> Or a css object?
>>>   =20
>> My first internal-only version used this approach, but
>> I was asked to do it like this.
> If we formulate this rather as "we now expose the default css", we (a)
> have something that really makes the most sense at a channel subsystem
> or machine level, and (b) can be detected by libvirt as an indicator of
> "no restriction for virtual vs. non-virtual".

I think that there are good reasons for using a device property as well=20
as for using a machine property. Technically both options are possible=20
(even for libvirt :) without too much rope...). At first my personal=20
choice was to express the changed behavior/capability on the device=20
level since that is what a user defines on the command line and also=20
where he gets restricted to use a css matching his device type.
 From the libvirt perspective we would have supported vfio-ccw devices=20
only if the vfio-ccw would be allowed to be defined with unrestricted=20
cssids.
As I wrote before I also understand the reasoning to express the channel=20
subsystem wide changed behavior as a machine option. In that case=20
libvirt would need to check that both capabilities (vfio-ccw and machine=20
option cssid-unrestricted) are set and not just=20
vfio-cww.cssid-unrestricted. All doable. A qemu command line user would=20
obviously need to know the correlation of the machine option and the ccw=20
devices but that certainly is also nothing new.
When talking to Christian and Halil I started to favor the idea of a new=20
css object especially when thinking about the future in which the user=20
might want to specify the default css. It for sure would also be able to=20
be set with the use of a machine option but a css object would at that=20
point be much a nicer and more capable approach. What do you think?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
