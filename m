Received: from eggs.gnu.org ([2001:4830:134:3::10]:59865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAsD-0002wm-Ov
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAsA-0004Zf-Ii
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:17:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEAsA-0004Yo-8j
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:17:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAD9DZe6100396
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:17:37 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e77fxkb06-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:17:36 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 09:17:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vAD9HVHQ49610824
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:17:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324B842049
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:12:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192B24204B
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:12:28 +0000 (GMT)
Received: from [9.145.26.235] (unknown [9.145.26.235])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:12:28 +0000 (GMT)
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-7-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109202308.06a8bc45.cohuck@redhat.com>
	<15d59e1d-e42f-3068-ddc5-e991a5f21879@linux.vnet.ibm.com>
	<20171110105116.2a470f57.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 10:17:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171110105116.2a470f57.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <36efc351-d009-faf9-2610-0901770846af@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] s390x/pci: move the memory region
 write from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 10/11/2017 10:51, Cornelia Huck wrote:
> On Fri, 10 Nov 2017 17:40:12 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>=20
>> =E5=9C=A8 2017/11/10 =E4=B8=8A=E5=8D=883:23, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Tue,  7 Nov 2017 18:24:38 +0100
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> Let's move the memory region write from pcistg into a dedicated
>>>> function.
>>>> This allows us to prepare a later patch searching for subregions
>>>> inside of the memory region.
>>> OK, so here is the memory region write. Do we have any sleeping
>>> endianness bugs in there for when we wire up tcg? I'm not sure how th=
is
>>> plays with the bswaps (see patch 1).
>>>
>>> But maybe I've just gotten lost somewhere.
>> I think there's no error. For PCI bars' MRs, we got the little-endian =
data
>> that is exactly fit to the byte ordering of pcilg instruction. For PCI
>> config
>> space, the data has been swapped according to the cpu byte ordering.
>=20
> Host or target cpu?
>=20
>> So we use zpci_swap_endian() to swap the data back to the little-endia=
n
>> ordering.

I do not see where we use the zpci_swap_endian() function in this patch=20
or in the zpci_write_bar() function.

>=20
> That swap is unconditional. If we were running on a little-endian host,
> it would be wrong, wouldn't it?

I think there is no problem here, we do not use this function but we use=20
the memory_region_dispatch_write() to access a subregion of the PCI=20
device which is defined as DEVICE_LITTLE_ENDIAN

AFAIU The memory access process the endianness correctly.

>=20
>>>  =20
>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
>>>>    1 file changed, 17 insertions(+), 10 deletions(-)
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
