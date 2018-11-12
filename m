Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMFQ4-00005s-Fp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMFPu-0001ES-7w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:50:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMFPe-0000zW-HM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:50:14 -0500
Date: Mon, 12 Nov 2018 16:49:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112164943.GV3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-2-berrange@redhat.com>
	<CAJ+F1CKZ87QcRk=9uQc9FdNEMmswRakMvVrsxuA_HJrM14G++g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKZ87QcRk=9uQc9FdNEMmswRakMvVrsxuA_HJrM14G++g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/11] util: add helper APIs for dealing
 with inotify in portable manner
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

On Wed, Nov 07, 2018 at 10:08:05PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 19, 2018 at 5:41 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > The inotify userspace API for reading events is quite horrible, so it=
 is
> > useful to wrap it in a more friendly API to avoid duplicating code
> > across many users in QEMU. Wrapping it also allows introduction of a
> > platform portability layer, so that we can add impls for non-Linux ba=
sed
> > equivalents in future.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---

> > +struct QFileMonitor {
> > +    QemuMutex lock;
> > +    int fd;
> > +
> > +    GHashTable *dirs; /* dirname =3D> QFileMonitorDir */
> > +    GHashTable *idmap; /* inotify ID =3D> dirname */
> > +};
> > +
> > +
> > +typedef struct {
> > +    int id; /* watch ID */
> > +    char *filename; /* optional filter */
> > +    QFileMonitorHandler cb;
> > +    void *opaque;
> > +} QFileMonitorWatch;
> > +
> > +
> > +typedef struct {
> > +    char *path;
> > +    int id; /* inotify ID */
> > +    int nextid; /* watch ID counter */
> > +    gsize nwatches;
> > +    QFileMonitorWatch *watches;
> > +} QFileMonitorDir;
> > +
> > +
> > +#ifdef CONFIG_INOTIFY1
> > +#include <sys/inotify.h>
> > +
> > +static void qemu_file_monitor_watch(void *arg)
> > +{
> > +    QFileMonitor *mon =3D arg;
> > +    char buf[4096]
> > +        __attribute__ ((aligned(__alignof__(struct inotify_event))))=
;
> > +    int used =3D 0;
> > +    int len =3D read(mon->fd, buf, sizeof(buf));
> > +
> > +    qemu_mutex_lock(&mon->lock);
>=20
> I suppose the lock should guard from mon->fd above, or there might be
> a race when modifying/removing a watch from a different thread.

The mutex is only there to protect the "dirs" and "idmap" hash tables.

The "fd" has enough safety - the kernel is fine with you reading
from the fd, while another thread is adding/removing files on
the inotify handle.

Since the QFileMonitor object is a singleton that can never be
free'd we'll never race with closing 'fd either.

>=20
> > +
> > +    if (len < 0) {
> > +        if (errno !=3D EAGAIN) {
> > +            error_report("Failure monitoring inotify FD, disabling e=
vents");
>=20
> strerror(errno) could be useful

Yep.


> > +static void
> > +qemu_file_monitor_dir_free(void *data)
> > +{
> > +    QFileMonitorDir *dir =3D data;
> > +
> > +    g_free(dir->watches);
>=20
> for sake, I would add
> assert(dir->nwatches =3D 0)

Yep.


> > +#ifdef CONFIG_INOTIFY1
> > +int
> > +qemu_file_monitor_add_watch(QFileMonitor *mon,
> > +                            const char *dirpath,
> > +                            const char *filename,
> > +                            QFileMonitorHandler cb,
> > +                            void *opaque,
> > +                            Error **errp)
> > +{
> > +    QFileMonitorDir *dir;
> > +    int ret =3D -1;
> > +
> > +    qemu_mutex_lock(&mon->lock);
> > +    dir =3D g_hash_table_lookup(mon->dirs, dirpath);
> > +    if (!dir) {
> > +        int rv =3D inotify_add_watch(mon->fd, dirpath,
> > +                                   IN_CREATE | IN_DELETE | IN_MODIFY=
 |
> > +                                   IN_MOVED_TO | IN_MOVED_FROM);
> > +
> > +        if (rv < 0) {
> > +            error_setg_errno(errp, errno, "Unable to watch '%s'", di=
rpath);
> > +            goto cleanup;
> > +        }
> > +
> > +        trace_qemu_file_monitor_enable_watch(mon, dirpath, rv);
> > +
> > +        dir =3D g_new0(QFileMonitorDir, 1);
> > +        dir->path =3D g_strdup(dirpath);
> > +        dir->id =3D rv;
> > +
> > +        g_hash_table_insert(mon->dirs, dir->path, dir);
> > +        g_hash_table_insert(mon->idmap, GINT_TO_POINTER(rv), dir);
> > +
> > +        if (g_hash_table_size(mon->dirs) =3D=3D 1) {
> > +            qemu_set_fd_handler(mon->fd, qemu_file_monitor_watch, NU=
LL, mon);
> > +        }
> > +    }
> > +
> > +    dir->watches =3D g_renew(QFileMonitorWatch, dir->watches, dir->n=
watches + 1);
>=20
> GArray could eventually make handling of watches a bit simpler
> (counting, resizing, removing etc)

ok, i'll have a look at that API.

>=20
> > +
> > +    dir->watches[dir->nwatches].id =3D ++dir->nextid;
> > +    dir->watches[dir->nwatches].filename =3D filename ? g_strdup(fil=
ename) : NULL;
>=20
> g_strdup(NULL) returns NULL already

Ah, I forget that.

>=20
> > +    dir->watches[dir->nwatches].cb =3D cb;
> > +    dir->watches[dir->nwatches].opaque =3D opaque;
> > +    dir->nwatches++;
> > +
> > +    trace_qemu_file_monitor_add_watch(mon, dirpath,
> > +                                      filename ? filename : "<none>"=
,
> > +                                      cb, opaque,
> > +                                      dir->watches[dir->nwatches - 1=
].id);
> > +
> > +    ret =3D 0;
> > +
> > + cleanup:
> > +    qemu_mutex_unlock(&mon->lock);
> > +    return ret;
> > +}
> > +
> > +
> > +void qemu_file_monitor_remove_watch(QFileMonitor *mon,
> > +                                    const char *dirpath,
> > +                                    int id)
> > +{
> > +    QFileMonitorDir *dir;
> > +    gsize i;
> > +
> > +    qemu_mutex_lock(&mon->lock);
> > +
> > +    trace_qemu_file_monitor_remove_watch(mon, dirpath, id);
> > +
> > +    dir =3D g_hash_table_lookup(mon->dirs, dirpath);
> > +    if (!dir) {
> > +        goto cleanup;
> > +    }
> > +
> > +    for (i =3D 0; i < dir->nwatches; i++) {
> > +        if (dir->watches[i].id =3D=3D id) {
> > +            if (i < (dir->nwatches - 1)) {
> > +                memmove(dir->watches + i,
> > +                        dir->watches + i + 1,
> > +                        sizeof(QFileMonitorWatch) *
> > +                        (dir->nwatches - (i + 1)));
> > +                dir->watches =3D g_renew(QFileMonitorWatch, dir->wat=
ches,
> > +                                       dir->nwatches - 1);
> > +                dir->nwatches--;
> > +            }
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (dir->nwatches =3D=3D 0) {
> > +        inotify_rm_watch(mon->fd, dir->id);
> > +        trace_qemu_file_monitor_disable_watch(mon, dir->path, dir->i=
d);
> > +
> > +        g_hash_table_remove(mon->idmap, GINT_TO_POINTER(dir->id));
> > +        g_hash_table_remove(mon->dirs, dir->path);
> > +    }
> > +
> > + cleanup:
> > +    qemu_mutex_lock(&mon->lock);
> > +}
> > +
> > +#else
> > +int
> > +qemu_file_monitor_add_watch(QFileMonitor *mon,
> > +                            const char *dirpath,
> > +                            const char *filename,
> > +                            QFileMonitorHandler cb,
> > +                            void *opaque,
> > +                            Error **errp)
> > +{
> > +    error_setg(errp, "File monitoring not available on this platform=
");
> > +    return -1;
> > +}
> > +
> > +void qemu_file_monitor_remove_watch(QFileMonitor *mon,
> > +                                    const char *dirpath,
> > +                                    int id)
> > +{
> > +}
>=20
> Wouldn't it be cleaner with stubs/ ?

I guess we could do it that way.


>=20
> Looks good, but would be even better with tests :)

I'll see what I can do about that.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
