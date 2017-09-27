Received: from eggs.gnu.org ([2001:4830:134:3::10]:49512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxA4D-0003Yb-Vq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxA4A-0003Cv-0m
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:59:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dxA49-0003Az-Nw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:59:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8RAwtYP045361
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 06:59:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d83qrn1hm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 06:59:40 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 11:59:38 +0100
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 12:59:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170927125606.65dc514d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, dgilbert@redhat.com



On 09/27/2017 12:56 PM, Cornelia Huck wrote:
> On Wed, 27 Sep 2017 18:25:00 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>=20
>> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Tue, 26 Sep 2017 20:40:25 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>=20
>>>> I'd really really really (did I mention really?) favor something lik=
e a
>>>> dummy device, because we could easily handle the !CONFIG_PCI case th=
en.
>>>>
>>>> All these compat options and conditions will kill us someday... we'r=
e
>>>> already patching around that whole stuff way too much.
>>>>
>>>> If we ever unconditionally created a device, we should keep doing so=
. =20
>>> Yes, that whole thing is horrible, especially interaction with compat
>>> machines.
>>>
>>> Do you have an idea on how to create such a dummy device (without
>>> having to effectively copy a lot of configured-out code)?
>>>
>>> =20
>> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpci)?
>> If no zpci feature, we avoid plugging any pci device.
>> Then we could always create phb.
>> I think pcibus's vmstate is only data to migrate.
>=20
> That's still problematic if CONFIG_PCI is off. I currently don't have a
> better idea than either disallowing compat machines on builds without
> pci, or using a dummy device...

For this particular case your initial patch might be less problematic tha=
n
a dummy device, because the code that does the migration is NOT contained
in s390 specific code but in common PCI code instead. We would need to ke=
ep
the dummy device always in a way that it will work with the common PCI
code.
