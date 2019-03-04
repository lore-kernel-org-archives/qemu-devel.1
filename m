Received: from eggs.gnu.org ([209.51.188.92]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0sfb-0002LR-1e
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0sfV-00082I-Lj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:50:33 -0500
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-5-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9218d2e9-5519-055b-dfb9-e78f99559b80@redhat.com>
Date: Mon, 4 Mar 2019 19:45:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190225183757.27378-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 25/02/2019 19.37, Markus Armbruster wrote:
> The first call of sysbus_get_default() creates the main system bus and
> stores it in QOM as "/machine/unattached/sysbus".  This must not
> happen before main() creates "/machine", or else container_get() would
> "helpfully" create it as "container" object, and the real creation of
> "/machine" would later abort with "attempt to add duplicate property
> 'machine' to object (type 'container')".  Has been that way ever since
> we wired up busses in QOM (commit f968fc6892d, v1.2.0).
>=20
> I believe the bug is latent.  I got it to bite by trying to
> qdev_create() a sysbus device from a machine's .instance_init()
> method.
>=20
> The fix is obvious: store the main system bus in QOM right after
> creating "/machine".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/sysbus.c | 3 ---
>  vl.c             | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 9f9edbcab9..307cf90a51 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -357,9 +357,6 @@ static void main_system_bus_create(void)
>      qbus_create_inplace(main_system_bus, system_bus_info.instance_size=
,
>                          TYPE_SYSTEM_BUS, NULL, "main-system-bus");
>      OBJECT(main_system_bus)->free =3D g_free;
> -    object_property_add_child(container_get(qdev_get_machine(),
> -                                            "/unattached"),
> -                              "sysbus", OBJECT(main_system_bus), NULL)=
;
>  }
> =20
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
> =20
>      if (machine_class->minimum_page_bits) {
>          if (!set_preferred_target_page_bits(machine_class->minimum_pag=
e_bits)) {
>=20

Looks right. Especially, a device should also not add itself to a
parent, so this definitely should not be done in sysbus.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


PS: Not directly related to your patch, but in a separate patch we
should also object_unref(current_machine) here to drop the superfluous
second reference to current_machine after we added it as a child of the
root object.
