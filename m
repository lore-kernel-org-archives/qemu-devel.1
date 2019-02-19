Received: from eggs.gnu.org ([209.51.188.92]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw2wV-0007uG-SO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw2wU-00088p-OM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gw2wU-000889-Gq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:48:02 -0500
Date: Tue, 19 Feb 2019 11:38:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190219113847.5b23334e@redhat.com>
In-Reply-To: <8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com>
References: <87wom249zf.fsf@dusky.pond.sub.org>
	<8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Object instantiation vs. device realization: what
 to do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>

On Thu, 14 Feb 2019 17:58:06 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 14/02/19 17:21, Markus Armbruster wrote:
> >  * As an interim step, the #DeviceState:realized property can also be
> >  * set with qdev_init_nofail().
> >  * In the future, devices will propagate this state change to their chi=
ldren
> >  * and along busses they expose.
> >=20
> > This sentence is five years old.  Any progress?  If not, any intentions
> > to make progress? =20
>=20
> Good news, it's done!  What we still don't do is removing
> qdev_init_nofail and realizing the whole machine in one fell swoop.
>=20
> Bad news, it's been done for five years:
>=20
>     commit 5c21ce77d7e5643089ceec556c0408445d017f32
>     Author: Bandan Das <bsd@redhat.com>
>     Date:   Wed Mar 12 21:02:12 2014 +0100
>=20
>     qdev: Realize buses on device realization
>=20
>     Integrate (un)realization of child buses with
>     realization/unrealization
>     of the device hosting them. Code in device_unparent() is reordered
>     for unrealization of buses to work as part of device unrealization.
>=20
>     That way no changes need to be made to bus instantiation.
>=20
>     Signed-off-by: Bandan Das <bsd@redhat.com>
>     Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>=20
> so I don't expect that the next step will ever happen...

that isn't really used (realize part) last time we've looked at it
https://www.mail-archive.com/qemu-devel@nongnu.org/msg570424.html


> >  * The point in time will be deferred to machine creation, so that valu=
es
> >  * set in @realize will not be introspectable beforehand. Therefore dev=
ices
> >  * must not create children during @realize; they should initialize the=
m via
> >  * object_initialize() in their own #TypeInfo.instance_init and forward=
 the
> >  * realization events appropriately.
> >=20
> > This is mostly greek to me.  Pity the developer who knows less about
> > qdev than I do. =20
>=20
> The first part refers to what virtio_instance_init_common does:
>=20
>     object_initialize(vdev, vdev_size, vdev_name);
>     object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev),
>                               NULL);
>     object_unref(OBJECT(vdev));
>=20
> The second part doesn't apply to virtio because it has a bus (so the
> code from the above commit handles recursive realization automatically).
>=20
> hw/sd/milkymist-memcard.c has an example of this:
>=20
>     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
>=20
> but it should create the device in milkymist_memcard_init rather than
> milkymist_memcard_realize, in order to obey the directives of the sacred
> book of QEMU.
>=20
> Paolo
>=20
