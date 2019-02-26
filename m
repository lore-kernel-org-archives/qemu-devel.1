Received: from eggs.gnu.org ([209.51.188.92]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc9e-0002kZ-AZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc9d-0002tX-Gv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:48:14 -0500
MIME-Version: 1.0
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-5-armbru@redhat.com>
In-Reply-To: <20190225183757.27378-5-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Feb 2019 13:48:00 +0100
Message-ID: <CAJ+F1CK9ffC6mQRStNdeY0vjcQdLWu4-yZyTUm0rdqEMggN+yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] sysbus: Fix latent bug with
 onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Mon, Feb 25, 2019 at 7:40 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> The first call of sysbus_get_default() creates the main system bus and
> stores it in QOM as "/machine/unattached/sysbus".  This must not
> happen before main() creates "/machine", or else container_get() would
> "helpfully" create it as "container" object, and the real creation of
> "/machine" would later abort with "attempt to add duplicate property
> 'machine' to object (type 'container')".  Has been that way ever since
> we wired up busses in QOM (commit f968fc6892d, v1.2.0).
>
> I believe the bug is latent.  I got it to bite by trying to
> qdev_create() a sysbus device from a machine's .instance_init()
> method.
>
> The fix is obvious: store the main system bus in QOM right after
> creating "/machine".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

makes sense to me, but I might miss some subtleties..

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/core/sysbus.c | 3 ---
>  vl.c             | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 9f9edbcab9..307cf90a51 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -357,9 +357,6 @@ static void main_system_bus_create(void)
>      qbus_create_inplace(main_system_bus, system_bus_info.instance_size,
>                          TYPE_SYSTEM_BUS, NULL, "main-system-bus");
>      OBJECT(main_system_bus)->free =3D g_free;
> -    object_property_add_child(container_get(qdev_get_machine(),
> -                                            "/unattached"),
> -                              "sysbus", OBJECT(main_system_bus), NULL);
>  }
>
>  BusState *sysbus_get_default(void)
> diff --git a/vl.c b/vl.c
> index e3fdce410f..6ce3d2d448 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3990,6 +3990,10 @@ int main(int argc, char **argv, char **envp)
>      }
>      object_property_add_child(object_get_root(), "machine",
>                                OBJECT(current_machine), &error_abort);
> +    object_property_add_child(container_get(OBJECT(current_machine),
> +                                            "/unattached"),
> +                              "sysbus", OBJECT(sysbus_get_default()),
> +                              NULL);
>
>      if (machine_class->minimum_page_bits) {
>          if (!set_preferred_target_page_bits(machine_class->minimum_page_=
bits)) {
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
