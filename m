Received: from eggs.gnu.org ([2001:4830:134:3::10]:48417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO2wv-0000v4-4Y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO2wq-00054O-6X
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:23:41 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO2wq-000548-1n
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:23:36 -0400
Received: by mail-qk0-x241.google.com with SMTP id h7-v6so7513466qkm.0
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:23:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530061035.22592-1-clg@kaod.org>
	<20180530061035.22592-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10b667eb-ff35-c64a-a3b1-37d8cd2b845e@amsat.org>
Date: Wed, 30 May 2018 12:23:31 -0300
MIME-Version: 1.0
In-Reply-To: <20180530061035.22592-3-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] slirp/ncsi: add a "Get Parameters"
 response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org

On 05/30/2018 03:10 AM, Cédric Le Goater wrote:
> Command 0x17 'Get Parameters' is used to get configuration parameter
> values currently in effect on the controller and it is mandatory in
> the NS-CI specification.
> 
> Provide a minimum response to exercise the kernel.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  Changes since v1:
> 
>  - removed bogus MAC addr and initialized VLAN filters to zero.
> 
>  slirp/ncsi.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index 02d0e9def3e8..7b3fff207ab3 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -35,6 +35,20 @@ static int ncsi_rsp_handler_gls(struct ncsi_rsp_pkt_hdr *rnh)
>      return 0;
>  }
>  
> +/* Get Parameters */
> +static int ncsi_rsp_handler_gp(struct ncsi_rsp_pkt_hdr *rnh)
> +{
> +    struct ncsi_rsp_gp_pkt *rsp = (struct ncsi_rsp_gp_pkt *) rnh;
> +
> +    /* no MAC address filters or VLAN filters on the channel */
> +    rsp->mac_cnt = 0;
> +    rsp->mac_enable = 0;
> +    rsp->vlan_cnt = 0;
> +    rsp->vlan_enable = 0;
> +
> +    return 0;
> +}
> +
>  static const struct ncsi_rsp_handler {
>          unsigned char   type;
>          int             payload;
> @@ -62,7 +76,7 @@ static const struct ncsi_rsp_handler {
>          { NCSI_PKT_RSP_SNFC,    4, NULL },
>          { NCSI_PKT_RSP_GVI,    40, NULL },
>          { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
> -        { NCSI_PKT_RSP_GP,     -1, NULL },
> +        { NCSI_PKT_RSP_GP,     40, ncsi_rsp_handler_gp },
>          { NCSI_PKT_RSP_GCPS,  172, NULL },
>          { NCSI_PKT_RSP_GNS,   172, NULL },
>          { NCSI_PKT_RSP_GNPTS, 172, NULL },
> 
