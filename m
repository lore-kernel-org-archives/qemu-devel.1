Received: from eggs.gnu.org ([2001:4830:134:3::10]:53624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHMnm-0000G8-Pe
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHMnj-000594-GX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gHMnj-00058m-AV
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:42:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C64308FB90
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:42:50 +0000 (UTC)
Date: Tue, 30 Oct 2018 13:42:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181030054242.GE22523@xz-x1>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029125733.14597-6-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] monitor: prevent inserting new
 monitors after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 29, 2018 at 04:57:32PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Add a monitor_destroyed global to check if monitor_cleanup() has been
> already called. In this case, don't insert the new monitor in the
> list, but free it instead.

Pure question: how to trigger the condition when doing monitor
cleanups?

I can understand the problem to be fixed in the follow-up patch, but I
don't know whether it's that helpful to have this patch though,
especially considering that we're reaching softfreeze.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index fffeb27ef9..7fe89daa87 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -263,10 +263,11 @@ typedef struct QMPRequest QMPRequest;
>  /* QMP checker flags */
>  #define QMP_ACCEPT_UNKNOWNS 1
> =20
> -/* Protects mon_list, monitor_qapi_event_state.  */
> +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
>  static QemuMutex monitor_lock;
>  static GHashTable *monitor_qapi_event_state;
>  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
> +static bool monitor_destroyed;
> =20
>  /* Protects mon_fdsets */
>  static QemuMutex mon_fdsets_lock;
> @@ -4536,8 +4537,16 @@ void error_vprintf_unless_qmp(const char *fmt, v=
a_list ap)
>  static void monitor_list_append(Monitor *mon)
>  {
>      qemu_mutex_lock(&monitor_lock);
> -    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +    if (!monitor_destroyed) {
> +        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +        mon =3D NULL;
> +    }
>      qemu_mutex_unlock(&monitor_lock);
> +
> +    if (mon) {
> +        monitor_data_destroy(mon);
> +        g_free(mon);
> +    }
>  }
> =20
>  static void monitor_qmp_setup_handlers_bh(void *opaque)
> @@ -4631,6 +4640,7 @@ void monitor_cleanup(void)
> =20
>      /* Flush output buffers and destroy monitors */
>      qemu_mutex_lock(&monitor_lock);
> +    monitor_destroyed =3D true;
>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
>          QTAILQ_REMOVE(&mon_list, mon, entry);
>          monitor_flush(mon);
> --=20
> 2.19.0.271.gfe8321ec05
>=20

Regards,

--=20
Peter Xu
