Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYVpW-0001z8-38
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYVpU-0003TY-7n
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYVpU-0003So-2B
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B218640255D7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:15:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180625101216.GE18277@paraplu>
Date: Thu, 28 Jun 2018 14:15:14 +0200
In-Reply-To: <20180625101216.GE18277@paraplu> (Kashyap Chamarthy's message of
	"Mon, 25 Jun 2018 12:12:16 +0200")
Message-ID: <87y3ez150t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, dgilbert@redhat.com, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

Kashyap Chamarthy <kchamart@redhat.com> writes:

> QEMU still defaults to /dev/random as entropy source.  Any reason why
> not default to /dev/urandom?
>
> The other day Dan Berrang=C3=A9 explained elsewhere that /dev/urandom is
> recommended -- as it is non-blocking; and doesn't have the same
> limitations of /dev/random, which is a legacy interface.  (And other
> applications[*] are any way overriding the QEMU default to
> /dev/urandom.)
>
> `random(4)` says the following about the blocking nature of /dev/random:
>
>        The /dev/random device is a legacy interface which dates back to
>        a time where the cryptographic primitives used in the
>        implementation of /dev/urandom were not widely trusted.  It will
>        return random bytes only within the estimated number of bits of
>        fresh noise in the entropy pool, blocking if necessary.
>        /dev/random is suitable for applications  that  need high quality
>        randomness, and can afford indeterminate delays.
>
> And its "Usage" section says:
>
>        The  /dev/random  interface is considered a legacy interface, and
>        /dev/urandom is preferred and sufficient in all use cases, with
>        the exception of applications which require ran=E2=80=90 domness d=
uring
>        early boot time; for these applications, getrandom(2) must be
>        used instead, because it will block until the entropy pool is
>        initialized.
>
>        If a seed file is saved across reboots as recommended below (all
>        major Linux distributions have done this since 2000 at least),
>        the output  is  cryptographically  secure  against attackers
>        without local root access as soon as it is reloaded in the boot
>        sequence, and perfectly adequate for network encryption session
>        keys.  Since reads from /dev/random may block, users will usually
>        want to open it in nonblocking mode (or perform a read with
>        timeout), and provide some sort of user notification if the
>        desired entropy is  not  immedi=E2=80=90 ately available.
>
> [*] E.g. libguestfs:
>     https://github.com/libguestfs/libguestfs/blob/master/lib/launch-direc=
t.c#L592

There's also getrandom(2).

See random(7) for a comparison between getrandom(), /dev/urandom,
/dev/random.

As you wrote, Linux's /dev/random blocks when the kernel entropy pool
has been depleted, while /dev/urandom doesn't.  There are systems where
both devices behave exactly the same, or only /dev/random exists.
Trying /dev/urandom first, and /dev/random as fallback is simple and
works okay across a wide range of hosts.  That said, getrandom(2) or
getentropy(3) are even nicer when available.

I can see two uses of /dev/random in QEMU outside tests:

* crypto/random-platform.c

    int qcrypto_random_init(Error **errp)
    {
    #ifndef _WIN32
        /* TBD perhaps also add support for BSD getentropy / Linux
         * getrandom syscalls directly */
        fd =3D open("/dev/urandom", O_RDONLY);
        if (fd =3D=3D -1 && errno =3D=3D ENOENT) {
            fd =3D open("/dev/random", O_RDONLY);
        }

        if (fd < 0) {
            error_setg(errp, "No /dev/urandom or /dev/random found");
            return -1;
        }
    #else
    [...]
    #endif

        return 0;
    }

  Looks good to me.  Resolving the TBD would be nice.

* backends/rng-random.c

    static void rng_random_init(Object *obj)
    {
        RngRandom *s =3D RNG_RANDOM(obj);

        object_property_add_str(obj, "filename",
                                rng_random_get_filename,
                                rng_random_set_filename,
                                NULL);

        s->filename =3D g_strdup("/dev/random");
        s->fd =3D -1;
    }

   This is TYPE_RNG_RANDOM's instance_init() method.  Doesn't look so
   good, but it's "only" a default.

   What TYPE_RNG_RANDOM's intended use?  The manual suggests "backend
   for virtio-rng":

    @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}

    Creates a random number generator backend which obtains entropy from
    a device on the host. The @option{id} parameter is a unique ID that
    will be used to reference this entropy backend from the @option{virtio-=
rng}
    device. The @option{filename} parameter specifies which file to obtain
    entropy from and if omitted defaults to @option{/dev/random}.

Regardless of other considerations, duplicating something as hairy as
getting high-quality random numbers from the host in a portable manner
is a Bad Idea.
