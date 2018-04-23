Received: from eggs.gnu.org ([2001:4830:134:3::10]:51259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAelZ-00033K-EB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAelY-0002Wf-KJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:56:37 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAelY-0002WD-Fp
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:56:36 -0400
Received: by mail-ot0-x242.google.com with SMTP id q10-v6so13284168oth.9
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:56:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423162523.6392-2-f4bug@amsat.org>
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 17:56:15 +0100
Message-ID: <CAFEAcA-p1-5YzcE-0mN4Wy-1oMtr_qfbntws5ynHrrg2FxEZuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bswap.h: Fix ldl_he_p() signedness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 23 April 2018 at 17:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> As per the "Load and Store APIs" documentation (docs/devel/loads-stores.r=
st),
> "No signed load operations are provided."

That phrase is used in the documentation sections for other
kinds of load/store function, but not in the section for ld*_p
and st*_p, which do provide both signed and unsigned flavours.

> Update lduw_he_p() to return as unsigned.

Code is changing a different function to the one named here...

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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

This would make it not match the other ldl*_p functions
(ldl_le_p, ldl_be_p).

The expectation with the ldl functions is that you're
putting it into a variable of the right type and size,
and so we don't need to provide both a signed 32 bit load
and an unsigned 32 bit load.

thanks
-- PMM
