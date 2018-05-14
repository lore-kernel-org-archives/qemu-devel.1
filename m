Received: from eggs.gnu.org ([2001:4830:134:3::10]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIGGG-00015U-4B
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIGGD-0003cE-9J
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fIGGD-0003c0-3o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:41 -0400
Date: Mon, 14 May 2018 17:23:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180514162337.GE23010@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<1525817687-34620-16-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9=byErqiGKfeSmgrd7Uyu31LDZubLv+Ov-Z3c+86a5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9=byErqiGKfeSmgrd7Uyu31LDZubLv+Ov-Z3c+86a5QA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/30] opts: don't silently truncate long
 option values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, May 14, 2018 at 05:19:04PM +0100, Peter Maydell wrote:
> On 8 May 2018 at 23:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > The existing QemuOpts parsing code uses a fixed size 1024 byte buffer
> > for storing the option values. If a value exceeded this size it was
> > silently truncated and no error reported to the user. Long option val=
ues
> > is not a common scenario, but it is conceivable that they will happen=
.
> > eg if the user has a very deeply nested filesystem it would be possib=
le
> > to come up with a disk path that was > 1024 bytes. Most of the time i=
f
> > such data was silently truncated, the user would get an error about
> > opening a non-existant disk. If they're unlucky though, QEMU might us=
e a
> > completely different disk image from another VM, which could be
> > considered a security issue. Another example program was in using the
> > -smbios command line arg with very large data blobs. In this case the
> > silent truncation will be providing semantically incorrect data to th=
e
> > guest OS for SMBIOS tables.
> >
> > If the operating system didn't limit the user's argv when spawning QE=
MU,
> > the code should honour whatever length arguments were given without
> > imposing its own length restrictions. This patch thus changes the cod=
e
> > to use a heap allocated buffer for storing the values during parsing,
> > lifting the arbitrary length restriction.
>=20
> Hi; Coverity doesn't like this change (CID1391003):
>=20
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -70,25 +70,37 @@ static const char *get_opt_name(const char *p, ch=
ar **option, char delim)
> >   * delimiter is fixed to be comma which starts a new option. To spec=
ify an
> >   * option value that contains commas, double each comma.
> >   */
> > -const char *get_opt_value(char *buf, int buf_size, const char *p)
> > +const char *get_opt_value(const char *p, char **value)
> >  {
> > -    char *q;
> > +    size_t capacity =3D 0, length;
> > +    const char *offset;
> > +
> > +    *value =3D NULL;
>=20
> Here we write to *value, so value must be non-NULL, and
> within the loop the only place we write to value it
> can't become NULL either (g_renew can't fail)...

Oh, real bug ! This should have been

   if (value) {
      *value =3D NULL;
   }

because multiboot.c passes in NULL for this parameter.

Unless we decide to rewrite multiboot.c to avoid that instead,
since all other callers pass non-NULL.

>=20
> > +    while (1) {
> > +        offset =3D strchr(p, ',');
> > +        if (!offset) {
> > +            offset =3D p + strlen(p);
> > +        }
> >
> > -    q =3D buf;
> > -    while (*p !=3D '\0') {
> > -        if (*p =3D=3D ',') {
> > -            if (*(p + 1) !=3D ',')
> > -                break;
> > -            p++;
> > +        length =3D offset - p;
> > +        if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
> > +            length++;
> > +        }
> > +        if (value) {
>=20
> ...so this check for whether value is NULL can never be true.
>=20
> > +            *value =3D g_renew(char, *value, capacity + length + 1);
> > +            strncpy(*value + capacity, p, length);
> > +            (*value)[capacity + length] =3D '\0';
> > +        }
> > +        capacity +=3D length;
> > +        if (*offset =3D=3D '\0' ||
> > +            *(offset + 1) !=3D ',') {
> > +            break;
> >          }
> > -        if (q && (q - buf) < buf_size - 1)
> > -            *q++ =3D *p;
> > -        p++;
> > +
> > +        p +=3D (offset - p) + 2;
> >      }
> > -    if (q)
> > -        *q =3D '\0';
> >
> > -    return p;
> > +    return offset;
> >  }
> >
>=20
> thanks
> -- PMM
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
