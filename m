Received: from eggs.gnu.org ([2001:4830:134:3::10]:51109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkVtt-0004zb-Hf
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkVts-0006Be-03
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:45:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fkVtr-0006A7-Is
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:45:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id b15-v6so16951842wrv.10
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 07:45:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pnz3sx5s.fsf@dusky.pond.sub.org>
References: <20180730125746.22794-1-marcandre.lureau@redhat.com>
	<87pnz3sx5s.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jul 2018 16:45:21 +0200
Message-ID: <CAJ+F1C+gUCnruzi4vx=9p09-E_dgbDTkrvrUQrTnF2CG3ukXWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Tue, Jul 31, 2018 at 9:05 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> With a Spice port chardev, it is possible to reenter
>> monitor_qapi_event_queue() (when the client disconnects for
>> example). This will dead-lock on monitor_lock.
>>
>> Instead, use some TLS variables to check for recursion and queue the
>> events.
> [...]
>>
>> Note that error report is now moved to the first caller, which may
>> receive an error for a recursed event. This is probably fine (95% of
>> callers use &error_abort, the rest have NULL error and ignore it)
>
> I'm not 100% sure I understand this paragraph, but it might be moot; see
> [*] below.
>
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  monitor.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index d8d8211ae4..d580c5a79c 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque)=
;
>>   * applying any rate limiting if required.
>>   */
>>  static void
>> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict, Erro=
r **errp)
>>  {
>>      MonitorQAPIEventConf *evconf;
>>      MonitorQAPIEventState *evstate;
>> @@ -688,6 +688,55 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qd=
ict, Error **errp)
>>      qemu_mutex_unlock(&monitor_lock);
>>  }
>>
>> +static void
>> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    /*
>> +     * If the function recurse, monitor_lock will dead-lock.
>> +     * Instead, queue pending events in TLS.
>
> recurses
>
> The claim is correct before the patch.  But the comment needs to explain
> current code.  Perhaps:
>
>         * monitor_qapi_event_queue_no_recurse() is not reentrant: it
>         * would deadlock on monitor_lock.  Work around by queueing
>         * events in thread-local storage.

ok

>
>> +     * TODO: remove this, make it re-enter safe.
>> +     */
>> +    static __thread bool recurse;
>> +    typedef struct MonitorQapiEvent {
>> +        QAPIEvent event;
>> +        QDict *qdict;
>> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
>> +    } MonitorQapiEvent;
>> +    MonitorQapiEvent *ev;
>> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
>
> Let's put the static variables first.

ok

>> +
>> +    if (!recurse) {
>> +        QSIMPLEQ_INIT(&event_queue);
>> +    }
>> +
>> +    ev =3D g_new(MonitorQapiEvent, 1);
>> +    ev->qdict =3D qobject_ref(qdict);
>> +    ev->event =3D event;
>> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
>> +    if (recurse) {
>> +        return;
>> +    }
>> +
>> +    recurse =3D true;
>> +
>> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
>> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
>
> Could we use QSIMPLEQ_FOREACH_SAFE()?

I don't think so, the next variable could be NULL, while a recursive
call could be adding an element.

>
>> +        if (!local_err) {
>> +            monitor_qapi_event_queue_no_recurse(ev->event, ev->qdict,
>> +                                                &local_err);
>> +        }
>
> [*] This looks scary: we silently throw away events after event queuing
> fails.
>
> Fortunately, monitor_qapi_event_queue_no_recurse() cannot fail.  It
> takes an Error ** parameter only so you can put it into @qmp_emit.
>

right

> Aside: I wish we'd get rid of the indirection through @qmp_emit.
>

for later: You would hard code a function name instead?

> Let's pass &error_abort and drop @local_err.

actually, we can just ignore errp, right?

for later: What about dropping error from the emit function?

>
>> +        qobject_unref(ev->qdict);
>> +        g_free(ev);
>> +    }
>> +
>> +    recurse =3D false;
>
> Aha: @recurse means we've reentered the function.
>
> "Recurse" is imperative mood.  Misleading, as it's not an order to
> recurse.
>
> Rename to @recursed?  @reentered?
>

ok, let's rename it "reentered"

>> +
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +    }
>> +}
>> +
>>  /*
>>   * This function runs evconf->rate ns after sending a throttled
>>   * event.
>
> monitor_lock clearly needs a rethink.  Your TODO comment suggests you
> agree.  But that's something for 3.1.
>
> I hate messing with locks at -rc3, but I also hate shipping known
> deadlocks.  Your patch isn't pretty, but probably as simple as we can
> make it for 3.0.  A few more review eyeballs would be nice.
>

thanks, I'll send v2

--=20
Marc-Andr=C3=A9 Lureau
