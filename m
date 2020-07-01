Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93221C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A24320771
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgWA-0001JQ-ME
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqgVS-0000gA-GP; Wed, 01 Jul 2020 13:26:46 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqgVO-0002Tb-Sl; Wed, 01 Jul 2020 13:26:45 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6BB85BF64B;
 Wed,  1 Jul 2020 17:26:39 +0000 (UTC)
Date: Wed, 1 Jul 2020 19:26:35 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 17/18] hw/block/nvme: Use zone metadata file for
 persistence
Message-ID: <20200701172635.iqfw53xlq2uufb6c@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-18-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-18-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:11:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:34, Dmitry Fomichev wrote:
> A ZNS drive that is emulated by this driver is currently initialized
> with all zones Empty upon startup. However, actual ZNS SSDs save the
> state and condition of all zones in their internal NVRAM in the event
> of power loss. When such a drive is powered up again, it closes or
> finishes all zones that were open at the moment of shutdown. Besides
> that, the write pointer position as well as the state and condition
> of all zones is preserved across power-downs.
> 
> This commit adds the capability to have a persistent zone metadata
> to the driver. The new optional driver property, "zone_file",
> is introduced. If added to the command line, this property specifies
> the name of the file that stores the zone metadata. If "zone_file" is
> omitted, the driver will initialize with all zones empty, the same as
> before.
> 
> If zone metadata is configured to be persistent, then zone descriptor
> extensions also persist across controller shutdowns.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Stefan, before I review this in depth, can you comment on if mmap'ing a
file from a device model and issuing regular msync's is an acceptable
approach to storing state persistently across QEMU invocations?

I could not find any examples of this in hw/, so I am unsure. I
implemented something like this using an additional blockdev on the
device and doing blk_aio's, but just mmaping a file seems much simpler,
but at the cost of portability? On the other hand, I can't find any
examples of using an additional blockdev either.

Can you shed any light on the preferred approach?

