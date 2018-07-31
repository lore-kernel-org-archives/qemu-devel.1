Received: from eggs.gnu.org ([2001:4830:134:3::10]:47764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkXK4-00087O-5w
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkXK3-0006a3-6o
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:16:32 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fkXK2-0006Zm-Tt
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:16:31 -0400
Received: by mail-wm0-x244.google.com with SMTP id n11-v6so3789957wmc.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:16:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e02bf50c-ec2a-c024-ebae-ffa33e7c41b2@redhat.com>
References: <20180731150144.14022-1-marcandre.lureau@redhat.com>
	<e02bf50c-ec2a-c024-ebae-ffa33e7c41b2@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jul 2018 18:16:29 +0200
Message-ID: <CAJ+F1CJ0eyQk0xwh_QzSYdCsyba++OKEB7qpsEb6xP7mK3xf6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Tue, Jul 31, 2018 at 6:03 PM, Eric Blake <eblake@redhat.com> wrote:
> On 07/31/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> With a Spice port chardev, it is possible to reenter
>> monitor_qapi_event_queue() (when the client disconnects for
>> example). This will dead-lock on monitor_lock.
>>
>> Instead, use some TLS variables to check for recursion and queue the
>> events.
>>
>
>>
>> diff --git a/monitor.c b/monitor.c
>> index d8d8211ae4..4d9c1873bc 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque)=
;
>>    * applying any rate limiting if required.
>>    */
>>   static void
>> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict)
>>   {
>>       MonitorQAPIEventConf *evconf;
>>       MonitorQAPIEventState *evstate;
>> @@ -688,6 +688,48 @@ monitor_qapi_event_queue(QAPIEvent event, QDict
>> *qdict, Error **errp)
>>       qemu_mutex_unlock(&monitor_lock);
>>   }
>>   +static void
>> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +{
>> +    /*
>> +     * monitor_qapi_event_queue_no_recurse() is not reentrant: it
>> +     * would deadlock on monitor_lock.  Work around by queueing
>> +     * events in thread-local storage.
>> +     * TODO: remove this, make it re-enter safe.
>> +     */
>> +    static __thread bool reentered;
>> +    typedef struct MonitorQapiEvent {
>> +        QAPIEvent event;
>> +        QDict *qdict;
>> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
>> +    } MonitorQapiEvent;
>> +    MonitorQapiEvent *ev;
>> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
>> +
>> +    if (!reentered) {
>> +        QSIMPLEQ_INIT(&event_queue);
>> +    }
>
>
> Is it safe to call QSIMPLEQ_INIT() on an already-initialized but empty
> queue?

#define QSIMPLEQ_INIT(head) do {                                        \
    (head)->sqh_first =3D NULL;                                           \
    (head)->sqh_last =3D &(head)->sqh_first;                              \
} while (/*CONSTCOND*/0)


It looks safe to me. There is no allocation in QSIMPLEQ macros, and
some of them do call QSIMPLEQ_INIT on a number of operations on
already initialized queues.

Note that I would rather use QSIMPLEQ_HEAD_INITIALIZER, but there is an err=
or:


/home/elmarco/src/qemu/monitor.c: In function =E2=80=98monitor_qapi_event_q=
ueue=E2=80=99:
/home/elmarco/src/qemu/include/qemu/queue.h:247:13: error: initializer
element is not constant
     { NULL, &(head).sqh_first }

Tbh, I don't really understand the problem! :)

>
>
>> +
>> +    ev =3D g_new(MonitorQapiEvent, 1);
>> +    ev->qdict =3D qobject_ref(qdict);
>> +    ev->event =3D event;
>> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
>> +    if (reentered) {
>> +        return;
>> +    }
>> +
>> +    reentered =3D true;
>> +
>> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
>> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
>> +        monitor_qapi_event_queue_no_recurse(ev->event, ev->qdict);
>> +        qobject_unref(ev->qdict);
>> +        g_free(ev);
>> +    }
>> +
>> +    reentered =3D false;
>> +}
>> +
>>   /*
>>    * This function runs evconf->rate ns after sending a throttled
>>    * event.
>>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>



--=20
Marc-Andr=C3=A9 Lureau
