Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWM3R-0000eM-Rd
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWM3M-0005yn-Uw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:24:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-11-f4bug@amsat.org>
	<8b75e080-6c68-0bdc-1f2c-8ca6c0f80089@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44d9b737-073f-983e-fe19-03b908e7c9a3@amsat.org>
Date: Fri, 22 Jun 2018 10:24:36 -0300
MIME-Version: 1.0
In-Reply-To: <8b75e080-6c68-0bdc-1f2c-8ca6c0f80089@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/11] hw/net/stellaris_enet: Use
 qemu_log_mask(GUEST_ERROR) instead of hw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 05:43 AM, Thomas Huth wrote:
> On 21.06.2018 20:02, Philippe Mathieu-Daudé wrote:
>> hw_error() finally calls abort(), but there is no need to abort here.
> 
> Additionally, hw_error() is also only meant for CPU errors (since it
> dumps the CPU state). We should really rename that function to
> "cpu_hw_error" one day to avoid that people use it in the wrong spots...

Another painful cleanup series...

> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/net/stellaris_enet.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
>> index 04bd10ada3..188adcbd15 100644
>> --- a/hw/net/stellaris_enet.c
>> +++ b/hw/net/stellaris_enet.c
>> @@ -9,6 +9,7 @@
>>  #include "qemu/osdep.h"
>>  #include "hw/sysbus.h"
>>  #include "net/net.h"
>> +#include "qemu/log.h"
>>  #include <zlib.h>
>>  
>>  //#define DEBUG_STELLARIS_ENET 1
>> @@ -343,7 +344,9 @@ static uint64_t stellaris_enet_read(void *opaque, hwaddr offset,
>>      case 0x3c: /* Undocuented: Timestamp? */
>>          return 0;
>>      default:
>> -        hw_error("stellaris_enet_read: Bad offset %x\n", (int)offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "stellaris_enet_rd%d: 0x%" HWADDR_PRIx "\n",
>> +                      size, offset);
>>          return 0;
>>      }
>>  }
>> @@ -442,7 +445,9 @@ static void stellaris_enet_write(void *opaque, hwaddr offset,
>>          /* Ignored.  */
>>          break;
>>      default:
>> -        hw_error("stellaris_enet_write: Bad offset %x\n", (int)offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "stellaris_enet_wr%d: 0x%" HWADDR_PRIx " = 0x%lx\n",
>> +                      size, offset, value);
>>      }
>>  }
> 
> Could you please keep the "bad offset" or a similar error message, so
> that the user knows that there is really something wrong here?

Sure.
