Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXkfP-0000jx-Nt
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXkfM-0001Vk-FO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXkfM-0001U7-93
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:49:08 -0400
Date: Wed, 19 Jul 2017 10:49:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719104901.2091ce0f@gondolin>
In-Reply-To: <3d0597bd-efbd-af9e-7662-fef13c27b6f7@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-8-cohuck@redhat.com>
	<3d0597bd-efbd-af9e-7662-fef13c27b6f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 7/9] s390x/pci: fence off
 instructions for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 19 Jul 2017 10:07:53 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 18.07.2017 16:24, Cornelia Huck wrote:
> > If a guest running on a machine without zpci issues a pci instruction,
> > throw them an exception.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++-----=
--------
> >  1 file changed, 41 insertions(+), 13 deletions(-) =20
> [...]
> >  static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
> > @@ -1269,10 +1293,14 @@ static int kvm_mpcifc_service_call(S390CPU *cpu=
, struct kvm_run *run)
> >      uint64_t fiba;
> >      uint8_t ar;
> > =20
> > -    cpu_synchronize_state(CPU(cpu));
> > -    fiba =3D get_base_disp_rxy(cpu, run, &ar);
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        cpu_synchronize_state(CPU(cpu));
> > +        fiba =3D get_base_disp_rxy(cpu, run, &ar);
> > =20
> > -    return mpcifc_service_call(cpu, r1, fiba, ar);
> > +        return mpcifc_service_call(cpu, r1, fiba, ar);
> > +    } else {
> > +        return -1;
> > +    }
> >  } =20
>=20
> I think I'd rather write these cases with early exits =C3=A0 la
>=20
>     if (!s390_has_feat(S390_FEAT_ZPCI)) {
>         return -1;
>     }
>=20
> so you could get along with less change and less indentation=20

Yeah, that's just the same as for the other patch, only that the
difference is smaller here. I'll just keep it, unless there are strong
feelings.

> ... but
> since this is rather a matter of taste, anyway:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

Thanks!
