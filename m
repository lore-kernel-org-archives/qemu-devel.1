Received: from eggs.gnu.org ([2001:4830:134:3::10]:38034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gak-0006Vj-Jt
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gaj-0005Ow-Ik
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:05:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6gaj-0005OZ-DH
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:05:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so6019397oih.8
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:05:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-5-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-5-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 19:04:40 +0100
Message-ID: <CAFEAcA-WXivfqj=u=qhcWrFPqpFu-DpCWod-6bcjBmJj5KV-uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/14] timer: ds1338 clarify HOUR handling
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
> Simplify and comment the translation between
> registers and struct tm.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 72a4692d60..9bcda26e51 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -88,23 +88,23 @@ static void capture_current_time(DS1338State *s)
>       * which will be actually read by the data transfer operation.
>       */
>      struct tm now;
> +    bool mode12 = ARRAY_FIELD_EX32(s->nvram, HOUR, SET12);
>      qemu_get_timedate(&now, s->offset);
> +
>      s->nvram[R_SEC] = to_bcd(now.tm_sec);
>      s->nvram[R_MIN] = to_bcd(now.tm_min);
> -    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
> -        int tmp = now.tm_hour;
> -        if (tmp % 12 == 0) {
> -            tmp += 12;
> -        }
> -        s->nvram[R_HOUR] = 0;
> +    s->nvram[R_HOUR] = 0;
> +    if (mode12) {
> +        /* map 0-23 to 1-12 am/pm */
>          ARRAY_FIELD_DP32(s->nvram, HOUR, SET12, 1);
> -        if (tmp <= 12) {
> -            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 0);
> -            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp));
> -        } else {
> -            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 1);
> -            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp - 12));

Oh, you're rewriting all this code from the earlier patch anyway.
In that case you should definitely just have the earlier patch
match the logic that the existing code did, so that it's easier
to review as being a no-change patch.

> +        ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, now.tm_hour >= 12u);
> +        now.tm_hour %= 12u; /* wrap 0-23 to 0-11 */
> +        if (now.tm_hour == 0u) {
> +            /* midnight/noon stored as 12 */
> +            now.tm_hour = 12u;
>          }
> +        ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(now.tm_hour));
> +
>      } else {
>          ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR24, to_bcd(now.tm_hour));
>      }
> @@ -182,14 +182,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>              break;
>          case R_HOUR:
>              if (FIELD_EX32(data, HOUR, SET12)) {
> -                int tmp = from_bcd(FIELD_EX32(data, HOUR, HOUR12));
> +                /* 12 hour (1-12) */
> +                /* read and wrap 1-12 -> 0-11 */
> +                now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR12)) % 12u;
>                  if (FIELD_EX32(data, HOUR, AMPM)) {
> -                    tmp += 12;
> +                    now.tm_hour += 12;
>                  }
> -                if (tmp % 12 == 0) {
> -                    tmp -= 12;
> -                }
> -                now.tm_hour = tmp;
> +
>              } else {
>                  now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR24));
>              }
> --
> 2.11.0
>


thanks
-- PMM
