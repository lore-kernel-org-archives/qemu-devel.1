Received: from eggs.gnu.org ([2001:4830:134:3::10]:47293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cdmQV-0006S2-Pn
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cdmQR-0003iR-RV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:22:27 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cdmQR-0003i8-Na
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:22:23 -0500
Received: by mail-qk0-x241.google.com with SMTP id p22so13502813qka.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 15:22:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
	<20170203152321.19739-2-pbutsykin@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8cf56ca0-760a-8133-81a6-72d3c2b1e56b@amsat.org>
Date: Tue, 14 Feb 2017 20:22:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170203152321.19739-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: add MigrationState arg
 for ram_save_/compressed_/page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, amit.shah@redhat.com, den@openvz.org

On 02/03/2017 12:23 PM, Pavel Butsykin wrote:
> Cosmetic patch. The use of ms variable instead of migrate_get_current()
> looks nicer, especially when there reuse.
>
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/ram.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index a683f4bb9e..d866b6518b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -734,13 +734,14 @@ static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
>   *          >=0 - Number of pages written - this might legally be 0
>   *                if xbzrle noticed the page was the same.
>   *
> + * @ms: The current migration state.
>   * @f: QEMUFile where to send the data
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
>   * @bytes_transferred: increase it with the number of transferred bytes
>   */
> -static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
> +static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
>                           bool last_stage, uint64_t *bytes_transferred)
>  {
>      int pages = -1;
> @@ -786,8 +787,7 @@ static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
>               */
>              xbzrle_cache_zero_page(current_addr);
>          } else if (!ram_bulk_stage &&
> -                   !migration_in_postcopy(migrate_get_current()) &&
> -                   migrate_use_xbzrle()) {
> +                   !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
>              pages = save_xbzrle_page(f, &p, current_addr, block,
>                                       offset, last_stage, bytes_transferred);
>              if (!last_stage) {
> @@ -914,14 +914,15 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
>   *
>   * Returns: Number of pages written.
>   *
> + * @ms: The current migration state.
>   * @f: QEMUFile where to send the data
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
>   * @bytes_transferred: increase it with the number of transferred bytes
>   */
> -static int ram_save_compressed_page(QEMUFile *f, PageSearchStatus *pss,
> -                                    bool last_stage,
> +static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
> +                                    PageSearchStatus *pss, bool last_stage,
>                                      uint64_t *bytes_transferred)
>  {
>      int pages = -1;
> @@ -1252,11 +1253,11 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
>      if (migration_bitmap_clear_dirty(dirty_ram_abs)) {
>          unsigned long *unsentmap;
>          if (compression_switch && migrate_use_compression()) {
> -            res = ram_save_compressed_page(f, pss,
> +            res = ram_save_compressed_page(ms, f, pss,
>                                             last_stage,
>                                             bytes_transferred);
>          } else {
> -            res = ram_save_page(f, pss, last_stage,
> +            res = ram_save_page(ms, f, pss, last_stage,
>                                  bytes_transferred);
>          }
>
>
