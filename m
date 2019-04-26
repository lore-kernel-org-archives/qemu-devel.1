Received: from eggs.gnu.org ([209.51.188.92]:43671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzyl-0001Uw-77
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzyj-0001k6-Pz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJzyj-0001jj-HB
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:29:21 -0400
Date: Fri, 26 Apr 2019 14:29:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190426142908.5d63d530@Igors-MacBook-Pro.local>
In-Reply-To: <20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
	<20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a
 RAM block encrypted notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>

On Thu, 25 Apr 2019 22:58:18 +0000
"Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com> wrote:

> A client can register to this notifier to know whether the newly added or
> removed memory region is marked as encrypted. This information is needed
> for the SEV guest launch. In SEV guest, some memory regions may contain
> encrypted data (e.g guest RAM). The memory region which contains the
> encrypted data should be registered/unregistered using the
> KVM_MEMORY_{REG,UNREG}_ENCRYPTED ioctl.
> 
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---
>  exec.c                 |  1 +
>  include/exec/memory.h  | 18 ++++++++++++++++++
>  include/exec/ramlist.h | 19 +++++++++++++++++++
>  memory.c               | 16 ++++++++++++++++
>  numa.c                 | 33 +++++++++++++++++++++++++++++++++
>  stubs/ram-block.c      |  8 ++++++++
>  6 files changed, 95 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 2646207661..a02c394e48 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -79,6 +79,7 @@
>   * are protected by the ramlist lock.
>   */
>  RAMList ram_list = { .blocks = QLIST_HEAD_INITIALIZER(ram_list.blocks) };
> +RAMBlockEncryptedNotifierList ram_block_encrypted_notifier_list;
>  
>  static MemoryRegion *system_memory;
>  static MemoryRegion *system_io;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9144a47f57..ae720ff511 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -374,6 +374,7 @@ struct MemoryRegion {
>      bool terminates;
>      bool ram_device;
>      bool enabled;
> +    bool encrypted;
>      bool warning_printed; /* For reservations */
>      uint8_t vga_logging_count;
>      MemoryRegion *alias;
> @@ -1131,6 +1132,23 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
>   */
>  int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
>  
> +/**
> + * memory_region_mark_encrypted: marks the memory region as encrypted and
> + * lets the listeners of encrypted ram know that a memory region containing
> + * encrypted ram block has been added
> + *
> + * @mr: the memory region
> + */
> +void memory_region_mark_encrypted(MemoryRegion *mr);
> +
> +/**
> + * memory_region_is_encrypted: returns if the memory region was marked as
> + * encrypted when it was created
> + *
> + * @mr: the memory region
> + */
> +bool memory_region_is_encrypted(MemoryRegion *mr);
> +
>  /**
>   * memory_region_name: get a memory region's name
>   *
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index bc4faa1b00..5349f27fa5 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -7,6 +7,7 @@
>  #include "qemu/rcu_queue.h"
>  
>  typedef struct RAMBlockNotifier RAMBlockNotifier;
> +typedef struct RAMBlockEncryptedNotifier RAMBlockEncryptedNotifier;
>  
>  #define DIRTY_MEMORY_VGA       0
>  #define DIRTY_MEMORY_CODE      1
> @@ -55,6 +56,11 @@ typedef struct RAMList {
>  } RAMList;
>  extern RAMList ram_list;
>  
> +typedef struct RAMBlockEncryptedNotifierList {
> +    QLIST_HEAD(, RAMBlockEncryptedNotifier) ram_block_notifiers;
> +} RAMBlockEncryptedNotifierList;
> +extern RAMBlockEncryptedNotifierList ram_block_encrypted_notifier_list;
> +
>  /* Should be holding either ram_list.mutex, or the RCU lock. */
>  #define  INTERNAL_RAMBLOCK_FOREACH(block)  \
>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next)
> @@ -70,6 +76,14 @@ struct RAMBlockNotifier {
>      QLIST_ENTRY(RAMBlockNotifier) next;
>  };
>  
> +struct RAMBlockEncryptedNotifier {
> +    void (*ram_block_encrypted_added)(RAMBlockEncryptedNotifier *n,
> +                                      void *host, size_t size);
> +    void (*ram_block_encrypted_removed)(RAMBlockEncryptedNotifier *n,
> +                                        void *host, size_t size);
> +    QLIST_ENTRY(RAMBlockEncryptedNotifier) next;
> +};
> +
>  void ram_block_notifier_add(RAMBlockNotifier *n);
>  void ram_block_notifier_remove(RAMBlockNotifier *n);
>  void ram_block_notify_add(void *host, size_t size);
> @@ -77,4 +91,9 @@ void ram_block_notify_remove(void *host, size_t size);
>  
>  void ram_block_dump(Monitor *mon);
>  
> +void ram_block_encrypted_notifier_add(RAMBlockEncryptedNotifier *n);
> +void ram_block_encrypted_notifier_remove(RAMBlockEncryptedNotifier *n);
> +void ram_block_encrypted_notify_add(void *host, size_t size);
> +void ram_block_encrypted_notify_remove(void *host, size_t size);
> +
>  #endif /* RAMLIST_H */
> diff --git a/memory.c b/memory.c
> index bb2b71ee38..eca02d369b 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2009,6 +2009,22 @@ int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
>      return imrc->num_indexes(iommu_mr);
>  }
>  
> +void memory_region_mark_encrypted(MemoryRegion *mr)
> +{
> +    RAMBlock *block = mr->ram_block;
> +
> +    mr->encrypted = kvm_memcrypt_enabled();
> +
> +    if (mr->encrypted) {
> +        ram_block_encrypted_notify_add(block->host, block->max_length);
> +    }
> +}
> +
> +bool memory_region_is_encrypted(MemoryRegion *mr)
> +{
> +    return mr->encrypted;
> +}
> +
>  void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
>  {
>      uint8_t mask = 1 << client;
> diff --git a/numa.c b/numa.c
> index 3875e1efda..08601366c5 100644
> --- a/numa.c
> +++ b/numa.c

looks like wrong file to put RAMBlock code in. I though that we should put it in exec.c

> @@ -638,6 +638,39 @@ MemdevList *qmp_query_memdev(Error **errp)
>      return list;
>  }
>  
> +void ram_block_encrypted_notifier_add(RAMBlockEncryptedNotifier *n)
> +{
> +    QLIST_INSERT_HEAD(&ram_block_encrypted_notifier_list.ram_block_notifiers,
> +                      n, next);
> +}
> +
> +void ram_block_encrypted_notifier_remove(RAMBlockEncryptedNotifier *n)
> +{
> +    QLIST_REMOVE(n, next);
> +}
> +
> +void ram_block_encrypted_notify_add(void *host, size_t size)
> +{
> +    RAMBlockEncryptedNotifier *notifier;
> +
> +    QLIST_FOREACH(notifier,
> +                  &ram_block_encrypted_notifier_list.ram_block_notifiers,
> +                  next) {
> +        notifier->ram_block_encrypted_added(notifier, host, size);
> +    }
> +}
> +
> +void ram_block_encrypted_notify_remove(void *host, size_t size)
> +{
> +    RAMBlockEncryptedNotifier *notifier;
> +
> +    QLIST_FOREACH(notifier,
> +                  &ram_block_encrypted_notifier_list.ram_block_notifiers,
> +                  next) {
> +        notifier->ram_block_encrypted_removed(notifier, host, size);
> +    }
> +}
> +
>  void ram_block_notifier_add(RAMBlockNotifier *n)
>  {
>      QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> index 73c0a3ee08..0f68922feb 100644
> --- a/stubs/ram-block.c
> +++ b/stubs/ram-block.c
> @@ -25,6 +25,14 @@ void ram_block_notifier_remove(RAMBlockNotifier *n)
>  {
>  }
>  
> +void ram_block_encrypted_notifier_add(RAMBlockEncryptedNotifier *n)
> +{
> +}
> +
> +void ram_block_encrypted_notifier_remove(RAMBlockEncryptedNotifier *n)
> +{
> +}
> +
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
>  {
>      return 0;
