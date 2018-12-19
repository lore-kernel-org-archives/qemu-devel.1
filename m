Received: from eggs.gnu.org ([2001:4830:134:3::10]:59544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZXOo-0004LA-Ev
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZXOh-0004MZ-Jo
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:40:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZXOh-0004Ip-AA
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:40:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-14-armbru@redhat.com>
	<CAJ+F1CLnugfZKFaQTjK3oAPJ3PmsxvBwhDtD8mH-D1FnUqKKgg@mail.gmail.com>
Date: Wed, 19 Dec 2018 09:40:03 +0100
In-Reply-To: <CAJ+F1CLnugfZKFaQTjK3oAPJ3PmsxvBwhDtD8mH-D1FnUqKKgg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 18 Dec 2018
	23:37:04 +0400")
Message-ID: <87r2ednc4c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] Revert "qapi-events: add 'if'
 condition to implicit event enum"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Dec 18, 2018 at 10:27 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>
>> This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.
>>
>> The commit applied the events' conditions to the members of enum
>> QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
>> target-independent code as soon as we make an event target-dependent.
>> Reverting this has the following effects:
>>
>> * ui/vnc.c can remain target independent.
>
> Was it ever moved? I don't recall

It's currently target-independent, and we want it to remain that way.

You keep it that way by splitting target-dependent target_QAPIEvent off
QAPIEvent.

I keep it that way by not making any enum members target-dependent.

>> * monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.
>
> I suggested a way to get rid of monitor_qapi_event_conf[] in the patch
> message, by having the rate stored in the schema, which could actually
> be useful (for doc, introspection etc).

Introspection and generated documentation improvements might still make
that worthwhile.  For the former, we'd first want an actual user,
though.

>> * query-events again doesn't reflect conditionals.  I'm going to
>>   deprecate it in favor of query-qmp-schema.
>
> I guess that's not that important.

query-qmp-schema has reflected conditionals since we introduced them in
v3.0.  query-events has not.  Your commit fixes it for 4.0.  Fixes are
good, but when an interface is known to be deficient in some versions,
while a strictly more powerful buddy is fine in all versions, the
obvious thing to do is to stay away from the deficient one regardless of
version.

I think we should deprecate query-events even if we decide to fix it
now.

I'll work this into the next commit's commit message.

> I have a slight preference for not declaring enums when the related
> option is disabled.

Me too, but I like keeping things simple even more.

Possibly even simpler: dispense with the enumeration type, add suitable
#define to each qapi-event-MODULE.h.  We can have #ifdef there.  What do
you think?

> But people don't like having too much #ifdef code, which is understandabl=
e.

In this case, it's just one big #if in monitor.c.  Tolerable, I think.

If we replace QAPIEvent by #define, the #if shrinks to just #ifdef
QAPI_EVENT_RTC_CHANGE.

Note that monitor.c is already target-dependent.  It should really be
split up, though.  The #if would keep the QMP part target-dependent,
unless we split it up even more.  Hmm.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> # Conflicts:
>> #       scripts/qapi/events.py
>> ---
>>  scripts/qapi/events.py | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index e988e43941..c944ba90b8 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -194,7 +194,9 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdi=
ct);
>>              self._genc.add(gen_event_send(name, arg_type, boxed,
>>                                            self._event_enum_name,
>>                                            self._event_emit_name))
>> -        self._event_enum_members.append(QAPISchemaMember(name, ifcond))
>> +        # Note: we generate the enum member regardless of @ifcond, to
>> +        # keep the enumeration usable in target-independent code.
>> +        self._event_enum_members.append(QAPISchemaMember(name))
>>
>>
>>  def gen_events(schema, output_dir, prefix):
>> --
>> 2.17.2
>>
>>
