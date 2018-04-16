Received: from eggs.gnu.org ([2001:4830:134:3::10]:42001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f894x-00013s-Jv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f894u-0002jI-G2
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f894u-0002ii-BK
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:42:12 -0400
Date: Mon, 16 Apr 2018 19:42:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416184200.GB14488@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
	<87muy3m7uy.fsf@dusky.pond.sub.org>
	<20180416163839.GC17600@redhat.com>
	<87lgdnkoix.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgdnkoix.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Remove artificial length limits when
 parsing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 16, 2018 at 08:13:42PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, Apr 16, 2018 at 06:30:45PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>=20
> >> > A user trying out SMBIOS "OEM strings" feature reported that the d=
ata
> >> > they are exposing to the guest was truncated at 1023 bytes, which =
breaks
> >> > the app consuming in the guest. After searching for the cause I
> >> > eventually found that the QemuOpts parsing is using fixed length 1=
024
> >> > byte array for option values and 128 byte array for key names.
> >> >
> >> > We can certainly debate whether it is sane to have such long comma=
nd
> >> > line argument values (it is not sane), but if the OS was capable o=
f
> >> > exec'ing QEMU with such an ARGV array, there is little good reason=
 for
> >> > imposing an artificial length restriction when parsing it. Even wo=
rse is
> >> > that we silently truncate without reporting an error when hitting =
limits
> >> > resulting in a semantically incorrect behaviour, possibly even lea=
ding
> >> > to security flaws depending on the data that was truncated.
> >> >
> >> > Thus this patch series removes the artificial length limits by kil=
ling
> >> > the fixed length buffers.
> >> >
> >> > Separately I intend to make it possible to read "OEM strings" data=
 from
> >> > a file, to avoid need to have long command line args.
> >>=20
> >> Too bad I haven't been able to complete my quest to kill QemuOpts.
> >>=20
> >> As far as I know, keyval.c's only arbitrary limit is the length of a=
 key
> >> fragment (the things separated by '.').
> >
> > Looks like that's the same scenario I tried to address in patch 2. Th=
e
> > 'key' part in QemuOpts has the same 128 byte limit as in the keyval.c
> > code. I fear that could be hit with -blockdev when setting params on
> > very deeply nested block backends.  On the plus side  keyval.c actual=
ly
> > reports an error when it hits its 128 byte limit, instead of silently
> > carrying on as if all was well like QemuOpts did :-)
>=20
> In keyval.c, the key (things like "a.b.c") can be arbitrarily long
> (well, until g_malloc() throws in the towel), but each key fragment
> ("a", "b" and "c") is limited to 128 bytes.
>=20
> If key length was limited there, I would've asked you to fix it there,
> too.

Agreed, if only fragments are limited, that's fine because we know that
no code ever declares a key long enough to exceed the individual fragment
size.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
