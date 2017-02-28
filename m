Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cif7V-0004S4-2x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cif7U-0000aw-1O
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:35:01 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cif7T-0000Zp-Mu
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:34:59 -0500
Received: by mail-lf0-x242.google.com with SMTP id r36so660885lfi.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 02:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-6-marcandre.lureau@redhat.com>
	<62892df9-9e1e-8e4c-c4f0-f3c6cf0422c7@redhat.com>
In-Reply-To: <62892df9-9e1e-8e4c-c4f0-f3c6cf0422c7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Feb 2017 10:34:46 +0000
Message-ID: <CAJ+F1CKV9VUn9ahM6w6rSOGd8dMdX+4UZU7kPAU_-1MdgafyCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/21] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, Feb 27, 2017 at 8:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 27/02/2017 14:41, Marc-Andr=C3=A9 Lureau wrote:
> >
> > -    chr =3D CHARDEV(object_new(typename));
> > +    if (id) {
> > +        obj =3D object_new_with_props(typename, get_chardevs_root(),
> > +                                    id, &local_err, NULL);
> > +    } else {
> > +        obj =3D object_new(typename);
> > +    }
>
> I think you should open code object_new_with_props.  This can be just
> object_new(typename)...
>
>
Yes, it simplies things. Done. Any other remark about the rest of the
series? probably not worth a resend yet.

thanks


> > +    if (local_err) {
> > +        assert(!obj);
> > +        goto end;
> > +    }
> > +
> > +    chr =3D CHARDEV(obj);
> >      chr->label =3D g_strdup(id);
> >
> >      qemu_char_open(chr, backend, &be_opened, &local_err);
> >      if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        object_unref(OBJECT(chr));
> > -        return NULL;
> > +        goto end;
> >      }
> >
> >      if (!chr->filename) {
> > @@ -1250,6 +1263,18 @@ Chardev *qemu_chardev_new(const char *id, const
> char *typename,
> >          qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> >      }
> >
> > +end:
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        if (chr) {
> > +            if (id) {
> > +                object_unparent(OBJECT(chr));
> > +            } else {
> > +                object_unref(OBJECT(chr));
> > +            }
>
> Then here you do not have a parent object and you can do only unref...
>
> > +        }
> > +        return NULL;
> > +    }
>
> ... while here you do the object_property_add_child+object_unref.  The
> object_property_add_child keeps the object alive, while object_unref
> drops the reference originally returned by object_new.
>
> Paolo
>
> --
Marc-Andr=C3=A9 Lureau
