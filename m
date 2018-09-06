Received: from eggs.gnu.org ([2001:4830:134:3::10]:42177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxnLG-0001u2-Uq
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxnLC-0003XC-Ic
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:00:34 -0400
References: <20180906054340.28988-1-famz@redhat.com>
	<20180906054340.28988-3-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34b9f583-0c55-5dab-3e18-130db0edc40a@redhat.com>
Date: Thu, 6 Sep 2018 08:00:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180906054340.28988-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] slirp: Add sanity check for str
 option length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org

On 2018-09-06 07:43, Fam Zheng wrote:
> When user provides a long domainname or hostname that doesn't fit in the
> DHCP packet, we mustn't overflow the response packet buffer. Instead,
> report errors, following the g_warning() in the slirp->vdnssearch
> branch.
> 
> Also check the strlen against 256 when initializing slirp, which limit
> is also from the protocol where one byte represents the string length.
> This gives an early error before the warning which is harder to notice
> or diagnose.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  net/slirp.c   |  9 +++++++++
>  slirp/bootp.c | 32 ++++++++++++++++++++++----------
>  2 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index 1e14318b4d..fd21dc728c 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -365,6 +365,15 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>          return -1;
>      }
>  
> +    if (vdomainname && strlen(vdomainname) > 255) {
> +        error_setg(errp, "'domainname' parameter cannot exceed 255 bytes");
> +        return -1;
> +    }
> +
> +    if (vhostname && strlen(vhostname) > 255) {
> +        error_setg(errp, "'vhostname' parameter cannot exceed 255 bytes");
> +        return -1;
> +    }
>  
>      nc = qemu_new_net_client(&net_slirp_info, peer, model, name);
>  
> diff --git a/slirp/bootp.c b/slirp/bootp.c
> index 9e7b53ba94..1e8185f0ec 100644
> --- a/slirp/bootp.c
> +++ b/slirp/bootp.c
> @@ -159,6 +159,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
>      struct in_addr preq_addr;
>      int dhcp_msg_type, val;
>      uint8_t *q;
> +    uint8_t *end;
>      uint8_t client_ethaddr[ETH_ALEN];
>  
>      /* extract exact DHCP msg type */
> @@ -240,6 +241,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
>      rbp->bp_siaddr = saddr.sin_addr; /* Server IP address */
>  
>      q = rbp->bp_vend;
> +    end = (uint8_t *)&rbp[1];
>      memcpy(q, rfc1533_cookie, 4);
>      q += 4;
>  
> @@ -292,24 +294,33 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
>  
>          if (*slirp->client_hostname) {
>              val = strlen(slirp->client_hostname);
> -            *q++ = RFC1533_HOSTNAME;
> -            *q++ = val;
> -            memcpy(q, slirp->client_hostname, val);
> -            q += val;
> +            if (q + val + 2 >= end) {
> +                g_warning("DHCP packet size exceeded, "
> +                    "omitting host name option.");
> +            } else {
> +                *q++ = RFC1533_HOSTNAME;
> +                *q++ = val;
> +                memcpy(q, slirp->client_hostname, val);
> +                q += val;
> +            }
>          }
>  
>          if (slirp->vdomainname) {
>              val = strlen(slirp->vdomainname);
> -            *q++ = RFC1533_DOMAINNAME;
> -            *q++ = val;
> -            memcpy(q, slirp->vdomainname, val);
> -            q += val;
> +            if (q + val + 2 >= end) {
> +                g_warning("DHCP packet size exceeded, "
> +                    "omitting domain name option.");
> +            } else {
> +                *q++ = RFC1533_DOMAINNAME;
> +                *q++ = val;
> +                memcpy(q, slirp->vdomainname, val);
> +                q += val;
> +            }
>          }
>  
>          if (slirp->vdnssearch) {
> -            size_t spaceleft = sizeof(rbp->bp_vend) - (q - rbp->bp_vend);
>              val = slirp->vdnssearch_len;
> -            if (val + 1 > spaceleft) {
> +            if (q + val >= end) {
>                  g_warning("DHCP packet size exceeded, "
>                      "omitting domain-search option.");
>              } else {
> @@ -331,6 +342,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
>          memcpy(q, nak_msg, sizeof(nak_msg) - 1);
>          q += sizeof(nak_msg) - 1;
>      }
> +    assert(q < end);
>      *q = RFC1533_END;
>  
>      daddr.sin_addr.s_addr = 0xffffffffu;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

Since this can also fix potential QEMU crashes, I think this patch
should also go into the stable branches (put on CC: now).
