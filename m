Received: from eggs.gnu.org ([2001:4830:134:3::10]:50511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkOiV-0004Of-3Q
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkOiR-0008WG-V2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:05:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkOiR-0008Vh-No
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DE9240216FE
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 07:05:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180730125746.22794-1-marcandre.lureau@redhat.com>
Date: Tue, 31 Jul 2018 09:05:03 +0200
In-Reply-To: <20180730125746.22794-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 30 Jul 2018 14:57:46 +0200")
Message-ID: <87pnz3sx5s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] monitor: temporary fix for dead-lock
 on event recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> With a Spice port chardev, it is possible to reenter
> monitor_qapi_event_queue() (when the client disconnects for
> example). This will dead-lock on monitor_lock.
>
> Instead, use some TLS variables to check for recursion and queue the
> events.
[...]
>
> Note that error report is now moved to the first caller, which may
> receive an error for a recursed event. This is probably fine (95% of
> callers use &error_abort, the rest have NULL error and ignore it)

I'm not 100% sure I understand this paragraph, but it might be moot; see
[*] below.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/monitor.c b/monitor.c
> index d8d8211ae4..d580c5a79c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque);
>   * applying any rate limiting if required.
>   */
>  static void
> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict, Error=
 **errp)
>  {
>      MonitorQAPIEventConf *evconf;
>      MonitorQAPIEventState *evstate;
> @@ -688,6 +688,55 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdi=
ct, Error **errp)
>      qemu_mutex_unlock(&monitor_lock);
>  }
>=20=20
> +static void
> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    /*
> +     * If the function recurse, monitor_lock will dead-lock.
> +     * Instead, queue pending events in TLS.

recurses

The claim is correct before the patch.  But the comment needs to explain
current code.  Perhaps:

        * monitor_qapi_event_queue_no_recurse() is not reentrant: it
        * would deadlock on monitor_lock.  Work around by queueing
        * events in thread-local storage.

> +     * TODO: remove this, make it re-enter safe.
> +     */
> +    static __thread bool recurse;
> +    typedef struct MonitorQapiEvent {
> +        QAPIEvent event;
> +        QDict *qdict;
> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> +    } MonitorQapiEvent;
> +    MonitorQapiEvent *ev;
> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;

Let's put the static variables first.

> +
> +    if (!recurse) {
> +        QSIMPLEQ_INIT(&event_queue);
> +    }
> +
> +    ev =3D g_new(MonitorQapiEvent, 1);
> +    ev->qdict =3D qobject_ref(qdict);
> +    ev->event =3D event;
> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> +    if (recurse) {
> +        return;
> +    }
> +
> +    recurse =3D true;
> +
> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);

Could we use QSIMPLEQ_FOREACH_SAFE()?

> +        if (!local_err) {
> +            monitor_qapi_event_queue_no_recurse(ev->event, ev->qdict,
> +                                                &local_err);
> +        }

[*] This looks scary: we silently throw away events after event queuing
fails.

Fortunately, monitor_qapi_event_queue_no_recurse() cannot fail.  It
takes an Error ** parameter only so you can put it into @qmp_emit.

Aside: I wish we'd get rid of the indirection through @qmp_emit.

Let's pass &error_abort and drop @local_err.

> +        qobject_unref(ev->qdict);
> +        g_free(ev);
> +    }
> +
> +    recurse =3D false;

Aha: @recurse means we've reentered the function.

"Recurse" is imperative mood.  Misleading, as it's not an order to
recurse.

Rename to @recursed?  @reentered?

> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +}
> +
>  /*
>   * This function runs evconf->rate ns after sending a throttled
>   * event.

monitor_lock clearly needs a rethink.  Your TODO comment suggests you
agree.  But that's something for 3.1.

I hate messing with locks at -rc3, but I also hate shipping known
deadlocks.  Your patch isn't pretty, but probably as simple as we can
make it for 3.0.  A few more review eyeballs would be nice.
