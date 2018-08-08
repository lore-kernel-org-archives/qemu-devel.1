Received: from eggs.gnu.org ([2001:4830:134:3::10]:56637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fnW3z-0006r8-Ee
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fnW3y-0005gf-BR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:32:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180803144721.17036-5-stefanha@redhat.com>
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-5-stefanha@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 8 Aug 2018 14:31:41 -0700
Message-ID: <CAKmqyKOthBCQrWc_v9zhdYoBATHYfjyjkUQqx1W5mktm2b+6hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/6] loader: add rom transaction API
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
> Image file loaders may add a series of roms.  If an error occurs partway
> through loading there is no easy way to drop previously added roms.
>
> This patch adds a transaction mechanism that works like this:
>
>   rom_transaction_begin();
>   ...call rom_add_*()...
>   rom_transaction_end(ok);
>
> If ok is false then roms added in this transaction are dropped.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/loader.h | 19 +++++++++++++++++++
>  hw/core/loader.c    | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index e98b84b8f9..5235f119a3 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -225,6 +225,25 @@ int rom_check_and_register_reset(void);
>  void rom_set_fw(FWCfgState *f);
>  void rom_set_order_override(int order);
>  void rom_reset_order_override(void);
> +
> +/**
> + * rom_transaction_begin:
> + *
> + * Call this before of a series of rom_add_*() calls.  Call
> + * rom_transaction_end() afterwards to commit or abort.  These functions are
> + * useful for undoing a series of rom_add_*() calls if image file loading fails
> + * partway through.
> + */
> +void rom_transaction_begin(void);
> +
> +/**
> + * rom_transaction_end:
> + * @commit: true to commit added roms, false to drop added roms
> + *
> + * Call this after a series of rom_add_*() calls.  See rom_transaction_begin().
> + */
> +void rom_transaction_end(bool commit);
> +
>  int rom_copy(uint8_t *dest, hwaddr addr, size_t size);
>  void *rom_ptr(hwaddr addr, size_t size);
>  void hmp_info_roms(Monitor *mon, const QDict *qdict);
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 0c72e7c05a..612420b870 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -840,6 +840,8 @@ struct Rom {
>      char *fw_dir;
>      char *fw_file;
>
> +    bool committed;
> +
>      hwaddr addr;
>      QTAILQ_ENTRY(Rom) next;
>  };
> @@ -877,6 +879,8 @@ static void rom_insert(Rom *rom)
>          rom->as = &address_space_memory;
>      }
>
> +    rom->committed = false;
> +
>      /* List is ordered by load address in the same address space */
>      QTAILQ_FOREACH(item, &roms, next) {
>          if (rom_order_compare(rom, item)) {
> @@ -1168,6 +1172,34 @@ void rom_reset_order_override(void)
>      fw_cfg_reset_order_override(fw_cfg);
>  }
>
> +void rom_transaction_begin(void)
> +{
> +    Rom *rom;
> +
> +    /* Ignore ROMs added without the transaction API */
> +    QTAILQ_FOREACH(rom, &roms, next) {
> +        rom->committed = true;

My only thought is that maybe this should produce a warning or error
if a ROM isn't committed.

Alistair

> +    }
> +}
> +
> +void rom_transaction_end(bool commit)
> +{
> +    Rom *rom;
> +    Rom *tmp;
> +
> +    QTAILQ_FOREACH_SAFE(rom, &roms, next, tmp) {
> +        if (rom->committed) {
> +            continue;
> +        }
> +        if (commit) {
> +            rom->committed = true;
> +        } else {
> +            QTAILQ_REMOVE(&roms, rom, next);
> +            rom_free(rom);
> +        }
> +    }
> +}
> +
>  static Rom *find_rom(hwaddr addr, size_t size)
>  {
>      Rom *rom;
> --
> 2.17.1
>
>
