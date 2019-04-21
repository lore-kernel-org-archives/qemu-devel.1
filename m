Received: from eggs.gnu.org ([209.51.188.92]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9xS-0007vB-2w
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9xR-00026B-4w
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9xQ-00025T-V2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so11903348wrj.5
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:44:24 -0700 (PDT)
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
Date: Sun, 21 Apr 2019 12:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190420161446.2274-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] edu: mmio: allow mmio read dispatch
 accept 8 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

Hi Li,

On 4/20/19 6:14 PM, Li Qiang wrote:
> The edu spec said when address >= 0x80, the MMIO area can

"says"

> be accessed by 8 bytes.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/misc/edu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 65fc32b928..4018dddcb8 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)

Completing the diff ...:

       if (size != 4) {

>          return val;
>      }
>  
> +    if (addr >= 0x80 && size != 4 && size != 8) {

... to show this code is unreachable for size == 8.

> +        return val;
> +    }
> +
>      switch (addr) {
>      case 0x00:
>          val = 0x010000edu;
> 

I think the change you wanted is:

-- >8 --
@@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
addr, unsigned size)
     EduState *edu = opaque;
     uint64_t val = ~0ULL;

-    if (size != 4) {
+    if (addr < 0x80 && size != 4) {
+        return val;
+    }
+
+    if (addr >= 0x80 && size != 4 && size != 8) {
         return val;
     }

---

Another cleaner way to solve this is use 2 MemoryRegionOps, one for the
first 0x80 addresses and another for the rest.

Regards,

Phil.
