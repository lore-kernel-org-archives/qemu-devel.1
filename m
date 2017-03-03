Received: from eggs.gnu.org ([2001:4830:134:3::10]:43339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqie-0003by-KL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqid-0000ht-GC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:10:16 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjqid-0000h3-9v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:10:15 -0500
Received: by mail-wr0-x233.google.com with SMTP id l37so78013327wrc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 09:10:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4e71b620-8ebd-0f66-f032-64fb8cc98b9f@greensocs.com>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-12-alex.bennee@linaro.org>
	<4e71b620-8ebd-0f66-f032-64fb8cc98b9f@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 17:09:53 +0000
Message-ID: <CAFEAcA-t3vNH2dYWCGh8WaHsKeYs+kZonbcncv7dmm8dy29+Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] hw/intc/arm_gic: modernise the
 DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, MTTCG Devel <mttcg@listserver.greensocs.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM cores" <qemu-arm@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>

On 3 March 2017 at 17:05, Frederic Konrad <fred.konrad@greensocs.com> wrote=
:
> Hi Alex,
>
> On 03/02/2017 08:53 PM, Alex Benn=C3=A9e wrote:
>> While I was debugging the icount issues I realised a bunch of the
>> messages look quite similar. I've fixed this by including __func__ in
>> the debug print. At the same time I move the a modern if (GATE) style
>> printf which ensures the compiler can check for format string errors
>> even if the code gets optimised away in the non-DEBUG_GIC case.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/intc/arm_gic.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index 8e5a9d8a3e..b305d9032a 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -26,15 +26,20 @@
>>  #include "qemu/log.h"
>>  #include "trace.h"
>>
>> -//#define DEBUG_GIC
>> +/* #define DEBUG_GIC */
>>
>>  #ifdef DEBUG_GIC
>> -#define DPRINTF(fmt, ...) \
>> -do { fprintf(stderr, "arm_gic: " fmt , ## __VA_ARGS__); } while (0)
>> +#define DEBUG_GIC_GATE 1
>>  #else
>> -#define DPRINTF(fmt, ...) do {} while(0)
>> +#define DEBUG_GIC_GATE 0
>>  #endif
>>
>> +#define DPRINTF(fmt, ...) do {                                         =
 \
>> +        if (DEBUG_GIC_GATE) {                                          =
 \
>> +            fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__);     =
 \
>> +        }                                                              =
 \
>> +    } while (0)
>> +
>
> Seems a prefered way is using qemu_log instead of fprintf?

This is debug print. Our "preferred" approach is the trace-events
framework (look at how gicv3 does it for example), which has the
nice property of being user-enableable at runtime, but there's
no absolute requirement to update old code to use that instead of
debug printfs. (It's not completely trivial to update, and among
other things you need to consider what trace might be useful to
the user rather than merely whatever random fprintfs you found
helpful during development.)

qemu_log is for certain specific kinds of user-enableable tracing
(notably "guest did something wrong" and "we don't implement this").

thanks
-- PMM
