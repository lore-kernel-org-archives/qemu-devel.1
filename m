Received: from eggs.gnu.org ([209.51.188.92]:49878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGQeV-0007KJ-39
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGQeT-0006WV-M4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGQeT-0006W3-9R
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:09:41 -0400
Date: Tue, 16 Apr 2019 17:09:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190416160927.GT31311@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190415141547.15444-1-berrange@redhat.com>
	<87a7gq75l6.fsf@dusky.pond.sub.org>
	<20190416090358.GF31311@redhat.com>
	<87zhoq3pn9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhoq3pn9.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Apr 16, 2019 at 06:01:46PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Tue, Apr 16, 2019 at 09:49:09AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > The main thing I can see would be filenames.
> >
> > Though having said it is UTF-8 on looking more closely I think QEMU i=
s
> > probably 8-bit clean in its handling, so will just be blindly passing
> > whatever filename string it get from libvirt straight on to the kerne=
l
> > with no interpretation.
>=20
> Sounds good to me.
>=20
> > Libvirt has enabled UTF-8 validation in its JSON library when encodin=
g
> > data it sends to QEMU, so any data libvirt is sending will be a valid
> > UTF-8 byte sequence at least. Libvirt doesn't axctually do any charse=
t
> > conversion though, so if libvirt runs in a non-UTF8 locale it will
> > likely trip over this UTF-8 validation.
>=20
> QMP input must be encoded in UTF-8.  Converting from other encodings to
> UTF-8 is the QMP client's problem.

Ok, so consider the host OS is globally running in a non-UTF-8 locale
such as ISO8859-1. This means that any multibyte filenames in the
filesystem are assumed to be in ISO8859-1  encoding.

Since QMP input must be UTF-8, libvirt must convert the filename
from the current locale (ISO8859-1) to UTF-8 otherwise it might
be putting an invalid UTF-8 sequence in the JSON.

For QEMU to be able to open the file, QEMU must be honouring the
host OS LC_CTYPE, and converting from UTF-8 back to LC_CTYPE
character set.

>=20
> The more interesting direction is the one I inquired about: QMP output.
> If locale-dependent text gets sent to QMP, converting it to UTF-8 is
> QEMU's problem.
>=20
> On closer look, anything but JSON string contents is plain ASCII by
> construction.  JSON string contents gets assembled in to_json() case
> QTYPE_QSTRING.  It expects QString to use UTF-8[*].  You can have any
> locale as long as it uses ASCII or UTF-8.

IOW

>=20
> >> > +     *
> >> > +     *   - Lots of codes uses is{upper,lower,alnum,...} functions=
, expecting
> >> > +     *     C locale sorting behaviour. Most QEMU usage should lik=
ely be
> >> > +     *     changed to g_ascii_is{upper,lower,alnum...} to match c=
ode
> >> > +     *     assumptions, without being broken by locale settnigs.
> >> > +     *
> >> > +     * We do still have two requirements
> >> > +     *
> >> > +     *   - Ability to correct display translated text according t=
o the
> >> > +     *     user's locale
> >> > +     *
> >> > +     *   - Ability to handle multibyte characters, ideally accord=
ing to
> >> > +     *     user's locale specified character set. This affects ab=
ility
> >> > +     *     of usb-mtp to correctly convert filenames to UCS16 and=
 curses
> >> > +     *     & GTK frontends wide character display.
> >> > +     *
> >> > +     * The second requirement would need LC_CTYPE to be honoured,=
 but
> >> > +     * this conflicts with the 2nd & 3rd problems listed earlier.=
 For
> >> > +     * now we make a tradeoff, trying to set an explicit UTF-8 lo=
calee
> >> > +     *
> >> > +     * Note we can't set LC_MESSAGES here, since mingw doesn't de=
fine
> >> > +     * this constant in locale.h Fortunately we only need it for =
the
> >> > +     * GTK frontend and that uses gi18n.h which pulls in a defini=
tion
> >> > +     * of LC_MESSAGES.
> >> > +     */
> >> > +    setlocale(LC_CTYPE, "C.UTF-8");
> >> > +
> >> >      module_call_init(MODULE_INIT_TRACE);
> >> > =20
> >> >      qemu_init_cpu_list();
> >>=20
> >> We should've stayed out of the GUI business.
> >
> > This isn't only a GUI problem as above, it affects USB MTP.
>=20
> I believe setlocale() in QEMU is basically wrong.  Finding all the
> places that rely on the current locale when they shouldn't and
> converting them to locale-independent alternatives is a huge amount of
> work.  Even if we managed to complete it, it wouldn't stay complete.
>=20
> Instead, find the places that have reason to use the locale, and fix
> them to uselocale().

I think that's fundamentally the wrong way around. Most stuff *should*
be locale dependant, otherwise any interaction with the host OS is
likely to use incorrect localization. It isn't practical to put a
uselocale() call around every place that opens a filename. There are
a few places where QEMU should be locale indepandant such as the QMP
and guest OS ABI sensitive things, which should take account of it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
