Received: from eggs.gnu.org ([2001:4830:134:3::10]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1faQNx-0004Wu-Pg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1faQNw-0005KP-NE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:50:45 -0400
Date: Tue, 3 Jul 2018 11:50:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180703185035.GB14422@roeck-us.net>
References: <20180703171044.9503-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/4] cmsdk-apb-timer: various
 bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, Jul 03, 2018 at 06:10:40PM +0100, Peter Maydell wrote:
> This patchseries includes Guenter's recent patch to suppress
> warning messages from the ptimer layer that otherwise occur
> from the way the Linux driver for this timer device operates.
> 
> The other patches here fix more obscure things:
>  * the timer interrupt is only supposed to trigger when the
>    counter counts down from 1 to 0, not if it is at 0 for
>    some other reason like a direct write of 0 to the VALUE register.
>    Handling this requires adding a new policy option to the ptimer
>    code, which is what patch 1 does.
>  * we were incorrectly setting the NO_IMMEDIATE_TRIGGER
>    ptimer policy, which meant we would trigger the interrupt
>    one timer clock too late (when we did the timer reload,
>    rather than on the 1-to-0 counter transition)
>  * if the ptimer had already disabled itself because it was
>    in one-shot mode and had expired, writing to RELOAD or
>    VALUE needs to cause it to start counting again
> 
> Tested with a uCLinux/mps2 kernel and buildroot initfs.
> 

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

also with uCLinux/mps2 kernel and buildroot initfs.

Thanks,
Guenter

> thanks
> -- PMM
> 
> Guenter Roeck (1):
>   hw/timer/cmsdk-apb-timer: Correctly identify and set one-shot mode
> 
> Peter Maydell (3):
>   ptimer: Add TRIGGER_ONLY_ON_DECREMENT policy option
>   hw/timer/cmsdk-apb-timer: Correct ptimer policy settings
>   hw/timer/cmsdk-apb-timer: run or stop timer on writes to RELOAD and
>     VALUE
> 
>  include/hw/ptimer.h        |  9 +++++++++
>  hw/core/ptimer.c           | 22 +++++++++++++++++++++-
>  hw/timer/cmsdk-apb-timer.c | 20 ++++++++++++++++++--
>  tests/ptimer-test.c        | 25 +++++++++++++++++++------
>  4 files changed, 67 insertions(+), 9 deletions(-)
> 
> -- 
> 2.17.1
> 
