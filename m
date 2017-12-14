Received: from eggs.gnu.org ([2001:4830:134:3::10]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXuZ-000524-Vk
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXuW-0003Ac-5z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:07:11 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:36687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXuW-0003A0-26
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:07:08 -0500
Received: by mail-it0-x241.google.com with SMTP id d16so13150141itj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 10:07:08 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKN5dk=sEpSqbnDzyUoSp01YdOaOGQQZBDjcQsaEVhZ-xQ@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-10-f4bug@amsat.org>
	<CAKmqyKN5dk=sEpSqbnDzyUoSp01YdOaOGQQZBDjcQsaEVhZ-xQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 15:07:06 -0300
Message-ID: <CAAdtpL4A35MBm7-uRHzbz2eFkJnh6FQ-HpZS+wwu-Y=KT33Npw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/14] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 14, 2017 at 2:46 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/sd/sdhci.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 893be0e606..044e3d62f1 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/sd/sdhci.h"
>>  #include "sdhci-internal.h"
>>  #include "sd-internal.h"
>> +#include "qapi/error.h"
>>  #include "qemu/log.h"
>>
>>  /* host controller debug messages */
>> @@ -1191,17 +1192,21 @@ static void sdhci_realizefn(SDHCIState *s, Error=
 **errp)
>>                            SDHC_REGISTERS_MAP_SIZE);
>>  }
>>
>> +static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
>> +{
>> +    g_free(s->fifo_buffer);
>> +    s->fifo_buffer =3D NULL;
>
> I don't think setting this to NULL is required. Shouldn't g_free() do
> that for you?

You are right, good eye :) I didn't notice, this was just code
movement from the current code.

Indeed g_free() doesn't free() if the pointer is NULL, however since
it doesn't have access to the pointer address it can't set it to NULL.
In some case it matters (RCU code maybe?) but I just checked and it
this case it doesn't, so I'll drop this line.
