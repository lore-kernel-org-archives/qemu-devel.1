Received: from eggs.gnu.org ([2001:4830:134:3::10]:52335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOg3k-0005tp-At
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOg3f-0004kV-CB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:09:20 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOg3f-0004k4-51
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:09:15 -0400
Received: from player711.ha.ovh.net (unknown [10.109.105.37])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8081F19451
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 11:09:13 +0200 (CEST)
Date: Fri, 1 Jun 2018 11:09:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601110910.66545ea2@bahia.lan>
In-Reply-To: <62bbed45cc9c775ba23cd5572e8cf2d77d769dfb.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<62bbed45cc9c775ba23cd5572e8cf2d77d769dfb.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/20] 9p: proxy: Fix size passed to
 `connect`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Thu, 31 May 2018 21:25:57 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> The size to pass to the `connect` call is the size of the entire
> `struct sockaddr_un`. Passing anything shorter than this causes errors
> on darwin.
>=20

=46rom the linux unix(7) manual page:

           ret =3D connect (data_socket, (const struct sockaddr *) &addr,
                          sizeof(struct sockaddr_un));

Not sure why it was done differently, but I definitely prefer the
fixed size version.

Applied to 9p-next.

Thanks !

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>=20
> Changes since v1: New patch
>=20
>  hw/9pfs/9p-proxy.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index e2e0329..47a94e0 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -1088,7 +1088,7 @@ static int proxy_ioc_getversion(FsContext *fs_ctx, =
V9fsPath *path,
> =20
>  static int connect_namedsocket(const char *path, Error **errp)
>  {
> -    int sockfd, size;
> +    int sockfd;
>      struct sockaddr_un helper;
> =20
>      if (strlen(path) >=3D sizeof(helper.sun_path)) {
> @@ -1102,8 +1102,7 @@ static int connect_namedsocket(const char *path, Er=
ror **errp)
>      }
>      strcpy(helper.sun_path, path);
>      helper.sun_family =3D AF_UNIX;
> -    size =3D strlen(helper.sun_path) + sizeof(helper.sun_family);
> -    if (connect(sockfd, (struct sockaddr *)&helper, size) < 0) {
> +    if (connect(sockfd, (struct sockaddr *)&helper, sizeof(helper)) < 0)=
 {
>          error_setg_errno(errp, errno, "failed to connect to '%s'", path);
>          close(sockfd);
>          return -1;
