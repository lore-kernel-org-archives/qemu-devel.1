Received: from eggs.gnu.org ([2001:4830:134:3::10]:37173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQN5-0004H6-OG
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQN1-000878-Pn
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:43 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQN1-00086w-LP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:27:39 -0500
Received: by mail-qt0-x242.google.com with SMTP id r39so5855061qtr.13
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 19:27:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0c3542b-756d-aeaa-8ae6-64e8bba8faca@amsat.org>
Date: Wed, 6 Dec 2017 00:27:36 -0300
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 2/5] net: introduce net_crc32_le()
 function
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
> This provides a standard ethernet CRC32 little-endian implementation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/net/net.h |  2 ++
>  net/net.c         | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 586098cb94..4afac1a9dd 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -228,7 +228,9 @@ NetClientState *net_hub_port_find(int hub_id);
>  void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
>  
>  #define POLYNOMIAL_BE 0x04c11db6
> +#define POLYNOMIAL_LE 0xedb88320
>  uint32_t net_crc32(const uint8_t *p, int len);
> +uint32_t net_crc32_le(const uint8_t *p, int len);
>  unsigned compute_mcast_idx(const uint8_t *ep);
>  
>  #define vmstate_offset_macaddr(_state, _field)                       \
> diff --git a/net/net.c b/net/net.c
> index 02a567c18f..38008fe8e7 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1603,6 +1603,28 @@ uint32_t net_crc32(const uint8_t *p, int len)
>      return crc;
>  }
>  
> +uint32_t net_crc32_le(const uint8_t *p, int len)
> +{
> +    uint32_t crc;
> +    int carry, i, j;
> +    uint8_t b;
> +
> +    crc = 0xffffffff;
> +    for (i = 0; i < len; i++) {
> +        b = *p++;
> +        for (j = 0; j < 8; j++) {
> +            carry = (crc & 0x1) ^ (b & 0x01);
> +            crc >>= 1;
> +            b >>= 1;
> +            if (carry) {
> +                crc = crc ^ POLYNOMIAL_LE;
> +            }
> +        }
> +    }
> +
> +    return crc;
> +}
> +
>  unsigned compute_mcast_idx(const uint8_t *ep)
>  {
>      return net_crc32(ep, 6) >> 26;
> 
