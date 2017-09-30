Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uq-0005mP-JK
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Un-0007SL-P1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-6-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a757d6e-6745-9df4-7199-d55ee2510d8f@amsat.org>
Date: Fri, 29 Sep 2017 21:17:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-6-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/17] imx_fec: Use ENET_FTRL to determine
 truncation length
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com
List-ID: <qemu-devel.nongnu.org>

Hi Andrey,

On 09/18/2017 04:50 PM, Andrey Smirnov wrote:
> Frame truncation length, TRUNC_FL, is determined by the contents of
> ENET_FTRL register, so convert the code to use it instead of a
> hardcoded constant.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   hw/net/imx_fec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 767402909d..989c11be5f 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1050,8 +1050,8 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>       size += 4;
>   
>       /* Huge frames are truncted.  */
> -    if (size > ENET_MAX_FRAME_SIZE) {
> -        size = ENET_MAX_FRAME_SIZE;
> +    if (size > s->regs[ENET_FTRL]) {
> +        size = s->regs[ENET_FTRL]; >           flags |= ENET_BD_TR | ENET_BD_LG;
>       }

for this to be ok you need to update imx_enet_write(), such:

      case ENET_FTRL:
-        s->regs[index] = value & 0x00003fff;
+        value &= 0x00003fff;
+        if (value > ENET_MAX_FRAME_SIZE) {
+            warn_report("%s: guest requested bigger "
+                        "frame size than QEMU supports "
+                        "(%u > %u)", value,
+                        ENET_MAX_FRAME_SIZE);
+            value = ENET_MAX_FRAME_SIZE;
+        }
+        s->regs[index] = value;
          break;

Regards,

Phil.
