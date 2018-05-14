Received: from eggs.gnu.org ([2001:4830:134:3::10]:35886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAaZ-00011T-Nb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAaY-0005gM-Nk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:20:19 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAaY-0005fl-Hd
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:20:18 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so10149493oie.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:20:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-3-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:19:57 +0100
Message-ID: <CAFEAcA-pD9cqs1M=_eYohkfBkWZ0CQENmJ24VCZgKihkMVUDYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/27] fpu/softfloat: Don't set Invalid
 for float-to-int(MAXINT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>
> In float-to-integer conversion, if the floating point input
> converts exactly to the largest or smallest integer that
> fits in to the result type, this is not an overflow.
> In this situation we were producing the correct result value,
> but were incorrectly setting the Invalid flag.
> For example for Arm A64, "FCVTAS w0, d0" on an input of
> 0x41dfffffffc00000 should produce 0x7fffffff and set no flags.
>
> Fix the boundary case to take the right half of the if()
> statements.
>
> This fixes a regression from 2.11 introduced by the softfloat
> refactoring.
>
> Cc: qemu-stable@nongnu.org
> Fixes: ab52f973a50
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This is missing your Signed-off-by: line (and a reviewed-by
would be nice too :-))

> ---
>  fpu/softfloat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index b39c0c6fbb..bc0f52fa54 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1368,14 +1368,14 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
>              r = UINT64_MAX;
>          }
>          if (p.sign) {
> -            if (r < -(uint64_t) min) {
> +            if (r <= -(uint64_t) min) {
>                  return -r;
>              } else {
>                  s->float_exception_flags = orig_flags | float_flag_invalid;
>                  return min;
>              }
>          } else {
> -            if (r < max) {
> +            if (r <= max) {
>                  return r;
>              } else {
>                  s->float_exception_flags = orig_flags | float_flag_invalid;
> --
> 2.17.0

thanks
-- PMM
