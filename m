Received: from eggs.gnu.org ([2001:4830:134:3::10]:53018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJw4-0005hf-CL
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJw0-0005Dq-0v
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJvz-0005Di-Oa
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:11:11 -0400
Date: Wed, 29 Mar 2017 17:11:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170329201108.GB3709@thinpad.lan.raisama.net>
References: <20170329194148.19015-1-ehabkost@redhat.com>
	<04ec9702-6624-1ca3-4595-c22f482a3435@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <04ec9702-6624-1ca3-4595-c22f482a3435@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/9] qom: Make
 object_get_class()/*_GET_CLASS return const pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Wed, Mar 29, 2017 at 09:56:54PM +0200, Laszlo Ersek wrote:
> On 03/29/17 21:41, Eduardo Habkost wrote:
> > The problem
> > -----------
> >=20
> > QOM has a data model where class struct data is static: class
> > structs are initialized at class_init, and never changed again.
> >=20
> > ...except for a few rare cases where class data is changed
> > outside class_init. Those cases are:
> >=20
> >   qbus_realize(), code added by:
> >   commit 61de36761b565a4138d8ad7ec75489ab28fe84b6
> >   Date:   Thu Feb 6 16:08:15 2014 +0100
> >       qdev: Keep global allocation counter per bus
> >=20
> >   mips_jazz_init(), code added by:
> >   commit 54e755588cf1e90f0b1460c4e8e6b6a54b6d3a32
> >   Date:   Mon Nov 4 23:26:17 2013 +0100
> >       mips jazz: do not raise data bus exception when accessing inval=
id addresses
> >=20
> >   xen_set_dynamic_sysbus(), code added by:
> >   commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> >   Date:   Tue Nov 22 07:10:58 2016 +0100
> >       xen: create qdev for each backend device
> >=20
> >   s390_cpu_realizefn(), code added by:
> >   commit c6644fc88bed1176f67b4b7a9df691bcf25c0c5b
> >   Date:   Fri Mar 4 12:34:31 2016 -0500
> >       s390x/cpu: Get rid of side effects when creating a vcpu
> >=20
> > I want to prevent that from happening again.
> >=20
> > Proposal
> > --------
> >=20
> > I propose we make object_get_class() and *_GET_CLASS macros
> > return const pointers. This way, anybody willing to change class
> > structs outside class_init will (hopefully) be aware that they
> > are doing something unexpected.
> >=20
> > This would be very simple and trivial, except that:
> > * OBJECT_CLASS_CHECK cast its return value to a different
> >   (non-const) pointer type.
> > * OBJECT_CLASS_CHECK-based macros are used everywhere to
> >   cast class pointers to different class types.
> >=20
> > I have addressed this problem using C11's _Generic keyword.
> > _Generic allows us to make OBJECT_CLASS_CHECK and other macros
> > return a const pointer if its argument is a const pointer, and a
> > non-const pointer otherwise.
> >=20
> > This series changes OBJECT_CLASS, OBJECT_CLASS_CHECK,
> > object_class_dynamic_cast_assert(), object_class_dynamic_cast(),
> > and object_class_get_parent() to exhibit this const-aware
> > behavior.
> >=20
> > If the compiler doesn't support _Generic, we keep the old
> > behavior, and the cast macros will keep returning non-const
> > pointers.
> >=20
> > ---
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Herv=E9 Poussineau <hpoussin@reactos.org>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Andreas F=E4rber <afaerber@suse.de>
> >=20
> > Eduardo Habkost (9):
> >   configure: test if _Generic works as expected
> >   Simplify code using *MACHINE_GET_CLASS
> >   qom: QUALIFIED_CAST helper macro
> >   qom: Make object_class_get_parent() const-aware
> >   Make class parameter const at some functions
> >   Explicitly cast the *_GET_CLASS() value when we break the rules
> >   Use const variables for *_GET_CLASS values
> >   qom: Make class cast macros/functions const-aware
> >   qom: Make object_get_class() return const pointer
>=20
> Only superficial comments:
>=20
> (1) HACKING has some notes on C99 and C11 usage; I think you should
> update them as well.

I will take a look, thanks!

>=20
> (2) Can you CC the maintainers of the code being modified on each patch=
?

I can, on the shorter ones, but this will be difficult on patch
7, which is composed mostly of mechanical changes generated using
Coccinelle. I didn't want to generate a huge CC list just because
of those mechanical changes.

>=20
> (3) (Corollary of the former -- I'm not seeing patch 7 yet, which I
> assume is the big one, from the cumulative diffstat) -- is it possible
> to split up patch 7 more fine-grained? To help reviewers. (I don't
> maintain anything in QEMU, so this is just a generic suggestion;
> everyone feel free to disagree.)

The coccinelle-generated parts of patch 7 will be hard to split,
but I can try to split the rest of the changes later.

I tried to keep the patch count smaller on purpose on the RFC,
because first I want to hear what people think of this proposal.
If people like it, I will split a few patches, especially:

* [RFC v2 2/9] Simplify code using *MACHINE_GET_CLASS
  (split the pc, machine core, and pci changes into separate patches)
* [RFC v2 5/9] Make class parameter const at some functions
  (split into one patch for each subsystem being changed)
* [RFC v2 6/9] Explicitly cast the *_GET_CLASS() value when we break the =
rules
  (not sure if I I will split it, but I will surely CC the
  maintainers for each subsystem)
* [RFC v2 7/9] Use const variables for *_GET_CLASS values
  (probably I will separate the coccinelle-generated changes from the oth=
ers,
  and split the manual changes per subsystem)

--=20
Eduardo
