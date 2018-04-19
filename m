Received: from eggs.gnu.org ([2001:4830:134:3::10]:33708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C2j-0002Ko-UF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C2j-0004Ty-02
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:04:17 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9C2i-0004Td-Pt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:04:16 -0400
Received: by mail-wr0-x241.google.com with SMTP id z73-v6so15506092wrb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <316596cd-46f1-4422-dbd3-8ca16b39b798@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-6-marcandre.lureau@redhat.com>
	<316596cd-46f1-4422-dbd3-8ca16b39b798@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 18:04:14 +0200
Message-ID: <CAJ+F1C+F7+Ndgbb10oOdUNtg+v1Pxg79Lrn_1x27v5ARtLQw6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/5] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Thu, Apr 19, 2018 at 5:39 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>> While it may be convenient to accept NULL value in
>> qobject_unref() (for similar reasons as free() accepts NULL), it is
>> not such a good idea for qobject_ref(): now assert() on NULL.
>>
>> Some places relied on that behaviour (the monitor request id for
>> example), and it's best to be explicit that NULL is accepted there.
>> We have to rely on testing, and manual inspection of qobject_ref()
>> usage:
>>
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Again, you've made a substantial change since v5 (more hunks added, and
> justification in the commit message that needs double-checking that your
> audit was sane), so I would have dropped R-b.

ok

>
>> ---
>>  include/qapi/qmp/qobject.h | 7 ++++---
>>  block.c                    | 9 +++++----
>>  block/blkdebug.c           | 3 ++-
>>  block/quorum.c             | 3 ++-
>>  monitor.c                  | 2 +-
>>  5 files changed, 14 insertions(+), 10 deletions(-)
>>
>
>> @@ -104,6 +103,7 @@ static inline void qobject_unref_impl(QObject *obj)
>>
>>  /**
>>   * qobject_ref(): Increment QObject's reference count
>> + * @obj: a #QObject or child type instance (must not be NULL)
>>   *
>>   * Returns: the same @obj. The type of @obj will be propagated to the
>>   * return type.
>> @@ -117,6 +117,7 @@ static inline void qobject_unref_impl(QObject *obj)
>>  /**
>>   * qobject_unref(): Decrement QObject's reference count, deallocate
>>   * when it reaches zero
>> + * @obj: a #QObject or children type instance (can be NULL)
>
> s/children/child/
>
>> +++ b/block.c
>> @@ -5110,8 +5110,9 @@ static bool append_open_options(QDict *d, BlockDri=
verState *bs)
>>      const char *p;
>>
>>      for (entry =3D qdict_first(bs->options); entry;
>> -         entry =3D qdict_next(bs->options, entry))
>> -    {
>> +         entry =3D qdict_next(bs->options, entry)) {
>> +        QObject *val;
>> +
>>          /* Exclude options for children */
>>          QLIST_FOREACH(child, &bs->children, next) {
>>              if (strstart(qdict_entry_key(entry), child->name, &p)
>> @@ -5134,8 +5135,8 @@ static bool append_open_options(QDict *d, BlockDri=
verState *bs)
>>              continue;
>>          }
>>
>> -        qdict_put_obj(d, qdict_entry_key(entry),
>> -                      qobject_ref(qdict_entry_value(entry)));
>> +        val =3D qdict_entry_value(entry);
>> +        qdict_put_obj(d, qdict_entry_key(entry), val ? qobject_ref(val)=
 : NULL);
>
> I don't think we allow pushing NULL into qdict; we should probably beef
> up the testsuite and/or add asserts to qdict_put_obj(), at which point
> this hunk is spurious.
>
>> +++ b/block/blkdebug.c
>> @@ -845,7 +845,8 @@ static void blkdebug_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
>>      opts =3D qdict_new();
>>      qdict_put_str(opts, "driver", "blkdebug");
>>
>> -    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_option=
s));
>> +    qdict_put(opts, "image", bs->file->bs->full_open_options ?
>> +              qobject_ref(bs->file->bs->full_open_options) : NULL);
>
> Likewise, this hunk is spurious if we can't push NULL into a QDict.
>
>> +++ b/block/quorum.c
>> @@ -1083,7 +1083,8 @@ static void quorum_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
>>      children =3D qlist_new();
>>      for (i =3D 0; i < s->num_children; i++) {
>>          qlist_append(children,
>> -                     qobject_ref(s->children[i]->bs->full_open_options)=
);
>> +                     s->children[i]->bs->full_open_options ?
>> +                     qobject_ref(s->children[i]->bs->full_open_options)=
 : NULL);
>
> And again, but for QList.


Yes, for now I stayed on the safe side. Open-questions in the commit messag=
e.

--=20
Marc-Andr=C3=A9 Lureau
