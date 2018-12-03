Received: from eggs.gnu.org ([2001:4830:134:3::10]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTkxK-0001Ex-5Z
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTkxH-0003r4-0U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:55:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gTkxG-0003qa-Sb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:55:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so12935059qtm.13
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 01:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-6-marcandre.lureau@redhat.com>
	<87mupn6l5v.fsf@dusky.pond.sub.org>
In-Reply-To: <87mupn6l5v.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Dec 2018 13:55:43 +0400
Message-ID: <CAMxuvawM0PV0EaCcP+=3ZWPQF5LXLDvxgsrgD0shPzDTm_1_dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] monitor: prevent inserting new
 monitors after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Hi
On Mon, Dec 3, 2018 at 12:59 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add a monitor_destroyed global to check if monitor_cleanup() has been
> > already called. In this case, don't insert the new monitor in the
> > list, but free it instead.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The commit message explains what the patch does, but not why we want to
> do it.
>
> > ---
> >  monitor.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index fffeb27ef9..7fe89daa87 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -263,10 +263,11 @@ typedef struct QMPRequest QMPRequest;
> >  /* QMP checker flags */
> >  #define QMP_ACCEPT_UNKNOWNS 1
> >
> > -/* Protects mon_list, monitor_qapi_event_state.  */
> > +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> >  static QemuMutex monitor_lock;
> >  static GHashTable *monitor_qapi_event_state;
> >  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
> > +static bool monitor_destroyed;
> >
> >  /* Protects mon_fdsets */
> >  static QemuMutex mon_fdsets_lock;
> > @@ -4536,8 +4537,16 @@ void error_vprintf_unless_qmp(const char *fmt, v=
a_list ap)
> >  static void monitor_list_append(Monitor *mon)
> >  {
> >      qemu_mutex_lock(&monitor_lock);
> > -    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> > +    if (!monitor_destroyed) {
> > +        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> > +        mon =3D NULL;
> > +    }
> >      qemu_mutex_unlock(&monitor_lock);
> > +
> > +    if (mon) {
> > +        monitor_data_destroy(mon);
> > +        g_free(mon);
> > +    }
> >  }
> >
> >  static void monitor_qmp_setup_handlers_bh(void *opaque)
> > @@ -4631,6 +4640,7 @@ void monitor_cleanup(void)
> >
> >      /* Flush output buffers and destroy monitors */
> >      qemu_mutex_lock(&monitor_lock);
> > +    monitor_destroyed =3D true;
> >      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> >          QTAILQ_REMOVE(&mon_list, mon, entry);
> >          monitor_flush(mon);
>
> monitor_cleanup() is one of the last things main() calls before it
> returns.  If another thread creates a monitor afterwards, it won't be
> cleaned up.  I figure that's the reason we want this patch.  There might
> be more serious issues than failure to clean up.  Please explain in your
> commit message.

Is this clearer?

    monitor_cleanup() is one of the last things main() calls before it
    returns.  In the following patch, monitor_cleanup() will release the
    monitor_lock during flushing. There may be pending commands to insert
    new monitors, which would modify the mon_list during iteration, and
    the clean-up could thus miss those new insertions.

    Add a monitor_destroyed global to check if monitor_cleanup() has been
    already called. In this case, don't insert the new monitor in the
    list, but free it instead.

> monitor_list_append() is called by monitor_init(), either directly right
> before it returns, or via a bottom half if mon->use_io_thread.
> Therefore, @monitor_destroyed can only be true if monitor_init()
> commonly runs in a thread other than the main thread.  Please give an
> example where it does, in your commit message.
