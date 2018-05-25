Received: from eggs.gnu.org ([2001:4830:134:3::10]:40707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fMDMj-0001R7-Si
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fMDMe-0002JH-Uc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:06:45 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fMDMe-0002Ir-LP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:06:40 -0400
Received: by mail-wm0-x244.google.com with SMTP id n10-v6so14926665wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:06:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-2-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b685c79-fefb-e73f-f0ed-ee9c0c97ca11@redhat.com>
Date: Fri, 25 May 2018 16:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180423162523.6392-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bswap.h: Fix ldl_he_p() signedness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 23/04/2018 18:25, Philippe Mathieu-Daudé wrote:
> As per the "Load and Store APIs" documentation (docs/devel/loads-stores.rst),
> "No signed load operations are provided."
> Update lduw_he_p() to return as unsigned.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

This is ldl_he_p, not lduw_he_p.

However, this patch should not be necessary; using uint16_t is needed
for shorts because they implicitly extend to int, so a "short -0x1234"
becomes 0xffff1234 when assigned to uint32_t.  Instead, an int can be
assigned to a uint32_t (which is the type of fdt32_to_cpu's argument)
with no change in value.

Paolo

> ---
>  include/qemu/bswap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 3f28f661b1..613978f838 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -330,9 +330,9 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>      memcpy(ptr, &v, sizeof(v));
>  }
>  
> -static inline int ldl_he_p(const void *ptr)
> +static inline uint32_t ldl_he_p(const void *ptr)
>  {
> -    int32_t r;
> +    uint32_t r;
>      memcpy(&r, ptr, sizeof(r));
>      return r;
>  }
> 
