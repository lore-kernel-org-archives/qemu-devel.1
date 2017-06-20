Received: from eggs.gnu.org ([2001:4830:134:3::10]:54185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNIyC-0008RF-TC
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNIyB-0004VX-Oi
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:13:24 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNIyB-0004V4-Hx
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:13:23 -0400
Received: by mail-wr0-x229.google.com with SMTP id r103so91752643wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 06:13:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-4-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 14:13:02 +0100
Message-ID: <CAFEAcA9ardEEJr-QYd7ghkqKvENiro6k-rJno9rnruZx22=4TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 03/13] all: fix up code consitency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This is pretty much a mechanical change where I ran:
>
>   indent -kr
>
> Across all the files and then fixed up all but a few violations of:
>
>   ../../qemu.git/scripts/checkpatch.pl -f *.c *.h > checkpatch.out
>
> Along with heavy use of M-x untabify to make everything consistent.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
> index 5309f3a..8e6736b 100644
> --- a/risu_reginfo_arm.c
> +++ b/risu_reginfo_arm.c
> @@ -26,173 +26,173 @@ extern int insnsize(ucontext_t *uc);
>
>  static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
>  {
> -   // Read VFP registers. These live in uc->uc_regspace, which is
> -   // a sequence of
> -   //   u32 magic
> -   //   u32 size
> -   //   data....
> -   // blocks. We have to skip through to find the one for VFP.
> -   unsigned long *rs =3D uc->uc_regspace;
> -
> -   for (;;)
> -   {
> -      switch (*rs++)
> -      {
> -         case 0:
> -         {
> -            /* We didn't find any VFP at all (probably a no-VFP
> -             * kernel). Zero out all the state to avoid mismatches.
> -             */
> -            int j;
> -            for (j =3D 0; j < 32; j++)
> -               ri->fpregs[j] =3D 0;
> -            ri->fpscr =3D 0;
> -            return;
> -         }
> -         case 0x56465001: /* VFP_MAGIC */
> -         {
> -            /* This is the one we care about. The format (after the size=
 word)
> -             * is 32 * 64 bit registers, then the 32 bit fpscr, then som=
e stuff
> -             * we don't care about.
> -             */
> -            int i;
> -            /* Skip if it's smaller than we expected (should never happe=
n!) */
> -            if (*rs < ((32*2)+1))
> +    /* Read VFP registers. These live in uc->uc_regspace, which is
> +     * a sequence of
> +     *   u32 magic
> +     *   u32 size
> +     *   data....
> +     * blocks. We have to skip through to find the one for VFP.
> +     */
> +    unsigned long *rs =3D uc->uc_regspace;
> +
> +    for (;;) {
> +        switch (*rs++) {
> +        case 0:
>              {
> -               rs +=3D (*rs / 4);
> -               break;
> +                /* We didn't find any VFP at all (probably a no-VFP
> +                 * kernel). Zero out all the state to avoid mismatches.
> +                 */
> +                int j;
> +                for (j =3D 0; j < 32; j++) {
> +                    ri->fpregs[j] =3D 0;
> +                }
> +                ri->fpscr =3D 0;
> +                return;
>              }
> -            rs++;
> -            for (i =3D 0; i < 32; i++)
> +        case 0x56465001:        /* VFP_MAGIC */
>              {
> -               ri->fpregs[i] =3D *rs++;
> -               ri->fpregs[i] |=3D (uint64_t)(*rs++) << 32;
> +                /* This is the one we care about. The format (after


Something seems to have gone wrong in this file -- note the extra indent
of {} blocks after "case 0:". The others are all fine though so I'll
just fix this locally.

thanks
-- PMM
