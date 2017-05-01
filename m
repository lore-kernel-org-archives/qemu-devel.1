Received: from eggs.gnu.org ([2001:4830:134:3::10]:47403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d54Zf-0006vu-Jb
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d54Za-0005nD-MH
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:12:43 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56632
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d54Za-0005mw-Ez
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:12:38 -0400
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1492763327-12742-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA-8DazW24_XwZ+2e+TSPJWfygQXWtmqUaBSUcTNpe32TA@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6ff07b41-285d-cb8b-7dfb-ea4b50c142b0@ilande.co.uk>
Date: Mon, 1 May 2017 07:12:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8DazW24_XwZ+2e+TSPJWfygQXWtmqUaBSUcTNpe32TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/13] cg3: remove TARGET_PAGE_SIZE
 rounding on dirty page detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 25/04/17 15:57, Peter Maydell wrote:

> On 21 April 2017 at 09:28, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> This was an artifact from very early versions of the code from before the
>> memory API and is no longer needed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  hw/display/cg3.c |    6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
>> index 1174220..7d43694 100644
>> --- a/hw/display/cg3.c
>> +++ b/hw/display/cg3.c
>> @@ -26,7 +26,6 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>> -#include "cpu.h"
>>  #include "qemu/error-report.h"
>>  #include "ui/console.h"
>>  #include "hw/sysbus.h"
>> @@ -114,7 +113,7 @@ static void cg3_update_display(void *opaque)
>>      for (y = 0; y < height; y++) {
>>          int update = s->full_update;
>>
>> -        page = (y * width) & TARGET_PAGE_MASK;
>> +        page = y * width;
> 
> Coverity warns that this is multiplying two 32 bit quantities
> and giving a 32 bit result that's then assigned to a 64 bit variable.
> Casting like:
>     page = (ram_addr_t)y * width;
> 
> is the usual way to placate it.

Ah okay. I've done a quick test here and the above change seems fine so
I'll send along a patch.


ATB,

Mark.
