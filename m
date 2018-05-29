Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNeQ3-0008EC-8J
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNePz-0006hw-7m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:12:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-6-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48fac48c-168d-70b6-5020-1faac584804e@amsat.org>
Date: Tue, 29 May 2018 10:11:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180529062838.20556-6-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] slirp/ncsi: add a "Get Parameter"
 response
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

Hi Cédric,

In title: "Get Parameters" (plural)

On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
> This is a minimum response to exercise the kernel.

This type is mandatory in DMTF Standard v1.0.1 indeed (DSP0222).

> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  slirp/ncsi.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index 02d0e9def3e8..f00253641ea4 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -35,6 +35,27 @@ static int ncsi_rsp_handler_gls(struct ncsi_rsp_pkt_hdr *rnh)
>      return 0;
>  }
>  
> +/* Get Parameter */

"Parameters"

> +static int ncsi_rsp_handler_gp(struct ncsi_rsp_pkt_hdr *rnh)
> +{
> +    struct ncsi_rsp_gp_pkt *rsp = (struct ncsi_rsp_gp_pkt *) rnh;
> +
> +    rsp->mac_cnt = 0x0;

"MAC Address Count: The number of MAC addresses supported by the channel"

0 means "no [MAC Address] filter [in use]"

> +    rsp->mac_enable = 0x0;

"MAC Address Flags: all [MAC Address filters] disabled" ...

> +
> +    /* TODO: provide the guest configured MAC */
> +    rsp->mac[0] = 0xaa;
> +    rsp->mac[1] = 0xbb;
> +    rsp->mac[2] = 0xcc;
> +    rsp->mac[3] = 0xdd;
> +    rsp->mac[4] = 0xee;
> +    rsp->mac[5] = 0xff;

So there is no need to set this filter,
or you have to set:

    rsp->mac_cnt = 1;
    rsp->mac_enable = 1 << 0;

Also, you forgot to set:

    rsp->vlan_cnt = 0;
    rsp->vlan_enable = 0;

> +
> +    /* more data follows */
> +
> +    return 0;
> +}
> +
>  static const struct ncsi_rsp_handler {
>          unsigned char   type;
>          int             payload;
> @@ -62,7 +83,7 @@ static const struct ncsi_rsp_handler {
>          { NCSI_PKT_RSP_SNFC,    4, NULL },
>          { NCSI_PKT_RSP_GVI,    40, NULL },
>          { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
> -        { NCSI_PKT_RSP_GP,     -1, NULL },
> +        { NCSI_PKT_RSP_GP,     40, ncsi_rsp_handler_gp },
>          { NCSI_PKT_RSP_GCPS,  172, NULL },
>          { NCSI_PKT_RSP_GNS,   172, NULL },
>          { NCSI_PKT_RSP_GNPTS, 172, NULL },
> 