> ---
>  hw/block/nvme.c | 371 +++++++++++++++++++++++++++++++++++++++++++++---
>  hw/block/nvme.h |  38 +++++
>  2 files changed, 388 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 14d5f1d155..63e7a6352e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -69,6 +69,8 @@
>      } while (0)
>  
>  static void nvme_process_sq(void *opaque);
> +static void nvme_sync_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, int len);
>  
>  /*
>   * Add a zone to the tail of a zone list.
> @@ -90,6 +92,7 @@ static void nvme_add_zone_tail(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
>          zl->tail = idx;
>      }
>      zl->size++;
> +    nvme_set_zone_meta_dirty(n, ns, true);
>  }
>  
>  /*
> @@ -106,12 +109,15 @@ static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
>      if (zl->size == 0) {
>          zl->head = NVME_ZONE_LIST_NIL;
>          zl->tail = NVME_ZONE_LIST_NIL;
> +        nvme_set_zone_meta_dirty(n, ns, true);
>      } else if (idx == zl->head) {
>          zl->head = zone->next;
>          ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
> +        nvme_set_zone_meta_dirty(n, ns, true);
>      } else if (idx == zl->tail) {
>          zl->tail = zone->prev;
>          ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
> +        nvme_set_zone_meta_dirty(n, ns, true);
>      } else {
>          ns->zone_array[zone->next].prev = zone->prev;
>          ns->zone_array[zone->prev].next = zone->next;
> @@ -138,6 +144,7 @@ static NvmeZone *nvme_remove_zone_head(NvmeCtrl *n, NvmeNamespace *ns,
>              ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
>          }
>          zone->prev = zone->next = 0;
> +        nvme_set_zone_meta_dirty(n, ns, true);
>      }
>  
>      return zone;
> @@ -476,6 +483,7 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
>      case NVME_ZONE_STATE_READ_ONLY:
>          zone->tstamp = 0;
>      }
> +    nvme_sync_zone_file(n, ns, zone, sizeof(NvmeZone));
>  }
>  
>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> @@ -2976,9 +2984,114 @@ static const MemoryRegionOps nvme_cmb_ops = {
>      },
>  };
>  
> -static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
> +static int nvme_validate_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
>      uint64_t capacity)
>  {
> +    NvmeZoneMeta *meta = ns->zone_meta;
> +    NvmeZone *zone = ns->zone_array;
> +    uint64_t start = 0, zone_size = n->params.zone_size;
> +    int i, n_imp_open = 0, n_exp_open = 0, n_closed = 0, n_full = 0;
> +
> +    if (meta->magic != NVME_ZONE_META_MAGIC) {
> +        return 1;
> +    }
> +    if (meta->version != NVME_ZONE_META_VER) {
> +        return 2;
> +    }
> +    if (meta->zone_size != zone_size) {
> +        return 3;
> +    }
> +    if (meta->zone_capacity != n->params.zone_capacity) {
> +        return 4;
> +    }
> +    if (meta->nr_offline_zones != n->params.nr_offline_zones) {
> +        return 5;
> +    }
> +    if (meta->nr_rdonly_zones != n->params.nr_rdonly_zones) {
> +        return 6;
> +    }
> +    if (meta->lba_size != n->conf.logical_block_size) {
> +        return 7;
> +    }
> +    if (meta->zd_extension_size != n->params.zd_extension_size) {
> +        return 8;
> +    }
> +
> +    for (i = 0; i < n->num_zones; i++, zone++) {
> +        if (start + zone_size > capacity) {
> +            zone_size = capacity - start;
> +        }
> +        if (zone->d.zt != NVME_ZONE_TYPE_SEQ_WRITE) {
> +            return 9;
> +        }
> +        if (zone->d.zcap != n->params.zone_capacity) {
> +            return 10;
> +        }
> +        if (zone->d.zslba != start) {
> +            return 11;
> +        }
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_EMPTY:
> +        case NVME_ZONE_STATE_OFFLINE:
> +        case NVME_ZONE_STATE_READ_ONLY:
> +            if (zone->d.wp != start) {
> +                return 12;
> +            }
> +            break;
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +            if (zone->d.wp < start ||
> +                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
> +                return 13;
> +            }
> +            n_imp_open++;
> +            break;
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +            if (zone->d.wp < start ||
> +                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
> +                return 13;
> +            }
> +            n_exp_open++;
> +            break;
> +        case NVME_ZONE_STATE_CLOSED:
> +            if (zone->d.wp < start ||
> +                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
> +                return 13;
> +            }
> +            n_closed++;
> +            break;
> +        case NVME_ZONE_STATE_FULL:
> +            if (zone->d.wp != zone->d.zslba + zone->d.zcap) {
> +                return 14;
> +            }
> +            n_full++;
> +            break;
> +        default:
> +            return 15;
> +        }
> +
> +        start += zone_size;
> +    }
> +
> +    if (n_imp_open != nvme_zone_list_size(ns->exp_open_zones)) {
> +        return 16;
> +    }
> +    if (n_exp_open != nvme_zone_list_size(ns->imp_open_zones)) {
> +        return 17;
> +    }
> +    if (n_closed != nvme_zone_list_size(ns->closed_zones)) {
> +        return 18;
> +    }
> +    if (n_full != nvme_zone_list_size(ns->full_zones)) {
> +        return 19;
> +    }
> +
> +    return 0;
> +}
> +
> +static int nvme_init_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
> +    uint64_t capacity)
> +{
> +    NvmeZoneMeta *meta = ns->zone_meta;
>      NvmeZone *zone;
>      Error *err;
>      uint64_t start = 0, zone_size = n->params.zone_size;
> @@ -2986,18 +3099,33 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
>      int i;
>      uint16_t zs;
>  
> -    ns->zone_array = g_malloc0(n->zone_array_size);
> -    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> -    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> -    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
> -    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
> -    ns->zd_extensions = g_malloc0(n->params.zd_extension_size * n->num_zones);
> +    if (n->params.zone_file) {
> +        meta->magic = NVME_ZONE_META_MAGIC;
> +        meta->version = NVME_ZONE_META_VER;
> +        meta->zone_size = zone_size;
> +        meta->zone_capacity = n->params.zone_capacity;
> +        meta->lba_size = n->conf.logical_block_size;
> +        meta->nr_offline_zones = n->params.nr_offline_zones;
> +        meta->nr_rdonly_zones = n->params.nr_rdonly_zones;
> +        meta->zd_extension_size = n->params.zd_extension_size;
> +    } else {
> +        ns->zone_array = g_malloc0(n->zone_array_size);
> +        ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> +        ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> +        ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
> +        ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
> +        ns->zd_extensions =
> +            g_malloc0(n->params.zd_extension_size * n->num_zones);
> +    }
>      zone = ns->zone_array;
>  
>      nvme_init_zone_list(ns->exp_open_zones);
>      nvme_init_zone_list(ns->imp_open_zones);
>      nvme_init_zone_list(ns->closed_zones);
>      nvme_init_zone_list(ns->full_zones);
> +    if (n->params.zone_file) {
> +        nvme_set_zone_meta_dirty(n, ns, true);
> +    }
>  
>      for (i = 0; i < n->num_zones; i++, zone++) {
>          if (start + zone_size > capacity) {
> @@ -3048,7 +3176,189 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
>      return 0;
>  }
>  
> -static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
> +static int nvme_open_zone_file(NvmeCtrl *n, bool *init_meta)
> +{
> +    struct stat statbuf;
> +    size_t fsize;
> +    int ret;
> +
> +    ret = stat(n->params.zone_file, &statbuf);
> +    if (ret && errno == ENOENT) {
> +        *init_meta = true;
> +    } else if (!S_ISREG(statbuf.st_mode)) {
> +        fprintf(stderr, "%s is not a regular file\n", strerror(errno));
> +        return -1;
> +    }
> +
> +    n->zone_file_fd = open(n->params.zone_file,
> +                           O_RDWR | O_LARGEFILE | O_BINARY | O_CREAT, 644);
> +    if (n->zone_file_fd < 0) {
> +            fprintf(stderr, "failed to create zone file %s, err %s\n",
> +                    n->params.zone_file, strerror(errno));
> +            return -1;
> +    }
> +
> +    fsize = n->meta_size * n->num_namespaces;
> +
> +    if (stat(n->params.zone_file, &statbuf)) {
> +        fprintf(stderr, "can't stat zone file %s, err %s\n",
> +                n->params.zone_file, strerror(errno));
> +        return -1;
> +    }
> +    if (statbuf.st_size != fsize) {
> +        ret = ftruncate(n->zone_file_fd, fsize);
> +        if (ret < 0) {
> +            fprintf(stderr, "can't truncate zone file %s, err %s\n",
> +                    n->params.zone_file, strerror(errno));
> +            return -1;
> +        }
> +        *init_meta = true;
> +    }
> +
> +    return 0;
> +}
> +
> +static int nvme_map_zone_file(NvmeCtrl *n, NvmeNamespace *ns, bool *init_meta)
> +{
> +    off_t meta_ofs = n->meta_size * (ns->nsid - 1);
> +
> +    ns->zone_meta = mmap(0, n->meta_size, PROT_READ | PROT_WRITE,
> +                         MAP_SHARED, n->zone_file_fd, meta_ofs);
> +    if (ns->zone_meta == MAP_FAILED) {
> +        fprintf(stderr, "failed to map zone file %s, ofs %lu, err %s\n",
> +                n->params.zone_file, meta_ofs, strerror(errno));
> +        return -1;
> +    }
> +
> +    ns->zone_array = (NvmeZone *)(ns->zone_meta + 1);
> +    ns->exp_open_zones = &ns->zone_meta->exp_open_zones;
> +    ns->imp_open_zones = &ns->zone_meta->imp_open_zones;
> +    ns->closed_zones = &ns->zone_meta->closed_zones;
> +    ns->full_zones = &ns->zone_meta->full_zones;
> +
> +    if (n->params.zd_extension_size) {
> +        ns->zd_extensions = (uint8_t *)(ns->zone_meta + 1);
> +        ns->zd_extensions += n->zone_array_size;
> +    }
> +
> +    return 0;
> +}
> +
> +static void nvme_sync_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, int len)
> +{
> +    uintptr_t addr, zd = (uintptr_t)zone;
> +
> +    addr = zd & qemu_real_host_page_mask;
> +    len += zd - addr;
> +    if (msync((void *)addr, len, MS_ASYNC) < 0)
> +        fprintf(stderr, "msync: failed to sync zone descriptors, file %s\n",
> +                strerror(errno));
> +
> +    if (nvme_zone_meta_dirty(n, ns)) {
> +        nvme_set_zone_meta_dirty(n, ns, false);
> +        if (msync(ns->zone_meta, sizeof(NvmeZoneMeta), MS_ASYNC) < 0)
> +            fprintf(stderr, "msync: failed to sync zone meta, file %s\n",
> +                    strerror(errno));
> +    }
> +}
> +
> +/*
> + * Close or finish all the zones that might be still open after power-down.
> + */
> +static void nvme_prepare_zones(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    NvmeZone *zone;
> +    uint32_t set_state;
> +    int i;
> +
> +    assert(!ns->nr_active_zones);
> +    assert(!ns->nr_open_zones);
> +
> +    zone = ns->zone_array;
> +    for (i = 0; i < n->num_zones; i++, zone++) {
> +        zone->flags = 0;
> +        zone->tstamp = 0;
> +
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +            break;
> +        case NVME_ZONE_STATE_CLOSED:
> +            nvme_aor_inc_active(n, ns);
> +            /* pass through */
> +        default:
> +            continue;
> +        }
> +
> +        if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
> +            set_state = NVME_ZONE_STATE_CLOSED;
> +        } else if (zone->d.wp == zone->d.zslba) {
> +            set_state = NVME_ZONE_STATE_EMPTY;
> +        } else if (n->params.max_active_zones == 0 ||
> +                   ns->nr_active_zones < n->params.max_active_zones) {
> +            set_state = NVME_ZONE_STATE_CLOSED;
> +        } else {
> +            set_state = NVME_ZONE_STATE_FULL;
> +        }
> +
> +        switch (set_state) {
> +        case NVME_ZONE_STATE_CLOSED:
> +            trace_pci_nvme_power_on_close(nvme_get_zone_state(zone),
> +                                          zone->d.zslba);
> +            nvme_aor_inc_active(n, ns);
> +            nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
> +        break;
> +        case NVME_ZONE_STATE_EMPTY:
> +            trace_pci_nvme_power_on_reset(nvme_get_zone_state(zone),
> +                                          zone->d.zslba);
> +        break;
> +        case NVME_ZONE_STATE_FULL:
> +            trace_pci_nvme_power_on_full(nvme_get_zone_state(zone),
> +                                         zone->d.zslba);
> +            zone->d.wp = nvme_zone_wr_boundary(zone);
> +        }
> +
> +        nvme_set_zone_state(zone, set_state);
> +    }
> +}
> +
> +static int nvme_load_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
> +    uint64_t capacity, bool init_meta)
> +{
> +    int ret = 0;
> +
> +    if (n->params.zone_file) {
> +        ret = nvme_map_zone_file(n, ns, &init_meta);
> +        trace_pci_nvme_mapped_zone_file(n->params.zone_file, ret);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        if (!init_meta) {
> +            ret = nvme_validate_zone_file(n, ns, capacity);
> +            if (ret) {
> +                trace_pci_nvme_err_zone_file_invalid(ret);
> +                init_meta = true;
> +            }
> +        }
> +    } else {
> +        init_meta = true;
> +    }
> +
> +    if (init_meta) {
> +        ret = nvme_init_zone_file(n, ns, capacity);
> +    } else {
> +        nvme_prepare_zones(n, ns);
> +    }
> +    if (!ret && n->params.zone_file) {
> +        nvme_sync_zone_file(n, ns, ns->zone_array, n->zone_array_size);
> +    }
> +
> +    return ret;
> +}
> +
> +static void nvme_zoned_init_ctrl(NvmeCtrl *n, bool *init_meta, Error **errp)
>  {
>      uint64_t zone_size = 0, capacity;
>      uint32_t nz;
> @@ -3084,6 +3394,9 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
>      nz = DIV_ROUND_UP(capacity, zone_size);
>      n->num_zones = nz;
>      n->zone_array_size = sizeof(NvmeZone) * nz;
> +    n->meta_size = sizeof(NvmeZoneMeta) + n->zone_array_size +
> +                          nz * n->params.zd_extension_size;
> +    n->meta_size = ROUND_UP(n->meta_size, qemu_real_host_page_size);
>  
>      n->params.rzr_delay_usec *= SCALE_MS;
>      n->params.rrl_usec *= SCALE_MS;
> @@ -3119,6 +3432,13 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
>          }
>      }
>  
> +    if (n->params.zone_file) {
> +        if (nvme_open_zone_file(n, init_meta) < 0) {
> +            error_setg(errp, "cannot open zone metadata file");
> +            return;
> +        }
> +    }
> +
>      if (n->params.zone_async_events) {
>          n->ae_cfg |= NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES;
>      }
> @@ -3127,13 +3447,14 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
>  }
>  
>  static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
> -    Error **errp)
> +    bool init_meta, Error **errp)
>  {
>      int ret;
>  
> -    ret = nvme_init_zone_meta(n, ns, n->num_zones * n->params.zone_size);
> +    ret = nvme_load_zone_meta(n, ns, n->num_zones * n->params.zone_size,
> +                              init_meta);
>      if (ret) {
> -        error_setg(errp, "could not init zone metadata");
> +        error_setg(errp, "could not load/init zone metadata");
>          return -1;
>      }
>  
> @@ -3164,15 +3485,20 @@ static void nvme_zoned_clear(NvmeCtrl *n)
>  {
>      int i;
>  
> +    if (n->params.zone_file)  {
> +        close(n->zone_file_fd);
> +    }
>      for (i = 0; i < n->num_namespaces; i++) {
>          NvmeNamespace *ns = &n->namespaces[i];
>          g_free(ns->id_ns_zoned);
> -        g_free(ns->zone_array);
> -        g_free(ns->exp_open_zones);
> -        g_free(ns->imp_open_zones);
> -        g_free(ns->closed_zones);
> -        g_free(ns->full_zones);
> -        g_free(ns->zd_extensions);
> +        if (!n->params.zone_file) {
> +            g_free(ns->zone_array);
> +            g_free(ns->exp_open_zones);
> +            g_free(ns->imp_open_zones);
> +            g_free(ns->closed_zones);
> +            g_free(ns->full_zones);
> +            g_free(ns->zd_extensions);
> +        }
>      }
>  }
>  
> @@ -3258,7 +3584,8 @@ static void nvme_init_blk(NvmeCtrl *n, Error **errp)
>      n->ns_size = bs_size;
>  }
>  
> -static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, bool init_meta,
> +    Error **errp)
>  {
>      NvmeIdNs *id_ns = &ns->id_ns;
>      int lba_index;
> @@ -3272,7 +3599,7 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      if (n->params.zoned) {
>          ns->csi = NVME_CSI_ZONED;
>          id_ns->ncap = cpu_to_le64(n->params.zone_capacity * n->num_zones);
> -        if (nvme_zoned_init_ns(n, ns, lba_index, errp) != 0) {
> +        if (nvme_zoned_init_ns(n, ns, lba_index, init_meta, errp) != 0) {
>              return;
>          }
>      } else {
> @@ -3429,6 +3756,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      NvmeCtrl *n = NVME(pci_dev);
>      NvmeNamespace *ns;
>      Error *local_err = NULL;
> +    bool init_meta = false;
>  
>      int i;
>  
> @@ -3452,7 +3780,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      }
>  
>      if (n->params.zoned) {
> -        nvme_zoned_init_ctrl(n, &local_err);
> +        nvme_zoned_init_ctrl(n, &init_meta, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> @@ -3463,7 +3791,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      ns = n->namespaces;
>      for (i = 0; i < n->num_namespaces; i++, ns++) {
>          ns->nsid = i + 1;
> -        nvme_init_namespace(n, ns, &local_err);
> +        nvme_init_namespace(n, ns, init_meta, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> @@ -3506,6 +3834,7 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT64("zone_size", NvmeCtrl, params.zone_size, 512),
>      DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity, 512),
>      DEFINE_PROP_UINT32("zone_append_max_size", NvmeCtrl, params.zamds_bs, 0),
> +    DEFINE_PROP_STRING("zone_file", NvmeCtrl, params.zone_file),
>      DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeCtrl,
>                         params.zd_extension_size, 0),
>      DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 900fc54809..5e9a3a62f7 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -14,6 +14,7 @@ typedef struct NvmeParams {
>      uint16_t msix_qsize;
>      uint32_t cmb_size_mb;
>  
> +    char        *zone_file;
>      bool        zoned;
>      bool        cross_zone_read;
>      bool        zone_async_events;
> @@ -114,6 +115,27 @@ typedef struct NvmeZoneList {
>      uint8_t         rsvd12[4];
>  } NvmeZoneList;
>  
> +#define NVME_ZONE_META_MAGIC 0x3aebaa70
> +#define NVME_ZONE_META_VER  1
> +
> +typedef struct NvmeZoneMeta {
> +    uint32_t        magic;
> +    uint32_t        version;
> +    uint64_t        zone_size;
> +    uint64_t        zone_capacity;
> +    uint32_t        nr_offline_zones;
> +    uint32_t        nr_rdonly_zones;
> +    uint32_t        lba_size;
> +    uint32_t        rsvd40;
> +    NvmeZoneList    exp_open_zones;
> +    NvmeZoneList    imp_open_zones;
> +    NvmeZoneList    closed_zones;
> +    NvmeZoneList    full_zones;
> +    uint8_t         zd_extension_size;
> +    uint8_t         dirty;
> +    uint8_t         rsvd594[3990];
> +} NvmeZoneMeta;
> +
>  typedef struct NvmeNamespace {
>      NvmeIdNs        id_ns;
>      uint32_t        nsid;
> @@ -122,6 +144,7 @@ typedef struct NvmeNamespace {
>  
>      NvmeIdNsZoned   *id_ns_zoned;
>      NvmeZone        *zone_array;
> +    NvmeZoneMeta    *zone_meta;
>      NvmeZoneList    *exp_open_zones;
>      NvmeZoneList    *imp_open_zones;
>      NvmeZoneList    *closed_zones;
> @@ -174,6 +197,7 @@ typedef struct NvmeCtrl {
>  
>      int             zone_file_fd;
>      uint32_t        num_zones;
> +    size_t          meta_size;
>      uint64_t        zone_size_bs;
>      uint64_t        zone_array_size;
>      uint8_t         zamds;
> @@ -282,6 +306,19 @@ static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
>      return &ns->zone_array[z->next];
>  }
>  
> +static inline bool nvme_zone_meta_dirty(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->params.zone_file ? ns->zone_meta->dirty : false;
> +}
> +
> +static inline void nvme_set_zone_meta_dirty(NvmeCtrl *n, NvmeNamespace *ns,
> +    bool yesno)
> +{
> +    if (n->params.zone_file) {
> +        ns->zone_meta->dirty = yesno;
> +    }
> +}
> +
>  static inline int nvme_ilog2(uint64_t i)
>  {
>      int log = -1;
> @@ -295,6 +332,7 @@ static inline int nvme_ilog2(uint64_t i)
>  
>  static inline void _hw_nvme_check_size(void)
>  {
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneMeta) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeZoneList) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeZone) != 88);
>  }
> -- 
> 2.21.0
> 
> 

