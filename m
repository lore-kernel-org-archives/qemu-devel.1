Received: from eggs.gnu.org ([2001:4830:134:3::10]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ft7iS-00009H-BM
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ft7hH-0003WL-5V
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:44:00 -0400
MIME-Version: 1.0
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-3-marcandre.lureau@redhat.com>
	<87d0u8b2u8.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0u8b2u8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Aug 2018 10:43:44 +0200
Message-ID: <CAJ+F1CLVBmcqa0Rz_=KJY9VphbwxhFWrqWtGnc4kTu61BJOjDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qobject: modify qobject_ref() to
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

Hi
On Fri, Aug 24, 2018 at 10:12 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > While it may be convenient to accept NULL value in
> > qobject_unref() (for similar reasons as free() accepts NULL), it is
> > not such a good idea for qobject_ref(): now assert() on NULL.
>
> Why is it not such a good idea?
>
> Is it unsafe?  Unclean?  Ugly?
>
> If unsafe, can you point to actual problems, present or past?
>
> If you consider it unclean or ugly, can you point to established
> convention?

In general, a function/method shouldn't accept NULL as argument, as it
is usually a programmer mistake.

free() / unref() are exceptions, for convenience.

fwiw, g_object_ref/unref() do not accept NULL. However,
g_clear_object() was introduced later to simply clearing an object
reference (unref and set to NULL, checks NULL).

>
> > Some code relied on that behaviour, but it's best to be explicit that
> > NULL is accepted.  We have to rely on testing, and manual inspection
> > of qobject_ref() usage:
> >
> > * block.c:
> >  - bdrv_refresh_filename(): guarded
> >  - append_open_options(): it depends if qdict values could be NULL,
> >    handled for extra safety, might be unnecessary
> >
> > * block/blkdebug.c:
> >  - blkdebug_refresh_filename(): depends if qdict values could be NULL,
> >    full_open_options could be NULL apparently, handled
> >
> > * block/blkverify.c: guarded
> >
> > * block/{null,nvme}.c: guarded, previous qdict_del() (actually
> >   qdict_find()) guarantee non-NULL)
> >
> > * block/quorum.c: full_open_options could be NULL, handled for extra
> >   safety, might be unnecessary
> >
> > * monitor: events have associated qdict, but may not have 'data' dict
> >   entry. Command 'id' is already guarded. A queued response is
> >   non-NULL.
> >
> > * qapi/qmp-dispatch.c: if "arguments" exists, it can't be NULL during
> >   json parsing
> >
> > * qapi/qobject-input-visitor.c: guarded by assert in visit_type_any()
> >
> > * qapi/qobject-output-visitor.c: guarded by assert() in visit_type_any(=
)
> >   qobject_output_complete(): guarded by pre-condition assert()
> >
> > * qmp.c: guarded, error out before if NULL
> >
> > * qobject/q{list,dict}.c: can accept NULL values apparently, what's
> >   the reason? how are you supposed to handle that? no test?
> >
> >   Some code, such as qdict_flatten_qdict(), assume the value is always
> >   non-NULL for example.
> >
> > - tests/*: considered to be covered by make check, not critical
> >
> > - util/keyval.c: guarded, if (!elt[i]) before
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> That's a lot of analysis to support a change...
>
> > ---
> >  include/qapi/qmp/qobject.h | 7 ++++---
> >  block.c                    | 6 ++++--
> >  block/blkdebug.c           | 3 ++-
> >  block/quorum.c             | 3 ++-
> >  monitor.c                  | 2 +-
> >  5 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> > index fcfd549220..2fe5b42579 100644
> > --- a/include/qapi/qmp/qobject.h
> > +++ b/include/qapi/qmp/qobject.h
> > @@ -74,9 +74,8 @@ static inline void qobject_init(QObject *obj, QType t=
ype)
> >
> >  static inline void qobject_ref_impl(QObject *obj)
> >  {
> > -    if (obj) {
> > -        obj->base.refcnt++;
> > -    }
> > +    assert(obj);
> > +    obj->base.refcnt++;
> >  }
> >
> >  /**
> > @@ -103,6 +102,7 @@ static inline void qobject_unref_impl(QObject *obj)
> >
> >  /**
> >   * qobject_ref(): Increment QObject's reference count
> > + * @obj: a #QObject or child type instance (must not be NULL)
> >   *
> >   * Returns: the same @obj. The type of @obj will be propagated to the
> >   * return type.
> > @@ -116,6 +116,7 @@ static inline void qobject_unref_impl(QObject *obj)
> >  /**
> >   * qobject_unref(): Decrement QObject's reference count, deallocate
> >   * when it reaches zero
> > + * @obj: a #QObject or child type instance (can be NULL)
> >   */
> >  #define qobject_unref(obj) qobject_unref_impl(QOBJECT(obj))
> >
> > diff --git a/block.c b/block.c
> > index 6161dbe3eb..f1e35c3c1e 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -5154,6 +5154,8 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
> >      for (entry =3D qdict_first(bs->options); entry;
> >           entry =3D qdict_next(bs->options, entry))
> >      {
> > +        QObject *val;
> > +
> >          /* Exclude node-name references to children */
> >          QLIST_FOREACH(child, &bs->children, next) {
> >              if (!strcmp(entry->key, child->name)) {
> > @@ -5174,8 +5176,8 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
> >              continue;
> >          }
> >
> > -        qdict_put_obj(d, qdict_entry_key(entry),
> > -                      qobject_ref(qdict_entry_value(entry)));
> > +        val =3D qdict_entry_value(entry);
> > +        qdict_put_obj(d, qdict_entry_key(entry), val ? qobject_ref(val=
) : NULL);
> >          found_any =3D true;
> >      }
> >
> > diff --git a/block/blkdebug.c b/block/blkdebug.c
> > index 0759452925..062263f7e1 100644
> > --- a/block/blkdebug.c
> > +++ b/block/blkdebug.c
> > @@ -846,7 +846,8 @@ static void blkdebug_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
> >      opts =3D qdict_new();
> >      qdict_put_str(opts, "driver", "blkdebug");
> >
> > -    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_optio=
ns));
> > +    qdict_put(opts, "image", bs->file->bs->full_open_options ?
> > +              qobject_ref(bs->file->bs->full_open_options) : NULL);
> >
> >      for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) =
{
> >          if (strcmp(qdict_entry_key(e), "x-image")) {
> > diff --git a/block/quorum.c b/block/quorum.c
> > index 9152da8c58..96cd094ede 100644
> > --- a/block/quorum.c
> > +++ b/block/quorum.c
> > @@ -1089,7 +1089,8 @@ static void quorum_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
> >      children =3D qlist_new();
> >      for (i =3D 0; i < s->num_children; i++) {
> >          qlist_append(children,
> > -                     qobject_ref(s->children[i]->bs->full_open_options=
));
> > +                     s->children[i]->bs->full_open_options ?
> > +                     qobject_ref(s->children[i]->bs->full_open_options=
) : NULL);
> >      }
> >
> >      opts =3D qdict_new();
> > diff --git a/monitor.c b/monitor.c
> > index eab2dc7b7b..be4bcd82a0 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -675,7 +675,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event=
, QDict *qdict)
> >
> >              evstate =3D g_new(MonitorQAPIEventState, 1);
> >              evstate->event =3D event;
> > -            evstate->data =3D qobject_ref(data);
> > +            evstate->data =3D data ? qobject_ref(data) : NULL;
> >              evstate->qdict =3D NULL;
> >              evstate->timer =3D timer_new_ns(monitor_get_event_clock(),
> >                                            monitor_qapi_event_handler,
>
> ... that only complicates code.  By not much, granted.  My problem with
> it is that the commit message doesn't convince me it's an improvement.
>


--=20
Marc-Andr=C3=A9 Lureau
