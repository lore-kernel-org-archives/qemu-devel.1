Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdAC-0006Z3-9R
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdAB-0004VX-9y
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:13:56 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAdAB-0004VH-4B
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:13:55 -0400
Received: by mail-ot0-x243.google.com with SMTP id w4-v6so17591138ote.12
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423141436.12172-1-f4bug@amsat.org>
References: <20180423141436.12172-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 16:13:33 +0100
Message-ID: <CAFEAcA_dbsys+f5OUtxtQM0fBkS16SDEJVmAnRu8pFBTgxyyTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <paul.burton@mips.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 23 April 2018 at 15:14, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> This fixes the following ASan warning:
>
>   $ mips64el-softmmu/qemu-system-mips64el -M boston -kernel vmlinux.gz.it=
b -nographic
>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned address =
0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>   0x7f95cd7e4264: note: pointer points here
>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 0=
0 00  00 00 00 03 00 00 00 14
>                 ^
>
> Reported-by: AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: do not change the 32-bit access, add comments (David Gibson)
>
>  hw/core/loader-fit.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 0c4a7207f4..c1c7c9c119 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -94,6 +94,7 @@ static int fit_image_addr(const void *itb, int img, con=
st char *name,
>  {
>      const void *prop;
>      int len;
> +    fdt64_t fdt64;
>
>      prop =3D fdt_getprop(itb, img, name, &len);
>      if (!prop) {
> @@ -102,10 +103,18 @@ static int fit_image_addr(const void *itb, int img,=
 const char *name,
>
>      switch (len) {
>      case 4:
> +        /* Assuming the base of the fdt is aligned, then fdt_getprop()
> +         * returns 32-bit aligned properties, so this load is guaranteed
> +         * to be 32-bit aligned.
> +         */
>          *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>          return 0;
>      case 8:
> -        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
> +        /* Since the property is not guaranteed to be 64-bit aligned,
> +         * use the stack to avoid an unaligned load.
> +         */
> +        memcpy(&fdt64, prop, sizeof(fdt64));
> +        *addr =3D fdt64_to_cpu(fdt64);
>          return 0;
>      default:

No, don't use memcpy. This is what ldq_p() is for.

thanks
-- PMM
