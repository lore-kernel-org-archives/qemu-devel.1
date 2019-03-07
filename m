Received: from eggs.gnu.org ([209.51.188.92]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1hbP-0001U9-3x
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1hbO-0001Vj-5P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:13:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1hbL-0001V8-Qk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:13:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so7694318wmj.0
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 17:13:35 -0800 (PST)
References: <20190306200925.17605-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c756da8a-2545-2349-dfa1-a2c44f21195d@redhat.com>
Date: Thu, 7 Mar 2019 02:13:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190306200925.17605-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: add new netlink types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 3/6/19 9:09 PM, Laurent Vivier wrote:
> Add QEMU_IFLA_BR_VLAN_STATS_PER_PORT (from linux v4.20),
>     QEMU_IFLA_BR_MULTI_BOOLOPT (from linux v5.0).
> 
> The first new entry fixes the following error:
> 
>   Unknown QEMU_IFLA_BR type 45
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  linux-user/fd-trans.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 30425c9df6bc..612819c1b1ec 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -75,6 +75,8 @@ enum {
>      QEMU_IFLA_BR_MCAST_STATS_ENABLED,
>      QEMU_IFLA_BR_MCAST_IGMP_VERSION,
>      QEMU_IFLA_BR_MCAST_MLD_VERSION,
> +    QEMU_IFLA_BR_VLAN_STATS_PER_PORT,
> +    QEMU_IFLA_BR_MULTI_BOOLOPT,
>      QEMU___IFLA_BR_MAX,
>  };
>  
> @@ -438,6 +440,7 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
>      case QEMU_IFLA_BR_MCAST_STATS_ENABLED:
>      case QEMU_IFLA_BR_MCAST_IGMP_VERSION:
>      case QEMU_IFLA_BR_MCAST_MLD_VERSION:
> +    case QEMU_IFLA_BR_VLAN_STATS_PER_PORT:
>          break;
>      /* uint16_t */
>      case QEMU_IFLA_BR_PRIORITY:
> @@ -543,6 +546,12 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
>      case QEMU_IFLA_BRPORT_ROOT_ID:
>      case QEMU_IFLA_BRPORT_BRIDGE_ID:
>          break;
> +    /* br_boolopt_multi { uint32_t, uint32_t } */
> +    case QEMU_IFLA_BR_MULTI_BOOLOPT:
> +        u32 = NLA_DATA(nlattr);
> +        u32[0] = tswap32(u32[0]); /* optval */
> +        u32[1] = tswap32(u32[1]); /* optmask */
> +        break;
>      default:
>          gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
>          break;
> 
