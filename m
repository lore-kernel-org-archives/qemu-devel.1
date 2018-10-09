Received: from eggs.gnu.org ([2001:4830:134:3::10]:49490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9uEd-0006ZS-SH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9uEY-0001bo-Lb
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g9uEY-0001b8-6a
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49BFB88E58
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 15:47:41 +0000 (UTC)
References: <1539093025-101599-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ccf4afa-3528-a336-3eb2-9fc516852e91@redhat.com>
Date: Tue, 9 Oct 2018 17:47:12 +0200
MIME-Version: 1.0
In-Reply-To: <1539093025-101599-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: move MemoryRegion::size cleanup to
 memory_region_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com

On 09/10/2018 15:50, Igor Mammedov wrote:
> It's not necessary to clean up MemoryRegion::size manually in multiple places
> like it's been implemented in
>  (1cd3d49262 "memory: cleanup side effects of  memory_region_init_foo() on failure")
> since each memory_region_init_foo() now calls object_unparent(mr) on failure,
> memory region destructor memory_region_finalize() will be called upon its
> completion for each memory_region_init_foo().
> It's sufficient to clean MemoryRegion::size only from memory_region_finalize(),
> so do it.

Stupid question, why is it necessary to clear mr->size at all?...

Paolo

> ---
>  memory.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index d852f11..ad24b57 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1491,7 +1491,6 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1516,7 +1515,6 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1541,7 +1539,6 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1565,7 +1562,6 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>                                             fd, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1628,7 +1624,6 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc(size, false, mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1652,7 +1647,6 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc(size, false,  mr, &err);
>      if (err) {
> -        mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
>          error_propagate(errp, err);
>      }
> @@ -1701,6 +1695,7 @@ static void memory_region_finalize(Object *obj)
>      memory_region_clear_coalescing(mr);
>      g_free((char *)mr->name);
>      g_free(mr->ioeventfds);
> +    mr->size = int128_zero();
>  }
>  
>  Object *memory_region_owner(MemoryRegion *mr)
> 
