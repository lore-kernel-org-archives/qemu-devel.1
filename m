Received: from eggs.gnu.org ([2001:4830:134:3::10]:47681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cba6G-0000Sn-S6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cba6C-0003r8-0l
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:48:28 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cba6B-0003qy-Sk
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:48:23 -0500
Received: by mail-qk0-x243.google.com with SMTP id i34so19724603qkh.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:48:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486564125-31366-1-git-send-email-ashijeetacharya@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <edbe0ae7-8727-5e5c-1d08-b4a1bafd6eff@gmail.com>
Date: Wed, 8 Feb 2017 18:48:19 -0300
MIME-Version: 1.0
In-Reply-To: <1486564125-31366-1-git-send-email-ashijeetacharya@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] migrate: Introduce zero RAM checks to
 skip RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, thuth@redhat.com, quintela@redhat.com, groug@kaod.org, pbonzini@redhat.com, dgilbert@redhat.com



On 02/08/2017 11:28 AM, Ashijeet Acharya wrote:
> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead place zero RAM checks at
> appropriate places to skip migration of RAM in this case and complete
> migration successfully for devices only.
>
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Changes in v3:
> - handle migration cleanup appropriately (Dave)
> Changes in v2:
> - try to migrate successfully by skipping RAM (Paolo, Greg)
> - drop the idea of erroring out and failing nicely
> ---
>  migration/ram.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index ef8fadf..faff5ab 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1325,6 +1325,11 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
>      ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
>                                   ram_addr_t space */
>
> +    /* No dirty page as there is zero RAM */
> +    if (!ram_bytes_total()) {
> +        return pages;
> +    }
> +
>      pss.block = last_seen_block;
>      pss.offset = last_offset;
>      pss.complete_round = false;
> @@ -1912,14 +1917,17 @@ static int ram_save_init_globals(void)
>      bytes_transferred = 0;
>      reset_ram_globals();
>
> -    ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>      migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
> -    migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> -
> -    if (migrate_postcopy_ram()) {
> -        migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +    /* Skip setting bitmap if there is no RAM */
> +    if (ram_bytes_total()) {
> +        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
> +        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> +        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> +
> +        if (migrate_postcopy_ram()) {
> +            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> +            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +        }
>      }
>
>      /*
>
