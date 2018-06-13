Received: from eggs.gnu.org ([2001:4830:134:3::10]:47613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8Ha-00089I-6S
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8HU-00060z-Ft
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:06:02 -0400
References: <20180612104430.25745-1-kraxel@redhat.com>
	<20180612104430.25745-5-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <431f487d-71f0-a766-eea4-7f3369984a7f@redhat.com>
Date: Wed, 13 Jun 2018 18:05:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180612104430.25745-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/8] bus: do not unref the added child bus
 on realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/06/2018 12:44, Gerd Hoffmann wrote:
>=20
> When the parent bus removes the child property, it takes care of
> removing the added reference, in object_finalize_child_property().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180531195119.22021-2-marcandre.lureau@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/core/bus.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 4651f24486..ad0c9df335 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -102,7 +102,6 @@ static void qbus_realize(BusState *bus, DeviceState=
 *parent, const char *name)
>          QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
>          bus->parent->num_child_bus++;
>          object_property_add_child(OBJECT(bus->parent), bus->name, OBJE=
CT(bus), NULL);
> -        object_unref(OBJECT(bus));

This is wrong.  object_finalize_child_property()'s unref balances the
ref in object_property_add_child().  qbus_realize's unref balances the
ref that was initially placed by object_new/object_initialize.

So you're introducing a leak.

Paolo
