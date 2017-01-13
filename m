Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS6R2-000448-CD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS6Qx-00028W-KL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:18:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cS6Qx-00028J-B1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:18:39 -0500
Date: Fri, 13 Jan 2017 20:18:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170113193004-mutt-send-email-mst@kernel.org>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
	<1587720065.2308546.1484319819288.JavaMail.zimbra@redhat.com>
	<AF473AD9-3343-4C5F-8DE1-B0870DC65327@nutanix.com>
	<20170113190029-mutt-send-email-mst@kernel.org>
	<93A04CF9-EC7D-4250-8AE5-3C5F3F0E325E@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <93A04CF9-EC7D-4250-8AE5-3C5F3F0E325E@nutanix.com>
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

On Fri, Jan 13, 2017 at 05:15:22PM +0000, Felipe Franciosi wrote:
>=20
> > On 13 Jan 2017, at 09:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Fri, Jan 13, 2017 at 03:09:46PM +0000, Felipe Franciosi wrote:
> >> Hi Marc-Andre,
> >>=20
> >>> On 13 Jan 2017, at 07:03, Marc-Andr=E9 Lureau <mlureau@redhat.com> =
wrote:
> >>>=20
> >>> Hi
> >>>=20
> >>> ----- Original Message -----
> >>>> Currently, VQs are started as soon as a SET_VRING_KICK is received=
. That
> >>>> is too early in the VQ setup process, as the backend might not yet=
 have
> >>>=20
> >>> I think we may want to reconsider queue_set_started(), move it else=
where, since kick/call fds aren't mandatory to process the rings.
> >>=20
> >> Hmm. The fds aren't mandatory, but I imagine in that case we should =
still receive SET_VRING_KICK/CALL messages without an fd (ie. with the VH=
OST_MSG_VQ_NOFD_MASK flag set). Wouldn't that be the case?
> >=20
> > Please look at docs/specs/vhost-user.txt, Starting and stopping rings
> >=20
> > The spec says:
> > 	Client must start ring upon receiving a kick (that is, detecting tha=
t
> > 	file descriptor is readable) on the descriptor specified by
> > 	VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
> > 	VHOST_USER_GET_VRING_BASE.
>=20
> Yes I have seen the spec, but there is a race with the current libvhost=
-user code which needs attention. My initial proposal (which got turned d=
own) was to send a spurious notification upon seeing a callfd. Then I cam=
e up with this proposal. See below.
>=20
> >=20
> >=20
> >>>=20
> >>>> a callfd to notify in case it received a kick and fully processed =
the
> >>>> request/command. This patch only starts a VQ when a SET_VRING_CALL=
 is
> >>>> received.
> >>>=20
> >>> I don't like that much, as soon as the kick fd is received, it shou=
ld start polling it imho. callfd is optional, it may have one and not the=
 other.
> >>=20
> >> So the question is whether we should be receiving a SET_VRING_CALL a=
nyway or not, regardless of an fd being sent. (I think we do, but I haven=
't done extensive testing with other device types.)
> >=20
> > I would say not, only KICK is mandatory and that is also not enough
> > to process ring. You must wait for it to be readable.
>=20
> The problem is that Qemu takes time between sending the kickfd and the =
callfd. Hence the race. Consider this scenario:
>=20
> 1) Guest configures the device
> 2) Guest put a request on a virtq
> 3) Guest kicks
> 4) Qemu starts configuring the backend
> 4.a) Qemu sends the masked callfds
> 4.b) Qemu sends the virtq sizes and addresses
> 4.c) Qemu sends the kickfds
>=20
> (When using MQ, Qemu will only send the callfd once all VQs are configu=
red)
>=20
> 5) The backend starts listening on the kickfd upon receiving it
> 6) The backend picks up the guest's request
> 7) The backend processes the request
> 8) The backend puts the response on the used ring
> 9) The backend notifies the masked callfd
>=20
> 4.d) Qemu sends the callfds
>=20
> At which point the guest missed the notification and gets stuck.
>=20
> Perhaps you prefer my initial proposal of sending a spurious notificati=
on when the backend sees a callfd?
>=20
> Felipe

I thought we read the masked callfd when we unmask it,
and forward the interrupt. See kvm_irqfd_assign:

        /*
         * Check if there was an event already pending on the eventfd
         * before we registered, and trigger it as if we didn't miss it.
         */
        events =3D f.file->f_op->poll(f.file, &irqfd->pt);

        if (events & POLLIN)
                schedule_work(&irqfd->inject);



Is this a problem you observe in practice?

>=20
> >=20
> >>>=20
> >>> Perhaps it's best for now to delay the callfd notification with a f=
lag until it is received?
> >>=20
> >> The other idea is to always kick when we receive the callfd. I remem=
ber discussing that alternative with you before libvhost-user went in. Th=
e protocol says both the driver and the backend must handle spurious kick=
s. This approach also fixes the bug.
> >>=20
> >> I'm happy with whatever alternative you want, as long it makes libvh=
ost-user usable for storage devices.
> >>=20
> >> Thanks,
> >> Felipe
> >>=20
> >>=20
> >>>=20
> >>>=20
> >>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >>>> ---
> >>>> contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++----------=
---
> >>>> 1 file changed, 13 insertions(+), 13 deletions(-)
> >>>>=20
> >>>> diff --git a/contrib/libvhost-user/libvhost-user.c
> >>>> b/contrib/libvhost-user/libvhost-user.c
> >>>> index af4faad..a46ef90 100644
> >>>> --- a/contrib/libvhost-user/libvhost-user.c
> >>>> +++ b/contrib/libvhost-user/libvhost-user.c
> >>>> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserM=
sg *vmsg)
> >>>>        DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index)=
;
> >>>>    }
> >>>>=20
> >>>> -    dev->vq[index].started =3D true;
> >>>> -    if (dev->iface->queue_set_started) {
> >>>> -        dev->iface->queue_set_started(dev, index, true);
> >>>> -    }
> >>>> -
> >>>> -    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler)=
 {
> >>>> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >>>> -                       vu_kick_cb, (void *)(long)index);
> >>>> -
> >>>> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >>>> -               dev->vq[index].kick_fd, index);
> >>>> -    }
> >>>> -
> >>>>    return false;
> >>>> }
> >>>>=20
> >>>> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserM=
sg *vmsg)
> >>>>=20
> >>>>    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >>>>=20
> >>>> +    dev->vq[index].started =3D true;
> >>>> +    if (dev->iface->queue_set_started) {
> >>>> +        dev->iface->queue_set_started(dev, index, true);
> >>>> +    }
> >>>> +
> >>>> +    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler)=
 {
> >>>> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >>>> +                       vu_kick_cb, (void *)(long)index);
> >>>> +
> >>>> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >>>> +               dev->vq[index].kick_fd, index);
> >>>> +    }
> >>>> +
> >>>>    return false;
> >>>> }
> >>>>=20
> >>>> --
> >>>> 1.9.4
> >>>>=20
> >>>>=20
> >>=20
