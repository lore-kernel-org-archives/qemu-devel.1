Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMiFw-0004YV-Mk
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMiFv-0005qg-As
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:33:32 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eMiFv-0005pw-46
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:33:31 -0500
Date: Wed, 6 Dec 2017 23:33:27 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20171206223327.GB16343@aurel32.net>
References: <20171206093050.25308-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171206093050.25308-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH] target/sh4/translate.c: fix TCG leak
 during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 1735384@bugs.launchpad.net

On 2017-12-06 09:30, Alex Benn=E9e wrote:
> This fixes bug #1735384 while running java under qemu-sh4. When debug
> was enabled it showed a problem with TCG temps. Once fixed I was able
> to run java -version normally.
>=20
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  target/sh4/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 703020fe87..b4b5c822d0 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -2189,7 +2189,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
>      }
> =20
>      /* If op_src is not a valid register, then op_arg was a constant.  */
> -    if (op_src < 0) {
> +    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
>          tcg_temp_free_i32(op_arg);
>      }

I guess this happens when trying to match the exchange pattern, so this
looks correct to me.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
