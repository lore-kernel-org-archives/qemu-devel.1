Received: from eggs.gnu.org ([2001:4830:134:3::10]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCGM8-0007p4-4u
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCGM4-0002mR-SU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:17:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fCGM4-0002lm-Nx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:16:56 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
	<20180428022407.GG13269@xz-mi>
	<635e37b2-30a6-b204-3005-e3e098cb38f8@redhat.com>
	<20180428031413.GK13269@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a6486f0-e4bd-b727-b6d7-300b3796fa62@redhat.com>
Date: Sat, 28 Apr 2018 11:16:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180428031413.GK13269@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>



On 2018=E5=B9=B404=E6=9C=8828=E6=97=A5 11:14, Peter Xu wrote:
> On Sat, Apr 28, 2018 at 10:42:11AM +0800, Jason Wang wrote:
>
> [...]
>
>> Well, it's not about BQL specifically, it's about whether we have or n=
eed a
>> generic thread safety solution for all IOMMUs.
>>
>> We have more IOMMUs than just AMD, s390 and ppc:
>>
>> # git grep imrc-\>translate\ =3D
>> hw/alpha/typhoon.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D typhoon_tran=
slate_iommu;
>> hw/dma/rc4030.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D rc4030_dma_tran=
slate;
>> hw/i386/amd_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D amdvi_trans=
late;
>> hw/i386/intel_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D vtd_iommu=
_translate;
>> hw/ppc/spapr_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D spapr_tce_=
translate_iommu;
>> hw/s390x/s390-pci-bus.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D s390_tr=
anslate_iommu;
>> hw/sparc/sun4m_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4m_tr=
anslate_iommu;
>> hw/sparc64/sun4u_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4u_=
translate_iommu;
> Sorry I didn't notice this one.  This point is valid.  But again, we
> need to know whether they are thread-safe already.  For VT-d, it never
> hurt to have this patch to fix its own problem, so above is not a
> reason to not have current patch, since it solves different problems.
> Basically I'll see the solution of above problem as a separate patch
> as current one.
>
> Meanwhile, even if we want to provide a general protection on that,
> again I would prefer not using BQL but use some common and new
> iommu-lock.  BQL can be a nightmare sometimes.

Yes, you can use other if BQL turns out to be troublesome.

Thanks

>
> Thanks,
>
