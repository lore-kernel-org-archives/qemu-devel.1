Received: from eggs.gnu.org ([2001:4830:134:3::10]:57100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fgV3f-00075m-12
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fgV3a-0001LJ-3P
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fgV3Z-0001Kd-Qe
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:02:50 -0400
Date: Fri, 20 Jul 2018 09:02:46 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1935251498.52851607.1532091766703.JavaMail.zimbra@redhat.com>
In-Reply-To: <b6ef19f3-7f16-5427-bfed-f352a76e48b7@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<20180718085529.133a0a22@doriath>
	<367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com>
	<20180719121635.GA28107@stefanha-x1.localdomain>
	<b6ef19f3-7f16-5427-bfed-f352a76e48b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, kwolf@redhat.com, dan j williams <dan.j.williams@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, imammedo@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, pbonzini@redhat.com, nilal@redhat.com


> >>>>  /*
> >>>>   * virtio-balloon-pci: This extends VirtioPCIProxy.
> >>>>   */
> >>>> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> >>>> new file mode 100644
> >>>> index 0000000000..08c96d7e80
> >>>> --- /dev/null
> >>>> +++ b/hw/virtio/virtio-pmem.c
> >>>> @@ -0,0 +1,241 @@
> >>>> +/*
> >>>> + * Virtio pmem device
> >>>> + *
> >>>> + * Copyright (C) 2018 Red Hat, Inc.
> >>>> + * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
> >>>> + *
> >>>> + * This work is licensed under the terms of the GNU GPL, version 2.
> >>>> + * See the COPYING file in the top-level directory.
> >>>> + *
> >>>> + */
> >>>> +
> >>>> +#include "qemu/osdep.h"
> >>>> +#include "qapi/error.h"
> >>>> +#include "qemu-common.h"
> >>>> +#include "qemu/error-report.h"
> >>>> +#include "hw/virtio/virtio-access.h"
> >>>> +#include "hw/virtio/virtio-pmem.h"
> >>>> +#include "hw/mem/memory-device.h"
> >>>> +#include "block/aio.h"
> >>>> +#include "block/thread-pool.h"
> >>>> +
> >>>> +typedef struct VirtIOPMEMresp {
> >>>> +    int ret;
> >>>> +} VirtIOPMEMResp;
> >>>> +
> >>>> +typedef struct VirtIODeviceRequest {
> >>>> +    VirtQueueElement elem;
> >>>> +    int fd;
> >>>> +    VirtIOPMEM *pmem;
> >>>> +    VirtIOPMEMResp resp;
> >>>> +} VirtIODeviceRequest;
> >>>> +
> >>>> +static int worker_cb(void *opaque)
> >>>> +{
> >>>> +    VirtIODeviceRequest *req = opaque;
> >>>> +    int err = 0;
> >>>> +
> >>>> +    /* flush raw backing image */
> >>>> +    err = fsync(req->fd);
> >>>> +    if (err != 0) {
> >>>> +        err = errno;
> >>>> +    }
> >>>> +    req->resp.ret = err;
> >>>
> >>> Host question: are you returning the guest errno code to the host?
> >>
> >> No. I am returning error code from the host in-case of host fsync
> >> failure, otherwise returning zero.
> > 
> > I think that's what Luiz meant.  errno constants are not portable
> > between operating systems and architectures.  Therefore they cannot be
> > used in external interfaces in software that expects to communicate with
> > other systems.
> > 
> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.
> > 
> 
> In general, I wonder if we should report errors at all or rather *kill*
> the guest. That might sound harsh, but think about the following scenario:
> 
> fsync() fails due to some block that cannot e.g. be written (e.g.
> network connection failed). What happens if our guest tries to
> read/write that mmaped block? (e.g. network connection failed).
> 
> I assume we'll get a signal an get killed? So we are trying to optimize
> one special case (fsync()) although every read/write is prone to kill
> the guest. And as soon as the guest will try to access the block that
> made fsync fail, we will crash the guest either way.
> 
> I assume the main problem is that we are trying to take a file (with all
> the errors that can happen during read/write/fsync) and make it look
> like memory (dax). On ordinary block access, we can forward errors, but
> not if it's memory (maybe using MCE, but it's complicated and
> architecture specific).

There are two points which you highlighted:

1] Memory hardware errors:
These type of errors will be notified by MCA. If mce is non-recoverable, KVM gets 
SIG_BUS when hardware detects such error and injects mce in guest vCPU. If guest 
does not recoverable it can decide to kill the user-space process. 

Default option for mce is '1':
1: panic or SIGBUS on uncorrected errors, log corrected errors

2] read/write/fsync failure because of (network connection failure):
I assume you are talking about something like NFS mount where read/write/fsync
responsibility is taken care by NFS. This scenario can happen for any application
accessing a network filesystem and return appropriate error or wait. Until 'fsync' 
is not performed there is no guarantee ram data is backed. I think its
the responsibility of application to perform fsync after write operation or 
a transaction.
 
> 
> So I wonder if we should rather assume that our backend file is placed
> on some stable storage that cannot easily fail.
> 
> (we might have the same problem with NVDIMM right now, at least the
> memory reading/writing part)

NVDIMM NFIT handles this handler and checks if any SPA falls in the range
of mce:address. It creates a list of bad blocks(corresponding to nd_region) and handle 
in function 'pmem_do_bvec' used by 'pmem_mem_request' & 'pmem_read_write'.

void nfit_mce_register(void)
{
        mce_register_decode_chain(&nfit_mce_dec);
}

In 'fake DAX', we bypass NFIT ACPI and using virtio & nvdimm_bus way of registering
memory region. By default it should kill the userspace process or at worst cause guest reboot.
I am thinking how we can integrate the NFIT bad block handling with mce handler approach
for fake DAX. I think we can do this. But I want inputs from NVDIMM guys?

Thanks,
Pankaj

> 
> It's complicated and I am not a block level expert :)
