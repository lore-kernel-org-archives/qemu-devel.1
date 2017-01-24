Received: from eggs.gnu.org ([2001:4830:134:3::10]:38690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVxT0-00005s-3c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVxSy-000738-WC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:32:42 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cVxSy-00072m-RP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:32:40 -0500
Received: by mail-it0-x244.google.com with SMTP id o185so13214746itb.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:32:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pojcx3zd.fsf@dusky.pond.sub.org>
References: <1485206518-32403-1-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA860sYR6svwKMtjjoknfkVK=-Ch8vat_ywPyyvjtsr=MA@mail.gmail.com>
	<CAFEAcA-VKUKcCJ2a7Zx_rnWDQTUjbuu4ztXS1AqtmqSQnktVuQ@mail.gmail.com>
	<87pojcx3zd.fsf@dusky.pond.sub.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 24 Jan 2017 10:32:19 +0100
Message-ID: <CACXAS8CwO8+vr+NqSG9FghOLhTzqFZfszhtif_DvW4_fP7ux+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] niagara: fail if a firmware file is
 missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 24, 2017 at 9:21 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 23 January 2017 at 22:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 23 January 2017 at 21:21, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>>> ---
>>>>  hw/sparc64/niagara.c | 22 +++++++++++++++-------
>>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
>>>> index b55d4bb..e945b5a 100644
>>>> --- a/hw/sparc64/niagara.c
>>>> +++ b/hw/sparc64/niagara.c
>>>> @@ -35,6 +35,7 @@
>>>>  #include "hw/timer/sun4v-rtc.h"
>>>>  #include "exec/address-spaces.h"
>>>>  #include "sysemu/block-backend.h"
>>>> +#include "qemu/error-report.h"
>>>>
>>>>
>>>>  typedef struct NiagaraBoardState {
>>>> @@ -85,6 +86,14 @@ typedef struct NiagaraBoardState {
>>>>  #define NIAGARA_OBP_OFFSET  0x80000ULL
>>>>  #define PROM_SIZE_MAX       (4 * 1024 * 1024)
>>>>
>>>> +static void add_rom_or_fail(const char *file, const hwaddr addr)
>>>> +{
>>>> +    if (rom_add_file_fixed(file, addr, -1)) {
>>>> +        error_report("Unable to load a firmware for -M niagara");
>>>> +        exit(1);
>>>
>>> It would be nice to include the name of the file in the
>>> error message -- or is that reported already inside
>>> rom_add_file_fixed() somehow?
>
> Yes, it is, in rom_add_file():
>
>     if (fd == -1) {
>         fprintf(stderr, "Could not open option rom '%s': %s\n",
>                 rom->path, strerror(errno));
>         goto err;
>     }
>
>> PS: doesn't this break 'make check' if the rom files
>> are missing?
>
> Yes, it does.  Obvious incremental fix appended.  It still prints
> rom_add_file()'s message.  Swap the operands of && to get rid of it.

Thanks, Markus. Will resubmit.

Artyom

> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index a14724f..6b78394 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -35,6 +35,7 @@
>  #include "hw/timer/sun4v-rtc.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/qtest.h"
>  #include "qemu/error-report.h"
>
>
> @@ -88,7 +89,7 @@ typedef struct NiagaraBoardState {
>
>  static void add_rom_or_fail(const char *file, const hwaddr addr)
>  {
> -    if (rom_add_file_fixed(file, addr, -1)) {
> +    if (rom_add_file_fixed(file, addr, -1) && !qtest_enabled()) {
>          error_report("Unable to load a firmware for -M niagara");
>          exit(1);
>      }



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
