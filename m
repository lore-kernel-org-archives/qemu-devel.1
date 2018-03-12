Received: from eggs.gnu.org ([2001:4830:134:3::10]:35536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQBw-0004XT-58
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQBu-0007Z8-VK
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:20:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evQBu-0007YO-Kl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:20:50 -0400
Received: by mail-wm0-x244.google.com with SMTP id q83so17836384wme.5
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:20:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-26-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-26-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 17:20:48 +0100
Message-ID: <CAJ+F1CKPR7JHasx_bU2Q8iGzZNBmEZEMb=8nKb3E54__iy_0Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 25/29] vhost+postcopy: Wire up
 POSTCOPY_END notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Wire up a call to VHOST_USER_POSTCOPY_END message to the vhost clients
> right before we ask the listener thread to shutdown.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/trace-events   |  2 ++
>  hw/virtio/vhost-user.c   | 34 ++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.c |  7 +++++++
>  migration/postcopy-ram.h |  1 +
>  4 files changed, 44 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index fe5e0ff856..857c495e65 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -7,6 +7,8 @@ vhost_region_add_section_abut(const char *name, uint64_t =
new_size) "%s: 0x%"PRIx
>  vhost_section(const char *name, int r) "%s:%d"
>
>  # hw/virtio/vhost-user.c
> +vhost_user_postcopy_end_entry(void) ""
> +vhost_user_postcopy_end_exit(void) ""
>  vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_addre=
ss, int nregions) "%s: @0x%"PRIx64" nregions:%d"
>  vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint=
64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
>  vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, u=
int64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 45de6d8a53..eb7d753b1a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1114,6 +1114,37 @@ static int vhost_user_postcopy_listen(struct vhost=
_dev *dev, Error **errp)
>      return 0;
>  }
>
> +/*
> + * Called at the end of postcopy
> + */
> +static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
> +{
> +    VhostUserMsg msg =3D {
> +        .hdr.request =3D VHOST_USER_POSTCOPY_END,
> +        .hdr.flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +    };
> +    int ret;
> +    struct vhost_user *u =3D dev->opaque;
> +
> +    trace_vhost_user_postcopy_end_entry();
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        error_setg(errp, "Failed to send postcopy_end to vhost");
> +        return -1;
> +    }
> +
> +    ret =3D process_message_reply(dev, &msg);
> +    if (ret) {
> +        error_setg(errp, "Failed to receive reply to postcopy_end");
> +        return ret;
> +    }
> +    postcopy_unregister_shared_ufd(&u->postcopy_fd);
> +    u->postcopy_fd.handler =3D NULL;
> +
> +    trace_vhost_user_postcopy_end_exit();
> +
> +    return 0;
> +}
> +
>  static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>                                          void *opaque)
>  {
> @@ -1139,6 +1170,9 @@ static int vhost_user_postcopy_notifier(NotifierWit=
hReturn *notifier,
>      case POSTCOPY_NOTIFY_INBOUND_LISTEN:
>          return vhost_user_postcopy_listen(dev, pnd->errp);
>
> +    case POSTCOPY_NOTIFY_INBOUND_END:
> +        return vhost_user_postcopy_end(dev, pnd->errp);
> +
>      default:
>          /* We ignore notifications we don't know */
>          break;
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 36db900e8f..1379923cfc 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -413,6 +413,13 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingS=
tate *mis)
>      trace_postcopy_ram_incoming_cleanup_entry();
>
>      if (mis->have_fault_thread) {
> +        Error *local_err =3D NULL;
> +
> +        if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +
>          if (qemu_ram_foreach_block(cleanup_range, mis)) {
>              return -1;
>          }
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index fef7448e4b..1d11276c94 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -132,6 +132,7 @@ enum PostcopyNotifyReason {
>      POSTCOPY_NOTIFY_PROBE =3D 0,
>      POSTCOPY_NOTIFY_INBOUND_ADVISE,
>      POSTCOPY_NOTIFY_INBOUND_LISTEN,
> +    POSTCOPY_NOTIFY_INBOUND_END,
>  };
>
>  struct PostcopyNotifyData {
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
