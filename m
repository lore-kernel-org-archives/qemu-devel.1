Received: from eggs.gnu.org ([2001:4830:134:3::10]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzpC-0003En-PO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzp9-0007ho-L0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYzp9-0007gP-Ec
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:16:55 -0400
Date: Fri, 29 Jun 2018 17:16:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629201652.GA7451@localhost.localdomain>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
	<20180629171821.5e379a31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629171821.5e379a31@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jun 29, 2018 at 05:18:21PM +0200, Igor Mammedov wrote:
> On Fri, 29 Jun 2018 12:14:05 +0100
> Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
>=20
> > On Fri, Jun 29, 2018 at 01:08:38PM +0200, Paolo Bonzini wrote:
> > > On 29/06/2018 13:07, Greg Kurz wrote: =20
> > > >>>> Also asserting current_machine !=3D NULL is not necessary, sin=
ce you're
> > > >>>> immediately dereferencing it.   =20
> > > >>> Is there a practical way to simply initialize the accelerators =
earlier
> > > >>> in startup sequence, so we just remove or at least reduce, the =
liklihood
> > > >>> of accessing it too early ?   =20
> > > >> We can try, though not for 3.0 of course.
> > > >> =20
> > > > FWIW, the motivation for this patch was kvm_enabled() being calle=
d under
> > > > the class_init function of the machine TypeInfo. This happens way=
 earlier
> > > > than accelerator init. Not sure this is doable, but I can have a =
look.
> > > >  =20
> > >=20
> > > Probably not, that's way too early indeed. =20
> >=20
> > Yeah, doing anything non-trivial in class_init is just asking for tro=
uble,
> > as conceivably nothing is initialized at that point.=20
> isn't class_init called lazily? (so it might actually work as far as ty=
pe
> isn't touched before kvm is initialized)

You have a good point: this means class_init bugs won't always
trigger the assert because of lazy class_init.  It would be a
good idea to add a functional test that calls qom-list-types
using --preconfig to try to trigger them.

--=20
Eduardo
