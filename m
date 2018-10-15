Received: from eggs.gnu.org ([2001:4830:134:3::10]:42152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCAzv-0003DI-Mp
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCAzs-0001OB-Hi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:05:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCAzs-0001M8-7Q
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:05:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so19337260edq.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:05:55 -0700 (PDT)
References: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73dcea68-2342-63b7-9691-a151f00a42e8@redhat.com>
Date: Tue, 16 Oct 2018 00:05:26 +0200
MIME-Version: 1.0
In-Reply-To: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Julien Grall <julien.grall@arm.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Stewart,

On 15/10/2018 23:26, Stewart Hildebrand wrote:
> "The Image must be placed text_offset bytes from a 2MB aligned base
> address anywhere in usable system RAM and called there."
> 
> For the virt board, we write our startup bootloader at the very
> bottom of RAM, so that bit can't be used for the image. To avoid
> overlap in case the image requests to be loaded at an offset
> smaller than our bootloader, we increment the load offset to the
> next 2MB.
> 
> This fixes a boot failure for Xen AArch64.
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@dornerworks.com>
> ---
>  hw/arm/boot.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 20c71d7d96..559ddbcd53 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -919,6 +919,16 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
>          memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
>          if (hdrvals[1] != 0) {
>              kernel_load_offset = le64_to_cpu(hdrvals[0]);
> +
> +            /* For the virt board, we write our startup "bootloader" at the very
> +             * bottom of RAM, so that bit can't be used for the image. To avoid
> +             * overlap in case the image requests to be loaded at an offset
> +             * smaller than our bootloader, we increment the load offset to the
> +             * next 2MB.
> +             */
> +            if (kernel_load_offset < FIXUP_MAX) {

I don't understand how this is related to FIXUP_MAX...

> +                kernel_load_offset += 2 << 20;

You can use += 2 * MiB; which is easier to review.

> +            }
>          }
>      }
>  
> 
