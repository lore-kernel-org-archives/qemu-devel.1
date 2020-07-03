Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20ABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF3B2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGTeBBWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF3B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIrT-0001Yp-Nz
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrIqt-000122-4o
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:23:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrIqp-0000oc-TG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593771802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TNr08yu7sjvjES169fcfQOLPFvRXwRO6AOPtq8dXuUY=;
 b=MGTeBBWDhPBU8ygdz7UbYju4cZfCYMRXdLtxwBxj5aSFYTxjrYElhqCqztEiBhNd391RDu
 OXLhHgDfOBucvdFhclIL09LkHAPbRRhu3N2trC7bDbnmOonatuUeEgmsNyUTbzU+PlvkR1
 79Mz0IxXU87RspQ3nn78dHALsIgRopg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-omU7wPprMHO5nXj10mXrmA-1; Fri, 03 Jul 2020 06:23:19 -0400
X-MC-Unique: omU7wPprMHO5nXj10mXrmA-1
Received: by mail-wr1-f70.google.com with SMTP id e11so31262060wrs.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 03:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TNr08yu7sjvjES169fcfQOLPFvRXwRO6AOPtq8dXuUY=;
 b=ti78Nj7cs5ioYtYhcBZCtN4v3oEFHAIUt5n/I+E2IQ1sv0HB+6aZyyMafwm6wjp5UC
 UF6nWRSLWh1jpjwya4j7U6QxTSgZ3dk1RyzRtuJqb16lI0RrJiAnhY+KGF+zLEkTfdzW
 gE3pw7TjKIP2JMt7IR8/waryjfX35DrAYXUTOI/WSRXKE3LdgdFghB+CBIoqyV8MFohp
 9eYdsBVOmJDxN5Efs/ApSIUHIIUgP9R3LD/2CoztT5LYN34ZUVMQ+ue+xRKIEh7OZ4yu
 sqaRgh6eJil5iIhmrhUAugS3Rm6Q8riLJHL1hMgd4sqVZmguUo01zGA4LHBjdNPFHyRN
 gXKQ==
X-Gm-Message-State: AOAM531X3xxqlv/FvEYNpQAfpbOAMrhVkZfCFIn4k0gi2SxF4wHDu8ao
 372qWfrVZI8+CjEDq3+wE4ysSGFUEquMG+pGcEUlCGOIfrI+U6Z/VZn3Hg6/eMVKjr3YkRwdFLx
 IvGkLURZ3Rnba7DI=
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr39426251wrr.371.1593771797474; 
 Fri, 03 Jul 2020 03:23:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/gJuMo94rwPfqZi+fM2E9f+WXttRtQiZri0mnFUsrCZiJOcM+W1xl2sZA6ZvadDJUyT4iAw==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr39426222wrr.371.1593771797186; 
 Fri, 03 Jul 2020 03:23:17 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 w14sm13597552wrt.55.2020.07.03.03.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 03:23:16 -0700 (PDT)
Date: Fri, 3 Jul 2020 06:23:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 13/41] virtio-mem: Paravirtualized memory hot(un)plug
Message-ID: <20200703062243-mutt-send-email-mst@kernel.org>
References: <20200703090252.368694-1-mst@redhat.com>
 <20200703090252.368694-14-mst@redhat.com>
 <3691367f-9b31-dfa2-f180-823b1f080c09@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3691367f-9b31-dfa2-f180-823b1f080c09@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 11:18:42AM +0200, David Hildenbrand wrote:
