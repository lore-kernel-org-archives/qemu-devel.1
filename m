Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkXM2-0000Tj-Rh
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkXLx-00077R-P3
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:18:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkXLx-00076p-Ig
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0D4D8790A
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 16:18:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180731150144.14022-1-marcandre.lureau@redhat.com>
	<e02bf50c-ec2a-c024-ebae-ffa33e7c41b2@redhat.com>
Date: Tue, 31 Jul 2018 18:18:23 +0200
In-Reply-To: <e02bf50c-ec2a-c024-ebae-ffa33e7c41b2@redhat.com> (Eric Blake's
	message of "Tue, 31 Jul 2018 11:03:02 -0500")
Message-ID: <878t5rs7jk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/31/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
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
>> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque);
>>    * applying any rate limiting if required.
>>    */
>>   static void
>> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict)
>>   {
>>       MonitorQAPIEventConf *evconf;
>>       MonitorQAPIEventState *evstate;
>> @@ -688,6 +688,48 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qd=
ict, Error **errp)
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
> Is it safe to call QSIMPLEQ_INIT() on an already-initialized but empty
> queue?

Yes.

    #define QSIMPLEQ_HEAD(name, type)                                      =
 \
    struct name {                                                          =
 \
        struct type *sqh_first;    /* first element */                     =
 \
        struct type **sqh_last;    /* addr of last next element */         =
 \
    }

    #define QSIMPLEQ_INIT(head) do {                                       =
 \
        (head)->sqh_first =3D NULL;                                        =
   \
        (head)->sqh_last =3D &(head)->sqh_first;                           =
   \
    } while (/*CONSTCOND*/0)


Removing the last member results in the same state as QSIMPLEQ_INIT():

    #define QSIMPLEQ_REMOVE_HEAD(head, field) do {                         =
 \
        if (((head)->sqh_first =3D (head)->sqh_first->field.sqe_next) =3D=
=3D NULL)\
            (head)->sqh_last =3D &(head)->sqh_first;                       =
   \
    } while (/*CONSTCOND*/0)

Calling QSIMPLEQ_INIT() again then is a no-op.

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
