Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnrEd-0006jU-5w
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnrEZ-0005MG-TK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:31:51 -0400
Received: from mail.kernel.org ([198.145.29.136]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnrEZ-0005KD-J5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:31:47 -0400
Date: Tue, 14 Mar 2017 11:31:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <b6840be0-b4eb-6318-8354-1ee7dff307be@citrix.com>
Message-ID: <alpine.DEB.2.10.1703141050360.21520@sstabellini-ThinkPad-X260>
References: <1489434313-11639-1-git-send-email-igor.druzhinin@citrix.com>
	<alpine.DEB.2.10.1703131336270.3116@sstabellini-ThinkPad-X260>
	<b6840be0-b4eb-6318-8354-1ee7dff307be@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3] xen: don't save/restore the physmap on
 VM save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com, paul.durrant@citrix.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net

On Tue, 14 Mar 2017, Igor Druzhinin wrote:
> On 13/03/17 21:15, Stefano Stabellini wrote:
> > On Mon, 13 Mar 2017, Igor Druzhinin wrote:
> >> Saving/restoring the physmap to/from xenstore was introduced to
> >> QEMU majorly in order to cover up the VRAM region restore issue.
> >> The sequence of restore operations implies that we should know
> >> the effective guest VRAM address *before* we have the VRAM region
> >> restored (which happens later). Unfortunately, in Xen environment
> >> VRAM memory does actually belong to a guest - not QEMU itself -
> >> which means the position of this region is unknown beforehand and
> >> can't be mapped into QEMU address space immediately.
> >>
> >> Previously, recreating xenstore keys, holding the physmap, by the
> >> toolstack helped to get this information in place at the right
> >> moment ready to be consumed by QEMU to map the region properly.
> >>
> >> The extraneous complexity of having those keys transferred by the
> >> toolstack and unnecessary redundancy prompted us to propose a
> >> solution which doesn't require any extra data in xenstore. The idea
> >> is to defer the VRAM region mapping till the point we actually know
> >> the effective address and able to map it. To that end, we initially
> >> only register the pointer to the framebuffer without actual mapping.
> >> Then, during the memory region restore phase, we perform the mapping
> >> of the known address and update the VRAM region metadata (including
> >> previously registered pointer) accordingly.
> >>
> >> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> > 
> > Let me get this straight. The current sequence is:
> > 
> > - read physmap from xenstore, including vram and rom addresses
> > - vga initialization
> >   - register framebuffer with xen-hvm.c
> >   - set vram_ptr by mapping the vram region using xen_map_cache
> > - rtl8139 initialization
> >   - map rom files using xen_map_cache
> > 
> > The new sequence would be:
> > 
> > - vga initialization
> >   - register framebuffer and &vram_ptr with xen-hvm.c
> >   - set vram_ptr to NULL because we don't know the vram address yet
> > - rtl8139 initialization
> >   - map rom files using xen_map_cache ???
> > - the vram address is discovered as part of the savevm file
> > - when the vram region is mapped into the guest, set vram_ptr to the right value
> > 
> > 
> > Is that right? If so, why can't we just move the
> > 
> >   s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
> > 
> > line in vga.c to later? It would be better than changing the value of
> > vram_ptr behind the scenes. Clearer for the vga maintainers too.
> > 
> 
> Yes, it's one of the possible solutions. Probably would require more
> changes in VGA code. But I'll take a look at this.

Patch v4 is better in this regard, thanks.


> > But my main concern is actually rom files. The current physmap mechanism
> > also covers roms, such as the rtl8139 rom, which is used for pxebooting
> > from the VM. How do you plan to cover those?
> > 
> 
> Here is an excerpt from xen_add_to_physmap() which clearly indicates
> that the only region that we track now is VRAM region.
> 
>     if (mr == framebuffer && start_addr > 0xbffff) {
>         goto go_physmap;
>     }
>     return -1;
> 
> Maybe I'm missing something?

Looking at the code now, you are right that ROMs don't seem to be
tracked. We rely on QEMU "allocating" ROMs at the same addresses at
restore time. The allocation is skipped at the beginning of
xen_ram_alloc, but then the following xen_map_cache call will map the
ROM memory regardless. It works because the addresses are the same. (I
wonder if those addresses could change, causing a breakage.)


