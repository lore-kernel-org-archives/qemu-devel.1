Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTWqp-0002NS-6H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTWqm-0003HS-UW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:15:31 -0400
Date: Fri, 7 Jul 2017 18:15:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170707171517.GD18375@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 09:36:31PM +0800, Fam Zheng wrote:
> diff --git a/block/nvme-vfio.c b/block/nvme-vfio.c
> new file mode 100644
> index 0000000..f030a82
> --- /dev/null
> +++ b/block/nvme-vfio.c
> @@ -0,0 +1,703 @@
> +/*
> + * NVMe VFIO interface

As far as I can tell nothing in this file is related to NVMe.  This is
purely a VFIO utility library.  If someone wanted to write a VFIO
NetClient, they could reuse these functions.  Should they be generic
=66rom the start?

> +struct NVMeVFIOState {
> +    int container;
> +    int group;
> +    int device;
> +    RAMBlockNotifier ram_notifier;
> +    struct vfio_region_info config_region_info, bar_region_info[6];
> +
> +    /* VFIO's IO virtual address space is managed by splitting into a few
> +     * sections:
> +     *
> +     * ---------------       <=3D 0
> +     * |xxxxxxxxxxxxx|
> +     * |-------------|       <=3D NVME_VFIO_IOVA_MIN
> +     * |             |
> +     * |    Fixed    |
> +     * |             |
> +     * |-------------|       <=3D low_water_mark
> +     * |             |
> +     * |    Free     |
> +     * |             |
> +     * |-------------|       <=3D high_water_mark
> +     * |             |
> +     * |    Temp     |
> +     * |             |
> +     * |-------------|       <=3D NVME_VFIO_IOVA_MAX
> +     * |xxxxxxxxxxxxx|
> +     * |xxxxxxxxxxxxx|
> +     * ---------------
> +     *
> +     * - Addresses lower than NVME_VFIO_IOVA_MIN are reserved as invalid;
> +     *
> +     * - Fixed mappings of HVAs are assigned "low" IOVAs in the range of
> +     *   [NVME_VFIO_IOVA_MIN, low_water_mark).  Once allocated they will=
 not be
> +     *   reclaimed - low_water_mark never shrinks;
> +     *
> +     * - IOVAs in range [low_water_mark, high_water_mark) are free;
> +     *
> +     * - IOVAs in range [high_water_mark, NVME_VFIO_IOVA_MAX) are volati=
le
> +     *   mappings. At each nvme_vfio_dma_reset_temporary() call, the who=
le area
> +     *   is recycled. The caller should make sure I/O's depending on the=
se
> +     *   mappings are completed before calling.
> +     **/
> +    uint64_t low_water_mark;
> +    uint64_t high_water_mark;
> +    IOVAMapping *mappings;
> +    int nr_mappings;
> +    QemuMutex lock;

Please document what the lock protects.

