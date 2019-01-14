Received: from eggs.gnu.org ([209.51.188.92]:56057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3HT-00072s-Ma
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3HO-0003hw-3G
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:31:59 -0500
Date: Mon, 14 Jan 2019 14:31:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190114143144.GH3686@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Qemu-block <qemu-block@nongnu.org>

On Mon, Jan 14, 2019 at 01:52:01PM +0000, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 13:47, Thomas Huth <thuth@redhat.com> wrote:
> >
> > The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
> > "inline" prototype definitions which GCC refuses to compile in its
> > gnu99 mode:
> >
> > In file included from block/iscsi.c:52:0:
> > /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> > =E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror=
]
> >  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
> >              ^
> > /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> > =E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror=
]
> >  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
> >              ^
> >
> > This has been fixed by upstream libiscsi in version 1.10.0 (see
> > https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
> > since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
> > have to work-around the issue by compiling with "-fgnu89-inline"
> > in this case instead.
> >
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  configure | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 2b9ba7d..aa80c17 100755
> > --- a/configure
> > +++ b/configure
> > @@ -4562,6 +4562,11 @@ if test "$libiscsi" !=3D "no" ; then
> >      libiscsi=3D"yes"
> >      libiscsi_cflags=3D$($pkg_config --cflags libiscsi)
> >      libiscsi_libs=3D$($pkg_config --libs libiscsi)
> > +    if $pkg_config --exact-version=3D=3D1.9.0 libiscsi; then
> > +      # There are some bad inline declarations in scsi-lowlevel.h of
> > +      # libiscsi 1.9.0 which don't work in gnu99 mode without this:
> > +      libiscsi_cflags=3D"-fgnu89-inline $libiscsi_cflags"
> > +    fi
>=20
> Can we suppress the warnings with #pragma instead ?
> That would avoid compiling the .o file with different
> C semantics.

IIUC this is a built-in warning you can't disable, except by changing
the compilation mode to have gnu89 inline semantics :-(

I'd rather we just added  -Wno-error  to libiscsi_cflags instead of
changing compilation mode.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
