Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fZ06B-0000ei-Qx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fZ068-00052Q-N9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:34:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fZ068-00050Q-GS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:34:28 -0400
Date: Fri, 29 Jun 2018 17:34:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629203424.GG914@localhost.localdomain>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
	<20180629171821.5e379a31@redhat.com>
	<20180629201652.GA7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629201652.GA7451@localhost.localdomain>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 29, 2018 at 05:16:52PM -0300, Eduardo Habkost wrote:
> On Fri, Jun 29, 2018 at 05:18:21PM +0200, Igor Mammedov wrote:
> > On Fri, 29 Jun 2018 12:14:05 +0100
> > Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
> >=20
> > > On Fri, Jun 29, 2018 at 01:08:38PM +0200, Paolo Bonzini wrote:
> > > > On 29/06/2018 13:07, Greg Kurz wrote: =20
> > > > >>>> Also asserting current_machine !=3D NULL is not necessary, s=
ince you're
> > > > >>>> immediately dereferencing it.   =20
> > > > >>> Is there a practical way to simply initialize the accelerator=
s earlier
> > > > >>> in startup sequence, so we just remove or at least reduce, th=
e liklihood
> > > > >>> of accessing it too early ?   =20
> > > > >> We can try, though not for 3.0 of course.
> > > > >> =20
> > > > > FWIW, the motivation for this patch was kvm_enabled() being cal=
led under
> > > > > the class_init function of the machine TypeInfo. This happens w=
ay earlier
> > > > > than accelerator init. Not sure this is doable, but I can have =
a look.
> > > > >  =20
> > > >=20
> > > > Probably not, that's way too early indeed. =20
> > >=20
> > > Yeah, doing anything non-trivial in class_init is just asking for t=
rouble,
> > > as conceivably nothing is initialized at that point.=20
> > isn't class_init called lazily? (so it might actually work as far as =
type
> > isn't touched before kvm is initialized)
>=20
> You have a good point: this means class_init bugs won't always
> trigger the assert because of lazy class_init.  It would be a
> good idea to add a functional test that calls qom-list-types
> using --preconfig to try to trigger them.

Heh, I just noticed that the first thing we do immediately after
parsing command-line options is calling:

 select_machine()
 find_default_machine()
 object_class_get_list()
 object_class_foreach()
 g_hash_table_foreach()
 object_class_foreach_tramp()
 type_initialize()

...which will call class_init for every single QOM type in QEMU.

--=20
Eduardo
