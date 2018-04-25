Received: from eggs.gnu.org ([2001:4830:134:3::10]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7tC-0006eA-1V
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7t8-0001pC-RA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:02:26 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB7t8-0001ov-LA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:02:22 -0400
Received: by mail-pf0-x242.google.com with SMTP id j11so13591217pff.10
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:02:22 -0700 (PDT)
References: <20180424222103.19946-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <37e4fa16-a061-fd8e-d484-9153ff500cbd@linaro.org>
Date: Tue, 24 Apr 2018 14:02:17 -1000
MIME-Version: 1.0
In-Reply-To: <20180424222103.19946-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/24/2018 12:21 PM, Philippe Mathieu-Daudé wrote:
> The libfdt does not guarantee than fdt_getprop() returns a pointer
> aligned to the property size.
> 
> Assuming the base of the fdt is aligned, a 32-bit property returns
> a 32-bit aligned pointer. This is however not guaranteed for 64-bit
> properties, where 64-bit loads might trigger unaligned access.
> 
> Fix the 64-bit access using the ldst (host) API, which uses a local
> copy on the stack, thus guaranteeing a safe aligned access.
> 
> This fixes the following ASan warning:
> 
>   $ qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned address 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>   0x7f95cd7e4264: note: pointer points here
>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 00 00  00 00 00 03 00 00 00 14
>                 ^
> 
> Reported-by: AddressSanitizer
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v4: do not change the 32-bit access, use ldq_he_p() for the 64-bit access
> v3: do not use memcpy(), incorrectly change ldl_he_p()
> v2: do not change the 32-bit access, use memcpy(), add comments (David Gibson)
> v1: use memcpy()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
