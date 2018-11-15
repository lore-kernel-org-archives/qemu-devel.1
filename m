Received: from eggs.gnu.org ([2001:4830:134:3::10]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNIxr-0001TG-5B
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNIxb-0006gE-Gf
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:49:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNIxZ-0006f6-8C
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:49:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so21494275wrq.11
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:49:32 -0800 (PST)
References: <20181115143535.5885-1-peter.maydell@linaro.org>
	<20181115143535.5885-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <164351da-7ffa-3e44-8883-f4e272d181dd@redhat.com>
Date: Thu, 15 Nov 2018 15:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143535.5885-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] hw/block/onenand: Fix
 off-by-one error allowing out-of-bounds read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

On 15/11/18 15:35, Peter Maydell wrote:
> An off-by-one error in a switch case in onenand_read() allowed
> a misbehaving guest to read off the end of a block of memory.
> 
> NB: the onenand device is used only by the "n800" and "n810"
> machines, which are usable only with TCG, not KVM, so this is
> not a security issue.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I tweaked RTH's suggested fix to use an 0xbffe offset so
> we don't overrun on an access to 0xbfff either.

Correct.

> 
>   hw/block/onenand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 0cb8d7fa135..49ef68c9b14 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -608,7 +608,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
>       int offset = addr >> s->shift;
>   
>       switch (offset) {
> -    case 0x0000 ... 0xc000:
> +    case 0x0000 ... 0xbffe:
>           return lduw_le_p(s->boot[0] + addr);
>   
>       case 0xf000:	/* Manufacturer ID */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