> On 03.07.20 11:04, Michael S. Tsirkin wrote:
> > From: David Hildenbrand <david@redhat.com>
> > 
> > This is the very basic/initial version of virtio-mem. An introduction to
> > virtio-mem can be found in the Linux kernel driver [1]. While it can be
> > used in the current state for hotplug of a smaller amount of memory, it
> > will heavily benefit from resizeable memory regions in the future.
> > 
> > Each virtio-mem device manages a memory region (provided via a memory
> > backend). After requested by the hypervisor ("requested-size"), the
> > guest can try to plug/unplug blocks of memory within that region, in order
> > to reach the requested size. Initially, and after a reboot, all memory is
> > unplugged (except in special cases - reboot during postcopy).
> > 
> > The guest may only try to plug/unplug blocks of memory within the usable
> > region size. The usable region size is a little bigger than the
> > requested size, to give the device driver some flexibility. The usable
> > region size will only grow, except on reboots or when all memory is
> > requested to get unplugged. The guest can never plug more memory than
> > requested. Unplugged memory will get zapped/discarded, similar to in a
> > balloon device.
> > 
> > The block size is variable, however, it is always chosen in a way such that
> > THP splits are avoided (e.g., 2MB). The state of each block
> > (plugged/unplugged) is tracked in a bitmap.
> > 
> > As virtio-mem devices (e.g., virtio-mem-pci) will be memory devices, we now
> > expose "VirtioMEMDeviceInfo" via "query-memory-devices".
> > 
> > --------------------------------------------------------------------------
> > 
> > There are two important follow-up items that are in the works:
> > 1. Resizeable memory regions: Use resizeable allocations/RAM blocks to
> >    grow/shrink along with the usable region size. This avoids creating
> >    initially very big VMAs, RAM blocks, and KVM slots.
> > 2. Protection of unplugged memory: Make sure the gust cannot actually
> >    make use of unplugged memory.
> > 
> > Other follow-up items that are in the works:
> > 1. Exclude unplugged memory during migration (via precopy notifier).
> > 2. Handle remapping of memory.
> > 3. Support for other architectures.
> > 
> > --------------------------------------------------------------------------
> > 
> > Example usage (virtio-mem-pci is introduced in follow-up patches):
> > 
> > Start QEMU with two virtio-mem devices (one per NUMA node):
> >  $ qemu-system-x86_64 -m 4G,maxmem=20G \
> >   -smp sockets=2,cores=2 \
> >   -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
> >   [...]
> >   -object memory-backend-ram,id=mem0,size=8G \
> >   -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,requested-size=0M \
> >   -object memory-backend-ram,id=mem1,size=8G \
> >   -device virtio-mem-pci,id=vm1,memdev=mem1,node=1,requested-size=1G
> > 
> > Query the configuration:
> >  (qemu) info memory-devices
> >  Memory device [virtio-mem]: "vm0"
> >    memaddr: 0x140000000
> >    node: 0
> >    requested-size: 0
> >    size: 0
> >    max-size: 8589934592
> >    block-size: 2097152
> >    memdev: /objects/mem0
> >  Memory device [virtio-mem]: "vm1"
> >    memaddr: 0x340000000
> >    node: 1
> >    requested-size: 1073741824
> >    size: 1073741824
> >    max-size: 8589934592
> >    block-size: 2097152
> >    memdev: /objects/mem1
> > 
> > Add some memory to node 0:
> >  (qemu) qom-set vm0 requested-size 500M
> > 
> > Remove some memory from node 1:
> >  (qemu) qom-set vm1 requested-size 200M
> > 
> > Query the configuration again:
> >  (qemu) info memory-devices
> >  Memory device [virtio-mem]: "vm0"
> >    memaddr: 0x140000000
> >    node: 0
> >    requested-size: 524288000
> >    size: 524288000
> >    max-size: 8589934592
> >    block-size: 2097152
> >    memdev: /objects/mem0
> >  Memory device [virtio-mem]: "vm1"
> >    memaddr: 0x340000000
> >    node: 1
> >    requested-size: 209715200
> >    size: 209715200
> >    max-size: 8589934592
> >    block-size: 2097152
> >    memdev: /objects/mem1
> > 
> > [1] https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > Message-Id: <20200626072248.78761-11-david@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  qapi/misc.json                 |  39 +-
> >  include/hw/virtio/virtio-mem.h |  78 ++++
> >  hw/virtio/virtio-mem.c         | 724 +++++++++++++++++++++++++++++++++
> >  hw/virtio/Kconfig              |  11 +
> >  hw/virtio/Makefile.objs        |   1 +
> >  5 files changed, 852 insertions(+), 1 deletion(-)
> >  create mode 100644 include/hw/virtio/virtio-mem.h
> >  create mode 100644 hw/virtio/virtio-mem.c
> > 
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index a5a0beb902..65ca3edf32 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1356,19 +1356,56 @@
> >            }
> >  }
> >  
> > +##
> > +# @VirtioMEMDeviceInfo:
> > +#
> > +# VirtioMEMDevice state information
> > +#
> > +# @id: device's ID
> > +#
> > +# @memaddr: physical address in memory, where device is mapped
> > +#
> > +# @requested-size: the user requested size of the device
> > +#
> > +# @size: the (current) size of memory that the device provides
> > +#
> > +# @max-size: the maximum size of memory that the device can provide
> > +#
> > +# @block-size: the block size of memory that the device provides
> > +#
> > +# @node: NUMA node number where device is assigned to
> > +#
> > +# @memdev: memory backend linked with the region
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'VirtioMEMDeviceInfo',
> > +  'data': { '*id': 'str',
> > +            'memaddr': 'size',
> > +            'requested-size': 'size',
> > +            'size': 'size',
> > +            'max-size': 'size',
> > +            'block-size': 'size',
> > +            'node': 'int',
> > +            'memdev': 'str'
> > +          }
> > +}
> > +
> >  ##
> >  # @MemoryDeviceInfo:
> >  #
> >  # Union containing information about a memory device
> >  #
> >  # nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> > +# virtio-mem is included since 5.1.
> >  #
> >  # Since: 2.1
> >  ##
> >  { 'union': 'MemoryDeviceInfo',
> >    'data': { 'dimm': 'PCDIMMDeviceInfo',
> >              'nvdimm': 'PCDIMMDeviceInfo',
> > -            'virtio-pmem': 'VirtioPMEMDeviceInfo'
> > +            'virtio-pmem': 'VirtioPMEMDeviceInfo',
> > +            'virtio-mem': 'VirtioMEMDeviceInfo'
> >            }
> >  }
> >  
> > diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
> > new file mode 100644
> > index 0000000000..6981096f7c
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-mem.h
> > @@ -0,0 +1,78 @@
> > +/*
> > + * Virtio MEM device
> > + *
> > + * Copyright (C) 2020 Red Hat, Inc.
> > + *
> > + * Authors:
> > + *  David Hildenbrand <david@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef HW_VIRTIO_MEM_H
> > +#define HW_VIRTIO_MEM_H
> > +
> > +#include "standard-headers/linux/virtio_mem.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "qapi/qapi-types-misc.h"
> > +#include "sysemu/hostmem.h"
> > +
> > +#define TYPE_VIRTIO_MEM "virtio-mem"
> > +
> > +#define VIRTIO_MEM(obj) \
> > +        OBJECT_CHECK(VirtIOMEM, (obj), TYPE_VIRTIO_MEM)
> > +#define VIRTIO_MEM_CLASS(oc) \
> > +        OBJECT_CLASS_CHECK(VirtIOMEMClass, (oc), TYPE_VIRTIO_MEM)
> > +#define VIRTIO_MEM_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(VirtIOMEMClass, (obj), TYPE_VIRTIO_MEM)
> > +
> > +#define VIRTIO_MEM_MEMDEV_PROP "memdev"
> > +#define VIRTIO_MEM_NODE_PROP "node"
> > +#define VIRTIO_MEM_SIZE_PROP "size"
> > +#define VIRTIO_MEM_REQUESTED_SIZE_PROP "requested-size"
> > +#define VIRTIO_MEM_BLOCK_SIZE_PROP "block-size"
> > +#define VIRTIO_MEM_ADDR_PROP "memaddr"
> > +
> > +typedef struct VirtIOMEM {
> > +    VirtIODevice parent_obj;
> > +
> > +    /* guest -> host request queue */
> > +    VirtQueue *vq;
> > +
> > +    /* bitmap used to track unplugged memory */
> > +    int32_t bitmap_size;
> > +    unsigned long *bitmap;
> > +
> > +    /* assigned memory backend and memory region */
> > +    HostMemoryBackend *memdev;
> > +
> > +    /* NUMA node */
> > +    uint32_t node;
> > +
> > +    /* assigned address of the region in guest physical memory */
> > +    uint64_t addr;
> > +
> > +    /* usable region size (<= region_size) */
> > +    uint64_t usable_region_size;
> > +
> > +    /* actual size (how much the guest plugged) */
> > +    uint64_t size;
> > +
> > +    /* requested size */
> > +    uint64_t requested_size;
> > +
> > +    /* block size and alignment */
> > +    uint64_t block_size;
> > +} VirtIOMEM;
> > +
> > +typedef struct VirtIOMEMClass {
> > +    /* private */
> > +    VirtIODevice parent;
> > +
> > +    /* public */
> > +    void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
> > +    MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
> > +} VirtIOMEMClass;
> > +
> > +#endif
> > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > new file mode 100644
> > index 0000000000..d8a0c974d3
> > --- /dev/null
> > +++ b/hw/virtio/virtio-mem.c
> > @@ -0,0 +1,724 @@
> > +/*
> > + * Virtio MEM device
> > + *
> > + * Copyright (C) 2020 Red Hat, Inc.
> > + *
> > + * Authors:
> > + *  David Hildenbrand <david@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qemu/iov.h"
> > +#include "qemu/cutils.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/units.h"
> > +#include "sysemu/numa.h"
> > +#include "sysemu/sysemu.h"
> > +#include "sysemu/reset.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-bus.h"
> > +#include "hw/virtio/virtio-access.h"
> > +#include "hw/virtio/virtio-mem.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "exec/ram_addr.h"
> > +#include "migration/misc.h"
> > +#include "hw/boards.h"
> > +#include "hw/qdev-properties.h"
> > +#include "config-devices.h"
> > +
> > +/*
> > + * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
> > + * memory (e.g., 2MB on x86_64).
> > + */
> > +#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
> > +/*
> > + * Size the usable region bigger than the requested size if possible. Esp.
> > + * Linux guests will only add (aligned) memory blocks in case they fully
> > + * fit into the usable region, but plug+online only a subset of the pages.
> > + * The memory block size corresponds mostly to the section size.
> > + *
> > + * This allows e.g., to add 20MB with a section size of 128MB on x86_64, and
> > + * a section size of 1GB on arm64 (as long as the start address is properly
> > + * aligned, similar to ordinary DIMMs).
> > + *
> > + * We can change this at any time and maybe even make it configurable if
> > + * necessary (as the section size can change). But it's more likely that the
> > + * section size will rather get smaller and not bigger over time.
> > + */
> > +#if defined(__x86_64__)
> > +#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
> 
> I just did a cross-compile on s390x and noticed that this should be
> guarded by defined(TARGET_X86_64) (it's target dependent).
> 
> Sorry for the noise.
> 
> -- 
> Thanks,
> 
> David / dhildenb


OK - can you post a fixup patch pls?

-- 
MST


