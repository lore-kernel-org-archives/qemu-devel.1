Received: from eggs.gnu.org ([2001:4830:134:3::10]:33621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAfKk-0000Ok-MN
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAfKg-0000bX-0z
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:32:58 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAfKf-0000aw-QF
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:32:53 -0400
Received: by mail-pg0-x241.google.com with SMTP id i6so8865031pgv.3
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 10:32:53 -0700 (PDT)
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af1add67-8a9a-24d2-79f0-9b41d20974ea@linaro.org>
Date: Mon, 23 Apr 2018 07:32:47 -1000
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
Cc: qemu-devel@nongnu.org

On 04/23/2018 06:25 AM, Philippe Mathieu-Daudé wrote:
> As per the "Load and Store APIs" documentation (docs/devel/loads-stores.rst),
> "No signed load operations are provided."
> Update lduw_he_p() to return as unsigned.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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

Nack, not without auditing all users.

The documentation is clear about ldl being an oddball,
primarily because we didn't audit all users last time.

In the short term, just cast your user, which is what
we wind up doing elsewhere in the codebase.

r~