> >> v3:
> >> * Modify qemu_ram_ptr_length similarly with qemu_map_ram_ptr
> >> * Add a comment explaining qemu_map_ram_ptr and qemu_ram_ptr_length 
> >>   semantic change for Xen
> >> * Dropped some redundant changes
> >>
> >> v2:
> >> * Fix some building and coding style issues
> >>
> >> ---
> >>  exec.c               |  16 ++++++++
> >>  hw/display/vga.c     |   2 +-
> >>  include/hw/xen/xen.h |   2 +-
> >>  xen-hvm-stub.c       |   2 +-
> >>  xen-hvm.c            | 111 ++++++++++++---------------------------------------
> >>  5 files changed, 44 insertions(+), 89 deletions(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index aabb035..a1ac8cd 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -2008,6 +2008,14 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> >>          }
> >>  
> >>          block->host = xen_map_cache(block->offset, block->max_length, 1);
> >> +        if (block->host == NULL) {
> >> +            /* In case we cannot establish the mapping right away we might
> >> +             * still be able to do it later e.g. on a later stage of restore.
> >> +             * We don't touch the block and return NULL here to indicate
> >> +             * that intention.
> >> +             */
> >> +            return NULL;
> >> +        }
> >>      }
> >>      return ramblock_ptr(block, addr);
> >>  }
> >> @@ -2041,6 +2049,14 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> >>          }
> >>  
> >>          block->host = xen_map_cache(block->offset, block->max_length, 1);
> >> +        if (block->host == NULL) {
> >> +            /* In case we cannot establish the mapping right away we might
> >> +             * still be able to do it later e.g. on a later stage of restore.
> >> +             * We don't touch the block and return NULL here to indicate
> >> +             * that intention.
> >> +             */
> >> +            return NULL;
> >> +        }
> >>      }
> >>  
> >>      return ramblock_ptr(block, addr);
> >> diff --git a/hw/display/vga.c b/hw/display/vga.c
> >> index 69c3e1d..be554c2 100644
> >> --- a/hw/display/vga.c
> >> +++ b/hw/display/vga.c
> >> @@ -2163,7 +2163,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
> >>      memory_region_init_ram(&s->vram, obj, "vga.vram", s->vram_size,
> >>                             &error_fatal);
> >>      vmstate_register_ram(&s->vram, global_vmstate ? NULL : DEVICE(obj));
> >> -    xen_register_framebuffer(&s->vram);
> >> +    xen_register_framebuffer(&s->vram, &s->vram_ptr);
> >>      s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
> >>      s->get_bpp = vga_get_bpp;
> >>      s->get_offsets = vga_get_offsets;
> >> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> >> index 09c2ce5..3831843 100644
> >> --- a/include/hw/xen/xen.h
> >> +++ b/include/hw/xen/xen.h
> >> @@ -45,6 +45,6 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> >>                     struct MemoryRegion *mr, Error **errp);
> >>  void xen_modified_memory(ram_addr_t start, ram_addr_t length);
> >>  
> >> -void xen_register_framebuffer(struct MemoryRegion *mr);
> >> +void xen_register_framebuffer(struct MemoryRegion *mr, uint8_t **ptr);
> >>  
> >>  #endif /* QEMU_HW_XEN_H */
> >> diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
> >> index c500325..c89065e 100644
> >> --- a/xen-hvm-stub.c
> >> +++ b/xen-hvm-stub.c
> >> @@ -46,7 +46,7 @@ qemu_irq *xen_interrupt_controller_init(void)
> >>      return NULL;
> >>  }
> >>  
> >> -void xen_register_framebuffer(MemoryRegion *mr)
> >> +void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
> >>  {
> >>  }
> >>  
> >> diff --git a/xen-hvm.c b/xen-hvm.c
> >> index 5043beb..221334a 100644
> >> --- a/xen-hvm.c
> >> +++ b/xen-hvm.c
> >> @@ -41,6 +41,7 @@
> >>  
> >>  static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
> >>  static MemoryRegion *framebuffer;
> >> +static uint8_t **framebuffer_ptr;
> >>  static bool xen_in_migration;
> >>  
> >>  /* Compatibility with older version */
> >> @@ -317,7 +318,6 @@ static int xen_add_to_physmap(XenIOState *state,
> >>      XenPhysmap *physmap = NULL;
> >>      hwaddr pfn, start_gpfn;
> >>      hwaddr phys_offset = memory_region_get_ram_addr(mr);
> >> -    char path[80], value[17];
> >>      const char *mr_name;
> >>  
> >>      if (get_physmapping(state, start_addr, size)) {
> >> @@ -340,6 +340,25 @@ go_physmap:
> >>      DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
> >>              start_addr, start_addr + size);
> >>  
> >> +    mr_name = memory_region_name(mr);
> >> +
> >> +    physmap = g_malloc(sizeof(XenPhysmap));
> >> +
> >> +    physmap->start_addr = start_addr;
> >> +    physmap->size = size;
> >> +    physmap->name = mr_name;
> >> +    physmap->phys_offset = phys_offset;
> >> +
> >> +    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> >> +
> >> +    /* At this point we have a physmap entry for the framebuffer region
> >> +     * established during the restore phase so we can safely update the
> >> +     * registered framebuffer address here. */
> >> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> >> +        *framebuffer_ptr = memory_region_get_ram_ptr(framebuffer);
> >> +        return 0;
> >> +    }
> >> +
> >>      pfn = phys_offset >> TARGET_PAGE_BITS;
> >>      start_gpfn = start_addr >> TARGET_PAGE_BITS;
> >>      for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
> >> @@ -350,49 +369,17 @@ go_physmap:
> >>          if (rc) {
> >>              DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
> >>                      PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
> >> +
> >> +            QLIST_REMOVE(physmap, list);
> >> +            g_free(physmap);
> >>              return -rc;
> >>          }
> >>      }
> >>  
> >> -    mr_name = memory_region_name(mr);
> >> -
> >> -    physmap = g_malloc(sizeof (XenPhysmap));
> >> -
> >> -    physmap->start_addr = start_addr;
> >> -    physmap->size = size;
> >> -    physmap->name = mr_name;
> >> -    physmap->phys_offset = phys_offset;
> >> -
> >> -    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> >> -
> >>      xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
> >>                                     start_addr >> TARGET_PAGE_BITS,
> >>                                     (start_addr + size - 1) >> TARGET_PAGE_BITS,
> >>                                     XEN_DOMCTL_MEM_CACHEATTR_WB);
> >> -
> >> -    snprintf(path, sizeof(path),
> >> -            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
> >> -            xen_domid, (uint64_t)phys_offset);
> >> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
> >> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> >> -        return -1;
> >> -    }
> >> -    snprintf(path, sizeof(path),
> >> -            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
> >> -            xen_domid, (uint64_t)phys_offset);
> >> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
> >> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> >> -        return -1;
> >> -    }
> >> -    if (mr_name) {
> >> -        snprintf(path, sizeof(path),
> >> -                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
> >> -                xen_domid, (uint64_t)phys_offset);
> >> -        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name))) {
> >> -            return -1;
> >> -        }
> >> -    }
> >> -
> >>      return 0;
> >>  }
> >>  
> >> @@ -1152,54 +1139,6 @@ static void xen_exit_notifier(Notifier *n, void *data)
> >>      xs_daemon_close(state->xenstore);
> >>  }
> >>  
> >> -static void xen_read_physmap(XenIOState *state)
> >> -{
> >> -    XenPhysmap *physmap = NULL;
> >> -    unsigned int len, num, i;
> >> -    char path[80], *value = NULL;
> >> -    char **entries = NULL;
> >> -
> >> -    snprintf(path, sizeof(path),
> >> -            "/local/domain/0/device-model/%d/physmap", xen_domid);
> >> -    entries = xs_directory(state->xenstore, 0, path, &num);
> >> -    if (entries == NULL)
> >> -        return;
> >> -
> >> -    for (i = 0; i < num; i++) {
> >> -        physmap = g_malloc(sizeof (XenPhysmap));
> >> -        physmap->phys_offset = strtoull(entries[i], NULL, 16);
> >> -        snprintf(path, sizeof(path),
> >> -                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
> >> -                xen_domid, entries[i]);
> >> -        value = xs_read(state->xenstore, 0, path, &len);
> >> -        if (value == NULL) {
> >> -            g_free(physmap);
> >> -            continue;
> >> -        }
> >> -        physmap->start_addr = strtoull(value, NULL, 16);
> >> -        free(value);
> >> -
> >> -        snprintf(path, sizeof(path),
> >> -                "/local/domain/0/device-model/%d/physmap/%s/size",
> >> -                xen_domid, entries[i]);
> >> -        value = xs_read(state->xenstore, 0, path, &len);
> >> -        if (value == NULL) {
> >> -            g_free(physmap);
> >> -            continue;
> >> -        }
> >> -        physmap->size = strtoull(value, NULL, 16);
> >> -        free(value);
> >> -
> >> -        snprintf(path, sizeof(path),
> >> -                "/local/domain/0/device-model/%d/physmap/%s/name",
> >> -                xen_domid, entries[i]);
> >> -        physmap->name = xs_read(state->xenstore, 0, path, &len);
> >> -
> >> -        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> >> -    }
> >> -    free(entries);
> >> -}
> >> -
> >>  static void xen_wakeup_notifier(Notifier *notifier, void *data)
> >>  {
> >>      xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
> >> @@ -1339,7 +1278,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
> >>          goto err;
> >>      }
> >>      xen_be_register_common();
> >> -    xen_read_physmap(state);
> >>  
> >>      /* Disable ACPI build because Xen handles it */
> >>      pcms->acpi_build_enabled = false;
> >> @@ -1374,9 +1312,10 @@ void destroy_hvm_domain(bool reboot)
> >>      }
> >>  }
> >>  
> >> -void xen_register_framebuffer(MemoryRegion *mr)
> >> +void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
> >>  {
> >>      framebuffer = mr;
> >> +    framebuffer_ptr = ptr;
> >>  }
> >>  
> >>  void xen_shutdown_fatal_error(const char *fmt, ...)
> >> -- 
> >> 2.7.4
> >>
> 
