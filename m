Received: from eggs.gnu.org ([2001:4830:134:3::10]:46470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzc6-0003QM-6T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYzc2-0001Jr-16
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYzc1-0001Hb-R7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:03:21 -0400
Date: Fri, 29 Jun 2018 17:03:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629200318.GY7451@localhost.localdomain>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629103910.GE27016@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 29, 2018 at 11:39:10AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 29, 2018 at 12:35:09PM +0200, Paolo Bonzini wrote:
> > On 29/06/2018 12:29, Greg Kurz wrote:
> > > It is unsafe to rely on *_enabled() helpers before the accelerator =
has
> > > been initialized, ie, accel_init_machine() has succeeded, because t=
hey
> > > always return false. But it is still possible to end up calling the=
m
> > > indirectly by inadvertance, and cause QEMU to misbehave.
> > >=20
> > > This patch causes QEMU to abort if we try to check for an accelerat=
or
> > > before it has been set up. This will help to catch bugs earlier.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >=20
> > > This patch was motivated by an regression we're currently fixing in
> > > spapr because of an early use of kvm_enabled(). David suggested to
> > > post this patch separately:
> > >=20
> > > https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg01136.htm=
l
> > >=20
> > > v2: - dropped change in qom/cpu.c (useless header inclusion)
> > >     - only #include "sysemu/kvm.h" if we actually need it
> > >     - added David's R-b from v1 because changes in v2 are minor
> >=20
> > This adds a function call on possibly hot paths.  Can you make it inl=
ine?
> >=20
> > Also asserting current_machine !=3D NULL is not necessary, since you'=
re
> > immediately dereferencing it.
>=20
> Is there a practical way to simply initialize the accelerators earlier
> in startup sequence, so we just remove or at least reduce, the liklihoo=
d
> of accessing it too early ?

We can reduce it, but not eliminate it: it would still be
possible to use the *_enabled() macros too early, before we parse
all command-line options (on QOM class_init, for example).

--=20
Eduardo
