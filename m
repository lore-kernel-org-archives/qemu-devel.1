Received: from eggs.gnu.org ([209.51.188.92]:41152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbuV-00037f-O2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbpS-0007uE-AL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:30:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIbpS-0007tZ-3F
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:30:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so15086532wmc.3
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:30:02 -0700 (PDT)
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0033c7fe-f9d5-223d-b5c2-6835041b7281@redhat.com>
Date: Mon, 22 Apr 2019 18:29:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190422141156.15746-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 4/22/19 4:11 PM, Li Qiang wrote:
> The edu spec says when address >= 0x80, the MMIO area can
> be accessed by 64-bit.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

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
>  
> 
