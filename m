Received: from eggs.gnu.org ([2001:4830:134:3::10]:49559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKT5P-0008EU-UT
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKT5M-0002M1-OO
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:01:54 -0500
Date: Wed, 7 Nov 2018 17:01:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181107190114.GD12503@habkost.net>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-14-marcandre.lureau@redhat.com>
	<CAJ+F1CLWy0xbb-Pc7yUNpHh70GsSTKJ=v+TeoTGJOThYO_xE2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLWy0xbb-Pc7yUNpHh70GsSTKJ=v+TeoTGJOThYO_xE2g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 13/14] hw/i386: add
 pc-i440fx-3.2 & pc-q35-3.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, amit@kernel.org, hpoussin@reactos.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.ibm.com, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

On Wed, Nov 07, 2018 at 07:49:54PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Nov 7, 2018 at 4:49 PM Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The following patch is going to add compatiblity parameters for
> > qemu <=3D 3.1.
> >
>=20
> I realize this may be good enough for x86 i440/q35 machines, but what
> about other machines & architectures?
>=20
> What do we officially support, for migration, across different versions=
?
>=20
> It seems we have versionized:
> - arm "virt" machines
> - "s390-ccw-virtio" machines
> - ppc "pseries" machines
> - x86 piix/q35 machines
>=20
> At least, I think I should update this patch to add new 3.2 machines fo=
r those.

This QEMU release seems to be unusual: normally we add features
that require adding new machine-types long before soft freeze.
If we didn't add new machine-types until now, this means we
didn't introduce any guest ABI changes that require them.

Now, this is an interesting case: we probably don't _need_ the
new machine-types, but users might be confused if they don't see
new machine-types.  Should we add them anyway?


>=20
> Is there any way to check compat properties are handled properly for
> those various machines? It looks like it is generally lacking. For
> example, if there is a new HW_COMPAT, it would be nice if something
> failed if a corresponding machine hasn't been added.
>=20
> It also looks like there is a bit of code duplication and a bit too
> much macros :) unfortunately, I don't yet have a good idea how to
> improve things...

I dream with the day all this compatibility data will be treated
like what it is: just data.  The ugly macro trickery needs to go
away eventually, but this requires making the QOM/machine-type
APIs more practical.

Removing very old machine-types will probably make this task
easier, because they are the main source of compatibility code
that is not represented as <driver.property=3Dvalue> tuples (grep
for "static void pc_compat_" and you'll see them).

--=20
Eduardo
