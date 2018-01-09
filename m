Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eYrs9-0006Sj-7V
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eYrs8-00067F-6c
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:15:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180108215007.46471-1-marcel@redhat.com>
References: <20180108215007.46471-1-marcel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Jan 2018 12:15:09 +0100
Message-ID: <CAJ+F1CLGi6bSMuafc7J1kzxAPHGErWfdKDmjbDX=H5WtK8YL0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Mon, Jan 8, 2018 at 10:50 PM, Marcel Apfelbaum <marcel@redhat.com> wrote=
:
> When all the fw_cfg slots are used, a write is made outside the
> bounds of the fw_cfg files array as part of the sort algorithm.
>
> Fix it by avoiding an unnecessary array element move.
> Fix also an assert while at it.
>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 753ac0e4ea..4313484b21 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const c=
har *filename,
>       * index and "i - 1" is the one being copied from, thus the
>       * unusual start and end in the for statement.
>       */
> -    for (i =3D count + 1; i > index; i--) {
> +    for (i =3D count; i > index; i--) {

Good catch (could be worth a test in fw_cfg-test.c for ASAN check?)

Just some thought, I wonder if the sorting should be done once after
all entries are added, with some higher function like g_array_sort().

>          s->files->f[i] =3D s->files->f[i - 1];
>          s->files->f[i].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i);
>          s->entries[0][FW_CFG_FILE_FIRST + i] =3D
> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *f=
ilename,
>      assert(s->files);
>
>      index =3D be32_to_cpu(s->files->count);
> -    assert(index < fw_cfg_file_slots(s));
>
>      for (i =3D 0; i < index; i++) {
>          if (strcmp(filename, s->files->f[i].name) =3D=3D 0) {
> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *f=
ilename,
>              return ptr;
>          }
>      }
> +
> +    assert(index < fw_cfg_file_slots(s));
> +

Well, the assert is redundant with the one in
fw_cfg_add_file_callback() at this point. I think the original assert
is there for sanity check only, before iterating over files.

>      /* add new one */
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);
>      return NULL;
> --
> 2.13.5
>
>





--=20
Marc-Andr=C3=A9 Lureau
