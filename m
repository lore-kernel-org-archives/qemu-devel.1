Received: from eggs.gnu.org ([2001:4830:134:3::10]:54390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHdEv-0007CQ-J5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 19:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHdEq-0007hy-Bt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 19:16:01 -0400
Date: Tue, 30 Oct 2018 20:15:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181030231545.GY3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
	<6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
	<20181030164633.2c8f21d3.cohuck@redhat.com>
	<74a8ecef-18c0-d55d-4b29-7ed6c6b57537@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <74a8ecef-18c0-d55d-4b29-7ed6c6b57537@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Oct 30, 2018 at 06:37:42PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 30/10/18 16:46, Cornelia Huck wrote:
> > On Tue, 30 Oct 2018 15:13:45 +0100
> > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> >=20
> > > On 30/10/18 15:00, Gerd Hoffmann wrote:
> > > > On Tue, Oct 30, 2018 at 02:32:40PM +0100, Philippe Mathieu-Daud=E9=
 wrote:
> > > > > > +##
> > > > > > +# @SupportState:
> > > > > > +#
> > > > > > +# Indicate Support level of qemu devices, backends, subsyste=
ms, ...
> > > > > > +#
> > > > > > +# Since: 3.2
> > > > > > +##
> > > > > > +{ 'enum': 'SupportState',
> > > > > > +  'data': [ 'unknown',
> > > > >=20
> > > > > 'unknown' is scary and should be fixed.
> > > >=20
> > > > 'unknown' maps to "0" due to being first in list, so this is what=
 you
> > > > get when it isn't explicitly set to something else.  Which make s=
ense
> > > > IMHO.
> > >=20
> > > Yes, I understand in your next patch, this case won't display warni=
ng to
> > > the user.
> > >=20
> > > I wanted to say "we should fix those entries in the MAINTAINERS fil=
e".
> >=20
> > I think that has been an ongoing quest for years :)
> >=20
> > >=20
> > > > > > +            'supported',
> > > > > > +            'maintained',
> > > > > > +            'odd-fixes',
> > > > >=20
> > > > > All those fit in 'supported'
> > > > > > +            'orphan',
> > > > > > +            'obsolete',
> > > > > > +            'deprecated' ] }
> > > > >=20
> > > > > And all those should appear as 'deprecated' IMHO.
> > > >=20
> > > > See minutes on deprecation discussion.  Seems there is agreement =
we
> > > > need something more finegrained than "supported" and "deprecated"=
.
> > >=20
> > > I read again the "Minutes of KVM Forum BoF on deprecating stuff" th=
read
> > > and don't find details on finegrains, can you point it to me?
> > >=20
> > > I think these are fine in the MAINTAINERS entries, but don't give u=
seful
> > > information to a QEMU user that is not custom to MAINTAINERS.
> >=20
> > We might squash 'supported' and 'maintained' together (as their only
> > real difference is whether someone gets paid for it), but 'odd fixes'
> > is different IMO (you have someone to talk to, but they don't dedicat=
e
> > much of their time to it.)
> >=20
> > >=20
> > > As a user I'd expect anything not "supported" to be eventually "dep=
recated".
> >=20
> > But there are differences:
> > - 'orphan' - nobody is looking after it; should become 'deprecated' i=
f
> >    nobody steps up, but may move to one of the 'someone looks after i=
t'
> >    states
> > - 'obsolete' - don't use this; should move to 'deprecated' once a
> >    replacement is ready (or it is not needed anymore)
> > - 'deprecated' - on the removal schedule; has not necessarily been in
> >    'orphan' or 'obsolete' before
>=20
> OK!
>=20
> If I understand correctly, we have this 'state machine':
>=20
>    Supported            Unsupported          Deprecated
>=20
> (someone to talk)     (nobody to talk)  (scheduled for removal)
> +--------------+       +------------+      +--------------+
> | S:Maintained |       | S:Unknown  |      |              |
> |              |       |            |      |              |
> | S:Supported  + <---> | S:Orphan   +----> | S:Deprecated +----> Remove=
d
> |              |       |            |      |              |
> | S:Odd Fixes  |       | S:Obsolete |      |              |
> +------+-------+       +------------+      +--------------+
>        |                                           ^
>        |                                           |
>        +-------------------------------------------+
>=20
> So we have 3 distinct states.
>=20
> Note:
> - Maintainers can deprecate stuffs
> - Orphan code can become Supported
> - Once scheduled for removal, there is no way back
> - 'Unknown' seems pretty similar to 'Orphan'.

I'm still worried that the supported/unsupported distinction may
cause unnecessary hassle for every downstream distributor of
QEMU.  Do we really have a need to differentiate supported vs
unsupported device types at runtime?

I'd prefer to make support/unsupported differentiation to be a
build system feature (e.g. a CONFIG_UNSUPPORTED build-time
option) instead of a QMP/runtime feature.

--=20
Eduardo
