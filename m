Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUBcB-0007xq-OM
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUBc7-0001Pk-EE
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:19:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUBc7-0001Nm-5M
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:19:19 -0500
Date: Wed, 27 Dec 2017 14:19:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171227141903.4e158a36@igors-macbook-pro.local>
In-Reply-To: <20171218201340.27583-6-dgilbert@redhat.com>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 5/7] vhost: Regenerate region list from
 changed sections list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

On Mon, 18 Dec 2017 20:13:38 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Compare the sections list that's just been generated, and if it's
> different from the old one regenerate the region list.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/trace-events |  1 +
>  hw/virtio/vhost.c      | 34 ++++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 0e63c8739d..742ff0f90b 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -1,6 +1,7 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # hw/virtio/vhost.c
> +vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
>  vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
>  vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
>  vhost_section(const char *name, int r) "%s:%d"
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 57d15acd2b..4394ac0275 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -643,21 +643,47 @@ static void vhost_commit(MemoryListener *listener)
>      MemoryRegionSection *old_sections;
>      int n_old_sections;
>      uint64_t log_size;
> +    size_t regions_size;
>      int r;
>      int i;
> +    bool changed = false;
>  
>      old_sections = dev->mem_sections;
>      n_old_sections = dev->n_mem_sections;
>      dev->mem_sections = dev->tmp_sections;
>      dev->n_mem_sections = dev->n_tmp_sections;
>  
> -    if (!dev->memory_changed) {
> -        goto out;
> +    if (dev->n_mem_sections != n_old_sections) {
> +        changed = true;
> +    } else {
> +        /* Same size, lets check the contents */
> +        changed = memcmp(dev->mem_sections, old_sections,
> +                         n_old_sections * sizeof(old_sections[0])) != 0;
>      }
> -    if (!dev->started) {
> +
> +    trace_vhost_commit(dev->started, changed);
> +    if (!changed) {
>          goto out;
>      }
> -    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
> +
> +    /* Rebuild the regions list from the new sections list */
> +    regions_size = offsetof(struct vhost_memory, regions) +
> +                       dev->n_mem_sections * sizeof dev->mem->regions[0];
> +    dev->mem = g_realloc(dev->mem, regions_size);
> +    dev->mem->nregions = dev->n_mem_sections;
> +    for (i = 0; i < dev->n_mem_sections; i++) {
> +        struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
> +        struct MemoryRegionSection *mrs = dev->mem_sections + i;
> +
> +        cur_vmr->guest_phys_addr = mrs->offset_within_address_space;
> +        cur_vmr->memory_size     = int128_get64(mrs->size);
> +        cur_vmr->userspace_addr  =
> +            (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
> +            mrs->offset_within_region;
> +        cur_vmr->flags_padding   = 0;
> +    }
is there a reason to keep dev->mem around after vhost_commit executed?
I'd suggest to use temporary local variable and free it on exit from function.

> +    if (!dev->started) {
also why memmap is generated this early and not right before first use?
here we might generate memap but not actually use it.

>          goto out;
>      }
>  
