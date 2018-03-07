Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1etPZm-0000M2-Go
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1etPZl-0006Ls-G4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:17:10 -0500
Date: Tue, 6 Mar 2018 22:16:56 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180307031656.GA12302@localhost.localdomain>
References: <20180206105204.14817-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180206105204.14817-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: include original filename when
 reporting invalid URIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 06, 2018 at 10:52:04AM +0000, Daniel P. Berrang=E9 wrote:
> Consider passing a JSON based block driver to "qemu-img commit"
>=20
> $ qemu-img commit 'json:{"driver":"qcow2","file":{"driver":"gluster",\
>                   "volume":"gv0","path":"sn1.qcow2",
>                   "server":[{"type":\
> 		  "tcp","host":"10.73.199.197","port":"24007"}]},}'
>=20
> Currently it will commit the content and then report an incredibly
> useless error message when trying to re-open the committed image:
>=20
>   qemu-img: invalid URI
>   Usage: file=3Dgluster[+transport]://[host[:port]]volume/path[?socket=3D=
...][,file.debug=3DN][,file.logfile=3D/path/filename.log]
>=20
> With this fix we get:
>=20
>   qemu-img: invalid URI json:{"server.0.host": "10.73.199.197",
>       "driver": "gluster", "path": "luks.qcow2", "server.0.type":
>       "tcp", "server.0.port": "24007", "volume": "gv0"}
>=20
> Of course the root cause problem still exists, but now we know
> what actually needs fixing.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  block/gluster.c  | 2 +-
>  block/sheepdog.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/gluster.c b/block/gluster.c
> index 0f4265a3a4..0215e19087 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -660,7 +660,7 @@ static struct glfs *qemu_gluster_init(BlockdevOptio=
nsGluster *gconf,
>      if (filename) {
>          ret =3D qemu_gluster_parse_uri(gconf, filename);
>          if (ret < 0) {
> -            error_setg(errp, "invalid URI");
> +            error_setg(errp, "invalid URI %s", filename);
>              error_append_hint(errp, "Usage: file=3Dgluster[+transport]=
://"
>                                      "[host[:port]]volume/path[?socket=3D=
...]"
>                                      "[,file.debug=3DN]"
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index f684477328..c847ab6c98 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1050,7 +1050,7 @@ static void sd_parse_uri(SheepdogConfig *cfg, con=
st char *filename,
> =20
>      cfg->uri =3D uri =3D uri_parse(filename);
>      if (!uri) {
> -        error_setg(&err, "invalid URI");
> +        error_setg(&err, "invalid URI '%s'", filename);
>          goto out;
>      }
> =20
> --=20
> 2.14.3
>=20

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
