Received: from eggs.gnu.org ([2001:4830:134:3::10]:38543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftAO4-0007Vb-TM
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftAO1-0004Mh-MJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:36:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-2-marcandre.lureau@redhat.com>
	<87in40b3fc.fsf@dusky.pond.sub.org>
	<CAJ+F1CLdS0V0wGjHS0eUe=VV0ExsTp+Bk09TTJn9Rm5A_DRjCg@mail.gmail.com>
Date: Fri, 24 Aug 2018 13:30:51 +0200
In-Reply-To: <CAJ+F1CLdS0V0wGjHS0eUe=VV0ExsTp+Bk09TTJn9Rm5A_DRjCg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 24 Aug 2018
	10:45:44 +0200")
Message-ID: <87wosg80ic.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qdict: add qdict_steal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, Aug 24, 2018 at 10:05 AM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Add a new function qdict_steal(), that deletes a key from a dict, and
>> > returns the associated value, if any. Simplify related code.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qapi/qmp/qdict.h |  1 +
>> >  monitor.c                |  3 +--
>> >  qobject/block-qdict.c    |  7 ++-----
>> >  qobject/qdict.c          | 22 ++++++++++++++++++++++
>> >  4 files changed, 26 insertions(+), 7 deletions(-)
>>
>> Missing: tests/check-qdict.c update.
>
> ok
>
>>
>> > diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> > index 7f3ec10a10..84644bfba6 100644
>> > --- a/include/qapi/qmp/qdict.h
>> > +++ b/include/qapi/qmp/qdict.h
>> > @@ -37,6 +37,7 @@ QObject *qdict_entry_value(const QDictEntry *entry);
>> >  size_t qdict_size(const QDict *qdict);
>> >  void qdict_put_obj(QDict *qdict, const char *key, QObject *value);
>> >  void qdict_del(QDict *qdict, const char *key);
>> > +QObject *qdict_steal(QDict *qdict, const char *key);
>> >  int qdict_haskey(const QDict *qdict, const char *key);
>> >  QObject *qdict_get(const QDict *qdict, const char *key);
>> >  bool qdict_is_equal(const QObject *x, const QObject *y);
>> > diff --git a/monitor.c b/monitor.c
>> > index a1999e396c..eab2dc7b7b 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -4262,8 +4262,7 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens)
>> >
>> >      qdict =3D qobject_to(QDict, req);
>> >      if (qdict) {
>> > -        id =3D qobject_ref(qdict_get(qdict, "id"));
>> > -        qdict_del(qdict, "id");
>> > +        id =3D qdict_steal(qdict, "id");
>> >      } /* else will fail qmp_dispatch() */
>> >
>> >      if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAN=
D)) {
>> > diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
>> > index 42054cc274..a07664ee6a 100644
>> > --- a/qobject/block-qdict.c
>> > +++ b/qobject/block-qdict.c
>> > @@ -692,8 +692,6 @@ void qdict_join(QDict *dest, QDict *src, bool over=
write)
>> >   */
>> >  bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Err=
or **errp)
>> >  {
>> > -    QObject *qobj;
>> > -
>> >      while (renames->from) {
>> >          if (qdict_haskey(qdict, renames->from)) {
>> >              if (qdict_haskey(qdict, renames->to)) {
>> > @@ -702,9 +700,8 @@ bool qdict_rename_keys(QDict *qdict, const QDictRe=
names *renames, Error **errp)
>> >                  return false;
>> >              }
>> >
>> > -            qobj =3D qdict_get(qdict, renames->from);
>> > -            qdict_put_obj(qdict, renames->to, qobject_ref(qobj));
>> > -            qdict_del(qdict, renames->from);
>> > +            qdict_put_obj(qdict, renames->to,
>> > +                          qdict_steal(qdict, renames->from));
>> >          }
>> >
>> >          renames++;
>>
>> How did you find possible uses for qdict_steal()?
>
> manual review

Okay.  I expected a few more than two.

>> > diff --git a/qobject/qdict.c b/qobject/qdict.c
>> > index 3d8c2f7bbc..322f23f094 100644
>> > --- a/qobject/qdict.c
>> > +++ b/qobject/qdict.c
>> > @@ -406,6 +406,28 @@ void qdict_del(QDict *qdict, const char *key)
>> >      }
>> >  }
>> >
>> > +/**
>> > + * qdict_steal(): Steal a 'key:value' pair from the dictionary
>>
>> "Steal" is cute, but perhaps qdict_get_and_del() would be clearer.
>
> "steal" is common in glib. I don't mind renaming.

Hmm.  I found g_hash_table_steal(), but it's a bit different: it
"Removes a key and its associated value from a GHashTable without
calling the key and value destroy functions" (that part seems close
enough), but returns a bool rather than the value.  Feels like sub-par
design to me.  Is this the precedence you have in mind?

[...]
