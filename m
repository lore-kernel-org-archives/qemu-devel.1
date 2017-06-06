Received: from eggs.gnu.org ([2001:4830:134:3::10]:42091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFye-0006WK-5D
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFyY-0004Ss-Ls
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:01:00 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIFyY-0004SW-CW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:00:54 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 7so99592723wmo.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:00:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170525035132.24268-14-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
	<20170525035132.24268-14-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 16:00:32 +0100
Message-ID: <CAFEAcA94hHrYU_MU9vHxvryAAvYXa6YCgECdqSqDN7GW9zFSxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 13/18] spapr: add pre_plug function for
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, sbobroff@redhat.com, sursingh@redhat.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 25 May 2017 at 04:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: Laurent Vivier <lvivier@redhat.com>
>
> This allows to manage errors before the memory
> has started to be hotplugged. We already have
> the function for the CPU cores.

> +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                  Error **errp)
> +{
> +    PCDIMMDevice *dimm = PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr = ddc->get_memory_region(dimm);
> +    uint64_t size = memory_region_size(mr);
> +    char *mem_dev;
> +
> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +        error_setg(errp, "Hotplugged memory size must be a multiple of "
> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +        return;
> +    }
> +
> +    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> +        error_setg(errp, "Memory backend has bad page size. "
> +                   "Use 'memory-backend-file' with correct mem-path.");
> +        return;
> +    }
> +}

Coverity points out that this leaks memory -- object_property_get_str()
returns a copy of a string which the caller is supposed to free, but
this code doesn't free it. (CID 1375942.)

thanks
-- PMM
