Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHmi9-0000zG-Cg
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHmi8-0003vX-II
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:22:49 -0400
Date: Wed, 31 Oct 2018 10:22:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181031102236.21fd9564.cohuck@redhat.com>
In-Reply-To: <20181030231545.GY3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
	<6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
	<20181030164633.2c8f21d3.cohuck@redhat.com>
	<74a8ecef-18c0-d55d-4b29-7ed6c6b57537@redhat.com>
	<20181030231545.GY3902@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S.
	Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 30 Oct 2018 20:15:45 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 30, 2018 at 06:37:42PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > If I understand correctly, we have this 'state machine':
> >=20
> >    Supported            Unsupported          Deprecated
> >=20
> > (someone to talk)     (nobody to talk)  (scheduled for removal)
> > +--------------+       +------------+      +--------------+
> > | S:Maintained |       | S:Unknown  |      |              |
> > |              |       |            |      |              |
> > | S:Supported  + <---> | S:Orphan   +----> | S:Deprecated +----> Removed
> > |              |       |            |      |              |
> > | S:Odd Fixes  |       | S:Obsolete |      |              |
> > +------+-------+       +------------+      +--------------+
> >        |                                           ^
> >        |                                           |
> >        +-------------------------------------------+

I believe we can also take things out of the deprecated state again,
but I would expect that to be a very rare event.

'Obsolete' is probably 'unsupported' in the 'do not use that' sense,
but there still might be someone to talk to.

Similarly, 'unknown' devices etc. may have someone we can talk to, it's
just the problem of finding out who that is and getting them to move it
into the 'supported' state :)

> >=20
> > So we have 3 distinct states.
> >=20
> > Note:
> > - Maintainers can deprecate stuffs

It's not only maintainers that can do that, but it has to get their
ack, of course.

> > - Orphan code can become Supported
> > - Once scheduled for removal, there is no way back

We should not block the way back, or else we cannot adapt to things we
did not know when we first deprecated it.

> > - 'Unknown' seems pretty similar to 'Orphan'. =20

Not quite. If something is 'orphan', it was explicitly moved to that
state when a maintainer gave it up. 'Unknown' may also be stuff that
simply fell through the cracks.

>=20
> I'm still worried that the supported/unsupported distinction may
> cause unnecessary hassle for every downstream distributor of
> QEMU.  Do we really have a need to differentiate supported vs
> unsupported device types at runtime?
>=20
> I'd prefer to make support/unsupported differentiation to be a
> build system feature (e.g. a CONFIG_UNSUPPORTED build-time
> option) instead of a QMP/runtime feature.

I think that makes sense -- we really want to single out
devices/machines that are deprecated and will go away unless
something magic happens.
