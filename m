Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d0xvD-0006ov-5O
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 18:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d0xv8-0004Wz-3t
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 18:17:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d0xv7-0004Wr-Us
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 18:17:54 -0400
Received: by mail-qk0-x244.google.com with SMTP id v75so5335550qkb.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:17:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170419205923.8808-1-quintela@redhat.com>
	<20170419205923.8808-50-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c52557bd-8621-6fdb-6fd2-2dfdc662d520@amsat.org>
Date: Wed, 19 Apr 2017 19:17:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170419205923.8808-50-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 49/59] ram: Remember last_page instead of
 last_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi Juan,

On 04/19/2017 05:59 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I think you missed Dave's Reviewed-by (he sent April 7)

"Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>"

>
> --
>
> Improve comment
> Fix typo

^ remove?

> ---
>  migration/ram.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 52ab14b..5b2045d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -171,8 +171,8 @@ struct RAMState {
>      RAMBlock *last_seen_block;
>      /* Last block from where we have sent data */
>      RAMBlock *last_sent_block;
> -    /* Last offset we have sent data from */
> -    ram_addr_t last_offset;
> +    /* Last dirty targe page we have sent */


still tipo in Dave's comment (you fixed it in PATCH 51/59)
"Last dirty target page we have sent"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    ram_addr_t last_page;
>      /* last ram version we have seen */
>      uint32_t last_version;
>      /* We are in the first round */
> @@ -1061,7 +1061,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>      pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
>                                                page_abs);
>      if (pss->complete_round && pss->block == rs->last_seen_block &&
> -        pss->offset >= rs->last_offset) {
> +        (pss->offset >> TARGET_PAGE_BITS) >= rs->last_page) {
>          /*
>           * We've been once around the RAM and haven't found anything.
>           * Give up.
> @@ -1402,7 +1402,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>      }
>
>      pss.block = rs->last_seen_block;
> -    pss.offset = rs->last_offset;
> +    pss.offset = rs->last_page << TARGET_PAGE_BITS;
>      pss.complete_round = false;
>
>      if (!pss.block) {
> @@ -1424,7 +1424,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>      } while (!pages && again);
>
>      rs->last_seen_block = pss.block;
> -    rs->last_offset = pss.offset;
> +    rs->last_page = pss.offset >> TARGET_PAGE_BITS;
>
>      return pages;
>  }
> @@ -1499,7 +1499,7 @@ static void ram_state_reset(RAMState *rs)
>  {
>      rs->last_seen_block = NULL;
>      rs->last_sent_block = NULL;
> -    rs->last_offset = 0;
> +    rs->last_page = 0;
>      rs->last_version = ram_list.version;
>      rs->ram_bulk_stage = true;
>  }
> @@ -1844,7 +1844,7 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
>      /* Easiest way to make sure we don't resume in the middle of a host-page */
>      rs->last_seen_block = NULL;
>      rs->last_sent_block = NULL;
> -    rs->last_offset     = 0;
> +    rs->last_page = 0;
>
>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>          unsigned long first = block->offset >> TARGET_PAGE_BITS;
>
