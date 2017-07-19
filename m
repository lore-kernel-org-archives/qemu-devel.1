Received: from eggs.gnu.org ([2001:4830:134:3::10]:43890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjYl-0004Gy-5H
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjYk-0006vO-EW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXjYk-0006vA-87
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:38:14 -0400
Date: Wed, 19 Jul 2017 09:38:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719093804.3fa131db@gondolin>
In-Reply-To: <c64d191c-c424-542f-cd60-4e587e412db8@linux.vnet.ibm.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-8-cohuck@redhat.com>
	<c64d191c-c424-542f-cd60-4e587e412db8@linux.vnet.ibm.com>
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
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, thuth@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com
Cc: qemu-devel@nongnu.org

[restored cc: list]

On Wed, 19 Jul 2017 11:21:30 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/7/18 =E4=B8=8B=E5=8D=8810:24, Cornelia Huck =E5=86=99=E9=
=81=93:
> > If a guest running on a machine without zpci issues a pci instruction,
> > throw them an exception.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++----=
---------
> >   1 file changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 880eccd58a..60688888c3 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, st=
ruct kvm_run *run)
> >   {
> >       uint8_t r2 =3D (run->s390_sieic.ipb & 0x000f0000) >> 16;
> >
> > -    return clp_service_call(cpu, r2);
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        return clp_service_call(cpu, r2);
> > +    } else {
> > +        return -1;
> > +    } =20
> Hi Conny,
>=20
> Should we use a global value to store s390_has_feat(S390_FEAT_ZPCI)?
> I'm not sure it's a good idea.
>=20
> Yi Min

s390_has_feat() should be fast enough after the first time it has been
called, as the cpu is cached, so I don't think it's worth it.
