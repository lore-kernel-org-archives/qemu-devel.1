Received: from eggs.gnu.org ([2001:4830:134:3::10]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eWYQB-0008KO-4f
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eWYQ7-0006GZ-7F
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:04:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:54020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eWYQ6-0006FQ-Rx
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:04:43 -0500
Date: Wed, 3 Jan 2018 10:04:58 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180103020458.gdnvfqhc24m4x2ez@hz-desktop>
References: <20171225010611.32621-1-haozhong.zhang@intel.com>
	<20171225010611.32621-2-haozhong.zhang@intel.com>
	<20171231175434-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171231175434-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] util/pmem: add function to make writes
 to pmem persistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 12/31/17 17:55 +0200, Michael S. Tsirkin wrote:
> On Mon, Dec 25, 2017 at 09:06:10AM +0800, Haozhong Zhang wrote:
> > The new function pmem_persistent() flushes the previous cached writes
> > on the specified memory buffer, which ensures the write persistence if
> > the buffer is in persistent memory.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> >  include/qemu/pmem.h |  25 ++++++++++
> >  util/Makefile.objs  |   1 +
> >  util/pmem.c         | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 include/qemu/pmem.h
> >  create mode 100644 util/pmem.c
> > 
> > diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
> > new file mode 100644
> > index 0000000000..6593ae1d5c
> > --- /dev/null
> > +++ b/include/qemu/pmem.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * Helper functions to operate on persistent memory.
> > + *
> > + * Copyright (c) 2017 Intel Corporation.
> > + *
> > + * Author: Haozhong Zhang <haozhong.zhang@intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef QEMU_PMEM_H
> > +#define QEMU_PMEM_H
> > +
> > +/**
> > + * Flush previous cached writes to the specified memory buffer. If the
> > + * buffer is in persistent memory, this function will ensure the write
> > + * persistence.
> > + *
> > + * @p: the pointer to the memory buffer
> > + * @len: the length in bytes of the memory buffer
> > + */
> > +void pmem_persistent(void *p, unsigned long len);
> > +
> > +#endif /* QEMU_PMEM_H */
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index 2973b0a323..2614a84a9e 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -41,6 +41,7 @@ util-obj-y += timed-average.o
> >  util-obj-y += base64.o
> >  util-obj-y += log.o
> >  util-obj-y += pagesize.o
> > +util-obj-y += pmem.o
> >  util-obj-y += qdist.o
> >  util-obj-y += qht.o
> >  util-obj-y += range.o
> > diff --git a/util/pmem.c b/util/pmem.c
> > new file mode 100644
> > index 0000000000..44be1dde58
> > --- /dev/null
> > +++ b/util/pmem.c
> > @@ -0,0 +1,132 @@
> > +/*
> > + * Helper functions to operate on persistent memory.
> > + *
> > + * Copyright (c) 2017 Intel Corporation.
> > + *
> > + * Author: Haozhong Zhang <haozhong.zhang@intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qemu/pmem.h"
> > +
> > +static size_t cache_line_size;
> > +
> > +typedef void (*cache_flush_func_t)(void *p);
> > +typedef void (*store_fence_func_t)(void);
> > +
> > +static cache_flush_func_t cache_flush_func;
> > +static store_fence_func_t store_fence_func;
> > +
> > +#if defined(__x86_64__) || defined(__i386__)
> > +
> > +#define CPUID_1_0_EBX_CLSIZE_MASK   0x0000ff00
> > +#define CPUID_1_0_EBX_CLSIZE_SHIFT  8
> > +#define CPUID_1_0_EDX_CLFLUSH       (1U << 19)
> > +#define CPUID_7_0_EBX_CLFLUSHOPT    (1U << 23)
> > +#define CPUID_7_0_EBX_CLWB          (1U << 24)
> > +
> > +static inline void cpuid(uint32_t function, uint32_t count,
> > +                         uint32_t *eax, uint32_t *ebx,
> > +                         uint32_t *ecx, uint32_t *edx)
> > +{
> > +    uint32_t vec[4];
> > +
> > +#ifdef __x86_64__
> > +    asm volatile("cpuid"
> > +                 : "=a"(vec[0]), "=b"(vec[1]),
> > +                   "=c"(vec[2]), "=d"(vec[3])
> > +                 : "0"(function), "c"(count) : "cc");
> > +#else
> > +    asm volatile("pusha\n\t"
> > +                 "cpuid\n\t"
> > +                 "mov %%eax, 0(%2)\n\t"
> > +                 "mov %%ebx, 4(%2)\n\t"
> > +                 "mov %%ecx, 8(%2)\n\t"
> > +                 "mov %%edx, 12(%2)\n\t"
> > +                 "popa"
> > +                 : : "a"(function), "c"(count), "S"(vec)
> > +                 : "memory", "cc");
> > +#endif
> > +
> > +    if (eax) {
> > +        *eax = vec[0];
> > +    }
> > +    if (ebx) {
> > +        *ebx = vec[1];
> > +    }
> > +    if (ecx) {
> > +        *ecx = vec[2];
> > +    }
> > +    if (edx) {
> > +        *edx = vec[3];
> > +    }
> > +}
> > +
> > +static void clflush(void *p)
> > +{
> > +    asm volatile("clflush %0" : "+m" (*(volatile char *)p));
> > +}
> > +
> > +static void clflushopt(void *p)
> > +{
> > +    asm volatile(".byte 0x66; clflush %0" : "+m" (*(volatile char *)p));
> > +}
> > +
> > +static void clwb(void *p)
> > +{
> > +    asm volatile(".byte 0x66; xsaveopt %0" : "+m" (*(volatile char *)p));
> > +}
> > +
> > +static void sfence(void)
> > +{
> > +    asm volatile("sfence" : : : "memory");
> > +}
> > +
> > +static void __attribute__((constructor)) init_funcs(void)
> > +{
> > +    uint32_t ebx, edx;
> > +
> > +    cpuid(0x1, 0x0, NULL, &ebx, NULL, &edx);
> > +
> > +    cache_line_size = ((ebx & CPUID_1_0_EBX_CLSIZE_MASK) >>
> > +                       CPUID_1_0_EBX_CLSIZE_SHIFT) * 8;
> > +    assert(cache_line_size && !(cache_line_size & (cache_line_size - 1)));
> > +
> > +    cpuid(0x7, 0x0, NULL, &ebx, NULL, NULL);
> > +    if (ebx & CPUID_7_0_EBX_CLWB) {
> > +        cache_flush_func = clwb;
> > +    } else if (ebx & CPUID_7_0_EBX_CLFLUSHOPT) {
> > +        cache_flush_func = clflushopt;
> > +    } else {
> > +        if (edx & CPUID_1_0_EDX_CLFLUSH) {
> > +            cache_flush_func = clflush;
> > +        }
> > +    }
> > +
> > +    store_fence_func = sfence;
> > +}
> > +
> > +#endif /* __x86_64__ || __i386__ */
> > +
> > +void pmem_persistent(void *p, unsigned long len)
> > +{
> > +    uintptr_t s, e;
> > +
> > +    if (!cache_flush_func || !store_fence_func) {
> > +        return;
> > +    }
> > +
> > +    s = (uintptr_t)p & ~(cache_line_size - 1);
> > +    e = (uintptr_t)p + len;
> > +
> > +    while (s < e) {
> > +        cache_flush_func((void *)s);
> > +        s +=  cache_line_size;
> > +    }
> > +
> > +    store_fence_func();
> > +}
> 
> 
> Shouldn't something be done for non x86 platforms?

This patch basically follows what pmdk [1] does. Recently there is an
initial AARCH64 port to pmdk [2]. I can add those instruction changes
to this patch series as well.

For other platforms, pmem_persistent() currently does nothing, and we
can add their support later when it's clear what changes are needed.

[1] Formerly known as nvml, http://pmem.io/pmdk/
[2] https://github.com/vvenkates27/nvml/commit/aeabe1d4bf9fc88c2b645d45ebce3de969e13a31


Haozhong
