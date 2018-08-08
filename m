Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fnW4m-0007Fi-Dd
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fnW4l-0006aS-J9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:33:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180803144721.17036-4-stefanha@redhat.com>
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-4-stefanha@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 8 Aug 2018 14:32:31 -0700
Message-ID: <CAKmqyKOLkNzAQgrr9rRYTCzrDnsjj1uChDaX4-2xnJMrEtEUKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/6] loader: extract rom_free() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, jusual@mail.ru

On Fri, Aug 3, 2018 at 7:47 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The next patch will need to free a rom.  There is already code to do
> this in rom_add_file().
>
> Note that rom_add_file() uses:
>
>   rom = g_malloc0(sizeof(*rom));
>   ...
>   if (rom->fw_dir) {
>       g_free(rom->fw_dir);
>       g_free(rom->fw_file);
>   }
>
> The conditional is unnecessary since g_free(NULL) is a no-op.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/loader.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index bbb6e65bb5..0c72e7c05a 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -847,6 +847,17 @@ struct Rom {
>  static FWCfgState *fw_cfg;
>  static QTAILQ_HEAD(, Rom) roms = QTAILQ_HEAD_INITIALIZER(roms);
>
> +/* rom->data must be heap-allocated (do not use with rom_add_elf_program()) */
> +static void rom_free(Rom *rom)
> +{
> +    g_free(rom->data);
> +    g_free(rom->path);
> +    g_free(rom->name);
> +    g_free(rom->fw_dir);
> +    g_free(rom->fw_file);
> +    g_free(rom);
> +}
> +
>  static inline bool rom_order_compare(Rom *rom, Rom *item)
>  {
>      return ((uintptr_t)(void *)rom->as > (uintptr_t)(void *)item->as) ||
> @@ -995,15 +1006,7 @@ err:
>      if (fd != -1)
>          close(fd);
>
> -    g_free(rom->data);
> -    g_free(rom->path);
> -    g_free(rom->name);
> -    if (fw_dir) {
> -        g_free(rom->fw_dir);
> -        g_free(rom->fw_file);
> -    }
> -    g_free(rom);
> -
> +    rom_free(rom);
>      return -1;
>  }
>
> --
> 2.17.1
>
>
