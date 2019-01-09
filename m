Received: from eggs.gnu.org ([209.51.188.92]:37818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1ghHug-0006Kc-EE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1ghHue-0003EM-7f
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjongsma@redhat.com>) id 1ghHud-0003CW-Vd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:45:08 -0500
Message-ID: <98b89b44cdba6e7128381a5216ec955771c4caaa.camel@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
Date: Wed, 09 Jan 2019 11:36:22 -0600
In-Reply-To: <20190108152648.32537-2-lhrazky@redhat.com>
References: <20190108152648.32537-1-lhrazky@redhat.com>
	<20190108152648.32537-2-lhrazky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH spice 1/3] QXL interface: add
 a function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Tue, 2019-01-08 at 16:26 +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD wrote=
:
> Adds a function to let QEMU provide information to identify graphics
> devices and their monitors in the guest. The function
> (spice_qxl_set_device_info) sets the device address (e.g. a PCI path)
> and monitor ID -> device display ID mapping of displays exposed by
> given
> QXL interface.


In my previous review, I asked for a slightly more explicit explanation
of the phrase "monitor ID" in the commit log. In this case, "monitor
ID" is an ID specific to the QXL instance starting at 0 and represents
the displays that are associated with that particular QXL instance.

Perhaps it makes sense to rename this "Qxl monitor ID"?

