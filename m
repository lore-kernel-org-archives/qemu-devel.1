Received: from eggs.gnu.org ([2001:4830:134:3::10]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRdn9-0007iB-PZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRdn8-0007mk-Ib
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:48:11 -0500
Date: Wed, 20 Dec 2017 13:47:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171220134754.77999bcf.cohuck@redhat.com>
In-Reply-To: <873745d7qp.fsf@dusky.pond.sub.org>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<87k1xig3zl.fsf@dusky.pond.sub.org>
	<20171220034730.696c3ceb@virtuozzo.com>
	<873745d7qp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v6 1/2] virtio: introduce `query-virtio' QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 20 Dec 2017 11:16:46 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:
>=20
> > On Tue, 19 Dec 2017 15:57:18 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:

> >> Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:

> Taking a step back: what's the intended purpose of query-virtio?  The
> cover letter doesn't really say:
>=20
>     After some discussion, I am going to suggest reworked QMP/HMP for
>     gathering virtio info. It would provide the following monitor output.
>=20
>     (qemu) info virtio
>     virtio-blk-device at 0000:00:02.0
>       QOM path: /machine/peripheral-anon/device[0]/virtio-backend
>       status: 0x0f
>         VIRTIO_CONFIG_S_ACKNOWLEDGE
>         VIRTIO_CONFIG_S_DRIVER
>         VIRTIO_CONFIG_S_DRIVER_OK
>         VIRTIO_CONFIG_S_FEATURES_OK
>       host features:  0x0000000179000e54
>       guest features: 0x0000000130000e54
>       common features:
>         VIRTIO_F_NOTIFY_ON_EMPTY
>         VIRTIO_F_ANY_LAYOUT
>         VIRTIO_RING_F_INDIRECT_DESC              acked
>         VIRTIO_RING_F_EVENT_IDX                  acked
>         VIRTIO_F_BAD_FEATURE
>         VIRTIO_F_VERSION_1                       acked
>       device features:
>         VIRTIO_BLK_F_SEG_MAX                     acked
>         VIRTIO_BLK_F_BLK_SIZE                    acked
>         VIRTIO_BLK_F_FLUSH                       acked
>         VIRTIO_BLK_F_TOPOLOGY                    acked
>=20
> The first sentence carries no useful information; suggest to scratch it.
> The rest is an HMP example.  Examples are great, but we really need to
> understand *why* you need this command.

=46rom my side, I see at least two use cases:

- Monitoring the state of virtio devices. If I can see from outside
  that VIRTIO_CONFIG_S_FAILED or VIRTIO_CONFIG_S_NEEDS_RESET has been
  set for a device, I know that something went wrong for that device.
- Debugging. This command gives me a nice way to find out why something
  is not working as it is supposed to, or to verify that something
  indeed does work as intended (I would have found such a command quite
  useful when implementing virtio-1).

>=20
> >> In case symbolic names may not be known at QEMU compile time (me
> >> having to wonder at v6 is a sign of rather ineffective patch review,
> >> sorry about that): you have to explain this in the doc comment, with a
> >> reference to where the bits are specified.
> >>  =20
> >
> > ok =20
>=20
> Can you think of a scenario where status or feature bits occur that are
> not known to QEMU at compile time?

Could happen for status bits (although very unlikely). For feature
bits, the guest is supposed to ack a subset of the offered bits, so
this would mean a fundamentally broken guest (also unlikely, but not
impossible).

>=20
> >> > +#
> >> > +# @status-names: names of checked bits in status bitmask =20
> >>=20
> >> How are the strings in @status-names connected to the bits in @status?
> >> Spell it out in this doc string, please.
> >>  =20
> >
> > ok
> >
> > ...but, strictly saying, I was not going to show in QAPI how these names
> > are mapped into bits, QMP answer would not contain how these names are
> > connected to bits. Otherwise, It would be reinvention of v4. =20
>=20
> To avoid going in circles some more, let's take a step back and examine
> what exactly you're trying to accomplish.  Give us use cases: this is my
> need, and this is how you use the proposed command to satisfy my need.
> Also give us design limitations: what the command is *not* trying to do.
