Received: from eggs.gnu.org ([2001:4830:134:3::10]:36171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuggL-0001Ni-Bp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fugTa-0001NV-8P
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:04:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fugTZ-0001NG-UY
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:04:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id 20-v6so2075956wrb.12
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 09:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-21-marcandre.lureau@redhat.com>
	<20180828155250.GF31005@redhat.com>
In-Reply-To: <20180828155250.GF31005@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 18:04:04 +0200
Message-ID: <CAJ+F1CLsCkehAOs3=63cT1UFL8frccFVJhjoXEmKxW+nsDW5JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/29] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi
On Tue, Aug 28, 2018 at 5:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Jul 13, 2018 at 03:09:07PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > There are variants of qemu_create_pidfile() in qemu-pr-helper and
> > qemu-ga. Let's have a common implementation in libqemuutil.
> >
> > The code is based from pr-helper write_pidfile(), but allows the
> > caller to deal with error reporting and behaviour.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qemu/osdep.h  |  3 ++-
> >  os-posix.c            | 24 -------------------
> >  os-win32.c            | 25 --------------------
> >  qga/main.c            | 54 ++++++++-----------------------------------
> >  scsi/qemu-pr-helper.c | 40 ++++----------------------------
> >  util/oslib-posix.c    | 33 ++++++++++++++++++++++++++
> >  util/oslib-win32.c    | 27 ++++++++++++++++++++++
> >  vl.c                  |  4 ++--
> >  8 files changed, 79 insertions(+), 131 deletions(-)
>
>
>
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 13b6f8d776..da1d4a3201 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -88,6 +88,39 @@ int qemu_daemon(int nochdir, int noclose)
> >      return daemon(nochdir, noclose);
> >  }
> >
> > +bool qemu_write_pidfile(const char *pidfile, Error **errp)
> > +{
> > +    int pidfd;
> > +    char pidstr[32];
> > +
> > +    pidfd =3D qemu_open(pidfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR=
);
> > +    if (pidfd =3D=3D -1) {
> > +        error_setg_errno(errp, errno, "Cannot open pid file");
> > +        return false;
> > +    }
> > +
> > +    if (lockf(pidfd, F_TLOCK, 0)) {
> > +        error_setg_errno(errp, errno, "Cannot lock pid file");
> > +        goto fail;
> > +    }
> > +    if (ftruncate(pidfd, 0)) {
> > +        error_setg_errno(errp, errno, "Failed to truncate pid file");
> > +        goto fail;
> > +    }
> > +
> > +    snprintf(pidstr, sizeof(pidstr), "%d\n", getpid());
> > +    if (write(pidfd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
> > +        error_setg(errp, "Failed to write pid file");
> > +        goto fail;
> > +    }
> > +    return true;
> > +
> > +fail:
> > +    unlink(pidfile);
>
> Danger,  Will Robinson !
>
> We can get to this fail: label if we were unable to lockf() the
> pidfile. ie someone else owns the pidfile, and we've now unlinked
> the pidfile they own.

The code was based on qemu-pr-helper, so the problem exists there.

So we better follow ga_open_pidfile() version here, and close the fd,
return an error. ok

>
>
> > +    close(pidfd);
> > +    return false;
> > +}
> > +
> >  void *qemu_oom_check(void *ptr)
> >  {
> >      if (ptr =3D=3D NULL) {
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--=20
Marc-Andr=C3=A9 Lureau
