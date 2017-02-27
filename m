Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciIzq-0003gS-87
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciIzn-000304-3I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:57:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciIzm-000300-QX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:57:35 -0500
References: <20170227104956.24729-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c039185-5531-83a6-179a-f2147ea7bdc2@redhat.com>
Date: Mon, 27 Feb 2017 11:57:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170227104956.24729-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user: delay vhost_user_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, den@openvz.org, dgilbert@redhat.com



On 27/02/2017 11:49, Marc-Andr=C3=A9 Lureau wrote:
> Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
> may trigger a disconnect events, calling vhost_user_stop() and clearing
> all the vhost_dev strutures holding data that vhost.c functions expect
> to remain valid. Delay the cleanup to keep the vhost_dev structure
> valid during the vhost.c functions.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v3:
>  - use aio_bh_schedule_oneshot(), as suggest by Paolo
> v2:
>  - fix reconnect race
>=20
> net/vhost-user.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++---=
----
>  1 file changed, 46 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 77b8110f8c..e7e63408a1 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -190,7 +190,35 @@ static gboolean net_vhost_user_watch(GIOChannel *c=
han, GIOCondition cond,
> =20
>      qemu_chr_fe_disconnect(&s->chr);
> =20
> -    return FALSE;
> +    return TRUE;
> +}
> +
> +static void net_vhost_user_event(void *opaque, int event);
> +
> +static void chr_closed_bh(void *opaque)
> +{
> +    const char *name =3D opaque;
> +    NetClientState *ncs[MAX_QUEUE_NUM];
> +    VhostUserState *s;
> +    Error *err =3D NULL;
> +    int queues;
> +
> +    queues =3D qemu_find_net_clients_except(name, ncs,
> +                                          NET_CLIENT_DRIVER_NIC,
> +                                          MAX_QUEUE_NUM);
> +    assert(queues < MAX_QUEUE_NUM);
> +
> +    s =3D DO_UPCAST(VhostUserState, nc, ncs[0]);
> +
> +    qmp_set_link(name, false, &err);
> +    vhost_user_stop(queues, ncs);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event=
,
> +                             opaque, NULL, true);
> +
> +    if (err) {
> +        error_report_err(err);
> +    }
>  }
> =20
>  static void net_vhost_user_event(void *opaque, int event)
> @@ -212,20 +240,31 @@ static void net_vhost_user_event(void *opaque, in=
t event)
>      trace_vhost_user_event(chr->label, event);
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> -                                         net_vhost_user_watch, s);
>          if (vhost_user_start(queues, ncs, &s->chr) < 0) {
>              qemu_chr_fe_disconnect(&s->chr);
>              return;
>          }
> +        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> +                                         net_vhost_user_watch, s);
>          qmp_set_link(name, true, &err);
>          s->started =3D true;
>          break;
>      case CHR_EVENT_CLOSED:
> -        qmp_set_link(name, false, &err);
> -        vhost_user_stop(queues, ncs);
> -        g_source_remove(s->watch);
> -        s->watch =3D 0;
> +        /* a close event may happen during a read/write, but vhost
> +         * code assumes the vhost_dev remains setup, so delay the
> +         * stop & clear to idle.
> +         * FIXME: better handle failure in vhost code, remove bh
> +         */
> +        if (s->watch) {
> +            AioContext *ctx =3D qemu_get_current_aio_context();
> +
> +            g_source_remove(s->watch);
> +            s->watch =3D 0;

Removing the watch here makes sense too!  Thanks,

Paolo
> +            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
> +                                     NULL, NULL, false);
> +
> +            aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> +        }
>          break;
>      }
> =20
>=20
