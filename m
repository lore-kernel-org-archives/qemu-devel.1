Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37471C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 22:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0902072A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 22:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0902072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9GIh-0006Ap-7f
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 17:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1j9GHX-0004uc-Sq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1j9GHT-000160-9C
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:44:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38186)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1j9GHT-00011L-4c
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:44:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id E4F742A49D;
 Tue,  3 Mar 2020 17:44:44 -0500 (EST)
Date: Wed, 4 Mar 2020 09:44:42 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL V2 01/23] dp8393x: Mask EOL bit from descriptor
 addresses
In-Reply-To: <1583230242-14597-2-git-send-email-jasowang@redhat.com>
Message-ID: <alpine.LNX.2.22.394.2003040842130.9@nippy.intranet>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
 <1583230242-14597-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

The patch in this pull request (since merged) differs from the patch that 
I sent. In particular, the change below is missing from commit 88f632fbb1 
("dp8393x: Mask EOL bit from descriptor addresses") in mainline.

--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                                  * (4 + 3 * s->regs[SONIC_TFC]),
                                MEMTXATTRS_UNSPECIFIED, s->data,
                                size);
-            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
-            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0);
+            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
                 /* EOL detected */
                 break;
             }

Please compare with "[PATCH v4 01/14] dp8393x: Mask EOL bit from 
descriptor addresses" in the mailing list archives: 
https://lore.kernel.org/qemu-devel/d6e8d06ad4d02f4a30c4caa6001967f806f21a1a.1580290069.git.fthain@telegraphics.com.au/

It appears that this portion of my patch went missing when merge conflicts 
were resolved. The conflicts were apparently caused by commit 19f7034773 
("Avoid address_space_rw() with a constant is_write argument").

Regards,
Finn

On Tue, 3 Mar 2020, Jason Wang wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> 
> The Least Significant bit of a descriptor address register is used as
> an EOL flag. It has to be masked when the register value is to be used
> as an actual address for copying memory around. But when the registers
> are to be updated the EOL bit should not be masked.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/dp8393x.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 7045193..216d44b 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while (0)
>  #define SONIC_ISR_PINT   0x0800
>  #define SONIC_ISR_LCD    0x1000
>  
> +#define SONIC_DESC_EOL   0x0001
> +#define SONIC_DESC_ADDR  0xFFFE
> +
>  #define TYPE_DP8393X "dp8393x"
>  #define DP8393X(obj) OBJECT_CHECK(dp8393xState, (obj), TYPE_DP8393X)
>  
> @@ -197,7 +200,8 @@ static uint32_t dp8393x_crba(dp8393xState *s)
>  
>  static uint32_t dp8393x_crda(dp8393xState *s)
>  {
> -    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
> +    return (s->regs[SONIC_URDA] << 16) |
> +           (s->regs[SONIC_CRDA] & SONIC_DESC_ADDR);
>  }
>  
>  static uint32_t dp8393x_rbwc(dp8393xState *s)
> @@ -217,7 +221,8 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
>  
>  static uint32_t dp8393x_ttda(dp8393xState *s)
>  {
> -    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
> +    return (s->regs[SONIC_UTDA] << 16) |
> +           (s->regs[SONIC_TTDA] & SONIC_DESC_ADDR);
>  }
>  
>  static uint32_t dp8393x_wt(dp8393xState *s)
> @@ -509,7 +514,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>                                 MEMTXATTRS_UNSPECIFIED, s->data,
>                                 size);
>              s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & 0x1) {
> +            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
>                  /* EOL detected */
>                  break;
>              }
> @@ -765,13 +770,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>      /* XXX: Check byte ordering */
>  
>      /* Check for EOL */
> -    if (s->regs[SONIC_LLFA] & 0x1) {
> +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>          /* Are we still in resource exhaustion? */
>          size = sizeof(uint16_t) * 1 * width;
>          address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>          address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                             s->data, size);
> -        if (dp8393x_get(s, width, 0) & 0x1) {
> +        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
>              /* Still EOL ; stop reception */
>              return -1;
>          } else {
> @@ -831,7 +836,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>                         dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
>                         MEMTXATTRS_UNSPECIFIED, s->data, size);
>      s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
> -    if (s->regs[SONIC_LLFA] & 0x1) {
> +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>          /* EOL detected */
>          s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>      } else {
> 

