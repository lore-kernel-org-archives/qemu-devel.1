Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7ncb-0001HA-Jj
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7ncY-0000Dg-HL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:43:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7ncY-0000DV-8f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:42:58 -0400
Date: Mon, 8 May 2017 19:42:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508184251.GM2120@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508173650.GJ2120@work-vm>
	<877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
	<20170508175906.GK2120@work-vm>
	<b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>=20
>=20
> On 05/08/2017 07:59 PM, Dr. David Alan Gilbert wrote:
> >>>>  const VMStateDescription vmstate_virtio_ccw_dev =3D {
> >>>>      .name =3D "s390_virtio_ccw_dev",
> >>>>      .version_id =3D 1,
> >>>> @@ -67,6 +93,14 @@ const VMStateDescription vmstate_virtio_ccw_dev =
=3D {
> >>>>          VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
> >>>>          VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
> >>>>          VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
> >>>> +        {
> >>>> +        /*
> >>>> +         * Ugly hack because VirtIODevice does not migrate itself.
> >>>> +         * This also makes legacy via vmstate_save_state possible.
> >>>> +         */
> >>>> +            .name         =3D "virtio/config_vector",
> >>>> +            .info         =3D &vmstate_info_config_vector,
> >>>> +        },
> >>> I'm a bit confused - isn't just this bit the bit going
> >>> through the vdev->load_config hook?
> >>>
> >> Exactly! If you examine the part underscored with =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D in
> >> virtio_ccw_(load|save)_config  (that is what is behind vdev->load_conf=
ig)
> >> you should see that we use vmstate_virtio_ccw_dev (that is this
> >> VMStateDescription to implement these function.=20
> >>
> >> Actually virtio_ccw_(load|save)_config won't do anything after patch 9
> >> and for new machines since the VirtIOCcwDevice is going to migrate
> >> itself via DeviceClass.vmsd like other "normal" devices, and we fall
> >> back to the VirtIO specific callbacks only in "legacy mode".
> >>
> >> I hope this helps!
> > Hmm, still confused!
> > Why are you changing a Virtio device not to use the same migration
> > oddities as all the other virtio devices?
> >=20
> > I was assuming we'd have to change the virtio core code to
> > solve that for all virtio devices.
> >=20
>=20
> You can ask difficult questions ;). First I'm not aware of any
> ongoing effort to solve this for all virtio devices by changing
> the core, and probably breaking compatibility for all devices
> (in a sense I break migration compatibility for all virtio-ccw
> devices). To be honest, I have considered that move unlikely,
> but the possibility is one of my reasons for seeking an upstream
> discussion and having You and Michael on cc.

Well I have been trying to improve it, but that code is particularly
nasty; and I don't want to break compatibility.  I had some ideas,
for example I was thinking of changing the vdev->load_config to
a VMState* and then calling a vmstate_load_state(f, vdc->config,...
=66rom virtio_load - but there's some challenging casting and hackery
there.

>=20
> Why not use virtio oddities? Because they are oddities. I have
> figured, it's a good idea to separate the migration of the=20
> proxy form the rest: we have two QEMU Device objects and it
> should be good practice, that these are migrating themselves via
> DeviceClass.vmsd. That's what I get with this patch set,=20
> for new machine versions (since we can not fix the past), and
> with the notable difference of config_vector, because it is
> defined as a common infrastructure (struct VirtIODevice) but
> ain't migrated as a common virtio infrastructure.

Have you got a bit of a description of your classes/structure - it's
a little hard to get my head around.

> Would you suggest to rather keep the oddities? Should I expect
> to see a generic solution to the problem sometime soon?

Not soon I fear; virtio_load is just too hairy.

Dave

> Halil
>=20
> > Dave
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
