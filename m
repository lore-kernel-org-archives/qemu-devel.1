Received: from eggs.gnu.org ([208.118.235.92]:59516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTkFE-00073c-2E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTk4S-00023S-Az
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTk4S-00022b-3j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 269ED3DE2C
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 08:59:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-6-marcandre.lureau@redhat.com>
Date: Mon, 03 Dec 2018 09:59:08 +0100
In-Reply-To: <20181029125733.14597-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Oct 2018 16:57:32 +0400")
Message-ID: <87mupn6l5v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a monitor_destroyed global to check if monitor_cleanup() has been
> already called. In this case, don't insert the new monitor in the
> list, but free it instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The commit message explains what the patch does, but not why we want to
do it.

> ---
>  monitor.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index fffeb27ef9..7fe89daa87 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -263,10 +263,11 @@ typedef struct QMPRequest QMPRequest;
>  /* QMP checker flags */
>  #define QMP_ACCEPT_UNKNOWNS 1
>=20=20
> -/* Protects mon_list, monitor_qapi_event_state.  */
> +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
>  static QemuMutex monitor_lock;
>  static GHashTable *monitor_qapi_event_state;
>  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
> +static bool monitor_destroyed;
>=20=20
>  /* Protects mon_fdsets */
>  static QemuMutex mon_fdsets_lock;
> @@ -4536,8 +4537,16 @@ void error_vprintf_unless_qmp(const char *fmt, va_=
list ap)
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
>=20=20
>  static void monitor_qmp_setup_handlers_bh(void *opaque)
> @@ -4631,6 +4640,7 @@ void monitor_cleanup(void)
>=20=20
>      /* Flush output buffers and destroy monitors */
>      qemu_mutex_lock(&monitor_lock);
> +    monitor_destroyed =3D true;
>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
>          QTAILQ_REMOVE(&mon_list, mon, entry);
>          monitor_flush(mon);

monitor_cleanup() is one of the last things main() calls before it
returns.  If another thread creates a monitor afterwards, it won't be
cleaned up.  I figure that's the reason we want this patch.  There might
be more serious issues than failure to clean up.  Please explain in your
commit message.

monitor_list_append() is called by monitor_init(), either directly right
before it returns, or via a bottom half if mon->use_io_thread.
Therefore, @monitor_destroyed can only be true if monitor_init()
commonly runs in a thread other than the main thread.  Please give an
example where it does, in your commit message.
