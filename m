Received: from eggs.gnu.org ([2001:4830:134:3::10]:58769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csW40-0000x5-2n
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csW3w-00013a-6e
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:08 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csW3w-00013T-1V
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:04 -0400
Received: by mail-qt0-x244.google.com with SMTP id x35so7928377qtc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:56:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
	<20170326184634.25042-3-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a81b0761-eda4-144d-edfe-f283ecfa6bb6@amsat.org>
Date: Mon, 27 Mar 2017 11:56:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170326184634.25042-3-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Send RDNSS in RA only if host
 has an IPv6 DNS server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, jan.kiszka@siemens.com

Hi Samuel,

On 03/26/2017 03:46 PM, Samuel Thibault wrote:
> Previously we would always send an RDNSS option in the RA, making the guest
> try to resolve DNS through IPv6, even if the host does not actually have
> and IPv6 DNS server available.
>
> This makes the RDNSS option enabled only when an IPv6 DNS server is
> available.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/ip6_icmp.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index d0f5cc1456..00183e5945 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -189,18 +189,22 @@ void ndp_send_ra(Slirp *slirp)
>      t->m_data += NDPOPT_PREFIXINFO_LEN;
>      pl_size += NDPOPT_PREFIXINFO_LEN;
>
> -#ifndef _WIN32
>      /* Prefix information (NDP option) */
> -    /* disabled for windows for now, until get_dns6_addr is implemented */
> -    struct ndpopt *opt3 = mtod(t, struct ndpopt *);
> -    opt3->ndpopt_type = NDPOPT_RDNSS;
> -    opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
> -    opt3->ndpopt_rdnss.reserved = 0;
> -    opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
> -    opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
> -    t->m_data += NDPOPT_RDNSS_LEN;
> -    pl_size += NDPOPT_RDNSS_LEN;
> -#endif
> +    {

Why don't declare at function begining and remove this { } ?
Else reading the file one might ask himself "what if () condition was 
missed here?".
Except this indentation issue the patch is Ok for me.

> +        struct in6_addr addr;
> +        uint32_t scope_id;
> +        if (get_dns6_addr(&addr, &scope_id) >= 0) {
> +            /* Host system does have an IPv6 DNS server, announce our proxy.  */
> +            struct ndpopt *opt3 = mtod(t, struct ndpopt *);
> +            opt3->ndpopt_type = NDPOPT_RDNSS;
> +            opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
> +            opt3->ndpopt_rdnss.reserved = 0;
> +            opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
> +            opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
> +            t->m_data += NDPOPT_RDNSS_LEN;
> +            pl_size += NDPOPT_RDNSS_LEN;
> +        }
> +    }
>
>      rip->ip_pl = htons(pl_size);
>      t->m_data -= sizeof(struct ip6) + pl_size;
>

Phil.
