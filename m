Received: from eggs.gnu.org ([2001:4830:134:3::10]:51692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0S3c-0007Oa-AR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0S3Y-00082N-DT
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:48:48 -0400
References: <20171006114624.10771-1-maxime.coquelin@redhat.com>
	<20171006114624.10771-2-maxime.coquelin@redhat.com>
	<1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
	<ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4c02172-cf19-bd56-d120-f72e043a54e0@redhat.com>
Date: Fri, 6 Oct 2017 14:48:22 +0200
MIME-Version: 1.0
In-Reply-To: <ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Maxime Coquelin <maxime.coquelin@redhat.com>, peterx@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 06/10/2017 14:46, Maxime Coquelin wrote:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ((iot=
lb.translated_addr & ~iotlb.addr_mask)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (addr & iotlb.addr_mask));
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *plen =3D MIN(*plen, (add=
r | iotlb.addr_mask) - addr + 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_mask =3D iotlb.addr_=
mask;
>>
>> Should this be "page_mask &=3D iotlb.addr_mask"?
>>
>> If you have multiple IOMMUs on top of each other (yeah, I know...) I
>> think the smallest size should win.=C2=A0 This is also consistent with=
 the
>> MIN in the line below.
>=20
> I agree, but changin to "page_mask &=3D iotlb.addr_mask" will not be
> enough, we also have to change the init value. Else we will always end
> up with 0xfff.
>=20
> Maybe we could do as plen was handled before, i.e. setting page_mask
> init value to (hwaddr)(-1), and after the loop set it to
> ~TARGET_PAGE_MASK if it hasn't been changed.
>=20
> Does that sound reasonable?

True that, in fact it makes sense for the "IOTLB entry" to represent all
of memory if there's no IOMMU at all.

Thanks,

Paolo
