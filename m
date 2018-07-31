Received: from eggs.gnu.org ([2001:4830:134:3::10]:43398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkX7O-0001sn-I0
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkX7K-0000Wu-LI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:03:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkX7K-0000JG-G0
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:03:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2D257C6CA
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 16:03:04 +0000 (UTC)
References: <20180731150144.14022-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e02bf50c-ec2a-c024-ebae-ffa33e7c41b2@redhat.com>
Date: Tue, 31 Jul 2018 11:03:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180731150144.14022-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] monitor: temporary fix for dead-lock on
 event recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 07/31/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> With a Spice port chardev, it is possible to reenter
> monitor_qapi_event_queue() (when the client disconnects for
> example). This will dead-lock on monitor_lock.
>=20
> Instead, use some TLS variables to check for recursion and queue the
> events.
>=20

>=20
> diff --git a/monitor.c b/monitor.c
> index d8d8211ae4..4d9c1873bc 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque=
);
>    * applying any rate limiting if required.
>    */
>   static void
> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict)
>   {
>       MonitorQAPIEventConf *evconf;
>       MonitorQAPIEventState *evstate;
> @@ -688,6 +688,48 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *q=
dict, Error **errp)
>       qemu_mutex_unlock(&monitor_lock);
>   }
>  =20
> +static void
> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
> +{
> +    /*
> +     * monitor_qapi_event_queue_no_recurse() is not reentrant: it
> +     * would deadlock on monitor_lock.  Work around by queueing
> +     * events in thread-local storage.
> +     * TODO: remove this, make it re-enter safe.
> +     */
> +    static __thread bool reentered;
> +    typedef struct MonitorQapiEvent {
> +        QAPIEvent event;
> +        QDict *qdict;
> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> +    } MonitorQapiEvent;
> +    MonitorQapiEvent *ev;
> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
> +
> +    if (!reentered) {
> +        QSIMPLEQ_INIT(&event_queue);
> +    }

Is it safe to call QSIMPLEQ_INIT() on an already-initialized but empty=20
queue?

> +
> +    ev =3D g_new(MonitorQapiEvent, 1);
> +    ev->qdict =3D qobject_ref(qdict);
> +    ev->event =3D event;
> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> +    if (reentered) {
> +        return;
> +    }
> +
> +    reentered =3D true;
> +
> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
> +        monitor_qapi_event_queue_no_recurse(ev->event, ev->qdict);
> +        qobject_unref(ev->qdict);
> +        g_free(ev);
> +    }
> +
> +    reentered =3D false;
> +}
> +
>   /*
>    * This function runs evconf->rate ns after sending a throttled
>    * event.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
