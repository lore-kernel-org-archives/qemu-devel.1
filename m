Received: from eggs.gnu.org ([2001:4830:134:3::10]:51082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS5HB-0004Kg-GC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS5H8-0008Mh-Aa
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:04:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cS5H8-0008LZ-1W
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:04:26 -0500
Date: Fri, 13 Jan 2017 19:04:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170113190029-mutt-send-email-mst@kernel.org>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
	<1587720065.2308546.1484319819288.JavaMail.zimbra@redhat.com>
	<AF473AD9-3343-4C5F-8DE1-B0870DC65327@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <AF473AD9-3343-4C5F-8DE1-B0870DC65327@nutanix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On Fri, Jan 13, 2017 at 03:09:46PM +0000, Felipe Franciosi wrote:
> Hi Marc-Andre,
>=20
> > On 13 Jan 2017, at 07:03, Marc-Andr=E9 Lureau <mlureau@redhat.com> wr=
ote:
> >=20
> > Hi
> >=20
> > ----- Original Message -----
> >> Currently, VQs are started as soon as a SET_VRING_KICK is received. =
That
> >> is too early in the VQ setup process, as the backend might not yet h=
ave
> >=20
> > I think we may want to reconsider queue_set_started(), move it elsewh=
ere, since kick/call fds aren't mandatory to process the rings.
>=20
> Hmm. The fds aren't mandatory, but I imagine in that case we should sti=
ll receive SET_VRING_KICK/CALL messages without an fd (ie. with the VHOST=
_MSG_VQ_NOFD_MASK flag set). Wouldn't that be the case?

Please look at docs/specs/vhost-user.txt, Starting and stopping rings

The spec says:
	Client must start ring upon receiving a kick (that is, detecting that
	file descriptor is readable) on the descriptor specified by
	VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
	VHOST_USER_GET_VRING_BASE.


> >=20
> >> a callfd to notify in case it received a kick and fully processed th=
e
> >> request/command. This patch only starts a VQ when a SET_VRING_CALL i=
s
> >> received.
> >=20
> > I don't like that much, as soon as the kick fd is received, it should=
 start polling it imho. callfd is optional, it may have one and not the o=
ther.
>=20
> So the question is whether we should be receiving a SET_VRING_CALL anyw=
ay or not, regardless of an fd being sent. (I think we do, but I haven't =
done extensive testing with other device types.)

I would say not, only KICK is mandatory and that is also not enough
to process ring. You must wait for it to be readable.

> >=20
> > Perhaps it's best for now to delay the callfd notification with a fla=
g until it is received?
>=20
> The other idea is to always kick when we receive the callfd. I remember=
 discussing that alternative with you before libvhost-user went in. The p=
rotocol says both the driver and the backend must handle spurious kicks. =
This approach also fixes the bug.
>=20
> I'm happy with whatever alternative you want, as long it makes libvhost=
-user usable for storage devices.
>=20
> Thanks,
> Felipe
>=20
>=20
> >=20
> >=20
> >> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >> ---
> >> contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++------------=
-
> >> 1 file changed, 13 insertions(+), 13 deletions(-)
> >>=20
> >> diff --git a/contrib/libvhost-user/libvhost-user.c
> >> b/contrib/libvhost-user/libvhost-user.c
> >> index af4faad..a46ef90 100644
> >> --- a/contrib/libvhost-user/libvhost-user.c
> >> +++ b/contrib/libvhost-user/libvhost-user.c
> >> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg=
 *vmsg)
> >>         DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >>     }
> >>=20
> >> -    dev->vq[index].started =3D true;
> >> -    if (dev->iface->queue_set_started) {
> >> -        dev->iface->queue_set_started(dev, index, true);
> >> -    }
> >> -
> >> -    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
> >> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >> -                       vu_kick_cb, (void *)(long)index);
> >> -
> >> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >> -               dev->vq[index].kick_fd, index);
> >> -    }
> >> -
> >>     return false;
> >> }
> >>=20
> >> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg=
 *vmsg)
> >>=20
> >>     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >>=20
> >> +    dev->vq[index].started =3D true;
> >> +    if (dev->iface->queue_set_started) {
> >> +        dev->iface->queue_set_started(dev, index, true);
> >> +    }
> >> +
> >> +    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
> >> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >> +                       vu_kick_cb, (void *)(long)index);
> >> +
> >> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >> +               dev->vq[index].kick_fd, index);
> >> +    }
> >> +
> >>     return false;
> >> }
> >>=20
> >> --
> >> 1.9.4
> >>=20
> >>=20
>=20
