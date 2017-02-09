Received: from eggs.gnu.org ([2001:4830:134:3::10]:46865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cbrpI-0002Pz-40
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cbrpE-0001zz-Tc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:44:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cbrpE-0001zi-LU
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:44:04 -0500
Date: Thu, 9 Feb 2017 16:43:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170209164358.GF2384@work-vm>
References: <1486653934-14805-1-git-send-email-den@openvz.org>
	<1486653934-14805-2-git-send-email-den@openvz.org>
	<20170209160922.GC26192@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170209160922.GC26192@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Feb 09, 2017 at 06:25:33PM +0300, Denis V. Lunev wrote:
> > From: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >=20
> > This patch adds a possibility to change a char device without a front=
end
> > removal.
> >=20
> > Ideally, it would have to happen transparently to a frontend, i.e. fr=
ontend
> > would continue its regular operation. However, backends are not state=
les
> > and are set up by the frontends via qemu_chr_fe_<> functions, and it'=
s not
> > (generally) possible to replay that setup entirely in a backend code,=
 as
> > different chardevs respond to the setup calls differently, so do fron=
tends
> > work differently basing on those setup responses. Moreover, some fron=
tend
> > can generally get and save the backend pointer (qemu_chr_fe_get_drive=
r()),
> > and it will become invalid after backend change.
> >=20
> > So, a frontend which would like to support chardev hotswap has to reg=
ister
> > a "backend change" handler, and redo its backend setup there.
> >=20
> > Write path can be used by multiple threads and thus protected with
> > chr_write_lock. So hotswap also has to be protected so write function=
s
> > won't access a backend being replaced.
> >=20
> > 3. Hotswap function can be called from e.g. a read handler of a monit=
or
> > socket. This can cause troubles so it's safer to defer execution to
> > a bottom-half. (however, it means we cannot return some of the errors
> > synchronously - but most of them we can)
> >=20
> > Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: "Marc-Andr=E9 Lureau" <marcandre.lureau@redhat.com>
> > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > ---
> >  chardev/char.c        | 161 ++++++++++++++++++++++++++++++++++++++++=
+++++++---
> >  hmp.c                 |  14 +++++
>=20
> IIRC we required new commands to have a QMP addition and the new HMP
> function written by invoking the QMP handler.
>=20
>=20
> > diff --git a/hmp.c b/hmp.c
> > index 2bc4f06..70252df 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -1522,6 +1522,20 @@ void hmp_change(Monitor *mon, const QDict *qdi=
ct)
> >              }
> >          }
> >          qmp_change("vnc", target, !!arg, arg, &err);
> > +    } else if (strcmp(device, "chardev") =3D=3D 0) {
> > +        QemuOpts *opts;
> > +
> > +        if (arg =3D=3D NULL) {
> > +            arg =3D "";
> > +        }
> > +        opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"), =
arg, true);
> > +        if (opts =3D=3D NULL) {
> > +            error_setg(&err, "Parsing chardev args failed");
> > +        } else {
> > +            qemu_opts_set_id(opts, g_strdup(target));
> > +            qemu_chr_change(opts, &err);
> > +            qemu_opts_del(opts);
> > +        }
>=20
> The hmp 'change' command is/was a huge mistake. We shouldn't continue
> to add stuff to it - create dedicated commands for any new functionalit=
y
> instead of over-loading it one command todo many different things.

Hmm.
There's an experimental qmp command - x-blockdev-change (see 7f821597 )
for a failover for block use.

I did post an HMP equivalent https://lists.gnu.org/archive/html/qemu-deve=
l/2015-12/msg02864.html
which hasn't gone in yet.

So something similar for char might be what you want.

I had wondered if a T adapter for chardevs would be useful in a few situa=
tions,
and maybe it would be here; i.e. something where output is sent
to all the outputs, and input is aggregated from the inputs.

Dave

>=20
> Regards,
> Daniel
> --=20
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberran=
ge/ :|
> |: http://libvirt.org              -o-             http://virt-manager.=
org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danbe=
rr/ :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
