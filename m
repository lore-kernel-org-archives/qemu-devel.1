Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF57FC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 17:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9C62071B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 17:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9C62071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCRR0-0007wZ-P4
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kCRQV-0007TP-4k; Sun, 30 Aug 2020 13:47:35 -0400
Received: from relay64.bu.edu ([128.197.228.104]:57902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kCRQT-0003RZ-C7; Sun, 30 Aug 2020 13:47:34 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07UHkafs000681
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 30 Aug 2020 13:46:39 -0400
Date: Sun, 30 Aug 2020 13:46:36 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] sd: sdhci: check data_count is within fifo_buffer
Message-ID: <20200830174636.q6tg3d4podqhekec@mozz.bu.edu>
References: <20200827115336.1851276-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827115336.1851276-1-ppandit@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 13:47:31
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Ruhr-University <bugs-syssec@rub.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a qtest reproducer for this one:

cat << EOF |./i386-softmmu/qemu-system-i386 -nodefaults \
-device sdhci-pci -device sd-card,drive=mydrive \
-drive if=sd,index=0,file=null-co://,format=raw,id=mydrive \
-nographic -accel qtest -qtest stdio -nographic
outl 0xcf8 0x80001001
outl 0xcfc 0x7e6f25b7
outl 0xcf8 0x80001012
outl 0xcfc 0x842b1212
writeb 0x12120005 0xff
writeq 0x12120027 0x5e32b7120584125e
write 0x0 0x1 0x21
write 0x8 0x1 0x21
write 0x10 0x1 0x21
write 0x18 0x1 0x21
write 0x20 0x1 0x21
write 0x23 0x1 0x2b
writeq 0x1212000c 0x123a0584052da3ab
writeq 0x12120000 0xcfff000000000002
writeq 0x12120027 0x5c04c1c9c100005e
clock_step
EOF

Is it related to this https://bugs.launchpad.net/qemu/+bug/1892960 ?
-Alex

On 200827 1723, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While doing multi block SDMA, transfer block size may exceed
> the 's->fifo_buffer[s->buf_maxsz]' size. It may leave the
> current element pointer 's->data_count' pointing out of bounds.
> Leading the subsequent DMA r/w operation to OOB access issue.
> Add check to avoid it.
> 
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1
>  ==1459837==ERROR: AddressSanitizer: heap-buffer-overflow
>  WRITE of size 54722048 at 0x61500001e280 thread T3
>     #0  __interceptor_memcpy (/lib64/libasan.so.6+0x3a71d)
>     #1  flatview_read_continue ../exec.c:3245
>     #2  flatview_read ../exec.c:3278
>     #3  address_space_read_full ../exec.c:3291
>     #4  address_space_rw ../exec.c:3319
>     #5  dma_memory_rw_relaxed ../include/sysemu/dma.h:87
>     #6  dma_memory_rw ../include/sysemu/dma.h:110
>     #7  dma_memory_read ../include/sysemu/dma.h:116
>     #8  sdhci_sdma_transfer_multi_blocks ../hw/sd/sdhci.c:629
>     #9  sdhci_write ../hw/sd/sdhci.c:1097
>     #10 memory_region_write_accessor ../softmmu/memory.c:483
>     ...
> 
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1785d7e1f7..155e25ceee 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -604,6 +604,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>                      s->blkcnt--;
>                  }
>              }
> +            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
> +                break;
> +            }
>              dma_memory_write(s->dma_as, s->sdmasysad,
>                               &s->fifo_buffer[begin], s->data_count - begin);
>              s->sdmasysad += s->data_count - begin;
> @@ -626,6 +629,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>                  s->data_count = block_size;
>                  boundary_count -= block_size - begin;
>              }
> +            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
> +                break;
> +            }
>              dma_memory_read(s->dma_as, s->sdmasysad,
>                              &s->fifo_buffer[begin], s->data_count - begin);
>              s->sdmasysad += s->data_count - begin;
> -- 
> 2.26.2
> 
> 