>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
> ---
>  server/red-qxl.c         | 44 ++++++++++++++++++++++++++++++++++++++
>  server/spice-qxl.h       | 46
> ++++++++++++++++++++++++++++++++++++++++
>  server/spice-server.syms |  5 +++++
>  3 files changed, 95 insertions(+)
>=20
> diff --git a/server/red-qxl.c b/server/red-qxl.c
> index 97940611..0ea424cd 100644
> --- a/server/red-qxl.c
> +++ b/server/red-qxl.c
> @@ -41,6 +41,9 @@
>  #include "red-qxl.h"
> =20
> =20
> +#define MAX_DEVICE_ADDRESS_LEN 256
> +#define MAX_MONITORS_COUNT 16
> +
>  struct QXLState {
>      QXLWorker qxl_worker;
>      QXLInstance *qxl;
> @@ -53,6 +56,9 @@ struct QXLState {
>      unsigned int max_monitors;
>      RedsState *reds;
>      RedWorker *worker;
> +    char device_address[MAX_DEVICE_ADDRESS_LEN];
> +    uint32_t device_display_ids[MAX_MONITORS_COUNT];
> +    size_t monitors_count;  // length of ^^^
> =20
>      pthread_mutex_t scanout_mutex;
>      SpiceMsgDisplayGlScanoutUnix scanout;
> @@ -846,6 +852,44 @@ void red_qxl_gl_draw_async_complete(QXLInstance
> *qxl)
>      red_qxl_async_complete(qxl, cookie);
>  }
> =20
> +SPICE_GNUC_VISIBLE
> +void spice_qxl_set_device_info(QXLInstance *instance,
> +                               const char *device_address,
> +                               uint32_t device_display_id_start,
> +                               uint32_t device_display_id_count)
> +{
> +    g_return_if_fail(device_address !=3D NULL);

Just a thought: what if qemu calls this function twice for the same
instance. In theory this shouldn't happen, but should we be defensive
and handle it somehow? Print a warning? Just overwrite the previous
mapping? Right now it looks like we would just overwrite.

> +
> +    size_t da_len =3D strnlen(device_address, MAX_DEVICE_ADDRESS_LEN);
> +    if (da_len >=3D MAX_DEVICE_ADDRESS_LEN) {
> +        spice_error("Device address too long: %lu > %u", da_len,
> MAX_DEVICE_ADDRESS_LEN);

Technically, I think the format string for a size_t variable is %zu,
not %lu

> +        return;
> +    }
> +
> +    if (device_display_id_count > MAX_MONITORS_COUNT) {
> +        spice_error("Device display ID count (%u) is greater than
> limit %u",
> +                    device_display_id_count,
> +                    MAX_MONITORS_COUNT);
> +        return;
> +    }
> +
> +    strncpy(instance->st->device_address, device_address,
> MAX_DEVICE_ADDRESS_LEN);
> +
> +    g_debug("QXL Instance %d setting device address \"%s\" and
> monitor -> device display mapping:",
> +            instance->id,
> +            device_address);
> +
> +    // store the mapping monitor_id -> device_display_id
> +    for (uint32_t monitor_id =3D 0; monitor_id <
> device_display_id_count; ++monitor_id) {
> +        uint32_t device_display_id =3D device_display_id_start +
> monitor_id;
> +        instance->st->device_display_ids[monitor_id] =3D
> device_display_id;
> +        g_debug("   monitor ID %u -> device display ID %u",
> +                monitor_id, device_display_id);
> +    }
> +
> +    instance->st->monitors_count =3D device_display_id_count;
> +}
> +
>  void red_qxl_init(RedsState *reds, QXLInstance *qxl)
>  {
>      QXLState *qxl_state;
> diff --git a/server/spice-qxl.h b/server/spice-qxl.h
> index 0c4e75fc..547d3d93 100644
> --- a/server/spice-qxl.h
> +++ b/server/spice-qxl.h
> @@ -115,6 +115,52 @@ void spice_qxl_gl_draw_async(QXLInstance
> *instance,
>                               uint32_t w, uint32_t h,
>                               uint64_t cookie);
> =20
> +/* since spice 0.14.2 */
> +
> +/**
> + * spice_qxl_set_device_info:
> + * @instance the QXL instance to set the path to
> + * @device_address the path of the device this QXL instance belongs
> to
> + * @device_display_id_start the starting device display ID of this
> interface,
> + *                          i.e. the one monitor ID 0 maps to

perhaps reword this last line:
i.e. the device display ID of monitor ID 0

> + * @device_display_id_count the total number of device display IDs
> on this
> + *                          interface
> + *
> + * Sets the device information for this QXL interface, i.e. the
> hardware
> + * address (e.g. PCI) of the graphics device and the IDs of the
> displays of the
> + * graphics device that are exposed by this interface (device
> display IDs).
> + *
> + * The supported device address format is:
> + * "pci/<DOMAIN>/<SLOT>.<FUNCTION>/.../<SLOT>.<FUNCTION>"
> + *
> + * The "pci" identifies the rest of the string as a PCI address. It
> is the only
> + * supported address at the moment, other identifiers can be
> introduced later.
> + * <DOMAIN> is the PCI domain, followed by <SLOT>.<FUNCTION> of any
> PCI bridges
> + * in the chain leading to the device. The last <SLOT>.<FUNCTION> is
> the
> + * graphics device. All of <DOMAIN>, <SLOT>, <FUNCTION> are
> hexadecimal numbers
> + * with the following number of digits:
> + *   <DOMAIN>: 4
> + *   <SLOT>: 2
> + *   <FUNCTION>: 1
> + *
> + * The device_display_id_{start,count} denotes the sequence of
> device display
> + * IDs that map to the zero-based sequence of monitor IDs provided
> by monitors
> + * config on this interface. For example with
> device_display_id_start =3D 2 and
> + * device_display_id_count =3D 3 you get the following mapping:
> + * monitor_id  ->  device_display_id
> + *          0  ->  2
> + *          1  ->  3
> + *          2  ->  4
> + *
> + * Note this example is unsupported in practice. The only supported
> cases are
> + * either a single device display ID (count =3D 1) or multiple device
> display IDs
> + * in a sequence starting from 0.
> + */

Gerd previously objected to using an example of an unsupported
scenario. But it doesn't seem that you changed anything here. I don't
care too much, myself.

> +void spice_qxl_set_device_info(QXLInstance *instance,
> +                               const char *device_address,
> +                               uint32_t device_display_id_start,
> +                               uint32_t device_display_id_count);
> +
>  typedef struct QXLDevInitInfo {
>      uint32_t num_memslots_groups;
>      uint32_t num_memslots;
> diff --git a/server/spice-server.syms b/server/spice-server.syms
> index edf04a42..ac4d9b14 100644
> --- a/server/spice-server.syms
> +++ b/server/spice-server.syms
> @@ -173,3 +173,8 @@ SPICE_SERVER_0.13.2 {
>  global:
>      spice_server_set_video_codecs;
>  } SPICE_SERVER_0.13.1;
> +
> +SPICE_SERVER_0.14.2 {
> +global:
> +    spice_qxl_set_device_info;
> +} SPICE_SERVER_0.13.2;
