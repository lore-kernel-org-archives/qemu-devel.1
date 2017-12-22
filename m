Received: from eggs.gnu.org ([2001:4830:134:3::10]:39756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eSQx8-0007MQ-GY
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 12:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eSQx7-0007ei-HJ
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 12:17:46 -0500
References: <cover.1513790494.git.alistair.francis@xilinx.com>
	<6bad4084f4cbc290e2e9f1a72fcfcda7223383ec.1513790495.git.alistair.francis@xilinx.com>
	<87lghulqno.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1cfb1217-e32d-8e91-da46-07f1c72be77f@redhat.com>
Date: Fri, 22 Dec 2017 18:17:32 +0100
MIME-Version: 1.0
In-Reply-To: <87lghulqno.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 04/29] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-trivial@nongnu.org, alistair23@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 22.12.2017 16:37, Markus Armbruster wrote:
> Second thoughts...
> 
> Alistair Francis <alistair.francis@xilinx.com> writes:
[...]
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>> @@ -1311,8 +1312,8 @@ static void omap_prcm_apll_update(struct omap_prcm_s *s)
>>      /* TODO: update clocks */
>>  
>>      if (mode[0] == 1 || mode[0] == 2 || mode[1] == 1 || mode[1] == 2)
>> -        fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
>> -                        __func__);
>> +        error_report("%s: bad EN_54M_PLL or bad EN_96M_PLL",
>> +                     __func__);
>>  }
> 
> This one's different: we neither exit() nor return a "failed" status to
> the caller.
> 
> We get here when the guest writes something funny to a certain
> memory-mapped I/O register.  In other words, it's guest misbehavior, not
> a user error.  I doubt it should be reported with error_report().
> Peter, do we have a canonical way to report or log  guest misbehavior?

qemu_log_mask(LOG_GUEST_ERROR, ...) ?

 Thomas
