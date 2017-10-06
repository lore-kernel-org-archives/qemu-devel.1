Received: from eggs.gnu.org ([2001:4830:134:3::10]:56888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0SIS-0005Xk-37
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0SIM-0005NT-IO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:04:08 -0400
References: <20171006114624.10771-1-maxime.coquelin@redhat.com>
	<20171006114624.10771-2-maxime.coquelin@redhat.com>
	<1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
	<ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
	<c4c02172-cf19-bd56-d120-f72e043a54e0@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <7ebed617-f286-5f35-e784-6b4b864e406a@redhat.com>
Date: Fri, 6 Oct 2017 15:03:50 +0200
MIME-Version: 1.0
In-Reply-To: <c4c02172-cf19-bd56-d120-f72e043a54e0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] exec: add page_mask for
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org



On 10/06/2017 02:48 PM, Paolo Bonzini wrote:
> On 06/10/2017 14:46, Maxime Coquelin wrote:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ((i=
otlb.translated_addr & ~iotlb.addr_mask)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (addr & iotlb.addr_mask));
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *plen =3D MIN(*plen, (ad=
dr | iotlb.addr_mask) - addr + 1);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_mask =3D iotlb.addr=
_mask;
>>>
>>> Should this be "page_mask &=3D iotlb.addr_mask"?
>>>
>>> If you have multiple IOMMUs on top of each other (yeah, I know...) I
>>> think the smallest size should win.=C2=A0 This is also consistent wit=
h the
>>> MIN in the line below.
>>
>> I agree, but changin to "page_mask &=3D iotlb.addr_mask" will not be
>> enough, we also have to change the init value. Else we will always end
>> up with 0xfff.
>>
>> Maybe we could do as plen was handled before, i.e. setting page_mask
>> init value to (hwaddr)(-1), and after the loop set it to
>> ~TARGET_PAGE_MASK if it hasn't been changed.
>>
>> Does that sound reasonable?
>=20
> True that, in fact it makes sense for the "IOTLB entry" to represent al=
l
> of memory if there's no IOMMU at all.

Indeed, that makes sense as no iommu means identity mapping. It would
moreover improve performance, as the vhost backend will only have a
single IOTLB entry in its cache.

Maybe it is better to wait for Peter to understand the reason he limited
it to the target page size?

Thanks,
Maxime

> Thanks,
>=20
> Paolo
>=20
