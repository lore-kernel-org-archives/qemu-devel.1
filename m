Received: from eggs.gnu.org ([2001:4830:134:3::10]:47089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f879g-0000wR-2n
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f879d-0006Em-FL
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:39:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f879d-0006EW-AD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:38:57 -0400
Date: Mon, 16 Apr 2018 17:38:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416163839.GC17600@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
	<87muy3m7uy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muy3m7uy.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 16, 2018 at 06:30:45PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > A user trying out SMBIOS "OEM strings" feature reported that the data
> > they are exposing to the guest was truncated at 1023 bytes, which bre=
aks
> > the app consuming in the guest. After searching for the cause I
> > eventually found that the QemuOpts parsing is using fixed length 1024
> > byte array for option values and 128 byte array for key names.
> >
> > We can certainly debate whether it is sane to have such long command
> > line argument values (it is not sane), but if the OS was capable of
> > exec'ing QEMU with such an ARGV array, there is little good reason fo=
r
> > imposing an artificial length restriction when parsing it. Even worse=
 is
> > that we silently truncate without reporting an error when hitting lim=
its
> > resulting in a semantically incorrect behaviour, possibly even leadin=
g
> > to security flaws depending on the data that was truncated.
> >
> > Thus this patch series removes the artificial length limits by killin=
g
> > the fixed length buffers.
> >
> > Separately I intend to make it possible to read "OEM strings" data fr=
om
> > a file, to avoid need to have long command line args.
>=20
> Too bad I haven't been able to complete my quest to kill QemuOpts.
>=20
> As far as I know, keyval.c's only arbitrary limit is the length of a ke=
y
> fragment (the things separated by '.').

Looks like that's the same scenario I tried to address in patch 2. The
'key' part in QemuOpts has the same 128 byte limit as in the keyval.c
code. I fear that could be hit with -blockdev when setting params on
very deeply nested block backends.  On the plus side  keyval.c actually
reports an error when it hits its 128 byte limit, instead of silently
carrying on as if all was well like QemuOpts did :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
