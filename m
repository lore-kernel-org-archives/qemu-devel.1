Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tRD-00026c-3H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tRB-0001Zg-Ut
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:35:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5tRB-0001ZL-LY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:35:53 -0400
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63211daf-4cda-163c-cb45-6fa3ac7e3cc5@redhat.com>
Date: Tue, 10 Apr 2018 08:35:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180410124913.10832-2-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WChXwIFnmQYtnKG69rLLje2tNq8wBckO5"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-thread: always keep the posix
 wrapper layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WChXwIFnmQYtnKG69rLLje2tNq8wBckO5
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <63211daf-4cda-163c-cb45-6fa3ac7e3cc5@redhat.com>
Subject: Re: [PATCH 1/2] qemu-thread: always keep the posix wrapper layer
References: <20180410124913.10832-1-peterx@redhat.com>
 <20180410124913.10832-2-peterx@redhat.com>
In-Reply-To: <20180410124913.10832-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 07:49 AM, Peter Xu wrote:
> We will conditionally have a wrapper layer depending on whether the hos=
t
> has the PTHREAD_SETNAME capability.  It complicates stuff.  Let's just
> keep the wrapper there, meanwhile we opt out the pthread_setname_np()
> call only.  The layer can be helpful in future patches to pass data fro=
m
> the parent thread to the child thread.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  util/qemu-thread-posix.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>=20
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index b789cf32e9..3ae96210d6 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -482,7 +482,6 @@ static void __attribute__((constructor)) qemu_threa=
d_atexit_init(void)
>  }
> =20

More context:

static bool name_threads;

void qemu_thread_naming(bool enable)
{
    name_threads =3D enable;

#ifndef CONFIG_THREAD_SETNAME_BYTHREAD
    /* This is a debugging option, not fatal */
    if (enable) {
        fprintf(stderr, "qemu: thread naming not supported on this host\n=
");
    }
#endif
}


> =20
> -#ifdef CONFIG_PTHREAD_SETNAME_NP

Why are we using CONFIG_THREAD_SETNAME_BYTHREAD in one place, and
CONFIG_PTHREAD_SETNAME_NP in another?

/me checks configure - oh:

# Hold two types of flag:
#   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name=
 on
#                                     a thread we have a handle to
#   CONFIG_PTHREAD_SETNAME_NP       - A way of doing it on a particular
#                                     platform

even though, right now, we only either set both flags at once or leave
both clear, since we don't (yet?) have any other platform-specific ways
to do it.

>  typedef struct {
>      void *(*start_routine)(void *);
>      void *arg;
> @@ -498,13 +497,15 @@ static void *qemu_thread_start(void *args)
>      /* Attempt to set the threads name; note that this is for debug, s=
o
>       * we're not going to fail if we can't set it.
>       */
> -    pthread_setname_np(pthread_self(), qemu_thread_args->name);
> +#ifdef CONFIG_PTHREAD_SETNAME_NP
> +    if (qemu_thread_args->name) {
> +        pthread_setname_np(pthread_self(), qemu_thread_args->name);

Post-patch, this (attempts to) set the thread name if a non-NULL name is
present...


> =20
> -#ifdef CONFIG_PTHREAD_SETNAME_NP
> -    if (name_threads) {
> -        QemuThreadArgs *qemu_thread_args;
> -        qemu_thread_args =3D g_new0(QemuThreadArgs, 1);
> -        qemu_thread_args->name =3D g_strdup(name);

=2E..but pre-patch, qemu_thread_args->name was left NULL unless
name_threads was true, because someone had called
qemu_thread_naming(true)...

> -        qemu_thread_args->start_routine =3D start_routine;
> -        qemu_thread_args->arg =3D arg;
> -
> -        err =3D pthread_create(&thread->thread, &attr,
> -                             qemu_thread_start, qemu_thread_args);
> -    } else
> -#endif
> -    {
> -        err =3D pthread_create(&thread->thread, &attr,
> -                             start_routine, arg);
> -    }
> +    qemu_thread_args =3D g_new0(QemuThreadArgs, 1);
> +    qemu_thread_args->name =3D g_strdup(name);

=2E..so you have changed semantics - you are now unconditionally trying t=
o
set the thread name, instead of honoring qemu_thread_naming().  Do we
still need qemu_thread_naming() (tied to opt debug-threads)?

You need to either fix your code to remain conditional on whether
name_threads is set, or document the semantic change as intentional in
the commit message.

However, the idea for refactoring to always use the shim makes sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WChXwIFnmQYtnKG69rLLje2tNq8wBckO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMvawACgkQp6FrSiUn
Q2ppLwf8CFqlO8B9PDwUiU0KQw4rf7k5OnJcXP14Jf8i/ktP8Pd5zitoRat0ad2O
ec5ohvRayEw8caYuYG444X4K0jk44TXNO8nsrgXWIR0hbuwMaJXZHrphOqEWmodF
hEFQH+OYc73FdNNput94YzsU39+u5YjZZncHzpCgHZH38H7YlX868X/taF43ml4v
mbmFPJRYHYb/2Xgv0x4sSuIxXfwCjoDPvbI6iktmbI/qOBM8r/kRYlUP+CXQFwYg
vzo7H+4sj3m65ajHHIqVdGUazp6rsiS/3leD2lclw5SH2q5nEIQjRJ1fdXweMq/e
LQgIFKAgk36YAZuvvzT/tFMkC/DZKA==
=GJ7P
-----END PGP SIGNATURE-----

--WChXwIFnmQYtnKG69rLLje2tNq8wBckO5--
