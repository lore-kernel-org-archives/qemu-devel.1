Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNecR-0005ul-Ol
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNecO-0007vG-F2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:24:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-7-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1d6ade72-ef0b-54c3-22f2-af2e514edb5a@amsat.org>
Date: Tue, 29 May 2018 10:24:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180529062838.20556-7-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] slirp/ncsi: add checksum support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
> The checksum field of a NC-SI packet contains a value that may be
> included in each command and response. The verification is optional
> but the Linux driver does so when a non-zero value is provided. Let's
> extend the model to compute the checksum value and exercise a little
> more the Linux driver.

Due to
- "If the originator of an NC-SI Control packet is not generating a
checksum, the originator shall use a value of all zeros for the header
checksum field."
- "All receivers of NC-SI Control packets shall accept packets with all
zeros as the checksum value (provided that other fields and the CRC are
correct)."
- "The receiver of an NC-SI Control packet may reject (silently discard)
a packet that has an incorrect non-zero checksum."

I was tempted to suggest you to check the input checksum if any, but
"A controller that generates checksums is not required to verify
checksums that it receives." so we don't care.

> 
> See section "8.2.2.3 - 2's Complement Checksum Compensation" in the
> Network Controller Sideband Interface (NC-SI) Specification for more
> details.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  slirp/ncsi.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index f00253641ea4..fbfb79713f23 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -8,9 +8,23 @@
>   */
>  #include "qemu/osdep.h"
>  #include "slirp.h"
> +#include "net/checksum.h"
>  
>  #include "ncsi-pkt.h"
>  
> +static uint32_t ncsi_calculate_checksum(unsigned char *data, int len)

"NC-SI packet payload interpreted as a series of 16-bit unsigned integer
values."

Can you use the "uint32_t ncsi_calculate_checksum(uint16_t *data, size_t
length)" prototype instead if you respin?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +{
> +    uint32_t checksum = 0;
> +    int i;
> +
> +    for (i = 0; i < len; i += 2) {
> +        checksum += (((uint32_t)data[i] << 8) | data[i + 1]);
> +    }
> +
> +    checksum = (~checksum + 1);
> +    return checksum;
> +}
> +
>  /* Get Capabilities */
>  static int ncsi_rsp_handler_gc(struct ncsi_rsp_pkt_hdr *rnh)
>  {
> @@ -108,6 +122,9 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>          (ncsi_reply + ETH_HLEN);
>      const struct ncsi_rsp_handler *handler = NULL;
>      int i;
> +    int ncsi_rsp_len = sizeof(*nh);
> +    uint32_t checksum;
> +    uint32_t *pchecksum;
>  
>      memset(ncsi_reply, 0, sizeof(ncsi_reply));
>  
> @@ -137,15 +154,19 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>              /* TODO: handle errors */
>              handler->handler(rnh);
>          }
> +        ncsi_rsp_len += handler->payload;
>      } else {
>          rnh->common.length = 0;
>          rnh->code          = htons(NCSI_PKT_RSP_C_UNAVAILABLE);
>          rnh->reason        = htons(NCSI_PKT_RSP_R_UNKNOWN);
>      }
>  
> -    /* TODO: add a checksum at the end of the frame but the specs
> -     * allows it to be zero */
> +    /* add a checksum at the end of the frame (the specs allows it to
> +     * be zero */
> +    checksum = ncsi_calculate_checksum((unsigned char *) rnh, ncsi_rsp_len);
> +    pchecksum = (uint32_t *)((void *) rnh + ncsi_rsp_len);
> +    *pchecksum = htonl(checksum);
> +    ncsi_rsp_len += 4;
>  
> -    slirp_output(slirp->opaque, ncsi_reply, ETH_HLEN + sizeof(*nh) +
> -                 (handler ? handler->payload : 0) + 4);
> +    slirp_output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
>  }
> 
