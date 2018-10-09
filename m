Received: from eggs.gnu.org ([2001:4830:134:3::10]:59258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1g9xlM-0000PW-Ch
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1g9xlJ-0005l2-0L
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjongsma@redhat.com>) id 1g9xlI-0005kV-Ne
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:33:44 -0400
Message-ID: <1539113618.12871.122.camel@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
Date: Tue, 09 Oct 2018 14:33:38 -0500
In-Reply-To: <20181009131052.18500-2-lhrazky@redhat.com>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On Tue, 2018-10-09 at 15:10 +0200, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD wrote=
:
> Adds two functions to let QEMU provide information to identify
> graphics
> devices and their monitors in the guest:
>=20
> * device path - The path identifying the device on the system (e.g.
> PCI
>   path):
>   spice_qxl_device_set_path(...)
>=20
> * device display ID - The index of the monitor on the graphics
> device:
>   spice_qxl_device_monitor_add_display_id(...)
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
> ---
>  server/red-qxl.c         | 67
> ++++++++++++++++++++++++++++++++++++++++
>  server/spice-qxl.h       |  3 ++
>  server/spice-server.syms |  6 ++++
>  3 files changed, 76 insertions(+)
>=20
> diff --git a/server/red-qxl.c b/server/red-qxl.c
> index 97940611..143228ca 100644
> --- a/server/red-qxl.c
> +++ b/server/red-qxl.c
> @@ -41,6 +41,9 @@
>  #include "red-qxl.h"
> =20
> =20
> +#define MAX_PATH_LEN 256
> +#define MAX_MONITORS_COUNT 16
> +
>  struct QXLState {
>      QXLWorker qxl_worker;
>      QXLInstance *qxl;
> @@ -53,6 +56,9 @@ struct QXLState {
>      unsigned int max_monitors;
>      RedsState *reds;
>      RedWorker *worker;
> +    char device_path[MAX_PATH_LEN];
> +    uint32_t device_display_ids[MAX_MONITORS_COUNT];
> +    size_t monitors_count;  // length of ^^^
> =20
>      pthread_mutex_t scanout_mutex;
>      SpiceMsgDisplayGlScanoutUnix scanout;
> @@ -846,6 +852,67 @@ void red_qxl_gl_draw_async_complete(QXLInstance
> *qxl)
>      red_qxl_async_complete(qxl, cookie);
>  }
> =20
> +/**
> + * spice_qxl_device_set_path:

It seems to me that _set_device_path() might be a better name than
_device_set_path(). And maybe _address is better than _path?=20

> + * @instance the QXL instance to set the path to
> + * @device_path the path of the device this QXL instance belongs to

It seems to me that if this is public API, the format of the
@device_path should be documented a bit better?

> + *
> + * Sets the hardware (e.g. PCI) path of the graphics device
> represented by this QXL interface instance.

So, this comment suggests that the caller might be able to provide a
path that is not a PCI path. But the implementation below (mostly the
debug output, I suppose...) assumes a PCI path. Do we need to support
non-PCI paths?

> + *
> + */
> +SPICE_GNUC_VISIBLE
> +void spice_qxl_device_set_path(QXLInstance *instance, const char
> *device_path)
> +{
> +    g_return_if_fail(device_path !=3D NULL);
> +
> +    size_t dp_len =3D strnlen(device_path, MAX_PATH_LEN);
> +    if (dp_len >=3D MAX_PATH_LEN) {
> +        spice_error("PCI device path too long: %lu > %u", dp_len,
> MAX_PATH_LEN);
> +        return;
> +    }
> +
> +    strncpy(instance->st->device_path, device_path, MAX_PATH_LEN);
> +
> +    g_debug("QXL Instance %d setting device PCI path \"%s\"",
> instance->id, device_path);
> +}
> +
> +/**
> + * spice_qxl_device_monitor_add_display_id:

I'm not sure that the word 'device' in this function adds much here. It
is essentially operating on the QxlInstance, which may represent a
single device, or may only represent part of a device (e.g. virtio-
gpu). So I think including 'device' in the name actually makes things
less clear. I'm also unclear why the word 'monitor' is here. As
written, it could be interpreted as refering to a "device monitor",
whatever that is. But it means that we have the word 'monitor' and
'display' within the same function name, which adds more confusion.=20

I would suggest a name like spice_qxl_add_device_display_id().

But part of me also doesn't like the verb 'add' here either. Because
we're not really adding anything by calling this function. The caller
is simply informing the spice server that this qxl instance provides
the specified display. So I might even consider a name like
spice_qxl_provides_device_display_id()... Or maybe
_register_display_id(). Maybe there are better options, though.

> + * @instance the QXL instance to add the display ID to
> + * @device_display_id the display ID to add to the QXL instance
> + *
> + * Adds a #device_display_id to this QXL interface instance. The
> + * #device_display_id is an index (a sequence starting from 0) into
> the list of
> + * all the displays on the graphics device. This function should be
> called in
> + * sequence for all possible displays of the device. The ID of the
> first call
> + * will belong to #monitor_id 0, and so forth in the sequence.
> + *
> + * Since for some graphics devices (e.g. virtio-gpu) a QXL interface
> instance
> + * is created per each display of a single device, you can get e.g.
> the single
> + * following call on the third QXL interface instance for this
> device:
> + *
> + * spice_qxl_device_monitor_add_display_id(instance, 2);
> + *
> + * This tells you that the single monitor of this QXL interface
> actually
> + * belongs to the 3rd display of the underlying device.
> + *
> + * Returns: The actual SPICE server monitor_id associated with the
> display

So, if I remember correctly, Gerd recommended returning this value from
the function. But I think it needs more explanation here. What exactly
is a "monitor_id" supposed to represent? It is not used in your follow-
up qemu patch so it's hard to tell.

> + */
> +SPICE_GNUC_VISIBLE
> +int spice_qxl_device_monitor_add_display_id(QXLInstance *instance,
> uint32_t device_display_id)
> +{
> +    if (instance->st->monitors_count >=3D MAX_MONITORS_COUNT) {
> +        spice_error("Cannot register more than %u monitors per QXL
> interface", MAX_MONITORS_COUNT);
> +        return -1;
> +    }
> +
> +    instance->st->device_display_ids[instance->st->monitors_count] =3D
> device_display_id;
> +
> +    g_debug("QXL Instance %d adding device display ID %u", instance-
> >id, device_display_id);
> +
> +    return instance->st->monitors_count++;
> +}

So, as far as I can tell, when you have e.g. a virtio-gpu device with
four monitors, you'll call this function 4 times, with the following
arguments:

spice_qxl_device_monitor_add_display_id(qxl1, 0);
spice_qxl_device_monitor_add_display_id(qxl2, 1);
spice_qxl_device_monitor_add_display_id(qxl3, 2);
spice_qxl_device_monitor_add_display_id(qxl4, 3);

And each of these calls would return a monitor_id of 0. Is that what
you expect? Or am I misreading this?

The other thing about this API, however, is that it seems pretty easy
to misuse. In general, I think that one of the marks of a good API is
that it's easy to use and difficult to misuse. At the moment, it seems
to require a lot of documentation explaining exactly how and when you
should call this function in order to get the right behavior.

If the caller (for whatever reason) executes the same call twice, what
happens?

spice_qxl_device_monitor_add_display_id(qxl, 0);
spice_qxl_device_monitor_add_display_id(qxl, 0);

Or if it calls them in the reverse order:

spice_qxl_device_monitor_add_display_id(qxl, 3);
spice_qxl_device_monitor_add_display_id(qxl, 2);
spice_qxl_device_monitor_add_display_id(qxl, 1);
spice_qxl_device_monitor_add_display_id(qxl, 0);

Granted, some of this could probably be solved by better internal error
handling and validation, but it makes me think that there may be a
better interface.

Maybe that better interface is something similar to the one suggested
by Gerd. Something like:

spice_qxl_register_display_ids(QxlInstance *qxl, uint32_t first_id,
uint32_t n_ids);

Or maybe not. I'm still thinking it over.

Jonathon


> +
>  void red_qxl_init(RedsState *reds, QXLInstance *qxl)
>  {
>      QXLState *qxl_state;
> diff --git a/server/spice-qxl.h b/server/spice-qxl.h
> index 0c4e75fc..ae2d5975 100644
> --- a/server/spice-qxl.h
> +++ b/server/spice-qxl.h
> @@ -114,6 +114,9 @@ void spice_qxl_gl_draw_async(QXLInstance
> *instance,
>                               uint32_t x, uint32_t y,
>                               uint32_t w, uint32_t h,
>                               uint64_t cookie);
> +/* since spice 0.14.2 */
> +void spice_qxl_device_set_path(QXLInstance *instance, const char
> *device_path);
> +int spice_qxl_device_monitor_add_display_id(QXLInstance *instance,
> uint32_t device_display_id);
> =20
>  typedef struct QXLDevInitInfo {
>      uint32_t num_memslots_groups;
> diff --git a/server/spice-server.syms b/server/spice-server.syms
> index edf04a42..fdeafd23 100644
> --- a/server/spice-server.syms
> +++ b/server/spice-server.syms
> @@ -173,3 +173,9 @@ SPICE_SERVER_0.13.2 {
>  global:
>      spice_server_set_video_codecs;
>  } SPICE_SERVER_0.13.1;
> +
> +SPICE_SERVER_0.14.2 {
> +global:
> +    spice_qxl_device_set_path;
> +    spice_qxl_device_monitor_add_display_id;
> +} SPICE_SERVER_0.13.2;
