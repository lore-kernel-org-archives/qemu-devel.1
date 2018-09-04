Received: from eggs.gnu.org ([2001:4830:134:3::10]:46496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxHgC-0008Ms-O8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxHg4-0006J9-Te
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:12:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxHg3-0006I3-1C
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:11:56 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfcdf727-a1cf-0ad5-c052-25d3b657a433@redhat.com>
Date: Tue, 4 Sep 2018 15:11:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-7-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

On 08/30/2018 09:27 AM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>   hw/net/rss_bpf_insns.h       | 3992 ++++++++++++++++++++++++++++++++++++++++++
>   hw/net/rss_tap_bpf.h         |   40 +
>   hw/net/rss_tap_bpf_program.c |  175 ++
>   hw/net/virtio-net.c          |   99 +-
>   4 files changed, 4305 insertions(+), 1 deletion(-)
>   create mode 100644 hw/net/rss_bpf_insns.h
>   create mode 100644 hw/net/rss_tap_bpf.h
>   create mode 100644 hw/net/rss_tap_bpf_program.c
> 
> diff --git a/hw/net/rss_bpf_insns.h b/hw/net/rss_bpf_insns.h
> new file mode 100644
> index 0000000000..1a92110b8d
> --- /dev/null
> +++ b/hw/net/rss_bpf_insns.h
> @@ -0,0 +1,3992 @@
> +/*
> + * RSS ebpf instructions for virtio-net
> + *
> + * Copyright (c) 2018 RedHat.

Please spell it "Red Hat", as that is the proper name in use in all 
other places in the repository.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <linux/bpf.h>
> +
> +#ifndef BPF_RSS_INSNS
> +#define BPF_RSS_INSNS
> +
> +/* bpf_insn array matching l3_l4 section. see tap_bpf_program.c file */
> +struct bpf_insn l3_l4_hash_insns[] = {
> +{0xbf , 0x6 , 0x1 , 0x0000 , 0x00000000},
> +{0x28 , 0x0 , 0x0 , 0x0000 , 0x0000000c},

Is this file generated?  If not, this long array of magic numbers can't 
be the preferred form for source editing (which would be in violation of 
GPL requirements); if so, why are we checking in a generated file into 
qemu.git?  It can indeed be valid to check in a generated file if the 
program for generating it is not commonly available to developers, but 
the comments should make it clear that such is the case; and you would 
be wise to point to more than just 'tap_bpf_program.c', but also include 
comments stating how to reproduce this generated file.

Your commit then adds a file by a similar name, but not matching the one 
you called out here:

> --- /dev/null
> +++ b/hw/net/rss_tap_bpf_program.c
> @@ -0,0 +1,175 @@
> +/*
> + * RSS ebpf code for virtio-net
> + *
> + * Copyright (c) 2018 RedHat.

Again, wrong spelling.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * This code is heavily based on the following bpf code from dpdk
> + * https://git.dpdk.org/dpdk/tree/drivers/net/tap/tap_bpf_program.c

Your choice of license might be incompatible.  That file states:

/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0

but GPLv2-only is not the same as your choice of GPLv2+.

Perhaps you can get away with GPLv2+ being compatible with BSD-3-Clause, 
but it might be safer to state that this file is GPLv2-only (as an 
explicit choice of one of your two options from the source you were 
copying).

> +
> +RSS(l3_l4)
> +
> +BPF_LICENSE("Dual BSD/GPL");

And this is different from what you wrote above. So which license is 
this file?

> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4a52a6a1d0..66b2140cc7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -27,6 +27,10 @@
>   #include "hw/virtio/virtio-access.h"
>   #include "migration/misc.h"
>   #include "standard-headers/linux/ethtool.h"
> +#include <sys/syscall.h>
> +#include <linux/bpf.h>

Is this going to cause compilation failure on non-Linux machines?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
