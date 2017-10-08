Received: from eggs.gnu.org ([2001:4830:134:3::10]:49458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1e1JwV-0006Mf-MK
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 18:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1e1JwU-0005B2-Uk
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 18:21:03 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:46605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1e1JwU-0005AL-KK
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 18:21:02 -0400
Date: Mon, 9 Oct 2017 00:20:58 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171008222058.3ngrwgadmhyucekf@var.youpi.perso.aquilenet.fr>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-37-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006235023.11952-37-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 36/88] SLIRP: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Hello,

Philippe Mathieu-Daud=C3=A9, on ven. 06 oct. 2017 20:49:31 -0300, wrote:
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -869,7 +869,7 @@ net_init_slirp_configs(const StringList *fwd, int f=
lags)
>      while (fwd) {
>          struct slirp_config_str *config;
> =20
> -        config =3D g_malloc0(sizeof(*config));
> +        config =3D g_new0(struct slirp_config_str, 1);

It doesn't really seem like an improvement to me in such case: we don't
have overflow issues here, and using sizeof(*config) makes the line
clearly correct, while expliciting the struct behind means we need to
make sure of the coherency.

> diff --git a/slirp/socket.c b/slirp/socket.c
> index cb7b5b608d..2eccb68c2e 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -48,7 +48,7 @@ socreate(Slirp *slirp)
>  {
>    struct socket *so;
> =20
> -  so =3D (struct socket *)malloc(sizeof(struct socket));
> +  so =3D g_new(struct socket, 1);

Similarly, here I'd rather write g_malloc(sizeof(*so));

Samuel
