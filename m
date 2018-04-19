Received: from eggs.gnu.org ([2001:4830:134:3::10]:58477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f99kM-0002nO-7H
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f99kK-00011r-VF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:37:10 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:46613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f99kK-000118-OV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:37:08 -0400
Received: by mail-wr0-x229.google.com with SMTP id d1-v6so14136556wrj.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:37:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8736zryb03.fsf@dusky.pond.sub.org>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-6-marcandre.lureau@redhat.com>
	<8736zryb03.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 15:37:06 +0200
Message-ID: <CAJ+F1C+dGBWRaZ5GjtkLTm9SAWK9FZ=MByVicJ9WFxfPQU_q3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/5] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Apr 19, 2018 at 8:18 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> While it may be convenient to accept NULL value in
>> qobject_unref() (for similar reasons as free() accepts NULL), it is
>> not such a good idea for qobject_ref(), assert() on NULL. One place
>> relied on that behaviour (the monitor request id), and it's best to be
>> explicit that NULL is accepted there.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qapi/qmp/qobject.h | 7 ++++---
>>  monitor.c                  | 2 +-
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index befc945504..a0b2affb2c 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -73,9 +73,8 @@ static inline void qobject_init(QObject *obj, QType ty=
pe)
>>
>>  static inline void *qobject_ref_impl(QObject *obj)
>>  {
>> -    if (obj) {
>> -        obj->base.refcnt++;
>> -    }
>> +    assert(obj);
>> +    obj->base.refcnt++;
>>      return obj;
>>  }
>>
>> @@ -103,6 +102,7 @@ static inline void qobject_unref_impl(QObject *obj)
>>
>>  /**
>>   * qobject_ref(): Increment QObject's reference count
>> + * @obj: a #QObject or child type instance (must not be NULL)
>>   *
>>   * Returns: the same @obj. The type of @obj will be propagated to the
>>   * return type.
>> @@ -112,6 +112,7 @@ static inline void qobject_unref_impl(QObject *obj)
>>  /**
>>   * qobject_unref(): Decrement QObject's reference count, deallocate
>>   * when it reaches zero
>> + * @obj: a #QObject or children type instance (can be NULL)
>>   */
>>  #define qobject_unref(obj) qobject_unref_impl(QOBJECT(obj))
>>
>> diff --git a/monitor.c b/monitor.c
>> index 7dbc1f74b8..3a750208fd 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4188,7 +4188,7 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>>
>>      req_obj =3D g_new0(QMPRequest, 1);
>>      req_obj->mon =3D mon;
>> -    req_obj->id =3D qobject_ref(id);
>> +    req_obj->id =3D id ? qobject_ref(id) : NULL;
>>      req_obj->req =3D req;
>>      req_obj->need_resume =3D false;
>
> What's your argument that this is the only use of qobject_ref() that
> needs to be guarded now?

Right, that's the only one that is obvious, as it fails in test, and
the code is pretty obvious about id being optional.

For the rest, we have to rely on testing, and manual inspection of
qobject_ref() usage:

- block.c: guarded in bdrv_refresh_filename(), more tricky for
append_open_options(), as it depends if qdict values could be NULL
- block/blkdebug.c: depends if qdict values could be NULL,
full_open_options could NULL apparently, so should probably be handled
FIXED
- block/blkverify.c: guarded
- block/{null,nvme}.c: guaded, previous qdict_del() (actually
qdict_find()) guarantee non-NULL)
- block/quorum.c: if full_open_options can be NULL, we should handle it. FI=
XED
- monitor: optional "id" case must be handled, done in 2 places
  monitor_json_emitter(): only called with data !=3D NULL, we could add
an earlier assert
  monitor_qapi_event_queue(): called from func_emit, by qapi events,
assert earlier during construction in qobject_output_complete()
- qapi/qmp-dispatch.c: if "arguments" exists, it can't be NULL during
json parsing
- qapi/qobject-input-visitor.c: guarded by assert in visit_type_any()
- qapi/qobject-output-visitor.c: guarded by assert in visit_type_any()
for qobject_output_type_any, guarded by assert() in
qobject_output_complete
- qmp.c: guarded, error out before if NULL
- qobject/q{list,dict}.c: can accept NULL values apparently, what's
the reason? how are you supposed to handle that?
- tests/*: let's consider this is covered by make check
- util/keyval.c: guarded, if (!elt[i]) before the ref

Except a very few corner cases, it looks quite safe to me. But, if
necessary, we can add if obj ? obj_ref(obj) : NULL for the dubious
cases.

--=20
Marc-Andr=C3=A9 Lureau
