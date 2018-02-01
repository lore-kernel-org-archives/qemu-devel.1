Received: from eggs.gnu.org ([2001:4830:134:3::10]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehDm0-0006RG-54
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehDlu-0000yl-Tr
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:15:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ehDlu-0000y9-Ho
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:15:18 -0500
Date: Thu, 1 Feb 2018 13:15:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201131500.637834fc.cohuck@redhat.com>
In-Reply-To: <76ce13fe-f5e1-8b31-7f62-58c9d6b0271a@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
	<20180131115824.7329b8ee.cohuck@redhat.com>
	<a048761a-7dbc-80e2-8b57-2b5b0fc35ff0@linux.vnet.ibm.com>
	<76ce13fe-f5e1-8b31-7f62-58c9d6b0271a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking
 IOMMU tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On Thu, 1 Feb 2018 12:56:01 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 01/02/2018 12:28, Yi Min Zhao wrote:
> >
> >
> > =E5=9C=A8 2018/1/31 =E4=B8=8B=E5=8D=886:58, Cornelia Huck =E5=86=99=E9=
=81=93: =20
> >> On Tue, 30 Jan 2018 10:47:13 +0100
> >> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> >>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >>> index be449210d9..63fa06fb97 100644
> >>> --- a/hw/s390x/s390-pci-inst.c
> >>> +++ b/hw/s390x/s390-pci-inst.c
> >>> @@ -644,16 +644,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t=20
> >>> r1, uint8_t r2, uintptr_t ra)
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (start < end) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D imrc=
->translate(iommu_mr, start, IOMMU_NONE);
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!entry.translated_add=
r) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
bdev->state =3D ZPCI_FS_ERROR;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
etcc(cpu, ZPCI_PCI_LS_ERR);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
390_pci_generate_error_event(ERR_EVENT_SERR,=20
> >>> pbdev->fh, pbdev->fid,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, ERR_EVENT_Q_BIT);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_=
notify_iommu(iommu_mr, entry);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=3D ent=
ry.addr_mask + 1; =20
> >> You're now progressing even though you might have generated an error
> >> event. Is that what's intended? =20
> > Yes, this is wrong. The right thing is only delete the code generating=
=20
> > error event,
> > and keep the if check here in this patch. =20
>=20
> Hum, I do not see any problem with having a translated address being 0.
>=20
> I would say it is one of the fixup ;) .

Isn't this in response to an instruction that is supposed to
register/... something? IOW, the caller of the instruction tried to
make something happen, but something did not work out as intended (and
doesn't the code stumble over this later? Or do we get an error then?)
Shouldn't the caller get an indication of that? Of course, this again
depends on what the architecture says :)
