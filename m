Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY63m-0006oR-H7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY63i-0003LQ-KH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:39:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY63i-0003LG-GX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:39:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id 50so2387037qtz.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:39:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-36-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <06200ec3-3c8b-4e69-a339-76b22b99e4d1@twiddle.net>
Date: Wed, 19 Jul 2017 21:39:35 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-36-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 35/43] tcg: dynamically allocate
 optimizer temps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> Groundwork for supporting multiple TCG contexts.
> 
> While at it, also allocate temps_used directly as a bitmap of the
> required size, instead of having a bitmap of TCG_MAX_TEMPS via
> TCGTempSet.
> 
> Performance-wise we lose about 2% in a translation-heavy workload
> such as booting+shutting down debian-arm:
> 
> Performance counter stats for 'taskset -c 0 arm-softmmu/qemu-system-arm \
> 	-machine type=virt -nographic -smp 1 -m 4096 \
> 	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
> 	-device virtio-net-device,netdev=unet \
> 	-drive file=die-on-boot.qcow2,id=myblock,index=0,if=none \
> 	-device virtio-blk-device,drive=myblock \
> 	-kernel kernel.img -append console=ttyAMA0 root=/dev/vda1 \
> 	-name arm,debug-threads=on -smp 1' (10 runs):
> 
> Before:
>        19489.126318 task-clock                #    0.960 CPUs utilized            ( +-  0.96% )
>              23,697 context-switches          #    0.001 M/sec                    ( +-  0.51% )
>                   1 CPU-migrations            #    0.000 M/sec
>              19,953 page-faults               #    0.001 M/sec                    ( +-  0.40% )
>      56,214,402,410 cycles                    #    2.884 GHz                      ( +-  0.95% ) [83.34%]
>      25,516,669,513 stalled-cycles-frontend   #   45.39% frontend cycles idle     ( +-  0.69% ) [83.33%]
>      17,266,165,747 stalled-cycles-backend    #   30.71% backend  cycles idle     ( +-  0.59% ) [66.66%]
>      79,007,843,327 instructions              #    1.41  insns per cycle
>                                               #    0.32  stalled cycles per insn  ( +-  1.19% ) [83.34%]
>      13,136,600,416 branches                  #  674.048 M/sec                    ( +-  1.29% ) [83.34%]
>         274,715,270 branch-misses             #    2.09% of all branches          ( +-  0.79% ) [83.33%]
> 
>        20.300335944 seconds time elapsed                                          ( +-  0.55% )
> 
> After:
>        19917.737030 task-clock                #    0.955 CPUs utilized            ( +-  0.74% )
>              23,973 context-switches          #    0.001 M/sec                    ( +-  0.37% )
>                   1 CPU-migrations            #    0.000 M/sec
>              19,824 page-faults               #    0.001 M/sec                    ( +-  0.38% )
>      57,380,269,537 cycles                    #    2.881 GHz                      ( +-  0.70% ) [83.34%]
>      26,462,452,508 stalled-cycles-frontend   #   46.12% frontend cycles idle     ( +-  0.65% ) [83.34%]
>      17,970,546,047 stalled-cycles-backend    #   31.32% backend  cycles idle     ( +-  0.64% ) [66.67%]
>      79,527,238,334 instructions              #    1.39  insns per cycle
>                                               #    0.33  stalled cycles per insn  ( +-  0.79% ) [83.33%]
>      13,272,362,192 branches                  #  666.359 M/sec                    ( +-  0.83% ) [83.34%]
>         278,357,773 branch-misses             #    2.10% of all branches          ( +-  0.65% ) [83.33%]
> 
>        20.850558455 seconds time elapsed                                          ( +-  0.55% )
> 
> That is, 2.70% slowdown.

That's disappointing.  How about using tcg_malloc?

Maximum allocation is sizeof(tcg_temp_info) * TCG_MAX_TEMPS = 12288, which is 
less than TCG_POOL_CHUNK_SIZE, so we'll retain the allocation in the pool 
across translations.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
