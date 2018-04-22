Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fACRE-0007LG-0K
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 06:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fACRC-000574-Fw
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 06:41:43 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fACRC-00056C-B8
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 06:41:42 -0400
Received: by mail-oi0-x241.google.com with SMTP id f63-v6so11743243oic.4
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 03:41:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180421211652.14794-1-f4bug@amsat.org>
References: <20180421211652.14794-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Apr 2018 11:41:20 +0100
Message-ID: <CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paul Burton <paul.burton@mips.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 21 April 2018 at 22:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
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
>  hw/core/loader-fit.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 0c4a7207f4..1a69697f89 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -93,6 +93,8 @@ static int fit_image_addr(const void *itb, int img, con=
st char *name,
>                            hwaddr *addr)
>  {
>      const void *prop;
> +    fdt32_t v32;
> +    fdt64_t v64;
>      int len;
>
>      prop =3D fdt_getprop(itb, img, name, &len);
> @@ -102,10 +104,12 @@ static int fit_image_addr(const void *itb, int img,=
 const char *name,
>
>      switch (len) {
>      case 4:
> -        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
> +        memcpy(&v32, prop, sizeof(v32));
> +        *addr =3D fdt32_to_cpu(v32);

If we need to do an unaligned load, then ldl_p() is the
right way to do it. (We could also just do
 *addr =3D ldl_be_p(prop) but we maybe don't want to
bake in knowledge that FDT is big-endian).

This does make me suspicious that maybe we're not using
the fdt APIs right here though. Since 'prop' is the return
value of fdt_getprop(), shouldn't libfdt be providing
APIs for "give me the fdt32 here" that don't require
the libfdt user to either implement its own unaligned
access helpers or invoke C undefined behaviour? David,
any suggestions?

(Similarly with the fdt64 access and ldq_p.)

thanks
-- PMM
