Received: from eggs.gnu.org ([209.51.188.92]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBVau-00009p-MT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBVat-0002dx-E8
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hBVat-0002dD-4Z
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:25:39 -0400
Date: Wed, 3 Apr 2019 10:25:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190403022532.GJ11008@xz-x1>
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<1554219001-18301-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554219001-18301-1-git-send-email-catherine.hecx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: avoid filling ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Tue, Apr 02, 2019 at 11:30:01AM -0400, Catherine Ho wrote:
> Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> addes ignore-shared capability to bypass the shared ramblock (e,g,
> membackend + numa node). It does good to live migration.
> 
> This commit expectes that QEMU doesn't write to guest RAM until
> VM starts, but it does on aarch64 qemu:
> Backtrace:
> 1  0x000055f4a296dd84 in address_space_write_rom_internal () at exec.c:3458
> 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> 6  0x000055f4a2c9851d in main () at vl.c:4552
> 
> Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> during rom_reset. In ignore-shared incoming case, this rom filling
> is not required since all the data has been stored in memory backend file.
> 
> Fixes: commit 18269069c310 ("migration: Introduce ignore-shared capability")
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>

(note: IIUC normally you should have your signed-off to be the last
 line before the suggested-by :)

About the patch content, I have had a question on whether we should
need to check ignore-shared at all... That question lies in:

https://patchwork.kernel.org/patch/10859889/#22546487

And if my understanding was correct above, IMHO the patch could be as
simply be as "if (runstate_check(RUN_STATE_INMIGRATE)) return;" at [1]
below.

Thanks,

> ---
>  hw/core/loader.c          | 15 +++++++++++++++
>  include/exec/cpu-common.h |  1 +
>  migration/ram.c           |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index fe5cb24122..861a03335b 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -53,6 +53,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
> +#include "exec/cpu-common.h"
>  #include "hw/boards.h"
>  #include "qemu/cutils.h"
>  
> @@ -1086,6 +1087,9 @@ int rom_add_option(const char *file, int32_t bootindex)
>  static void rom_reset(void *unused)
>  {
>      Rom *rom;
> +    MemoryRegion *mr;
> +    hwaddr hw_addr;
> +    hwaddr l;

[1]

>  
>      QTAILQ_FOREACH(rom, &roms, next) {
>          if (rom->fw_file) {
> @@ -1094,6 +1098,17 @@ static void rom_reset(void *unused)
>          if (rom->data == NULL) {
>              continue;
>          }
> +
> +        /* bypass the rom blob in ignore-shared migration case*/
> +        if (runstate_check(RUN_STATE_INMIGRATE)) {
> +            rcu_read_lock();
> +            mr = address_space_translate(rom->as, rom->addr, &hw_addr, &l,
> +                                         true, MEMTXATTRS_UNSPECIFIED);
> +            rcu_read_unlock();
> +            if (mr->ram_block != NULL && ramblock_is_ignored(mr->ram_block))
> +                continue;
> +        }
> +
>          if (rom->mr) {
>              void *host = memory_region_get_ram_ptr(rom->mr);
>              memcpy(host, rom->data, rom->datasize);
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index cef8b88a2a..c80b7248a6 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -76,6 +76,7 @@ void *qemu_ram_get_host_addr(RAMBlock *rb);
>  ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
>  ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>  bool qemu_ram_is_shared(RAMBlock *rb);
> +bool ramblock_is_ignored(RAMBlock *block);
>  bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
>  void qemu_ram_set_uf_zeroable(RAMBlock *rb);
>  bool qemu_ram_is_migratable(RAMBlock *rb);
> diff --git a/migration/ram.c b/migration/ram.c
> index 35bd6213e9..d6de9d335d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -159,7 +159,7 @@ out:
>      return ret;
>  }
>  
> -static bool ramblock_is_ignored(RAMBlock *block)
> +bool ramblock_is_ignored(RAMBlock *block)
>  {
>      return !qemu_ram_is_migratable(block) ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block));
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
