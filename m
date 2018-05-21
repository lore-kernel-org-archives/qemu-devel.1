Received: from eggs.gnu.org ([2001:4830:134:3::10]:34842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKgcS-0004oe-JA
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKgcO-0002eb-MG
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:56:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fKgcO-0002dP-Hi
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:56:36 -0400
Date: Mon, 21 May 2018 09:56:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180521085627.GD23090@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180514171913.17664-2-berrange@redhat.com>
	<CAFEAcA_Md+65UePz-_WWUWJi35EGVaOEnPHMUGuA=ZJPqGcp2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Md+65UePz-_WWUWJi35EGVaOEnPHMUGuA=ZJPqGcp2Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] i386: fix regression parsing multiboot
 initrd modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, May 18, 2018 at 06:54:48PM +0100, Peter Maydell wrote:
> On 14 May 2018 at 18:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> > The logic for parsing the multiboot initrd modules was messed up in
> >
> >   commit 950c4e6c94b15cd0d8b63891dddd7a8dbf458e6a
> >   Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >   Date:   Mon Apr 16 12:17:43 2018 +0100
> >
> >     opts: don't silently truncate long option values
> >
> > Causing the length to be undercounter, and the number of modules over
> > counted. It also passes NULL to get_opt_value() which was not robust
> > at accepting a NULL value.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  hw/i386/multiboot.c | 3 +--
> >  util/qemu-option.c  | 4 +++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> > index 7a2953e26f..8e26545814 100644
> > --- a/hw/i386/multiboot.c
> > +++ b/hw/i386/multiboot.c
> > @@ -292,8 +292,7 @@ int load_multiboot(FWCfgState *fw_cfg,
> >      cmdline_len +=3D strlen(kernel_cmdline) + 1;
> >      if (initrd_filename) {
> >          const char *r =3D get_opt_value(initrd_filename, NULL);
> > -        cmdline_len +=3D strlen(r) + 1;
> > -        mbs.mb_mods_avail =3D 1;
> > +        cmdline_len +=3D strlen(initrd_filename) + 1;
> >          while (1) {
> >              mbs.mb_mods_avail++;
> >              r =3D get_opt_value(r, NULL);
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 58d1c23893..8a68bc2314 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -75,7 +75,9 @@ const char *get_opt_value(const char *p, char **val=
ue)
> >      size_t capacity =3D 0, length;
> >      const char *offset;
> >
> > -    *value =3D NULL;
> > +    if (value) {
> > +        *value =3D NULL;
> > +    }
> >      while (1) {
> >          offset =3D strchr(p, ',');
> >          if (!offset) {
>=20
> Don't we delete this check again in patch 3? If we're
> going to fix this by making multiboot.c not pass in NULL pointers,
> is there a reason not to simply do that?

That is correct, however, I wanted to do a really simple fix that address=
ed
the crasher regression, so that aspect of the fix wasn't obscured by the
bigger refactoring I do in 2 & 3.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
