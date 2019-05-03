Received: from eggs.gnu.org ([209.51.188.92]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1hMUFX-0006u5-CS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1hMUFV-0001fk-H8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jirislaby@gmail.com>) id 1hMUFT-0001cv-Jf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so6844164wrr.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:12:55 -0700 (PDT)
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-3-liq3ea@163.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <77127529-fc4b-b8af-64c5-a40d2f322c35@suse.cz>
Date: Fri, 3 May 2019 11:12:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190422141156.15746-3-liq3ea@163.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] edu: mmio: allow 64-bit access in
 read dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, philmd@redhat.com

On 22. 04. 19, 16:11, Li Qiang wrote:
> The edu spec says when address >= 0x80, the MMIO area can
> be accessed by 64-bit.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v2:
> Fix an error per Phillippe's advice
> 
>  hw/misc/edu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 65fc32b928..33de05141f 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      EduState *edu = opaque;
>      uint64_t val = ~0ULL;
>  
> -    if (size != 4) {
> +    if (addr < 0x80 && size != 4) {
> +        return val;
> +    }
> +
> +    if (addr >= 0x80 && size != 4 && size != 8) {
>          return val;
>      }

Good catch, thanks.

-- 
js
suse labs
