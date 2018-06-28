Received: from eggs.gnu.org ([2001:4830:134:3::10]:37467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYVwW-00077k-UH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYVwT-0003sL-57
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:22:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYVwS-0003rv-Ud
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A832A3ED9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:22:28 +0000 (UTC)
Date: Thu, 28 Jun 2018 13:22:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628122224.GH3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625101216.GE18277@paraplu>
	<87y3ez150t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3ez150t.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RNG: Any reason QEMU doesn't default to
 `/dev/urandom`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, dgilbert@redhat.com

On Thu, Jun 28, 2018 at 02:15:14PM +0200, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
>=20
> > QEMU still defaults to /dev/random as entropy source.  Any reason why
> > not default to /dev/urandom?
> >
> > The other day Dan Berrang=C3=A9 explained elsewhere that /dev/urandom=
 is
> > recommended -- as it is non-blocking; and doesn't have the same
> > limitations of /dev/random, which is a legacy interface.  (And other
> > applications[*] are any way overriding the QEMU default to
> > /dev/urandom.)
> >
> > `random(4)` says the following about the blocking nature of /dev/rand=
om:
> >
> >        The /dev/random device is a legacy interface which dates back =
to
> >        a time where the cryptographic primitives used in the
> >        implementation of /dev/urandom were not widely trusted.  It wi=
ll
> >        return random bytes only within the estimated number of bits o=
f
> >        fresh noise in the entropy pool, blocking if necessary.
> >        /dev/random is suitable for applications  that  need high qual=
ity
> >        randomness, and can afford indeterminate delays.
> >
> > And its "Usage" section says:
> >
> >        The  /dev/random  interface is considered a legacy interface, =
and
> >        /dev/urandom is preferred and sufficient in all use cases, wit=
h
> >        the exception of applications which require ran=E2=80=90 domne=
ss during
> >        early boot time; for these applications, getrandom(2) must be
> >        used instead, because it will block until the entropy pool is
> >        initialized.
> >
> >        If a seed file is saved across reboots as recommended below (a=
ll
> >        major Linux distributions have done this since 2000 at least),
> >        the output  is  cryptographically  secure  against attackers
> >        without local root access as soon as it is reloaded in the boo=
t
> >        sequence, and perfectly adequate for network encryption sessio=
n
> >        keys.  Since reads from /dev/random may block, users will usua=
lly
> >        want to open it in nonblocking mode (or perform a read with
> >        timeout), and provide some sort of user notification if the
> >        desired entropy is  not  immedi=E2=80=90 ately available.
> >
> > [*] E.g. libguestfs:
> >     https://github.com/libguestfs/libguestfs/blob/master/lib/launch-d=
irect.c#L592
>=20
> There's also getrandom(2).
>=20
> See random(7) for a comparison between getrandom(), /dev/urandom,
> /dev/random.
>=20
> As you wrote, Linux's /dev/random blocks when the kernel entropy pool
> has been depleted, while /dev/urandom doesn't.  There are systems where
> both devices behave exactly the same, or only /dev/random exists.
> Trying /dev/urandom first, and /dev/random as fallback is simple and
> works okay across a wide range of hosts.  That said, getrandom(2) or
> getentropy(3) are even nicer when available.
>=20
> I can see two uses of /dev/random in QEMU outside tests:
>=20
> * crypto/random-platform.c
>=20
>     int qcrypto_random_init(Error **errp)
>     {
>     #ifndef _WIN32
>         /* TBD perhaps also add support for BSD getentropy / Linux
>          * getrandom syscalls directly */
>         fd =3D open("/dev/urandom", O_RDONLY);
>         if (fd =3D=3D -1 && errno =3D=3D ENOENT) {
>             fd =3D open("/dev/random", O_RDONLY);
>         }
>=20
>         if (fd < 0) {
>             error_setg(errp, "No /dev/urandom or /dev/random found");
>             return -1;
>         }
>     #else
>     [...]
>     #endif
>=20
>         return 0;
>     }
>=20
>   Looks good to me.  Resolving the TBD would be nice.

FYI, crypto/random-platform.c will only ever get used if neither GNUTLS
or GCrypt are available. So while I agree it would be nice to have a
getrandom() impl, in practice it wouldn't be used, as we'll prefer the
gcrypt/gnutls RNGs (which in turn usually use /dev/random or getrandom(),
long with a crypto routine on top).

>=20
> * backends/rng-random.c
>=20
>     static void rng_random_init(Object *obj)
>     {
>         RngRandom *s =3D RNG_RANDOM(obj);
>=20
>         object_property_add_str(obj, "filename",
>                                 rng_random_get_filename,
>                                 rng_random_set_filename,
>                                 NULL);
>=20
>         s->filename =3D g_strdup("/dev/random");
>         s->fd =3D -1;
>     }
>=20
>    This is TYPE_RNG_RANDOM's instance_init() method.  Doesn't look so
>    good, but it's "only" a default.
>=20
>    What TYPE_RNG_RANDOM's intended use?  The manual suggests "backend
>    for virtio-rng":
>=20
>     @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
>=20
>     Creates a random number generator backend which obtains entropy fro=
m
>     a device on the host. The @option{id} parameter is a unique ID that
>     will be used to reference this entropy backend from the @option{vir=
tio-rng}
>     device. The @option{filename} parameter specifies which file to obt=
ain
>     entropy from and if omitted defaults to @option{/dev/random}.
>=20
> Regardless of other considerations, duplicating something as hairy as
> getting high-quality random numbers from the host in a portable manner
> is a Bad Idea.

We could change semantics so that when 'filename' is not given, we defaul=
t
to using the qcrypto_random_bytes API. It would, however, mean we would
be pulling random bytes via gnutls in most deployments. This is still
secure of course, since gnults provides cryptographically strong bytes.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