> +};
> +
> +/** Find group file and return the full path in @path by PCI device addr=
ess
> + * @device. If succeeded, caller needs to g_free the returned path. */
> +static int sysfs_find_group_file(const char *device, char **path, Error =
**errp)
> +{
> +    int ret;
> +    char *sysfs_link =3D NULL;
> +    char *sysfs_group =3D NULL;
> +    char *p;
> +
> +    sysfs_link =3D g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group",
> +                                 device);
> +    sysfs_group =3D g_malloc(PATH_MAX);
> +    ret =3D readlink(sysfs_link, sysfs_group, PATH_MAX - 1);
> +    if (ret =3D=3D -1) {
> +        error_setg_errno(errp, errno, "Failed to find iommu group sysfs =
path");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +    ret =3D 0;
> +    p =3D strrchr(sysfs_group, '/');
> +    if (!p) {
> +        error_setg(errp, "Failed to find iommu group number");
> +        ret =3D -errno;

strrchr() doesn't set errno so this is likely to be 0.

I'm not sure why this function returns int.  It seems simpler to return
char *path instead.

> +/**
> + * Map a PCI bar area.
> + */
> +void *nvme_vfio_pci_map_bar(NVMeVFIOState *s, int index, Error **errp)
> +{
> +    void *p;
> +    assert(index >=3D 0 && index < 6);

nvme_vfio_pci_init_bar() says:

  assert(index < ARRAY_SIZE(s->bar_region_info));

I think they are trying to test for the same thing but are doing it in
different ways.  It would be nicer to avoid repetition:

  static inline void assert_bar_index_valid(NVMeVFIOState *s, int index)
  {
      assert(index >=3D 0 && index < ARRAY_SIZE(s->bar_region_info));
  }

> +static int nvme_vfio_pci_write_config(NVMeVFIOState *s, void *buf, int s=
ize, int ofs)
> +{
> +    if (pwrite(s->device, buf, size,
> +               s->config_region_info.offset + ofs) =3D=3D size) {
> +        return 0;
> +    }
> +
> +    return -1;
> +}

I'm not sure if it's safe to assume pread()/pwrite() do not return
EINTR.  It would be a shame for vfio initialization to fail because a
signal arrived at an incovenient time.

> +static int nvme_vfio_init_pci(NVMeVFIOState *s, const char *device,
> +                              Error **errp)
> +{
> +    int ret;
> +    int i;
> +    uint16_t pci_cmd;
> +    struct vfio_group_status group_status =3D { .argsz =3D sizeof(group_=
status) };
> +    struct vfio_iommu_type1_info iommu_info =3D { .argsz =3D sizeof(iomm=
u_info) };
> +    struct vfio_device_info device_info =3D { .argsz =3D sizeof(device_i=
nfo) };
> +    char *group_file =3D NULL;
> +
> +    /* Create a new container */
> +    s->container =3D open("/dev/vfio/vfio", O_RDWR);
> +
> +    if (ioctl(s->container, VFIO_GET_API_VERSION) !=3D VFIO_API_VERSION)=
 {
> +        error_setg(errp, "Invalid VFIO version");
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
> +        error_setg_errno(errp, errno, "VFIO IOMMU check failed");
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    /* Open the group */
> +    ret =3D sysfs_find_group_file(device, &group_file, errp);
> +    if (ret) {
> +        goto out;
> +    }
> +
> +    s->group =3D open(group_file, O_RDWR);
> +    g_free(group_file);
> +    if (s->group <=3D 0) {
> +        error_setg_errno(errp, errno, "Failed to open VFIO group file");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    /* Test the group is viable and available */
> +    if (ioctl(s->group, VFIO_GROUP_GET_STATUS, &group_status)) {
> +        error_setg_errno(errp, errno, "Failed to get VFIO group status");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
> +        error_setg(errp, "VFIO group is not viable");
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    /* Add the group to the container */
> +    if (ioctl(s->group, VFIO_GROUP_SET_CONTAINER, &s->container)) {
> +        error_setg_errno(errp, errno, "Failed to add group to VFIO conta=
iner");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    /* Enable the IOMMU model we want */
> +    if (ioctl(s->container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU)) {
> +        error_setg_errno(errp, errno, "Failed to set VFIO IOMMU type");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    /* Get additional IOMMU info */
> +    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, &iommu_info)) {
> +        error_setg_errno(errp, errno, "Failed to get IOMMU info");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    s->device =3D ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
> +
> +    if (s->device < 0) {
> +        error_setg_errno(errp, errno, "Failed to get device fd");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    /* Test and setup the device */
> +    if (ioctl(s->device, VFIO_DEVICE_GET_INFO, &device_info)) {
> +        error_setg_errno(errp, errno, "Failed to get device info");
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
> +        error_setg(errp, "Invalid device regions");
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    s->config_region_info =3D (struct vfio_region_info) {
> +        .index =3D VFIO_PCI_CONFIG_REGION_INDEX,
> +        .argsz =3D sizeof(struct vfio_region_info),
> +    };
> +    if (ioctl(s->device, VFIO_DEVICE_GET_REGION_INFO, &s->config_region_=
info)) {
> +        error_setg_errno(errp, errno, "Failed to get config region info"=
);
> +        ret =3D -errno;
> +        goto out;
> +    }
> +
> +    for (i =3D 0; i < 6; i++) {
> +        ret =3D nvme_vfio_pci_init_bar(s, i, errp);
> +        if (ret) {
> +            goto out;
> +        }
> +    }
> +
> +    /* Enable bus master */
> +    if (nvme_vfio_pci_read_config(s, &pci_cmd, sizeof(pci_cmd),
> +                                  PCI_COMMAND) < 0) {
> +        goto out;
> +    }
> +    pci_cmd |=3D PCI_COMMAND_MASTER;
> +    if (nvme_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd),
> +                                   PCI_COMMAND) < 0) {
> +        goto out;
> +    }
> +out:
> +    return ret;

Missing if (ret < 0) { close(foo); ... } cleanup in the error case.

> +}
> +
> +static void nvme_vfio_ram_block_added(RAMBlockNotifier *n,
> +                                      void *host, size_t size)
> +{
> +    NVMeVFIOState *s =3D container_of(n, NVMeVFIOState, ram_notifier);
> +    trace_nvme_vfio_ram_block_added(host, size);

Please include "s %p" s in the trace event so multiple NVMe adapters can
be differentiated from each other.  All trace events should include s.

> +/**
> + * Find the mapping entry that contains [host, host + size) and set @ind=
ex to
> + * the position. If no entry contains it, @index is the position _after_=
 which
> + * to insert the new mapping. IOW, it is the index of the largest elemen=
t that
> + * is smaller than @host, or -1 if no entry is.
> + */
> +static IOVAMapping *nvme_vfio_find_mapping(NVMeVFIOState *s, void *host,
> +                                           int *index)
> +{
> +    IOVAMapping *p =3D s->mappings;
> +    IOVAMapping *q =3D p ? p + s->nr_mappings - 1 : NULL;
> +    IOVAMapping *mid =3D p ? p + (q - p) / 2 : NULL;

This value is never used because mid is recalculated in the while loop.

> +    trace_nvme_vfio_find_mapping(s, host);
> +    if (!p) {
> +        *index =3D -1;
> +        return NULL;
> +    }
> +    while (true) {
> +        mid =3D p + (q - p) / 2;
> +        if (mid =3D=3D p) {
> +            break;
> +        }
> +        if (mid->host > host) {
> +            q =3D mid;
> +        } else if (mid->host < host) {
> +            p =3D mid;
> +        } else {
> +            break;
> +        }
> +    }
> +    if (mid->host > host) {
> +        mid--;
> +    } else if (mid < &s->mappings[s->nr_mappings - 1]
> +               && (mid + 1)->host <=3D host) {
> +        mid++;
> +    }
> +    *index =3D mid - &s->mappings[0];
> +    if (mid >=3D &s->mappings[0] &&
> +        mid->host <=3D host && mid->host + mid->size > host) {
> +        assert(mid < &s->mappings[s->nr_mappings]);
> +        return mid;
> +    }
> +    return NULL;

A junk *index value may be produced when we return NULL.

Consider these inputs:

mappings[] =3D {{.host =3D 0x2000}}
nr_mappings =3D 1
host =3D 0x1000

The result is:

*index =3D &s->mappings[-1] - &s->mappings[0]

> +/* Map [host, host + size) area into a contiguous IOVA address space, an=
d store
> + * the result in @iova if not NULL. The area must be aligned to page siz=
e, and
> + * mustn't overlap with existing mapping areas.
> + */
> +int nvme_vfio_dma_map(NVMeVFIOState *s, void *host, size_t size,
> +                      bool temporary, uint64_t *iova)

This function assumes that the mapping status is constant for the
entire range [host, host + size).  It does not handle split mappings.
For example:

1. [host, host + 4K) is mapped but [host + 4K, host + size) is not mapped.
2. [host, host + 4K) is not mapped but [host + 4K, host + size) is mapped.
3. [host, host + 4K) is mapped temporary but [host + 4K, host + size) is
   mapped !temporary.  (The iova space would not be contiguous.)

Is it safe to assume none of these can happen?

> +{
> +    int ret =3D 0;
> +    int index;
> +    IOVAMapping *mapping;
> +    uint64_t iova0;
> +
> +    assert(QEMU_PTR_IS_ALIGNED(host, getpagesize()));
> +    assert(QEMU_IS_ALIGNED(size, getpagesize()));
> +    trace_nvme_vfio_dma_map(s, host, size, temporary, iova);
> +    qemu_mutex_lock(&s->lock);
> +    mapping =3D nvme_vfio_find_mapping(s, host, &index);
> +    if (mapping) {
> +        iova0 =3D mapping->iova + ((uint8_t *)host - (uint8_t *)mapping-=
>host);
> +    } else {
> +        if (s->high_water_mark - s->low_water_mark + 1 < size) {
> +            ret =3D -ENOMEM;
> +            goto out;
> +        }
> +        if (!temporary) {
> +            iova0 =3D s->low_water_mark;
> +            mapping =3D nvme_vfio_add_mapping(s, host, size, index + 1, =
iova0);
> +            if (!mapping) {
> +                ret =3D -ENOMEM;
> +                goto out;
> +            }
> +            assert(nvme_vfio_verify_mappings(s));
> +            ret =3D nvme_vfio_do_mapping(s, host, size, iova0);
> +            if (ret) {
> +                nvme_vfio_undo_mapping(s, mapping, NULL);
> +                goto out;
> +            }
> +            s->low_water_mark +=3D size;
> +            nvme_vfio_dump_mappings(s);
> +        } else {
> +            iova0 =3D s->high_water_mark - size;
> +            ret =3D nvme_vfio_do_mapping(s, host, size, iova0);
> +            if (ret) {
> +                goto out;
> +            }
> +            s->high_water_mark -=3D size;
> +        }
> +    }
> +    if (iova) {
> +        *iova =3D iova0;
> +    }
> +    qemu_mutex_unlock(&s->lock);
> +out:
> +    return ret;
> +}
> +
> +/* Reset the high watermark and free all "temporary" mappings. */
> +int nvme_vfio_dma_reset_temporary(NVMeVFIOState *s)
> +{
> +    struct vfio_iommu_type1_dma_unmap unmap =3D {
> +        .argsz =3D sizeof(unmap),
> +        .flags =3D 0,
> +        .iova =3D s->high_water_mark,
> +        .size =3D NVME_VFIO_IOVA_MAX - s->high_water_mark,
> +    };
> +    trace_nvme_vfio_dma_reset_temporary(s);
> +    qemu_mutex_lock(&s->lock);
> +    if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> +        error_report("VFIO_UNMAP_DMA: %d", -errno);
> +        return -errno;

Missing qemu_mutex_unlock(&s->lock).

> +    }
> +    s->high_water_mark =3D NVME_VFIO_IOVA_MAX;
> +    qemu_mutex_lock(&s->lock);

s/lock/unlock/

> diff --git a/block/nvme-vfio.h b/block/nvme-vfio.h
> new file mode 100644
> index 0000000..2d5840b
> --- /dev/null
> +++ b/block/nvme-vfio.h
> @@ -0,0 +1,30 @@
> +/*
> + * NVMe VFIO interface
> + *
> + * Copyright 2016, 2017 Red Hat, Inc.
> + *
> + * Authors:
> + *   Fam Zheng <famz@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_VFIO_H
> +#define QEMU_VFIO_H
> +#include "qemu/queue.h"

Is "qemu/queue.h" needed by this header?

Error, bool, uint64_t, and EventNotifier so additional headers should
probably be included.

> +typedef struct {
> +    int         index;
> +    NVMeQueue   sq, cq;
> +    int         cq_phase;
> +    uint8_t     *prp_list_pages;
> +    uint64_t    prp_list_base_iova;
> +    NVMeRequest reqs[NVME_QUEUE_SIZE];
> +    CoQueue     free_req_queue;
> +    bool        busy;
> +    int         need_kick;
> +    int         inflight;
> +    QemuMutex   lock;
> +} NVMeQueuePair;

What does lock protect?

> +static void nvme_free_queue_pair(BlockDriverState *bs, NVMeQueuePair *q)
> +{
> +    qemu_vfree(q->prp_list_pages);
> +    qemu_vfree(q->sq.queue);
> +    qemu_vfree(q->cq.queue);

qemu_mutex_destroy(&q->lock);

> +static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)

Missing coroutine_fn since this function calls qemu_co_queue_wait().

> +{
> +    int i;
> +    NVMeRequest *req =3D NULL;
> +
> +    qemu_mutex_lock(&q->lock);
> +    while (q->inflight + q->need_kick > NVME_QUEUE_SIZE - 2) {
> +        /* We have to leave one slot empty as that is the full queue cas=
e (head
> +         * =3D=3D tail + 1). */
> +        trace_nvme_free_req_queue_wait(q);
> +        qemu_mutex_unlock(&q->lock);
> +        qemu_co_queue_wait(&q->free_req_queue, NULL);
> +        qemu_mutex_lock(&q->lock);
> +    }
> +    for (i =3D 0; i < NVME_QUEUE_SIZE; i++) {
> +        if (!q->reqs[i].busy) {
> +            q->reqs[i].busy =3D true;
> +            req =3D &q->reqs[i];
> +            break;
> +        }
> +    }
> +    assert(req);
> +    qemu_mutex_unlock(&q->lock);

This code takes q->lock but actually relies on coroutine cooperative
scheduling to avoid failing assert(req).  This bothers me a little
because it means there are undocumented locking assumptions.

> +    return req;
> +}
> +
> +static inline int nvme_translate_error(const NvmeCqe *c)
> +{
> +    uint16_t status =3D (le16_to_cpu(c->status) >> 1) & 0xFF;
> +    if (status) {
> +        trace_nvme_error(c->result, c->sq_head, c->sq_id, c->cid, status=
);

Should c's fields be byteswapped?

> +    }
> +    switch (status) {
> +    case 0:
> +        return 0;
> +    case 1:
> +        return -ENOSYS;
> +    case 2:
> +        return -EINVAL;
> +    default:
> +        return -EIO;
> +    }
> +}
> +
> +/* With q->lock */
> +static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
> +{
> +    bool progress =3D false;
> +    NVMeRequest *req;
> +    NvmeCqe *c;
> +
> +    trace_nvme_process_completion(s, q->index, q->inflight);
> +    if (q->busy || s->plugged) {
> +        trace_nvme_process_completion_queue_busy(s, q->index);
> +        return false;
> +    }
> +    q->busy =3D true;
> +    assert(q->inflight >=3D 0);
> +    while (q->inflight) {
> +        c =3D (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
> +        if (!c->cid || (le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase=
) {
> +            break;
> +        }
> +        q->cq.head =3D (q->cq.head + 1) % NVME_QUEUE_SIZE;
> +        if (!q->cq.head) {
> +            q->cq_phase =3D !q->cq_phase;
> +        }
> +        if (c->cid =3D=3D 0 || c->cid > NVME_QUEUE_SIZE) {

Will c->cid > NVME_QUEUE_SIZE work on big-endian hosts?  Looks like
le16_to_cpu(c->cid) is missing.  There are more instances below.

> +            fprintf(stderr, "Unexpected CID in completion queue: %" PRIu=
32 "\n",
> +                    c->cid);
> +            continue;
> +        }
> +        assert(c->cid <=3D NVME_QUEUE_SIZE);
> +        trace_nvme_complete_command(s, q->index, c->cid);
> +        req =3D &q->reqs[c->cid - 1];
> +        assert(req->cid =3D=3D c->cid);
> +        assert(req->cb);
> +        req->cb(req->opaque, nvme_translate_error(c));

The user callback is invoked with q->lock held?  This could have a
performance impact or risk deadlocks if the callback touches this BDS.

> +        req->cb =3D req->opaque =3D NULL;
> +        req->busy =3D false;
> +        if (!qemu_co_queue_empty(&q->free_req_queue)) {
> +            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_=
cb, q);
> +        }

The relationship between waiting coroutines and completion processing
seems strange to me:

A new oneshot BH is scheduled for each processed completion.  There may
only be one queued coroutine waiting so a lot of these BHs are wasted.
We hold q->lock so we cannot expect q->free_req_queue to empty itself
while we're still running.

What I'm wondering is whether it's better to schedule the BH in if
(progress) below.  At the moment nvme_free_req_queue_cb() will only
enter 1 waiting coroutine, so that would need to be adjusted to ensure
more waiting coroutines are woken if multiple reqs completed.

Maybe it's simpler to keep doing spurious notifications but it's worth
at least considering the idea of notifying from if (progress).

[I ran out of time here.  Will review more later.]

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZX8GlAAoJEJykq7OBq3PIwYAH/R9dYuEx41cOB90MvvZsgtb8
s0SvtqN1WybQJmNp1e+coPVksDnW+Rl3sKwaev7R9G8d8XAPtWdYw5DmnaKDVszg
fZ2+oc341olNi2F6InFhB9f/WxBUghoIjpRc4543L1dwThXEJy6rnEhYUHMRr1QE
CTCRGSVX/CHhO1zlMtSZRHM3xKiIY5T20uT91E7Gzr5GBSBa5lYgg3chN5zrwqbU
hBs0l/aU9qMOR0KSYxYJpyXIgbD9vWBKKJaWNtlk0DPB40VeD5nbmk/+zflUxAOE
TjxBMk1KS4G/+mjrPylU+hrqwcm75L4hAqe+CGGdJv8zXCqbi3aRNx8Rer1c74M=
=eaI0
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
