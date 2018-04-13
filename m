Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y2r-0000s2-P1
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y2q-00047P-Lh
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:13 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6y2q-00047K-Fw
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:12 -0400
Received: by mail-oi0-x244.google.com with SMTP id u141-v6so8234116oif.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 05:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-6-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-6-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 13:42:51 +0100
Message-ID: <CAFEAcA_zWoiC1EmkPpgPtBnYjXfSqA=aymwndEnfLt2nFoMvoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/14] timer: ds1338 change write handling
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
> instead of a read-modify-write, do direct translation
> of device registers to struct tm members.
>
> This new ds1338_update() is the reverse of
> the existing capture_current_time().
>
> Simplifies later handling of CENTURY bit in
> similar Dallas RTC chips.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 86 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 9bcda26e51..071c031563 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -159,6 +159,42 @@ static int ds1338_recv(I2CSlave *i2c)
>      return res;
>  }
>
> +/* call after guest writes to current time registers
> + * to re-compute our offset from host time.
> + */
> +static void ds1338_update(DS1338State *s)
> +{
> +
> +    struct tm now;
> +    memset(&now, 0, sizeof(now));

You can zero initialize a struct with just
       struct tm now = {};

so you don't need the memset.

> +
> +    /* TODO: Implement CH (stop) bit?  */
> +    now.tm_sec = from_bcd(s->nvram[R_SEC] & 0x7f);
> +    now.tm_min = from_bcd(s->nvram[R_MIN] & 0x7f);
> +    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
> +        /* 12 hour (1-12) */
> +        /* read and wrap 1-12 -> 0-11 */
> +        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR12)) % 12u;
> +        if (ARRAY_FIELD_EX32(s->nvram, HOUR, AMPM)) {
> +            now.tm_hour += 12;
> +        }
> +
> +    } else {
> +        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR24));
> +    }
> +    {
> +        /* The day field is supposed to contain a value in
> +               the range 1-7. Otherwise behavior is undefined.
> +             */

This patch is a good opportunity to bring the format of this
comment in line with the others in the file, ie
  /* multiple lines
   * all have a star on the left
   */

> +        int user_wday = (s->nvram[R_WDAY] & 7) - 1;

I would just declare user_wday at the top of the function, and
then you can drop the local {} scope.

> +        s->wday_offset = (user_wday - now.tm_wday + 7) % 7;

This line copied from the previous code is still assuming that
'now' contains valid date information, so it won't produce the
right answer. What you need to do is
 (1) move this down to after you set s->offset,
     so that we have the new offset value, and then
 (2) call qemu_get_timedate(&now, s->offset);
     to get an updated 'now' struct with a valid now.tm_wday;
 (3) then you can do
    s->wday_offset = (user_wday - now.tm_wday + 7) % 7;

(I think that's right, anyway -- you should check my working...)

> +    }
> +    now.tm_mday = from_bcd(s->nvram[R_DATE] & 0x3f);
> +    now.tm_mon = from_bcd(s->nvram[R_MONTH] & 0x1f) - 1;
> +    now.tm_year = from_bcd(s->nvram[R_YEAR]) + 100;
> +    s->offset = qemu_timedate_diff(&now);
> +

The rest of this looks good.

thanks
-- PMM
