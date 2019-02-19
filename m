Received: from eggs.gnu.org ([209.51.188.92]:57080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw5BQ-0003xq-3a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw5BP-000335-81
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:11:36 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw5BP-00031O-1r
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:11:35 -0500
Received: by mail-ot1-x342.google.com with SMTP id g1so33923113otj.11
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 05:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
In-Reply-To: <2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 13:11:22 +0000
Message-ID: <CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 19 Feb 2019 at 12:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/18/19 1:56 PM, Markus Armbruster wrote:
> > PFLASH_BUG()'s lone use has a suspicious smell: it prints "Possible
> > BUG", which sounds like a warning, then calls exit(1), followed by
> > unreachable goto reset_flash.  All this commit does is expanding the
> > macro, so the smell becomes more poignant, and the macro can be
> > deleted.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  hw/block/pflash_cfi01.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> > index 9efa7aa9af..f73c30a3ee 100644
> > --- a/hw/block/pflash_cfi01.c
> > +++ b/hw/block/pflash_cfi01.c
> > @@ -49,12 +49,6 @@
> >  #include "sysemu/sysemu.h"
> >  #include "trace.h"
> >
> > -#define PFLASH_BUG(fmt, ...) \
> > -do { \
> > -    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
> > -    exit(1); \
> > -} while(0)
> > -
> >  /* #define PFLASH_DEBUG */
> >  #ifdef PFLASH_DEBUG
> >  #define DPRINTF(fmt, ...)                                   \
> > @@ -624,8 +618,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
> >                  pfl->status |=3D 0x80;
> >              } else {
> >                  DPRINTF("%s: unknown command for \"write block\"\n", _=
_func__);
> > -                PFLASH_BUG("Write block confirm");
> > -                goto reset_flash;
> > +                fprintf(stderr, "PFLASH: Possible BUG - Write block co=
nfirm");
> > +                exit(1);
>
> Don't you want to use hw_error here?
>
>       hw_error("PFLASH: Possible BUG - Write block confirm");

This should just be
   qemu_log_mask(LOG_GUEST_ERROR, ...);
(replacing both the DPRINTF and the PFLASH_BUG()).

It's triggerable by a guest (if it puts the device into write-block
mode and then feeds it a bogus command byte), so it's just a guest
error, not an issue with our model of the pflash.

thanks
-- PMM
