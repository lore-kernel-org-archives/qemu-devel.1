Received: from eggs.gnu.org ([2001:4830:134:3::10]:50919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTPj-00051U-V8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTPi-00077f-Th
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:44:40 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebTPi-000775-Ob
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:44:38 -0500
Received: by mail-ot0-x241.google.com with SMTP id d10so13966878oti.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:44:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116151152.4040-2-marcandre.lureau@redhat.com>
References: <20180116151152.4040-1-marcandre.lureau@redhat.com>
	<20180116151152.4040-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 15:44:17 +0000
Message-ID: <CAFEAcA-3xF6z-D7XrKzAhNA_p0Y0U-UuDL7R1dK9+HaF4DPH1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] exynos4210: workaround UBSAN
 compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "open list:Exynos" <qemu-arm@nongnu.org>

On 16 January 2018 at 15:11, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> gcc 5.4.0-6ubuntu1~16.04.5 build with UBSAN enabled error:
>
>   CC      hw/display/exynos4210_fimd.o
> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c: In
> function =E2=80=98fimd_get_buffer_id=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c:1105:5=
:
> error: case label does not reduce to an integer constant
>      case FIMD_WINCON_BUF2_STAT:
>
> Because FIMD_WINCON_BUF2_STAT case contains an integer
> overflow, use U suffix to get the unsigned type.

We should note that this is a gcc bug here (we compile with
-fwrapv so integer overflows like this are well-defined)
which we are working around.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/exynos4210_fimd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index fd0b2bec65..86e37e93e9 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -98,7 +98,7 @@
>  #define FIMD_WINCON_BUFSTATUS       ((1 << 21) | (1 << 31))
>  #define FIMD_WINCON_BUF0_STAT       ((0 << 21) | (0 << 31))
>  #define FIMD_WINCON_BUF1_STAT       ((1 << 21) | (0 << 31))
> -#define FIMD_WINCON_BUF2_STAT       ((0 << 21) | (1 << 31))
> +#define FIMD_WINCON_BUF2_STAT       ((0 << 21) | (1U << 31))
>  #define FIMD_WINCON_BUFSELECT       ((1 << 20) | (1 << 30))
>  #define FIMD_WINCON_BUF0_SEL        ((0 << 20) | (0 << 30))
>  #define FIMD_WINCON_BUF1_SEL        ((1 << 20) | (0 << 30))
> --
> 2.16.0.rc1.1.gef27df75a1
>

thanks
-- PMM
