Received: from eggs.gnu.org ([209.51.188.92]:47353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hDL0s-0007Tb-DM
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 23:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hDL0r-0003YD-7j
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 23:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hDL0p-0003X5-2o
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 23:32:01 -0400
Date: Mon, 8 Apr 2019 11:31:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190408033152.GF23212@xz-x1>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration: do not rom_reset() during
 incoming migration
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

On Sun, Apr 07, 2019 at 09:56:56PM -0400, Catherine Ho wrote:
> Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> addes ignore-shared capability to bypass the shared ramblock (e,g,
> membackend + numa node). It does good to live migration.
> 
> As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> until VM starts, but it does on aarch64 qemu:
> Backtrace:
> 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> exec.c:3458
> 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> 6  0x000055f4a2c9851d in main () at vl.c:4552
> 
> Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> druing rom_reset. In ignore-shared incoming case, this rom filling
> is not required since all the data has been stored in memory backend
> file.
> 
> Further more, as suggested by Peter Xu, if we do rom_reset() now with
> these ROMs then the RAM data should be re-filled again too with the
> migration stream coming in.
> 
> Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> capability")
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
>  hw/core/loader.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index fe5cb24122..946bb8ff00 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1087,6 +1087,13 @@ static void rom_reset(void *unused)
>  {
>      Rom *rom;
>  
> +    /*
> +     * If we do rom_reset() now with these ROMs then the RAM data should be
> +     * re-filled again too with the migration stream coming in.

I'm unconfident about correcting English in patches, but it does look
a bit odd to me...  I would say:

  We don't need to fill in the RAM with ROM data because we'll fill
  the data in during the next incoming migration in all cases.  Note
  that some of those RAMs can actually be modified by the guest on ARM
  so this is probably the only right thing to do here.

> +     */
> +    if (runstate_check(RUN_STATE_INMIGRATE))
> +        return;

The change looks good to me but of course it'll be nicer if some other
people can review it.

> +
>      QTAILQ_FOREACH(rom, &roms, next) {
>          if (rom->fw_file) {
>              continue;
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
