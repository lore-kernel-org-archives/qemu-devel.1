Received: from eggs.gnu.org ([2001:4830:134:3::10]:45588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cr6Ey-0005Lf-Ce
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cr6Ev-0000ji-8R
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cr6Eu-0000gQ-V8
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:09:33 -0400
Date: Thu, 23 Mar 2017 19:09:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170323190609-mutt-send-email-mst@kernel.org>
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
	<20170303132149.34e5906a.cornelia.huck@de.ibm.com>
	<aa9b9219-f3a6-165c-2d92-156a9295adbb@linux.vnet.ibm.com>
	<20170303135012.17edb640.cornelia.huck@de.ibm.com>
	<d00802cc-150a-2263-604d-9c2eaa5c19d1@linux.vnet.ibm.com>
	<20170306155625.5c426793.cornelia.huck@de.ibm.com>
	<bf1f8af2-9d76-c148-24c5-7d00312c10d4@linux.vnet.ibm.com>
	<20170306170441.2a8f8b27.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170306170441.2a8f8b27.cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, Mar 06, 2017 at 05:04:41PM +0100, Cornelia Huck wrote:
> On Mon, 6 Mar 2017 16:21:13 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
> > On 03/06/2017 03:56 PM, Cornelia Huck wrote:
> > > On Fri, 3 Mar 2017 14:08:37 +0100
> > > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > >=20
> > >> On 03/03/2017 01:50 PM, Cornelia Huck wrote:
> > >>> On Fri, 3 Mar 2017 13:43:32 +0100
> > >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > >>>
> > >>>> On 03/03/2017 01:21 PM, Cornelia Huck wrote:
> > >>>>> On Thu,  2 Mar 2017 19:59:42 +0100
> > >>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > [...]
> > >> I admit, I did not investigate this thoroughly, also because the p=
atch
> > >> is flawed regarding multi-thread anyway. After a quick investigati=
on
> > >> it seems the linux guest won't auto-reset the device so the guest =
should
> > >> end up with a not working device. I think it's pretty likely that =
the
> > >> admin will check the logs if the device was important.
> > >=20
> > > Thinking a bit more about this, it seems setting the device broken =
is
> > > not the right solution for exactly that reason. Setting the virtio
> > > device broken is a way to signal the guest to 'you did something
> > > broken; please reset the device and start anew' (and that's how cur=
rent
> > > callers use it). In our case, this is not the guest's fault.
> >=20
> > Do we have something to just say stuff broken without blaming the gue=
st?
> > And device reset might not be that stupid at all in the given situati=
on,
> > if we want to save what can be saved from the perspective of the gues=
t.
> > (After reset stuff should work again until we hit the race again -- a=
nd
> > since turning ioeventfd on/off should not happen that often during no=
rmal
> > operation it could help limit damage suffered -- e.g. controlled shut=
down).
>=20
> Checking again, the spec says
>=20
> DEVICE_NEEDS_RESET (64) Indicates that the device has experienced an
> error from which it can=E2=80=99t recover.
>=20
> Nothing about 'guest error'.
>=20
> The only problem is that legacy devices don't have that state, which
> means they'll have a broken device through no fault of their own.
>=20
> >=20
> > >=20
> > > Maybe go back to the assert 'solution'? But I'm not sure that's eno=
ugh
> > > if production builds disable asserts...
> > >=20
> >=20
> > I will wait a bit, maybe other virtio folks are going to have an=20
> > opinion too.
> >=20
> > My concern about the assert solution is that for production it is
> > either too rigorous (kill off, hopefully with a dump) or not
> > enough (as you have mentioned, if NDEBUG assert does nothing).
> >=20
> >=20
> > I think there are setups where a loss of device does not have to be
> > fatal, and I would not like to be the one who makes it fatal (for the
> > guest).
>=20
> Basically, it's a host bug (and not a bug specific to a certain
> device). Moving the device which was impacted to a broken state may be
> a useful mitigation.
>=20
> But yes, let's hear some other opinions.

We don't support NDEBUG really so I think an assert is fine for now.
Handling unexpected errors more gracefully is laudable but I think we
want a more systematic approach than just open-coding it in
this specific place.


--=20
MST
