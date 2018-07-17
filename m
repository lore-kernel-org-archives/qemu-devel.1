Received: from eggs.gnu.org ([2001:4830:134:3::10]:58049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ffTL3-0006rH-IE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ffTL0-0003Kk-7f
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ffTKz-0003K1-O9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id k3-v6so707222pgq.5
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:00:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-6-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e72743f4-1bb8-cf0b-0f54-aef1aff9c714@twiddle.net>
Date: Tue, 17 Jul 2018 10:00:30 -0700
MIME-Version: 1.0
In-Reply-To: <1531809130-31088-6-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7 V10] mem/nvdimm: ensure write
 persistence to PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On 07/16/2018 11:32 PM, junyan.he@gmx.com wrote:
> +++ b/stubs/pmem.c
> @@ -0,0 +1,19 @@
> +/*
> + * Stubs for libpmem.
> + *
> + * Copyright (c) 2018 Intel Corporation.
> + *
> + * Author: Haozhong Zhang <address@hidden>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include <string.h>
> +
> +#include "qemu/pmem.h"
> +
> +void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
> +{
> +    return memcpy(pmemdest, src, len);
> +}
> 

This will never be used, because you prevented is_pmem
from being set when creating the device.

I also know that you want to avoid an ifdef within nvdimm_write_label_data, but
a more obvious solution might be in qemu/pmem.h,

#ifdef CONFIG_LIBPMEM
#include <libpmem.h>
#else  /* !CONFIG_LIBPMEM */

static inline void *
pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
{
    g_assert_not_reached();
}

#endif /* CONFIG_LIBPMEM */



r~
