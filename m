Received: from eggs.gnu.org ([2001:4830:134:3::10]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dHiOn-0006cI-Ju
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dHiOi-00035N-Ko
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:09:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dHiOi-00032U-Bp
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:09:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5539Kfe114413
	for <qemu-devel@nongnu.org>; Sun, 4 Jun 2017 23:09:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2avx6nt0v2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 23:09:38 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 4 Jun 2017 21:09:37 -0600
Date: Mon, 5 Jun 2017 11:09:31 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-06-02 16:05:31 +0200]:

Hi Halil,

Sorry for the late show up. I just found some nits, which could be
ignored for me.

> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
> flexibility (extending using subsections) and for fun.
> 
> To achieve this we need to hack the config_vector, which is VirtIODevice
> (that is common virtio) state, in the middle of the VirtioCcwDevice state
> representation.  This is somewhat ugly, but we have no choice because the
                 ^^
Nit:-------------++

> stream format needs to be preserved.
> 
> Almost no changes in behavior. Exception is everything that comes with
> vmstate like extra bookkeeping about what's in the stream, and maybe some
> extra checks and better error reporting.
> 
[...]

> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 711c11454f..7e7546a576 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -18,6 +18,7 @@
>  #include "trace.h"
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> 
>  S390FLICState *s390_get_flic(void)
>  {
> @@ -137,3 +138,30 @@ static void qemu_s390_flic_register_types(void)
>  }
> 
>  type_init(qemu_s390_flic_register_types)
> +
> +const VMStateDescription vmstate_adapter_info = {
> +    .name = "s390_adapter_info",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(ind_offset, AdapterInfo),
> +        /*
> +         * We do not have to migrate neither the id nor the addresses.
> +         * The id is set by css_register_io_adapter and the addresses
> +         * are set based on the IndAddr objects after those get mapped.
> +         */
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +const VMStateDescription vmstate_adapter_routes = {
> +
> +    .name = "s390_adapter_routes",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT(adapter, AdapterRoutes, 1, vmstate_adapter_info, \
                                                                          ^^
Nit:----------------------------------------------------------------------++

> +                       AdapterInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
[...]

> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 1e2f26b65a..348129e1b2 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
[...]

> +const VMStateDescription vmstate_virtio_ccw_dev = {
> +    .name = "s390_virtio_ccw_dev",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = virtio_ccw_dev_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
> +        /*
> +         * Ugly hack because VirtIODevice does not migrate itself.
> +         * This also makes legacy via vmstate_save_state possible.
> +         */
> +        VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
> +                         vmstate_virtio_ccw_dev_tmp),
> +        VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
                                                                             ^^
Nit:-------------------------------------------------------------------------++

> +                       AdapterRoutes),
> +        VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
> +        VMSTATE_INT32(revision, VirtioCcwDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
>                                 VirtioCcwDevice *dev);
> 
[...]

-- 
Dong Jia Shi
