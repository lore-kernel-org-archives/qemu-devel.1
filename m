Received: from eggs.gnu.org ([2001:4830:134:3::10]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU96-0006rS-3b
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU91-0004CB-0z
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:21:56 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLU90-0003CG-J0
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:21:50 -0500
Date: Sat, 10 Nov 2018 15:21:10 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181110142110.ric56fw4dpsd22xq@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181110134548.14741-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 02/13] slirp: remove do_pty from
 fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:37 +0400, a ecrit:
> QEMU uses fork_exec() with do_pty values 0 or 3.
> Let's clean up some unused code.

Applied to my tree, thanks!

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/misc.h     |  2 +-
>  slirp/misc.c     | 55 ++++++++++++++----------------------------------
>  slirp/tcp_subr.c |  2 +-
>  3 files changed, 18 insertions(+), 41 deletions(-)
>=20
> diff --git a/slirp/misc.h b/slirp/misc.h
> index 5211bbd30a..897650aea1 100644
> --- a/slirp/misc.h
> +++ b/slirp/misc.h
> @@ -53,6 +53,6 @@ struct slirp_quehead {
>  void slirp_insque(void *, void *);
>  void slirp_remque(void *);
>  int add_exec(struct ex_list **, int, char *, struct in_addr, int);
> -int fork_exec(struct socket *so, const char *ex, int do_pty);
> +int fork_exec(struct socket *so, const char *ex);
> =20
>  #endif
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 260187b6b6..ec5d5ec073 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -63,7 +63,7 @@ int add_exec(struct ex_list **ex_ptr, int do_pty, cha=
r *exec,
>  #ifdef _WIN32
> =20
>  int
> -fork_exec(struct socket *so, const char *ex, int do_pty)
> +fork_exec(struct socket *so, const char *ex)
>  {
>      /* not implemented */
>      return 0;
> @@ -77,13 +77,9 @@ fork_exec(struct socket *so, const char *ex, int do_=
pty)
>   * process, which connects to this socket, after which we
>   * exec the wanted program.  If something (strange) happens,
>   * the accept() call could block us forever.
> - *
> - * do_pty =3D 0   Fork/exec inetd style
> - * do_pty =3D 1   Fork/exec using slirp.telnetd
> - * do_ptr =3D 2   Fork/exec using pty
>   */
>  int
> -fork_exec(struct socket *so, const char *ex, int do_pty)
> +fork_exec(struct socket *so, const char *ex)
>  {
>  	int s;
>  	struct sockaddr_in addr;
> @@ -99,26 +95,20 @@ fork_exec(struct socket *so, const char *ex, int do=
_pty)
>  	DEBUG_CALL("fork_exec");
>  	DEBUG_ARG("so =3D %p", so);
>  	DEBUG_ARG("ex =3D %p", ex);
> -	DEBUG_ARG("do_pty =3D %x", do_pty);
> -
> -	if (do_pty =3D=3D 2) {
> -                return 0;
> -	} else {
> -		addr.sin_family =3D AF_INET;
> -		addr.sin_port =3D 0;
> -		addr.sin_addr.s_addr =3D INADDR_ANY;
> =20
> -		if ((s =3D qemu_socket(AF_INET, SOCK_STREAM, 0)) < 0 ||
> -		    bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
> -		    listen(s, 1) < 0) {
> -			error_report("Error: inet socket: %s", strerror(errno));
> -			if (s >=3D 0) {
> -			    closesocket(s);
> -			}
> +    addr.sin_family =3D AF_INET;
> +    addr.sin_port =3D 0;
> +    addr.sin_addr.s_addr =3D INADDR_ANY;
> =20
> -			return 0;
> -		}
> -	}
> +    s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
> +    if (s < 0 || bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
> +        listen(s, 1) < 0) {
> +        error_report("Error: inet socket: %s", strerror(errno));
> +        if (s >=3D 0) {
> +            closesocket(s);
> +        }
> +        return 0;
> +    }
> =20
>  	pid =3D fork();
>  	switch(pid) {
> @@ -151,13 +141,7 @@ fork_exec(struct socket *so, const char *ex, int d=
o_pty)
> =20
>  		i =3D 0;
>  		bptr =3D g_strdup(ex); /* No need to free() this */
> -		if (do_pty =3D=3D 1) {
> -			/* Setup "slirp.telnetd -x" */
> -			argv[i++] =3D "slirp.telnetd";
> -			argv[i++] =3D "-x";
> -			argv[i++] =3D bptr;
> -		} else
> -		   do {
> +        do {
>  			/* Change the string into argv[] */
>  			curarg =3D bptr;
>  			while (*bptr !=3D ' ' && *bptr !=3D (char)0)
> @@ -165,7 +149,7 @@ fork_exec(struct socket *so, const char *ex, int do=
_pty)
>  			c =3D *bptr;
>  			*bptr++ =3D (char)0;
>  			argv[i++] =3D g_strdup(curarg);
> -		   } while (c);
> +        } while (c);
> =20
>                  argv[i] =3D NULL;
>  		execvp(argv[0], (char **)argv);
> @@ -193,13 +177,6 @@ fork_exec(struct socket *so, const char *ex, int d=
o_pty)
>                  opt =3D 1;
>                  qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt,=
 sizeof(int));
>  		qemu_set_nonblock(so->s);
> -
> -		/* Append the telnet options now */
> -                if (so->so_m !=3D NULL && do_pty =3D=3D 1)  {
> -			sbappend(so, so->so_m);
> -                        so->so_m =3D NULL;
> -		}
> -
>  		return 1;
>  	}
>  }
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index 8d0f94b75f..a82efe78d7 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -973,7 +973,7 @@ int tcp_ctl(struct socket *so)
>                  }
>                  do_pty =3D ex_ptr->ex_pty;
>                  DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
> -                return fork_exec(so, ex_ptr->ex_exec, do_pty);
> +                return fork_exec(so, ex_ptr->ex_exec);
>              }
>          }
>      }
> --=20
> 2.19.1.708.g4ede3d42df
>=20

--=20
Samuel
gawk; talk; nice; date; wine; grep; touch; unzip; strip;  \
touch; gasp; finger; gasp; lyx; gasp; latex; mount; fsck; \
more; yes; gasp; umount; make clean; make mrproper; sleep
