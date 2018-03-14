Received: from eggs.gnu.org ([2001:4830:134:3::10]:44849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewAsZ-0005Rq-7z
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewAsV-0002z8-6I
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:11:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewAsV-0002yW-1A
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:11:55 -0400
Date: Wed, 14 Mar 2018 18:11:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314181137.GG3006@work-vm>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> This patch adds an API to clear bits corresponding to guest free pages
> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
> RAMBlock boundary.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/migration/misc.h |  2 ++
>  migration/ram.c          | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 77fd4f5..fae1acf 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -14,11 +14,13 @@
>  #ifndef MIGRATION_MISC_H
>  #define MIGRATION_MISC_H
> =20
> +#include "exec/cpu-common.h"
>  #include "qemu/notify.h"
> =20
>  /* migration/ram.c */
> =20
>  void ram_mig_init(void);
> +void qemu_guest_free_page_hint(void *addr, size_t len);
> =20
>  /* migration/block.c */
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index 5e33e5c..e172798 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2189,6 +2189,27 @@ static int ram_init_all(RAMState **rsp)
>      return 0;
>  }
> =20

This could do with some comments

> +void qemu_guest_free_page_hint(void *addr, size_t len)
> +{
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +    size_t used_len, start, npages;

=46rom your use I think the addr and len are coming raw from the guest;
so we need to take some care.

> +
> +    for (used_len =3D len; len > 0; len -=3D used_len) {

That initialisation of used_len is unusual; I'd rather put that
in the body.

> +        block =3D qemu_ram_block_from_host(addr, false, &offset);

CHeck for block !=3D 0

> +        if (unlikely(offset + len > block->used_length)) {

I think to make that overflow safe, that should be:
  if (len > (block->used_length - offset)) {

But we'll need another test before it, because qemu_ram_block_from_host
seems to check max_length not used_length, so we need to check
for offset > block->used_length first

> +            used_len =3D block->used_length - offset;
> +            addr +=3D used_len;
> +        }
> +
> +        start =3D offset >> TARGET_PAGE_BITS;
> +        npages =3D used_len >> TARGET_PAGE_BITS;
> +        ram_state->migration_dirty_pages -=3D
> +                      bitmap_count_one_with_offset(block->bmap, start, n=
pages);
> +        bitmap_clear(block->bmap, start, npages);

If this is happening while the migration is running, this isn't safe -
the migration code could clear a bit at about the same point this
happens, so that the count returned by bitmap_count_one_with_offset
wouldn't match the word that was cleared by bitmap_clear.

The only way I can see to fix it is to run over the range using
bitmap_test_and_clear_atomic, using the return value to decrement
the number of dirty pages.
But you also need to be careful with the update of the
migration_dirty_pages value itself, because that's also being read
by the migration thread.

Dave

> +    }
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
