Received: from eggs.gnu.org ([209.51.188.92]:59939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gjkea-00056W-UX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gjkUp-0008AW-JG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:40:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gjkUn-0007xA-D7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:40:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0GCeITo084215
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 07:40:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q23untxys-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 07:40:21 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 16 Jan 2019 12:40:18 -0000
Date: Wed, 16 Jan 2019 13:40:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190116134011.1189b027@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, thuth@redhat.com, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Tue, 15 Jan 2019 10:35:42 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/10/19 8:00 AM, Pierre Morel wrote:
> > The size of the accessible iommu memory region in the guest
> > is given to the IOMMU by the guest through the mpcifc request
> > specifying the PCI Base Address and the PCI Address Limit.
> >=20
> > Let set the size of the IOMMU region to:
> >      (PCI Address Limit) - (PCI Base Address) + 1.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   hw/s390x/s390-pci-bus.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 69e0671..e97696a 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
> >       char *name =3D g_strdup_printf("iommu-s390-%04x", iommu->pbdev->u=
id);
> >       memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr=
),
> >                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&i=
ommu->mr),
> > -                             name, iommu->pal + 1);
> > +                             name, iommu->pal - iommu->pba + 1);

=46rom the the look of this, I would say we basically used the address
denoting the end of the region as the size of the region. This smells
like a bug to me, but the commit message and the title ain't clear about
this, and there is no fixes tag. Because of the latter I did some digging
and came to commit f7c40aa "s390x/pci: fix failures of dma
map/unmap" (Yi Min Zhao, 2016-06-19) which basically did the inverse of
this commit!

My initial motivation was to check if this is stable material. But now
I'm very confused. I'm admittedly zPCI incompetent. Could some of the
people that understand what is going on help me feel better about this
patch?

Regards,
Halil



> >       iommu->enabled =3D true;
> >       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->=
iommu_mr));
> >       g_free(name);
> >=20
>=20
> Acked-by: Collin Walling <walling@linux.ibm.com>
>=20
>=20
