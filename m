Received: from eggs.gnu.org ([2001:4830:134:3::10]:35175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gXN-0004Pc-Vh
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gXN-0003KI-5Y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:01:34 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6gXM-0003Jv-U1
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:01:33 -0400
Received: by mail-ot0-x241.google.com with SMTP id m22-v6so6993963otf.8
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:01:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-3-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-3-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 19:01:10 +0100
Message-ID: <CAFEAcA-MV9YaUybz=N7JdUDbFbLGO=oUsCJVABVJZYaSSUDZxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/14] timer: ds1338 use registerfields.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2018 at 19:24, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Use names for registers and bits except
> for R_CTRL which will be dealt with later,
> and isn't modeled anyway.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

> ---
>  hw/timer/ds1338.c | 84 ++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> @@ -61,25 +89,29 @@ static void capture_current_time(DS1338State *s)
>       */
>      struct tm now;
>      qemu_get_timedate(&now, s->offset);
> -    s->nvram[0] = to_bcd(now.tm_sec);
> -    s->nvram[1] = to_bcd(now.tm_min);
> -    if (s->nvram[2] & HOURS_12) {
> +    s->nvram[R_SEC] = to_bcd(now.tm_sec);
> +    s->nvram[R_MIN] = to_bcd(now.tm_min);
> +    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
>          int tmp = now.tm_hour;
>          if (tmp % 12 == 0) {
>              tmp += 12;
>          }
> +        s->nvram[R_HOUR] = 0;
> +        ARRAY_FIELD_DP32(s->nvram, HOUR, SET12, 1);
>          if (tmp <= 12) {
> -            s->nvram[2] = HOURS_12 | to_bcd(tmp);
> +            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 0);

This is zeroing a bit that's already zero.

> +            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp));
>          } else {
> -            s->nvram[2] = HOURS_12 | HOURS_PM | to_bcd(tmp - 12);
> +            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 1);
> +            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp - 12));
>          }
>      } else {
> -        s->nvram[2] = to_bcd(now.tm_hour);
> +        ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR24, to_bcd(now.tm_hour));

This else clause used to definitely set all the bits in nvram[2],
and now it doesn't (the s->nvram[R_HOUR] = 0 is only in the if {}).

For cases like this where we're setting the whole thing, I think
    s->nvram[R_HOUR] = R_HOUR_SET12_MASK | to_bcd(tmp);

    s->nvram[R_HOUR] = R_HOUR_SET12_MASK | R_HOUR_AMPM_MASK | to_bcd(tmp - 12);

    s->nvram[R_HOUR] = R_HOUR_HOUR24_MASK | to_bcm(now.tm_hour);

is clearer than individually setting each field, but you can
do the "clear and then set individual fields" approach if you like.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
