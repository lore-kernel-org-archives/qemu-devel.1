Received: from eggs.gnu.org ([209.51.188.92]:56311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpxT-0002tE-Ig
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpxS-00005w-Mg
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:08:19 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwpxS-0008W4-Fq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:08:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id r5so17510678wrg.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:08:17 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org>
	<87sgwh5wef.fsf@dusky.pond.sub.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87sgwh5wef.fsf@dusky.pond.sub.org>
Date: Thu, 21 Feb 2019 15:08:15 +0000
Message-ID: <87bm3541sw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-D?= =?utf-8?Q?aud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>


Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Tue, 19 Feb 2019 at 12:41, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>>>
>>>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>>>> > PFLASH_BUG()'s lone use has a suspicious smell: it prints "Possible
>>>> > BUG", which sounds like a warning, then calls exit(1), followed by
>>>> > unreachable goto reset_flash.  All this commit does is expanding the
>>>> > macro, so the smell becomes more poignant, and the macro can be
>>>> > deleted.
>>>> >
>>>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> > ---
>>>> >  hw/block/pflash_cfi01.c | 10 ++--------
>>>> >  1 file changed, 2 insertions(+), 8 deletions(-)
>>>> >
>>>> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>>> > index 9efa7aa9af..f73c30a3ee 100644
>>>> > --- a/hw/block/pflash_cfi01.c
>>>> > +++ b/hw/block/pflash_cfi01.c
>>>> > @@ -49,12 +49,6 @@
>>>> >  #include "sysemu/sysemu.h"
>>>> >  #include "trace.h"
>>>> >
>>>> > -#define PFLASH_BUG(fmt, ...) \
>>>> > -do { \
>>>> > -    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__);=
 \
>>>> > -    exit(1); \
>>>> > -} while(0)
>>>> > -
>>>> >  /* #define PFLASH_DEBUG */
>>>> >  #ifdef PFLASH_DEBUG
>>>> >  #define DPRINTF(fmt, ...)                                   \
>>>> > @@ -624,8 +618,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwadd=
r offset,
>>>> >                  pfl->status |=3D 0x80;
>>>> >              } else {
>>>> >                  DPRINTF("%s: unknown command for \"write block\"\n"=
, __func__);
>>>> > -                PFLASH_BUG("Write block confirm");
>>>> > -                goto reset_flash;
>>>> > +                fprintf(stderr, "PFLASH: Possible BUG - Write block=
 confirm");
>>>> > +                exit(1);
>>>>
>>>> Don't you want to use hw_error here?
>>>>
>>>>       hw_error("PFLASH: Possible BUG - Write block confirm");
>>>
>>> This should just be
>>>    qemu_log_mask(LOG_GUEST_ERROR, ...);
>>> (replacing both the DPRINTF and the PFLASH_BUG()).
>>>
>>> It's triggerable by a guest (if it puts the device into write-block
>>> mode and then feeds it a bogus command byte), so it's just a guest
>>> error, not an issue with our model of the pflash.
>>
>> I can do that.  Thanks!
>
> Double-checking... you want me to keep goto reset_flash, like this:
>
> @@ -623,8 +617,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
>              } else {
> -                DPRINTF("%s: unknown command for \"write block\"\n", __f=
unc__);
> -                PFLASH_BUG("Write block confirm");
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "unknown command for \"write block\"\n");
>                  goto reset_flash;
>              }
>              break;

With this change:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
