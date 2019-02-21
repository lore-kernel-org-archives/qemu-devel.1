Received: from eggs.gnu.org ([209.51.188.92]:36768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwkYT-0002ju-At
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwkYS-0002Ew-Fm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:22:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org>
Date: Thu, 21 Feb 2019 10:22:00 +0100
In-Reply-To: <875ztfuc0j.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 19 Feb 2019 14:46:20 +0100")
Message-ID: <87sgwh5wef.fsf@dusky.pond.sub.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Tue, 19 Feb 2019 at 12:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>>
>>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>>> > PFLASH_BUG()'s lone use has a suspicious smell: it prints "Possible
>>> > BUG", which sounds like a warning, then calls exit(1), followed by
>>> > unreachable goto reset_flash.  All this commit does is expanding the
>>> > macro, so the smell becomes more poignant, and the macro can be
>>> > deleted.
>>> >
>>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> > ---
>>> >  hw/block/pflash_cfi01.c | 10 ++--------
>>> >  1 file changed, 2 insertions(+), 8 deletions(-)
>>> >
>>> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> > index 9efa7aa9af..f73c30a3ee 100644
>>> > --- a/hw/block/pflash_cfi01.c
>>> > +++ b/hw/block/pflash_cfi01.c
>>> > @@ -49,12 +49,6 @@
>>> >  #include "sysemu/sysemu.h"
>>> >  #include "trace.h"
>>> >
>>> > -#define PFLASH_BUG(fmt, ...) \
>>> > -do { \
>>> > -    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
>>> > -    exit(1); \
>>> > -} while(0)
>>> > -
>>> >  /* #define PFLASH_DEBUG */
>>> >  #ifdef PFLASH_DEBUG
>>> >  #define DPRINTF(fmt, ...)                                   \
>>> > @@ -624,8 +618,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>>> >                  pfl->status |=3D 0x80;
>>> >              } else {
>>> >                  DPRINTF("%s: unknown command for \"write block\"\n",=
 __func__);
>>> > -                PFLASH_BUG("Write block confirm");
>>> > -                goto reset_flash;
>>> > +                fprintf(stderr, "PFLASH: Possible BUG - Write block =
confirm");
>>> > +                exit(1);
>>>
>>> Don't you want to use hw_error here?
>>>
>>>       hw_error("PFLASH: Possible BUG - Write block confirm");
>>
>> This should just be
>>    qemu_log_mask(LOG_GUEST_ERROR, ...);
>> (replacing both the DPRINTF and the PFLASH_BUG()).
>>
>> It's triggerable by a guest (if it puts the device into write-block
>> mode and then feeds it a bogus command byte), so it's just a guest
>> error, not an issue with our model of the pflash.
>
> I can do that.  Thanks!

Double-checking... you want me to keep goto reset_flash, like this:

@@ -623,8 +617,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offse=
t,
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else {
-                DPRINTF("%s: unknown command for \"write block\"\n", __fun=
c__);
-                PFLASH_BUG("Write block confirm");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "unknown command for \"write block\"\n");
                 goto reset_flash;
             }
             break;
