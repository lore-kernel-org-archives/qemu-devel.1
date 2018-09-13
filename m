Received: from eggs.gnu.org ([2001:4830:134:3::10]:51867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0SpD-0008Fm-6T
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Sp9-0004zx-SU
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0Sp9-0004zh-HL
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6DD83082B06
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 14:42:26 +0000 (UTC)
References: <1536064777-42312-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5df4e1a6-aecf-c177-d1c5-af24d7e9d287@redhat.com>
Date: Thu, 13 Sep 2018 16:42:24 +0200
MIME-Version: 1.0
In-Reply-To: <1536064777-42312-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: cleanup side effects of
 memory_region_init_foo() on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

On 04/09/2018 14:39, Igor Mammedov wrote:
> if MemoryRegion intialization fails it's left in semi-initialized state,
> where it's size is not 0 and attached as child to owner object.
> And this leds to crash in following use-case:
>     (monitor) object_add memory-backend-file,id=mem1,size=99999G,mem-path=/tmp/foo,discard-data=yes
>     memory.c:2083: memory_region_get_ram_ptr: Assertion `mr->ram_block' failed
>     Aborted (core dumped)
> it happens due to assumption that memory region is intialized when
>    memory_region_size() != 0
> and therefore it's ok to access it in
>    file_backend_unparent()
>       if (memory_region_size() != 0)
>           memory_region_get_ram_ptr()
> 
> which happens when object_add fails and unparents failed backend making
> file_backend_unparent() access invalid memory region.
> 
> Fix it by making sure that memory_region_init_foo() APIs cleanup externally
> visible side effects on failure (like set size to 0 and unparenting object)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  memory.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 9b73892..4c2dfd3 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1518,12 +1518,18 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
>                                               bool share,
>                                               Error **errp)
>  {
> +    Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, share, mr, errp);
> +    mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  
>  void memory_region_init_resizeable_ram(MemoryRegion *mr,
> @@ -1536,13 +1542,19 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                         void *host),
>                                         Error **errp)
>  {
> +    Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
> -                                              mr, errp);
> +                                              mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  
>  #ifdef __linux__
> @@ -1555,13 +1567,19 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        const char *path,
>                                        Error **errp)
>  {
> +    Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, errp);
> +    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  
>  void memory_region_init_ram_from_fd(MemoryRegion *mr,
> @@ -1572,14 +1590,20 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>                                      int fd,
>                                      Error **errp)
>  {
> +    Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>                                             share ? RAM_SHARED : 0,
> -                                           fd, errp);
> +                                           fd, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  #endif
>  
> @@ -1630,13 +1654,19 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>                                        uint64_t size,
>                                        Error **errp)
>  {
> +    Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->readonly = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, false, mr, errp);
> +    mr->ram_block = qemu_ram_alloc(size, false, mr, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  
>  void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
> @@ -1647,6 +1677,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>                                               uint64_t size,
>                                               Error **errp)
>  {
> +    Error *err = NULL;
>      assert(ops);
>      memory_region_init(mr, owner, name, size);
>      mr->ops = ops;
> @@ -1654,7 +1685,12 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>      mr->terminates = true;
>      mr->rom_device = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, false,  mr, errp);
> +    mr->ram_block = qemu_ram_alloc(size, false,  mr, &err);
> +    if (err) {
> +        mr->size = 0;
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
> +    }
>  }
>  
>  void memory_region_init_iommu(void *_iommu_mr,
> 

Queued, thanks.

Paolo
