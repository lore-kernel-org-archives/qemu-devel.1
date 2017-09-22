Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvNkq-00049U-9K
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvNkn-0007c5-0m
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:12:28 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dvNkm-0007b6-Ru
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:12:24 -0400
Received: by mail-io0-x242.google.com with SMTP id e9so550411iod.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 06:12:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170921213052.1765-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9d640173-93fe-0850-9335-d545dd34b2de@twiddle.net>
Date: Fri, 22 Sep 2017 08:12:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170921213052.1765-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/kvm: fix and cleanup storing CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/21/2017 04:30 PM, David Hildenbrand wrote:
> +struct sigp_save_area {
> +    uint64_t    fprs[16];                       /* 0x0000 */
> +    uint64_t    grs[16];                        /* 0x0080 */
> +    PSW         psw;                            /* 0x0100 */
> +    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
> +    uint32_t    prefix;                         /* 0x0118 */
> +    uint32_t    fpc;                            /* 0x011c */
> +    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
> +    uint32_t    todpr;                          /* 0x0124 */
> +    uint64_t    cputm;                          /* 0x0128 */
> +    uint64_t    ckc;                            /* 0x0130 */
> +    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
> +    uint32_t    ars[16];                        /* 0x0140 */
> +    uint64_t    crs[16];                        /* 0x0384 */
> +} QEMU_PACKED;

I don't believe you need to use QEMU_PACKED.  Unless the "addr" that's passed
in can really be arbitrary?  (If so, the memory returned by
cpu_physical_memory_map will be unaligned and so we do need the PACKED to force
the compiler to generate unaligned stores into the structure.)

> QEMU_BUILD_BUG_ON(sizeof(*sa) != 512);

Put this right next to the structure?


r~
