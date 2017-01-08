Received: from eggs.gnu.org ([2001:4830:134:3::10]:32788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cQ9No-0004pT-3z
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cQ9Nl-0006S9-1D
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:03:20 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cQ9Nk-0006Rj-MU
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:03:16 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so14796089wml.2
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 01:03:14 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <F68AE366-F432-43FA-BBD8-6B4EF72BDC14@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Sun, 8 Jan 2017 11:03:12 +0200
In-Reply-To: <1483690133-25104-1-git-send-email-lprosek@redhat.com>
References: <1483690133-25104-1-git-send-email-lprosek@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: optimize checksum computation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com


> On 6 Jan 2017, at 10:08 AM, Ladi Prosek <lprosek@redhat.com> wrote:
> 
> Very simple loop optimization with a significant performance impact.
> 
> Microbenchmark results, modern x86-64:
> 
> buffer size | speed up
> ------------+---------
> 1500        | 1.7x
> 64          | 1.5x
> 8           | 1.15x
> 
> Microbenchmark results, POWER7:
> 
> buffer size | speed up
> ------------+---------
> 1500        | 5x
> 64          | 3.3x
> 8           | 1.13x
> 
> There is a lot of room for further improvement at the expense of
> code complexity - aligned multibyte reads, LE/BE considerations,
> architecture-specific optimizations, etc. This patch still keeps
> things simple and readable.

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
> net/checksum.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/net/checksum.c b/net/checksum.c
> index 23323b0..4da72a6 100644
> --- a/net/checksum.c
> +++ b/net/checksum.c
> @@ -22,17 +22,22 @@
> 
> uint32_t net_checksum_add_cont(int len, uint8_t *buf, int seq)
> {
> -    uint32_t sum = 0;
> +    uint32_t sum1 = 0, sum2 = 0;
>     int i;
> 
> -    for (i = seq; i < seq + len; i++) {
> -        if (i & 1) {
> -            sum += (uint32_t)buf[i - seq];
> -        } else {
> -            sum += (uint32_t)buf[i - seq] << 8;
> -        }
> +    for (i = 0; i < len - 1; i += 2) {
> +        sum1 += (uint32_t)buf[i];
> +        sum2 += (uint32_t)buf[i + 1];
> +    }
> +    if (i < len) {
> +        sum1 += (uint32_t)buf[i];
> +    }
> +
> +    if (seq & 1) {
> +        return sum1 + (sum2 << 8);
> +    } else {
> +        return sum2 + (sum1 << 8);
>     }
> -    return sum;
> }
> 
> uint16_t net_checksum_finish(uint32_t sum)
> -- 
> 2.7.4
> 
