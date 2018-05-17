Received: from eggs.gnu.org ([2001:4830:134:3::10]:40464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJFRZ-0006f0-6m
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJFRX-0005Sy-I5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:43:29 -0400
References: <1526495474-26394-1-git-send-email-eric.auger@redhat.com>
	<1526495474-26394-2-git-send-email-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0c16c6ac-7bd6-03b7-b67f-50b8737e57a1@redhat.com>
Date: Thu, 17 May 2018 11:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <1526495474-26394-2-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/smmuv3: Cache/invalidate config
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

Hi Peter,

On 05/16/2018 08:31 PM, Eric Auger wrote:
> Let's cache config data to avoid fetching and parsing STE/CD
> structures on each translation. We invalidate them on data structure
> invalidation commands.

You may remember that initially I was taking a QemuMutex to protect
IOTLB/cache structures against concurrent access. I checked whether the
BQL was hold on translate and I did not notice any case where it isn't.
However I may have missed some, featuring virtio-blk-pci where
translates are called from IO threads. Looks the problem was reported on
Intel and Peter's is trying to fix the issue with the introduction of a
local mutex.

[Qemu-devel] [PATCH v2 03/10] intel-iommu: add iommu lock
http://patchwork.ozlabs.org/patch/908464/

Also please see the original thread:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04153.html

So I think I may respin this series with the addition of the QemuMutex.

Thanks

Eric
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v11 -> v12:
> - only insert the new config if decode_cfg succeeds
> - use smmu_get_sid for trace_* and store hits/misses in the SMMUDevice
> - s/smmuv3_put_config/smmuv3_flush_config
> - document smmuv3_get_config
> - removing the mutex as BQL does the job
> ---
>  hw/arm/smmu-common.c         |  26 ++++++++-
>  hw/arm/smmuv3.c              | 130 +++++++++++++++++++++++++++++++++++++++++--
>  hw/arm/trace-events          |   6 ++
>  include/hw/arm/smmu-common.h |   5 ++
>  4 files changed, 159 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3c5f724..7e9827d 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -297,6 +297,8 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>          sdev->smmu = s;
>          sdev->bus = bus;
>          sdev->devfn = devfn;
> +        sdev->cfg_cache_misses = 0;
> +        sdev->cfg_cache_hits = 0;
>  
>          memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
>                                   s->mrtypename,
> @@ -310,6 +312,24 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
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
> @@ -321,7 +341,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> +    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>  
>      if (s->primary_bus) {
> @@ -333,7 +353,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
> index 42dc521..d3b64c2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -537,6 +537,58 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>      return decode_cd(cfg, &cd, event);
>  }
>  
> +/**
> + * smmuv3_get_config - Look up for a cached copy of configuration data for
> + * @sdev and on cache miss performs a configuration structure decoding from
> + * guest RAM.
> + *
> + * @sdev: SMMUDevice handle
> + * @event: output event info
> + *
> + * The configuration cache contains data resulting from both STE and CD
> + * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
> + * by the SMMUDevice handle.
> + */
> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
> +{
> +    SMMUv3State *s = sdev->smmu;
> +    SMMUState *bc = &s->smmu_state;
> +    SMMUTransCfg *cfg;
> +
> +    cfg = g_hash_table_lookup(bc->configs, sdev);
> +    if (cfg) {
> +        sdev->cfg_cache_hits += 1;
> +        trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
> +                            sdev->cfg_cache_hits, sdev->cfg_cache_misses,
> +                            100 * sdev->cfg_cache_hits /
> +                            (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
> +    } else {
> +        sdev->cfg_cache_misses += 1;
> +        trace_smmuv3_config_cache_miss(smmu_get_sid(sdev),
> +                            sdev->cfg_cache_hits, sdev->cfg_cache_misses,
> +                            100 * sdev->cfg_cache_hits /
> +                            (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
> +        cfg = g_new0(SMMUTransCfg, 1);
> +
> +        if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
> +            g_hash_table_insert(bc->configs, sdev, cfg);
> +        } else {
> +            g_free(cfg);
> +            cfg = NULL;
> +        }
> +    }
> +    return cfg;
> +}
> +
> +static void smmuv3_flush_config(SMMUDevice *sdev)
> +{
> +    SMMUv3State *s = sdev->smmu;
> +    SMMUState *bc = &s->smmu_state;
> +
> +    trace_smmuv3_config_cache_inv(smmu_get_sid(sdev));
> +    g_hash_table_remove(bc->configs, sdev);
> +}
> +
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag)
>  {
> @@ -545,7 +597,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      uint32_t sid = smmu_get_sid(sdev);
>      SMMUEventInfo event = {.type = SMMU_EVT_OK, .sid = sid};
>      SMMUPTWEventInfo ptw_info = {};
> -    SMMUTransCfg cfg = {};
> +    SMMUTransCfg *cfg = NULL;
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
> @@ -559,16 +611,17 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto out;
>      }
>  
> -    ret = smmuv3_decode_config(mr, &cfg, &event);
> -    if (ret) {
> +    cfg = smmuv3_get_config(sdev, &event);
> +    if (!cfg) {
> +        ret = -EINVAL;
>          goto out;
>      }
>  
> -    if (cfg.aborted) {
> +    if (cfg->aborted) {
>          goto out;
>      }
>  
> -    ret = smmu_ptw(&cfg, addr, flag, &entry, &ptw_info);
> +    ret = smmu_ptw(cfg, addr, flag, &entry, &ptw_info);
>      if (ret) {
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
> @@ -617,7 +670,7 @@ out:
>                        mr->parent_obj.name, addr, ret);
>          entry.perm = IOMMU_NONE;
>          smmuv3_record_event(s, &event);
> -    } else if (!cfg.aborted) {
> +    } else if (!cfg->aborted) {
>          entry.perm = flag;
>          trace_smmuv3_translate(mr->parent_obj.name, sid, addr,
>                                 entry.translated_addr, entry.perm);
> @@ -628,6 +681,7 @@ out:
>  
>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
> +    SMMUState *bs = ARM_SMMU(s);
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>      SMMUQueue *q = &s->cmdq;
>      SMMUCommandType type = 0;
> @@ -670,10 +724,74 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
> +            smmuv3_flush_config(sdev);
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
> +                smmuv3_flush_config(sdev);
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
> +            smmuv3_flush_config(sdev);
> +            break;
> +        }
>          case SMMU_CMD_TLBI_NH_ALL:
>          case SMMU_CMD_TLBI_NH_ASID:
>          case SMMU_CMD_TLBI_NH_VA:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 2d92727..fe4c2a8 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -39,3 +39,9 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>  smmuv3_translate(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d"
> +smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
> +smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
> +smmuv3_cmdq_cfgi_cd(uint32_t sid) "     |_ streamid = %d"
> +smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
> +smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
> +smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index c41eb5c..7ce95ca 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -75,6 +75,8 @@ typedef struct SMMUDevice {
>      int                devfn;
>      IOMMUMemoryRegion  iommu;
>      AddressSpace       as;
> +    uint32_t           cfg_cache_hits;
> +    uint32_t           cfg_cache_misses;
>  } SMMUDevice;
>  
>  typedef struct SMMUNotifierNode {
> @@ -142,4 +144,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>   */
>  SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
>  
> +/* Return the iommu mr associated to @sid, or NULL if none */
> +IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
> +
>  #endif  /* HW_ARM_SMMU_COMMON */
> 
