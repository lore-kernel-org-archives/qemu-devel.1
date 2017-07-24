Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZcN5-0000NF-Br
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZcN0-00027J-Fn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZcN0-00026q-6l
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:21:54 -0400
References: <20170724121409.8623-1-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c776e3a-a744-86e2-ba68-bf60e5234e20@redhat.com>
Date: Mon, 24 Jul 2017 14:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170724121409.8623-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp/(p)memsave: Allow >32bit file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, admin@manateeshome.com
Cc: Markus Armbruster <armbru@redhat.com>

On 24.07.2017 14:14, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> memsave and pmemsave only take 32bit size arguments in HMP at the
> moment; let them take 64bit values.
>=20
> Reported-by: Pierre Kim <admin@manateeshome.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp-commands.hx | 4 ++--
>  hmp.c           | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 1941e19932..ddf77ae7ac 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -829,7 +829,7 @@ ETEXI
> =20
>      {
>          .name       =3D "memsave",
> -        .args_type  =3D "val:l,size:i,filename:s",
> +        .args_type  =3D "val:l,size:l,filename:s",
>          .params     =3D "addr size file",
>          .help       =3D "save to disk virtual memory dump starting at =
'addr' of size 'size'",
>          .cmd        =3D hmp_memsave,
> @@ -843,7 +843,7 @@ ETEXI
> =20
>      {
>          .name       =3D "pmemsave",
> -        .args_type  =3D "val:l,size:i,filename:s",
> +        .args_type  =3D "val:l,size:l,filename:s",
>          .params     =3D "addr size file",
>          .help       =3D "save to disk physical memory dump starting at=
 'addr' of size 'size'",
>          .cmd        =3D hmp_pmemsave,
> diff --git a/hmp.c b/hmp.c
> index bf1de747d5..dfbd615380 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1066,7 +1066,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
> =20
>  void hmp_memsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size =3D qdict_get_int(qdict, "size");
> +    uint64_t size =3D qdict_get_int(qdict, "size");
>      const char *filename =3D qdict_get_str(qdict, "filename");
>      uint64_t addr =3D qdict_get_int(qdict, "val");
>      Error *err =3D NULL;
> @@ -1083,7 +1083,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict=
)
> =20
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size =3D qdict_get_int(qdict, "size");
> +    uint64_t size =3D qdict_get_int(qdict, "size");
>      const char *filename =3D qdict_get_str(qdict, "filename");
>      uint64_t addr =3D qdict_get_int(qdict, "val");
>      Error *err =3D NULL;

The "size" parameter of the qmp_memsave() and qmp_pmemsave() function is
a signed integer (int64_t) ... could we get into trouble here if the
integer is really big? E.g. should we make "size" here signed, too, and
then add a sanity check for "size >=3D 0" ?

 Thomas
