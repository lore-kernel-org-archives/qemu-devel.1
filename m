Received: from eggs.gnu.org ([2001:4830:134:3::10]:36712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMcA9-0007vY-KX
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMc9v-0000JW-DI
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMc9q-0000Eg-3X
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:23 -0500
Date: Tue, 13 Nov 2018 17:07:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181113170709.GJ14591@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-6-berrange@redhat.com>
	<CAJ+F1C+mSMjCKiZueUUoOWUCrgx5dML=zFZCQF__CW8hmwCn+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+mSMjCKiZueUUoOWUCrgx5dML=zFZCQF__CW8hmwCn+A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/11] hw/usb: switch MTP to use new
 inotify APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Wed, Nov 07, 2018 at 10:26:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Oct 19, 2018 at 5:42 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > The internal inotify APIs allow alot of conditional statements to be
>=20
> a lot
>=20
> > cleared out, and provide a simpler callback for handling events.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  hw/usb/dev-mtp.c    | 250 ++++++++++++++++--------------------------=
--
> >  hw/usb/trace-events |   2 +-
> >  2 files changed, 93 insertions(+), 159 deletions(-)
> >
> > diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> > index ccbe25820b..1a8d0f088d 100644
> > --- a/hw/usb/dev-mtp.c
> > +++ b/hw/usb/dev-mtp.c
> > @@ -15,13 +15,11 @@
> >  #include <dirent.h>
> >
> >  #include <sys/statvfs.h>
> > -#ifdef CONFIG_INOTIFY1
> > -#include <sys/inotify.h>
> > -#include "qemu/main-loop.h"
> > -#endif
> > +
> >
> >  #include "qemu-common.h"
> >  #include "qemu/iov.h"
> > +#include "qemu/filemonitor.h"
> >  #include "trace.h"
> >  #include "hw/usb.h"
> >  #include "desc.h"
> > @@ -124,7 +122,6 @@ enum {
> >      EP_EVENT,
> >  };
> >
> > -#ifdef CONFIG_INOTIFY1
> >  typedef struct MTPMonEntry MTPMonEntry;
> >
> >  struct MTPMonEntry {
> > @@ -133,7 +130,6 @@ struct MTPMonEntry {
> >
> >      QTAILQ_ENTRY(MTPMonEntry) next;
> >  };
> > -#endif
> >
> >  struct MTPControl {
> >      uint16_t     code;
> > @@ -162,10 +158,8 @@ struct MTPObject {
> >      char         *name;
> >      char         *path;
> >      struct stat  stat;
> > -#ifdef CONFIG_INOTIFY1
> > -    /* inotify watch cookie */
> > +    /* file monitor watch cookie */
> >      int          watchfd;
>=20
> Why not rename it watchid to avoid confusion?

Yes, will do.

> > -static void inotify_watchfn(void *arg)
> > +static void file_monitor_event(int wd,
> > +                               QFileMonitorEvent ev,
> > +                               const char *name,
> > +                               void *opaque)
> >  {
> > -    MTPState *s =3D arg;
> > -    ssize_t bytes;
> > -    /* From the man page: atleast one event can be read */
> > -    int pos;
> > -    char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
> > -
> > -    for (;;) {
> > -        bytes =3D read(s->inotifyfd, buf, sizeof(buf));
> > -        pos =3D 0;
> > -
> > -        if (bytes <=3D 0) {
> > -            /* Better luck next time */
> > +    MTPState *s =3D opaque;
> > +    int watchfd =3D 0;
> > +    MTPObject *parent =3D usb_mtp_object_lookup_wd(s, wd);
> > +    MTPMonEntry *entry =3D NULL;
> > +    MTPObject *o;
> > +
> > +    if (!parent) {
> > +        return;
> > +    }
> > +
> > +    switch (ev) {
> > +    case QFILE_MONITOR_EVENT_CREATED:
> > +        if (usb_mtp_object_lookup_name(parent, name, -1)) {
> > +            /* Duplicate create event */
> >              return;
> >          }
> > +        entry =3D g_new0(MTPMonEntry, 1);
> > +        entry->handle =3D s->next_handle;
> > +        entry->event =3D EVT_OBJ_ADDED;
> > +        o =3D usb_mtp_add_child(s, parent, name);
> > +        if (!o) {
> > +            g_free(entry);
> > +            return;
> > +        }
> > +        o->watchfd =3D watchfd;
>=20
> this effectively always set o->watchfd to 0, which is already
> initialized to 0 with g_new0(), you can drop it

Yeah, pre-existing pointless code, so I've dropped it.


> >  static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
> >  {
> >      struct dirent *entry;
> >      DIR *dir;
> > +    Error *err =3D NULL;
> >
> >      if (o->have_children) {
> >          return;
> > @@ -662,16 +596,19 @@ static void usb_mtp_object_readdir(MTPState *s,=
 MTPObject *o)
> >      if (!dir) {
> >          return;
> >      }
> > -#ifdef CONFIG_INOTIFY1
> > -    int watchfd =3D usb_mtp_add_watch(s->inotifyfd, o->path);
> > +
> > +    int watchfd =3D qemu_file_monitor_add_watch(s->file_monitor, o->=
path, NULL,
> > +                                              file_monitor_event, s,=
 &err);
>=20
> There is an add_watch(), but I don't see the corresponding
> remove_watch(). This may probably cause crashes if MTPState is freed.

Yes, I've added code to remove the watch, and also
to use a private file_monitor instance so free'ing
that will release all watches as a safety net.

>=20
> >      if (watchfd =3D=3D -1) {
> > -        fprintf(stderr, "usb-mtp: failed to add watch for %s\n", o->=
path);
> > +        fprintf(stderr, "usb-mtp: failed to add watch for %s: %s\n",=
 o->path,
> > +                error_get_pretty(err));
>=20
> maybe it's a good time to turn into error_report() ?

Yep


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
