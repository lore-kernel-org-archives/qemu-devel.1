Received: from eggs.gnu.org ([2001:4830:134:3::10]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQMT-0002kJ-8i
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQMP-0007in-AQ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:05 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQMP-0007ic-4y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:01 -0500
Received: by mail-qt0-x243.google.com with SMTP id r39so5852703qtr.13
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 19:27:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <27058e20-39a1-4410-e98f-efa2d8edb904@amsat.org>
Date: Wed, 6 Dec 2017 00:26:57 -0300
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 1/5] net: move CRC32 calculation from
 compute_mcast_idx() into its own net_crc32() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

On 12/05/2017 05:17 AM, Mark Cave-Ayland wrote:
> Separate out the standard ethernet CRC32 calculation into a new net_crc32()
> function, renaming the constant POLYNOMIAL to POLYNOMIAL_BE to make it clear
> that this is a big-endian CRC32 calculation.
> 
> Then remove the existing implementation from compute_mcast_idx() and call the
> new function in its place.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/net/net.h |  3 ++-
>  net/net.c         | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 1c55a93588..586098cb94 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -227,7 +227,8 @@ NetClientState *net_hub_port_find(int hub_id);
>  
>  void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
>  
> -#define POLYNOMIAL 0x04c11db6
> +#define POLYNOMIAL_BE 0x04c11db6
> +uint32_t net_crc32(const uint8_t *p, int len);
>  unsigned compute_mcast_idx(const uint8_t *ep);
>  
>  #define vmstate_offset_macaddr(_state, _field)                       \
> diff --git a/net/net.c b/net/net.c
> index 39ef546708..02a567c18f 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1581,25 +1581,31 @@ int net_client_parse(QemuOptsList *opts_list, const char *optarg)
>  
>  /* From FreeBSD */
>  /* XXX: optimize */
> -unsigned compute_mcast_idx(const uint8_t *ep)
> +uint32_t net_crc32(const uint8_t *p, int len)
>  {
>      uint32_t crc;
>      int carry, i, j;
>      uint8_t b;
>  
>      crc = 0xffffffff;
> -    for (i = 0; i < 6; i++) {
> -        b = *ep++;
> +    for (i = 0; i < len; i++) {
> +        b = *p++;
>          for (j = 0; j < 8; j++) {
>              carry = ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
>              crc <<= 1;
>              b >>= 1;
>              if (carry) {
> -                crc = ((crc ^ POLYNOMIAL) | carry);
> +                crc = ((crc ^ POLYNOMIAL_BE) | carry);
>              }
>          }
>      }
> -    return crc >> 26;
> +
> +    return crc;
> +}
> +
> +unsigned compute_mcast_idx(const uint8_t *ep)
> +{
> +    return net_crc32(ep, 6) >> 26;
>  }
>  
>  QemuOptsList qemu_netdev_opts = {
> 
