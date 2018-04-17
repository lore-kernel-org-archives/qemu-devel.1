Received: from eggs.gnu.org ([2001:4830:134:3::10]:40811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8PdF-0004mS-7q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8PdD-0007Ys-Jd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:22:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8PdD-0007YV-Cm
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:22:43 -0400
Received: by mail-oi0-x243.google.com with SMTP id y20-v6so6248274oix.5
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 05:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-16-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-16-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 13:22:21 +0100
Message-ID: <CAFEAcA_tWGs5RjpiueCnVSwvjUZqF0xNcVAfT+AiYeSA6VbAog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 15/17] hw/arm/smmuv3: Cache/invalidate
 config data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:38, Eric Auger <eric.auger@redhat.com> wrote:
> Let's cache config data to avoid fetching and parsing STE/CD
> structures on each translation. We invalidate them on data structure
> invalidation commands.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmu-common.c         |  24 +++++++-
>  hw/arm/smmuv3.c              | 129 ++++++++++++++++++++++++++++++++++++++++---
>  hw/arm/trace-events          |   6 ++
>  include/hw/arm/smmu-common.h |   3 +
>  include/hw/arm/smmuv3.h      |   1 +
>  5 files changed, 152 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 6a58948..c271a28 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -297,6 +297,24 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>      return &sdev->as;
>  }
>
> +IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
> +{
> +    uint8_t bus_n, devfn;
> +    SMMUPciBus *smmu_bus;
> +    SMMUDevice *smmu;
> +
> +    bus_n = PCI_BUS_NUM(sid);
> +    smmu_bus = smmu_find_smmu_pcibus(s, bus_n);
> +    if (smmu_bus) {
> +        devfn = sid & 0x7;
> +        smmu = smmu_bus->pbdev[devfn];
> +        if (smmu) {
> +            return &smmu->iommu;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
> @@ -308,7 +326,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> +    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>
>      if (s->primary_bus) {
> @@ -320,7 +338,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>
>  static void smmu_base_reset(DeviceState *dev)
>  {
> -    /* will be filled later on */
> +    SMMUState *s = ARM_SMMU(dev);
> +
> +    g_hash_table_remove_all(s->configs);
>  }
>
>  static Property smmu_dev_properties[] = {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6e0d7ad..938052e 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -537,6 +537,38 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>      return decode_cd(cfg, &cd, event);
>  }
>
> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
> +{
> +    SMMUv3State *s = sdev->smmu;
> +    SMMUState *bc = &s->smmu_state;
> +    SMMUTransCfg *cfg;
> +
> +    cfg = g_hash_table_lookup(bc->configs, sdev);

A comment somewhere that explains what exactly this cache
is caching (in terms of the architectural data structures,
STE, CD, etc) would be helpful.

> +    trace_smmuv3_config_cache_hit(((pci_bus_num(sdev->bus) & 0xff) << 8) |
> +                                  sdev->devfn);
> +    if (!cfg) {
> +        trace_smmuv3_config_cache_miss(((pci_bus_num(sdev->bus) & 0xff) << 8) |
> +                                       sdev->devfn);

In the cache miss code path you trace both the message
for cache hit and then the one for cache miss.

You could use smmu_get_sid() here rather than open-coding
the bus-number/devfn expression, I think.

> +        cfg = g_new0(SMMUTransCfg, 1);
> +        g_hash_table_insert(bc->configs, sdev, cfg);
> +
> +        if (smmuv3_decode_config(&sdev->iommu, cfg, event)) {
> +            g_hash_table_remove(bc->configs, sdev);

Could we just not insert it in the first place if this
condition is true ?

> +        }
> +    }
> +    return cfg;
> +}
> +
> +static void smmuv3_put_config(SMMUDevice *sdev)
> +{
> +    SMMUv3State *s = sdev->smmu;
> +    SMMUState *bc = &s->smmu_state;
> +
> +    trace_smmuv3_config_cache_inv(((pci_bus_num(sdev->bus) & 0xff) << 8) |
> +                                  sdev->devfn);
> +    g_hash_table_remove(bc->configs, sdev);

This seems an odd name for this function.

> +}
> +
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag)
>  {
> @@ -545,7 +577,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      uint32_t sid = smmu_get_sid(sdev);
>      SMMUEventInfo event = {.type = SMMU_EVT_OK, .sid = sid};
>      SMMUPTWEventInfo ptw_info = {};
> -    SMMUTransCfg cfg = {};
> +    SMMUTransCfg *cfg = NULL;
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
> @@ -556,19 +588,26 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      int ret = 0;
>
>      if (!smmu_enabled(s)) {
> +        return entry;

Making this do a 'return' loses the tracepoint tracing for this case.

> +    }
> +
> +    /*
> +     * the lock is held to sequentialize invalidation commands and
> +     * translation operations
> +     */
> +    qemu_mutex_lock(&s->mutex);

Aren't we operating under the BQL here? Per device mutexes
make me nervous about locking order issues.

> +
> +    cfg = smmuv3_get_config(sdev, &event);
> +    if (!cfg) {
> +        ret = -EINVAL;
>          goto out;
>      }
>
> -    ret = smmuv3_decode_config(mr, &cfg, &event);
> -    if (ret) {
> +    if (cfg->aborted) {
>          goto out;
>      }
>
> -    if (cfg.aborted) {
> -        goto out;
> -    }
> -
> -    ret = smmu_ptw(&cfg, addr, flag, &entry, &ptw_info);
> +    ret = smmu_ptw(cfg, addr, flag, &entry, &ptw_info);
>      if (ret) {
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
> @@ -617,17 +656,20 @@ out:
>                        mr->parent_obj.name, addr, ret);
>          entry.perm = IOMMU_NONE;
>          smmuv3_record_event(s, &event);
> -    } else if (!cfg.aborted) {
> +    } else if (!cfg->aborted) {
>          entry.perm = flag;
>          trace_smmuv3_translate(mr->parent_obj.name, sid, addr,
>                                 entry.translated_addr, entry.perm);
>      }
>
> +    qemu_mutex_unlock(&s->mutex);
> +
>      return entry;
>  }
>
>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
> +    SMMUState *bs = ARM_SMMU(s);
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>      SMMUQueue *q = &s->cmdq;
>      SMMUCommandType type = 0;
> @@ -662,6 +704,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>
>          trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
>
> +        qemu_mutex_lock(&s->mutex);
>          switch (type) {
>          case SMMU_CMD_SYNC:
>              if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
> @@ -670,10 +713,74 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              break;
>          case SMMU_CMD_PREFETCH_CONFIG:
>          case SMMU_CMD_PREFETCH_ADDR:
> +            break;
>          case SMMU_CMD_CFGI_STE:
> +        {
> +            uint32_t sid = CMD_SID(&cmd);
> +            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
> +            SMMUDevice *sdev;
> +
> +            if (CMD_SSEC(&cmd)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
> +            if (!mr) {
> +                break;
> +            }
> +
> +            trace_smmuv3_cmdq_cfgi_ste(sid);
> +            sdev = container_of(mr, SMMUDevice, iommu);
> +            smmuv3_put_config(sdev);
> +
> +            break;
> +        }
>          case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
> +        {
> +            uint32_t start = CMD_SID(&cmd), end, i;
> +            uint8_t range = CMD_STE_RANGE(&cmd);
> +
> +            if (CMD_SSEC(&cmd)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
> +            end = start + (1 << (range + 1)) - 1;
> +            trace_smmuv3_cmdq_cfgi_ste_range(start, end);
> +
> +            for (i = start; i <= end; i++) {
> +                IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, i);
> +                SMMUDevice *sdev;
> +
> +                if (!mr) {
> +                    continue;
> +                }
> +                sdev = container_of(mr, SMMUDevice, iommu);
> +                smmuv3_put_config(sdev);
> +            }
> +            break;
> +        }
>          case SMMU_CMD_CFGI_CD:
>          case SMMU_CMD_CFGI_CD_ALL:
> +        {
> +            uint32_t sid = CMD_SID(&cmd);
> +            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
> +            SMMUDevice *sdev;
> +
> +            if (CMD_SSEC(&cmd)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
> +            if (!mr) {
> +                break;
> +            }
> +
> +            trace_smmuv3_cmdq_cfgi_cd(sid);
> +            sdev = container_of(mr, SMMUDevice, iommu);
> +            smmuv3_put_config(sdev);
> +            break;
> +        }
>          case SMMU_CMD_TLBI_NH_ALL:
>          case SMMU_CMD_TLBI_NH_ASID:
>          case SMMU_CMD_TLBI_NH_VA:
> @@ -700,6 +807,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              break;
>          }
>          if (cmd_error) {
> +            qemu_mutex_unlock(&s->mutex);
>              break;
>          }
>          /*
> @@ -708,6 +816,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>           * and does not check the completion of previous commands
>           */
>          queue_cons_incr(q);
> +        qemu_mutex_unlock(&s->mutex);
>      }
>
>      if (cmd_error) {
> @@ -1078,6 +1187,8 @@ static void smmu_realize(DeviceState *d, Error **errp)
>          return;
>      }
>
> +    qemu_mutex_init(&s->mutex);
> +
>      memory_region_init_io(&sys->iomem, OBJECT(s),
>                            &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
>
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 032de48..ecc30be 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -39,3 +39,9 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>  smmuv3_translate(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, int initial_level) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d, initial_level = %d"
> +smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
> +smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
> +smmuv3_cmdq_cfgi_cd(uint32_t sid) "     |_ streamid = %d"
> +smmuv3_config_cache_hit(uint32_t sid) "Config cache HIT for sid %d"
> +smmuv3_config_cache_miss(uint32_t sid) "Config cache MISS for sid %d"
> +smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 4ccd131..ff07734 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -143,4 +143,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>   */
>  SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
>
> +/* Return the iommu mr associated to @sid, or NULL if none */
> +IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
> +
>  #endif  /* HW_ARM_SMMU_COMMON */
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 23f7036..36b2f45 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -59,6 +59,7 @@ typedef struct SMMUv3State {
>      SMMUQueue eventq, cmdq;
>
>      qemu_irq     irq[4];
> +    QemuMutex mutex;
>  } SMMUv3State;
>
>  typedef enum {
> --
> 2.5.5

thanks
-- PMM
