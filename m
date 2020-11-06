Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E500C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706FD2151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706FD2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5ss-0005xd-6B
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kb5qj-0005L8-MK
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:48:33 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:47624)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kb5qh-0008Hc-1n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:48:33 -0500
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0A6HlOV2046739;
 Fri, 6 Nov 2020 18:47:24 +0100 (CET)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0A6HlOfj019881; Fri, 6 Nov 2020 18:47:24 +0100
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0A6HlN3p019880;
 Fri, 6 Nov 2020 18:47:23 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.2 1/4] hw/net/can/ctucan: Don't allow guest to write
 off end of tx_buffer
Date: Fri, 6 Nov 2020 18:47:23 +0100
User-Agent: KMail/1.9.10
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-2-peter.maydell@linaro.org>
In-Reply-To: <20201106171153.32673-2-peter.maydell@linaro.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202011061847.23354.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0A6HlOV2046739
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.223, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
 NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1605289648.85887@Dpw+2y6iC0Lp+1gfp25TRA
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 12:48:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, qemu-devel@nongnu.org,
 Jan =?utf-8?q?Charv=C3=A1t?= <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Peter,

thanks much for the catching the problem and investing time into
fixing. I hope to find time for more review of remarks and Xilinx
patches next week. I do not find reasonable time slot till Sunday.
Excuse me. To not block updates, I confirm your changes.

On Friday 06 of November 2020 18:11:50 Peter Maydell wrote:
> The ctucan device has 4 CAN bus cores, each of which has a set of 20
> 32-bit registers for writing the transmitted data. The registers are
> however not contiguous; each core's buffers is 0x100 bytes after
> the last.
>
> We got the checks on the address wrong in the ctucan_mem_write()
> function:
>  * the first "is addr in range at all" check allowed
>    addr == CTUCAN_CORE_MEM_SIZE, which is actually the first
>    byte off the end of the range
>  * the decode of addresses into core-number plus offset in the
>    tx buffer for that core failed to check that the offset was
>    in range, so the guest could write off the end of the
>    tx_buffer[] array
>  * the decode had an explicit check for whether the core-number
>    was out of range, which is actually impossible given the
>    CTUCAN_CORE_MEM_SIZE check and the number of cores.
>
> Fix the top level check, check the offset, and turn the check
> on the core-number into an assertion.
>
> Fixes: Coverity CID 1432874
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/can/ctucan_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> index d20835cd7e9..ea09bf71a0c 100644
> --- a/hw/net/can/ctucan_core.c
> +++ b/hw/net/can/ctucan_core.c
> @@ -303,7 +303,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr,
> uint64_t val, DPRINTF("write 0x%02llx addr 0x%02x\n",
>              (unsigned long long)val, (unsigned int)addr);
>
> -    if (addr > CTUCAN_CORE_MEM_SIZE) {
> +    if (addr >= CTUCAN_CORE_MEM_SIZE) {
>          return;
>      }

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

There is another mistake

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index d20835cd7e..b90a8e3b76 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -418,7 +418,7 @@ uint64_t ctucan_mem_read(CtuCanCoreState *s, hwaddr addr, unsigned size)

     DPRINTF("read addr 0x%02x ...\n", (unsigned int)addr);

-    if (addr > CTUCAN_CORE_MEM_SIZE) {
+    if (addr >= CTUCAN_CORE_MEM_SIZE) {
         return 0;
     }
But is should be really harmless.

> @@ -312,7 +312,8 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr,
> uint64_t val, addr -= CTU_CAN_FD_TXTB1_DATA_1;
>          buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
>          addr %= CTUCAN_CORE_TXBUFF_SPAN;
> -        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
> +        assert(buff_num < CTUCAN_CORE_TXBUF_NUM);

Assert is not necessary. If there is not buffer at that location,
then write has no effect. Assert would check for driver errors,
but it is not a problem of QEMU and for sure should not lead to its
crash.

> +        if (addr < sizeof(s->tx_buffer[buff_num].data)) {
>              uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data +
> addr); *bufp = cpu_to_le32(val);
>          }

So my proposed solution is

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index d20835cd7e..af30d57cfd 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -312,7 +312,9 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
         addr -= CTU_CAN_FD_TXTB1_DATA_1;
         buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
         addr %= CTUCAN_CORE_TXBUFF_SPAN;
-        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
+        addr &= ~3;
+        if (buff_num < CTUCAN_CORE_TXBUF_NUM &&
+            addr < CTUCAN_CORE_MSG_MAX_LEN) {
             uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
             *bufp = cpu_to_le32(val);
         }

It ignores writes to unimplemented locations.

There is fix, workaround to make safe writes to unaligned addresses.
They are not supported by actual QEMU CTU CAN FD model.
Real HW supports them but driver never uses unaligned writes
nor any other size than 32-bits.

Reads supports at least accesses by smaller size correctly
but do not support unaligned reads which cross 32-bit boundaries.
Again, actual driver code never uses other size than 32-bits
for read. Byte access for debug dumps by rdwrmem by bytes
has been tested and works OK as well.

The following proposed correction right solution too

diff --git a/hw/net/can/ctucan_core.h b/hw/net/can/ctucan_core.h
index f21cb1c5ec..ad701c4764 100644
--- a/hw/net/can/ctucan_core.h
+++ b/hw/net/can/ctucan_core.h
@@ -31,10 +31,11 @@
 #include "exec/hwaddr.h"
 #include "net/can_emu.h"

-
+#ifndef HOST_WORDS_BIGENDIAN
 #ifndef __LITTLE_ENDIAN_BITFIELD
 #define __LITTLE_ENDIAN_BITFIELD 1
 #endif
+#endif

 #include "ctu_can_fd_frame.h"
 #include "ctu_can_fd_regs.h"

As for bitfields use, there is plan to add additional mode to generate
registers header file from IPXACT register definition sources which
would be based only on defines to follow Linux kernel registers
definition style.

In the longer run, if there is time we can switch QEMU model
to use this additional style and headers.

Thanks much for time again,

Pavel

