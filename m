Received: from eggs.gnu.org ([2001:4830:134:3::10]:45675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCGJe-0006oM-Ob
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCGJb-0001bX-K8
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:14:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fCGJb-0001bK-FL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:14:23 -0400
Date: Sat, 28 Apr 2018 11:14:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180428031413.GK13269@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
	<20180428022407.GG13269@xz-mi>
	<635e37b2-30a6-b204-3005-e3e098cb38f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <635e37b2-30a6-b204-3005-e3e098cb38f8@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>

On Sat, Apr 28, 2018 at 10:42:11AM +0800, Jason Wang wrote:

[...]

> Well, it's not about BQL specifically, it's about whether we have or ne=
ed a
> generic thread safety solution for all IOMMUs.
>=20
> We have more IOMMUs than just AMD, s390 and ppc:
>=20
> # git grep imrc-\>translate\ =3D
> hw/alpha/typhoon.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D typhoon_trans=
late_iommu;
> hw/dma/rc4030.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D rc4030_dma_trans=
late;
> hw/i386/amd_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D amdvi_transl=
ate;
> hw/i386/intel_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D vtd_iommu_=
translate;
> hw/ppc/spapr_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D spapr_tce_t=
ranslate_iommu;
> hw/s390x/s390-pci-bus.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D s390_tra=
nslate_iommu;
> hw/sparc/sun4m_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4m_tra=
nslate_iommu;
> hw/sparc64/sun4u_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4u_t=
ranslate_iommu;

Sorry I didn't notice this one.  This point is valid.  But again, we
need to know whether they are thread-safe already.  For VT-d, it never
hurt to have this patch to fix its own problem, so above is not a
reason to not have current patch, since it solves different problems.
Basically I'll see the solution of above problem as a separate patch
as current one.

Meanwhile, even if we want to provide a general protection on that,
again I would prefer not using BQL but use some common and new
iommu-lock.  BQL can be a nightmare sometimes.

Thanks,

--=20
Peter Xu
