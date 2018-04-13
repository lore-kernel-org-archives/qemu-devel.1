Received: from eggs.gnu.org ([2001:4830:134:3::10]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yJW-0005nh-JW
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yJV-0008Iz-M4
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:00:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yJV-0008Ig-HM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:00:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id z8-v6so8285748oix.2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:00:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-13-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-13-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:00:04 +0100
Message-ID: <CAFEAcA-4HE8OQRu9Q9H=vJfj+bMogxYUxoBeSihmTCyMbSQD1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 12/14] timer: ds-rtc handle CENTURY bit
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
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds-rtc.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 2df1bce3f8..5a4df1b115 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -70,6 +70,7 @@ typedef struct DSRTCState {
>  typedef struct DSRTCClass {
>      I2CSlaveClass parent_obj;
>
> +    bool has_century;
>      /* actual address space size must be <= NVRAM_SIZE */
>      unsigned addr_size;
>      unsigned ctrl_offset;
> @@ -91,7 +92,7 @@ static const VMStateDescription vmstate_dsrtc = {
>      }
>  };
>
> -static void capture_current_time(DSRTCState *s)
> +static void capture_current_time(DSRTCState *s, DSRTCClass *k)
>  {
>      /* Capture the current time into the secondary registers
>       * which will be actually read by the data transfer operation.
> @@ -123,25 +124,28 @@ static void capture_current_time(DSRTCState *s)
>      }
>      s->nvram[R_DATE] = to_bcd(now.tm_mday);
>      s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
> -    s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
> +    s->nvram[R_YEAR] = to_bcd(now.tm_year % 100u);
> +
> +    ARRAY_FIELD_DP32(s->nvram, MONTH, CENTURY,
> +                     k->has_century && now.tm_year >= 100)
>  }
>
> -static void inc_regptr(DSRTCState *s)
> +static void inc_regptr(DSRTCState *s, DSRTCClass *k)
>  {
> -    DSRTCClass *k = DSRTC_GET_CLASS(s);

I would just leave this function the way it is rather than
changing it to take the class pointer.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
