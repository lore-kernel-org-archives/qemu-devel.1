Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMw4E-0004QW-F2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMw4A-0000dX-Ft
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:22:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMw45-0000XE-8P
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:22:46 -0500
Date: Wed, 14 Nov 2018 14:22:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114142234.GJ19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 03/41] slirp: simplify fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On Wed, Nov 14, 2018 at 04:36:05PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Use g_spawn_async_with_fds() to setup the child.
>=20
> GSpawn handles reaping the child, and closing parent file descriptors.

The g_spawn* family of APIs is portable to Win32, which the current
fork/exec code in slirp is not.

So I'm curious if this conversion is sufficient to make this part
of slirp work on Win32, or if further portability problems remain.
If it does work on Win32, then you can also delete the stub
fork_exec() impl the code currently has.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/misc.c | 75 +++++++++++++++++++++++++---------------------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
>=20
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 7362e14339..7972b9b05b 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -129,56 +129,53 @@ err:
>      return -1;
>  }
> =20
> +static void
> +fork_exec_child_setup(gpointer data)
> +{
> +    setsid();
> +}
> +
>  int
>  fork_exec(struct socket *so, const char *ex)
>  {
> -	char **argv;
> -	int opt, c, sp[2];
> -	pid_t pid;
> +    GError *err =3D NULL;
> +    char **argv;
> +    int opt, sp[2];
> =20
> -	DEBUG_CALL("fork_exec");
> -	DEBUG_ARG("so =3D %p", so);
> -	DEBUG_ARG("ex =3D %p", ex);
> +    DEBUG_CALL("fork_exec");
> +    DEBUG_ARG("so =3D %p", so);
> +    DEBUG_ARG("ex =3D %p", ex);
> =20
>      if (slirp_socketpair_with_oob(sp) < 0) {
>          return 0;
>      }
> =20
> -	pid =3D fork();
> -	switch(pid) {
> -	 case -1:
> -		error_report("Error: fork failed: %s", strerror(errno));
> -		closesocket(sp[0]);
> -		closesocket(sp[1]);
> -		return 0;
> -
> -	 case 0:
> -		setsid();
> -		dup2(sp[1], 0);
> -		dup2(sp[1], 1);
> -		dup2(sp[1], 2);
> -		for (c =3D getdtablesize() - 1; c >=3D 3; c--)
> -		   close(c);
> +    argv =3D g_strsplit(ex, " ", -1);
> +    g_spawn_async_with_fds(NULL /* cwd */,
> +                           argv,
> +                           NULL /* env */,
> +                           G_SPAWN_SEARCH_PATH,
> +                           fork_exec_child_setup, NULL /* data */,
> +                           NULL /* child_pid */,
> +                           sp[1], sp[1], sp[1],
> +                           &err);
> +    g_strfreev(argv);
> =20
> -                argv =3D g_strsplit(ex, " ", -1);
> -		execvp(argv[0], (char **)argv);
> -
> -		/* Ooops, failed, let's tell the user why */
> -        fprintf(stderr, "Error: execvp of %s failed: %s\n",
> -                argv[0], strerror(errno));
> -		close(0); close(1); close(2); /* XXX */
> -		exit(1);
> +    if (err) {
> +        error_report("%s", err->message);
> +        g_error_free(err);
> +        closesocket(sp[0]);
> +        closesocket(sp[1]);
> +        return 0;
> +    }
> =20
> -	 default:
> -		so->s =3D sp[0];
> -		closesocket(sp[1]);
> -		qemu_add_child_watch(pid);
> -		socket_set_fast_reuse(so->s);
> -		opt =3D 1;
> -		qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
> -		qemu_set_nonblock(so->s);
> -		return 1;
> -	}
> +    so->s =3D sp[0];
> +    closesocket(sp[1]);
> +    socket_set_fast_reuse(so->s);
> +    opt =3D 1;
> +    qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int)=
);
> +    qemu_set_nonblock(so->s);
> +    return 1;
>  }
>  #endif
> =20
> --=20
> 2.19.1.708.g4ede3d42df
>=20
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
