Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D6C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A585207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A585207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCQQ-0005Wh-JN
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYCPP-00054w-6R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:12:23 -0400
Received: from relay68.bu.edu ([128.197.228.73]:56512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYCPN-0002kt-9Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:12:22 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09TIBfUh013533
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 Oct 2020 14:11:45 -0400
Date: Thu, 29 Oct 2020 14:11:41 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH-for-5.2 1/3] fuzz: fix writing DMA patterns
Message-ID: <20201029181141.pbyqo6lufl6dkfy4@mozz.bu.edu>
References: <20201029172901.534442-1-alxndr@bu.edu>
 <20201029172901.534442-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029172901.534442-2-alxndr@bu.edu>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 14:12:19
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.021, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201029 1328, Alexander Bulekov wrote:
> This code had all sorts of issues. We used a loop similar to
> address_space_write_rom, but I did not remove a "break" that only made
> sense in the context of the switch statement in the original code. Then,
> after the loop, we did a separate qtest_memwrite over the entire DMA
> access range, defeating the purpose of the loop. Additionally, we
> increment the buf pointer, and then try to g_free() it. Fix these
> problems.
> 
> Reported-by: OSS-Fuzz (Issue 26725)

Also:
Reported-by: OSS-Fuzz (Issue 26691)

> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/generic_fuzz.c | 37 +++++++++++++++------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index a8f5864883..3e2d50feaa 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -229,10 +229,10 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
>      address_range ar = {addr, len};
>      g_array_append_val(dma_regions, ar);
>      pattern p = g_array_index(dma_patterns, pattern, dma_pattern_index);
> -    void *buf = pattern_alloc(p, ar.size);
> +    void *buf_base = pattern_alloc(p, ar.size);
> +    void *buf = buf_base;
>      hwaddr l, addr1;
>      MemoryRegion *mr1;
> -    uint8_t *ram_ptr;
>      while (len > 0) {
>          l = len;
>          mr1 = address_space_translate(first_cpu->as,
> @@ -244,30 +244,27 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
>              l = memory_access_size(mr1, l, addr1);
>          } else {
>              /* ROM/RAM case */
> -            ram_ptr = qemu_map_ram_ptr(mr1->ram_block, addr1);
> -            memcpy(ram_ptr, buf, l);
> -            break;
> +            if (qtest_log_enabled) {
> +                /*
> +                * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> +                * that will be written by qtest.c with a DMA tag, so we can reorder
> +                * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> +                * command.
> +                */
> +                fprintf(stderr, "[DMA] ");
> +                if (double_fetch) {
> +                    fprintf(stderr, "[DOUBLE-FETCH] ");
> +                }
> +                fflush(stderr);
> +            }
> +            qtest_memwrite(qts_global, addr, buf, l);
>          }
>          len -= l;
>          buf += l;
>          addr += l;
>  
>      }
> -    if (qtest_log_enabled) {
> -        /*
> -         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> -         * that will be written by qtest.c with a DMA tag, so we can reorder
> -         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> -         * command.
> -         */
> -        fprintf(stderr, "[DMA] ");
> -        if (double_fetch) {
> -            fprintf(stderr, "[DOUBLE-FETCH] ");
> -        }
> -        fflush(stderr);
> -    }
> -    qtest_memwrite(qts_global, ar.addr, buf, ar.size);
> -    g_free(buf);
> +    g_free(buf_base);
>  
>      /* Increment the index of the pattern for the next DMA access */
>      dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
> -- 
> 2.28.0
> 

