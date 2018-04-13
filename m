Received: from eggs.gnu.org ([2001:4830:134:3::10]:48790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y5m-0003O1-64
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y5l-00061X-75
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:46:14 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6y5l-00060l-21
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:46:13 -0400
Received: by mail-ot0-x242.google.com with SMTP id i5-v6so248447oth.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 05:46:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-8-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-8-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 13:45:51 +0100
Message-ID: <CAFEAcA_sTV-vTNYmwOkDDf7exgfseuku-0MCY9+VasN9ErpoiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/14] timer: ds1338 fix wday_offset
 handling
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
> Correctly handle different real weekday in
> guest and host timezones.
> Allow guest to use any day as start of week
> (day 1).  eg. Monday instead of Sunday.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 071c031563..a969b5c8ba 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -108,7 +108,10 @@ static void capture_current_time(DS1338State *s)
>      } else {
>          ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR24, to_bcd(now.tm_hour));
>      }
> -    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7 + 1;
> +    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7;
> +    if (s->nvram[R_WDAY] == 0) {
> +        s->nvram[R_WDAY] = 7;
> +    }
>      s->nvram[R_DATE] = to_bcd(now.tm_mday);
>      s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
>      s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
> @@ -182,17 +185,22 @@ static void ds1338_update(DS1338State *s)
>      } else {
>          now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR24));
>      }
> -    {
> -        /* The day field is supposed to contain a value in
> -               the range 1-7. Otherwise behavior is undefined.
> -             */
> -        int user_wday = (s->nvram[R_WDAY] & 7) - 1;
> -        s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
> -    }
> +    now.tm_wday = from_bcd(s->nvram[R_WDAY]) - 1u;
>      now.tm_mday = from_bcd(s->nvram[R_DATE] & 0x3f);

You don't need to set now.tm_wday -- qemu_timedate_diff()
will not use that field in the structure you hand it.

>      now.tm_mon = from_bcd(s->nvram[R_MONTH] & 0x1f) - 1;
>      now.tm_year = from_bcd(s->nvram[R_YEAR]) + 100;
>      s->offset = qemu_timedate_diff(&now);
> +
> +    {
> +        /* Round trip to get real wday_offset based on time delta and
> +         * ref. timezone.
> +         * Race if midnight (in ref. timezone) happens here.
> +         */
> +        int user_wday = now.tm_wday;
> +        qemu_get_timedate(&now, s->offset);
> +
> +        s->wday_offset = (user_wday - now.tm_wday) % 7 + 1;
> +    }
>  }

Ah, this part is fixing the bug I pointed out in the earlier patch.
You should just fold that bug fix into it.

thanks
-- PMM
