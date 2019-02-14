Received: from eggs.gnu.org ([209.51.188.92]:51488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKL8-0000aT-3V
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKL6-0008Hv-19
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guKL2-0008EU-9Z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:58:16 -0500
References: <87wom249zf.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com>
Date: Thu, 14 Feb 2019 17:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <87wom249zf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 14/02/19 17:21, Markus Armbruster wrote:
>  * As an interim step, the #DeviceState:realized property can also be
>  * set with qdev_init_nofail().
>  * In the future, devices will propagate this state change to their chi=
ldren
>  * and along busses they expose.
>=20
> This sentence is five years old.  Any progress?  If not, any intentions
> to make progress?

Good news, it's done!  What we still don't do is removing
qdev_init_nofail and realizing the whole machine in one fell swoop.

Bad news, it's been done for five years:

    commit 5c21ce77d7e5643089ceec556c0408445d017f32
    Author: Bandan Das <bsd@redhat.com>
    Date:   Wed Mar 12 21:02:12 2014 +0100

    qdev: Realize buses on device realization

    Integrate (un)realization of child buses with
    realization/unrealization
    of the device hosting them. Code in device_unparent() is reordered
    for unrealization of buses to work as part of device unrealization.

    That way no changes need to be made to bus instantiation.

    Signed-off-by: Bandan Das <bsd@redhat.com>
    Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

so I don't expect that the next step will ever happen...

>  * The point in time will be deferred to machine creation, so that valu=
es
>  * set in @realize will not be introspectable beforehand. Therefore dev=
ices
>  * must not create children during @realize; they should initialize the=
m via
>  * object_initialize() in their own #TypeInfo.instance_init and forward=
 the
>  * realization events appropriately.
>=20
> This is mostly greek to me.  Pity the developer who knows less about
> qdev than I do.

The first part refers to what virtio_instance_init_common does:

    object_initialize(vdev, vdev_size, vdev_name);
    object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev),
                              NULL);
    object_unref(OBJECT(vdev));

The second part doesn't apply to virtio because it has a bus (so the
code from the above commit handles recursive realization automatically).

hw/sd/milkymist-memcard.c has an example of this:

    object_property_set_bool(OBJECT(carddev), true, "realized", &err);

but it should create the device in milkymist_memcard_init rather than
milkymist_memcard_realize, in order to obey the directives of the sacred
book of QEMU.

Paolo
