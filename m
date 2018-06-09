Received: from eggs.gnu.org ([2001:4830:134:3::10]:46656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fRZXZ-0004Ya-SN
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 04:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fRZXY-0003q8-Tv
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 04:48:05 -0400
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-11-laurent@vivier.eu>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3d55a7ff-93b1-06d6-252a-0df31aa8d084@reactos.org>
Date: Sat, 9 Jun 2018 10:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-11-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 10/13] dp8393x: fix dp8393x_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Le 08/06/2018 à 22:05, Laurent Vivier a écrit :
> address_space_rw() access size must be multiplied by width.
> dp8393x_receive() must return the number of bytes read, not the length
> of the last memory access.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index f2d2ce344c..ef5f1eb94f 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -808,9 +808,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>           /* EOL detected */
>           s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>       } else {
> +        size = sizeof(uint16_t) * width;
>           data[0 * width] = 0; /* in_use */
> -        address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
> +        address_space_rw(&s->as,
> +            dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
>           s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
> @@ -824,7 +826,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>       /* Done */
>       dp8393x_update_irq(s);
>   
> -    return size;
> +    return rx_len;
>   }
>   
>   static void dp8393x_reset(DeviceState *dev)
> 

NACK. This breaks NetBSD 5.1/arc networking.

This seems to revert the following commit and change the function return value.

commit 409b52bfe199d8106dadf7c5ff3d88d2228e89b5
Author: Hervé Poussineau <hpoussin@reactos.org>
Date:   Wed Jun 3 22:45:48 2015 +0200

     net/dp8393x: correctly reset in_use field

     Don't write more than the field width, which is always 16 bit.
     Fixes network in NetBSD 5.1/arc

     Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
     Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
     Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 4184045145..ff633f76a0 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -764,7 +764,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
          data[0 * width] = 0; /* in_use */
          address_space_rw(&s->as,
              ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
          s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
          s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
          s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
