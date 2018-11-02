Received: from eggs.gnu.org ([2001:4830:134:3::10]:55075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gITFT-0003SK-MB
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gITFR-0002s0-OJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:48:03 -0400
Date: Fri, 2 Nov 2018 14:47:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181102064747.GA21032@magic>
References: <20181101103807.25862-1-lifeng1519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101103807.25862-1-lifeng1519@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/nvme: optimize the performance of
 nvme driver based on vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Feng <lifeng1519@gmail.com>
Cc: fengli@smartx.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:NVMe Block Driver" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Thu, 11/01 18:38, Li Feng wrote:
> When the IO size is larger than 2 pages, we move the the pointer one by
> one in the pagelist, this is inefficient.
>=20
> This is a simple benchmark result:
>=20
> Before:
> $ qemu-io -c 'write 0 1G' nvme://0000:00:04.0/1
>=20
> wrote 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:02.41 (424.504 MiB/sec and 0.4146 ops/sec)
>=20
>  $ qemu-io -c 'read 0 1G' nvme://0000:00:04.0/1
>=20
> read 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:02.03 (503.055 MiB/sec and 0.4913 ops/sec)
>=20
> After:
> $ qemu-io -c 'write 0 1G' nvme://0000:00:04.0/1
>=20
> wrote 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:02.17 (471.517 MiB/sec and 0.4605 ops/sec)
>=20
>  $ qemu-io -c 'read 0 1G' nvme://0000:00:04.0/1                        =
                                                                         =
                                                                         =
                                                                         =
                   1 =E2=86=B5
>=20
> read 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:01.94 (526.770 MiB/sec and 0.5144 ops/sec)
>=20
> Signed-off-by: Li Feng <lifeng1519@gmail.com>
> ---
>  block/nvme.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 29294038fc..982097b5b1 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -837,7 +837,7 @@ try_map:
>          }
> =20
>          for (j =3D 0; j < qiov->iov[i].iov_len / s->page_size; j++) {
> -            pagelist[entries++] =3D iova + j * s->page_size;
> +            pagelist[entries++] =3D cpu_to_le64(iova + j * s->page_siz=
e);
>          }
>          trace_nvme_cmd_map_qiov_iov(s, i, qiov->iov[i].iov_base,
>                                      qiov->iov[i].iov_len / s->page_siz=
e);
> @@ -850,20 +850,16 @@ try_map:
>      case 0:
>          abort();
>      case 1:
> -        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> +        cmd->prp1 =3D pagelist[0];
>          cmd->prp2 =3D 0;
>          break;
>      case 2:
> -        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> -        cmd->prp2 =3D cpu_to_le64(pagelist[1]);;
> +        cmd->prp1 =3D pagelist[0];
> +        cmd->prp2 =3D pagelist[1];
>          break;
>      default:
> -        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> -        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova);
> -        for (i =3D 0; i < entries - 1; ++i) {
> -            pagelist[i] =3D cpu_to_le64(pagelist[i + 1]);
> -        }
> -        pagelist[entries - 1] =3D 0;
> +        cmd->prp1 =3D pagelist[0];
> +        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(uint64_t=
));
>          break;
>      }
>      trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
> --=20
> 2.11.0
>=20

Nice! Thanks. I've queued the patch.

Fam
