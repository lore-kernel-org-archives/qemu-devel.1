Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYteW-00051L-0U
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYteS-000873-O2
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:09:15 -0500
References: <20180108215007.46471-1-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3ea6176b-01a4-8f5a-81fc-3e9a8c846dc7@redhat.com>
Date: Tue, 9 Jan 2018 14:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180108215007.46471-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix memory corruption when all
 fw_cfg slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org, kraxel@redhat.com

On 01/08/18 22:50, Marcel Apfelbaum wrote:
> When all the fw_cfg slots are used, a write is made outside the
> bounds of the fw_cfg files array as part of the sort algorithm.
>=20
> Fix it by avoiding an unnecessary array element move.
> Fix also an assert while at it.
>=20
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 753ac0e4ea..4313484b21 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const=
 char *filename,
>       * index and "i - 1" is the one being copied from, thus the
>       * unusual start and end in the for statement.
>       */
> -    for (i =3D count + 1; i > index; i--) {
> +    for (i =3D count; i > index; i--) {
>          s->files->f[i] =3D s->files->f[i - 1];
>          s->files->f[i].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i);
>          s->entries[0][FW_CFG_FILE_FIRST + i] =3D

This hunk looks correct to me. We currently have count elements in the
array, so we cannot normally access the element *at* count. However, we
are extending the array right now, therefore we can assign (store) the
element at count (and then we'll increment count later). But accessing
an element at (count+1) is wrong.

> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char =
*filename,
>      assert(s->files);
> =20
>      index =3D be32_to_cpu(s->files->count);
> -    assert(index < fw_cfg_file_slots(s));
> =20
>      for (i =3D 0; i < index; i++) {
>          if (strcmp(filename, s->files->f[i].name) =3D=3D 0) {
> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char =
*filename,
>              return ptr;
>          }
>      }
> +
> +    assert(index < fw_cfg_file_slots(s));
> +
>      /* add new one */
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len,=
 true);
>      return NULL;
>=20

I think I agree with Marc-Andr=C3=A9 here, when I say, replace the assert
with a comment instead? (About the fact that fw_cfg_add_file_callback()
will assert(), *if* we reach that far.)

Thanks
Laszlo
