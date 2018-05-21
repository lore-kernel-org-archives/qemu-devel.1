Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn43-0002Ac-8s
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn42-00038Z-8K
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:49:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 21 May 2018 17:49:31 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <CAFEAcA-Q6c7Z49uxup1HdyaEvWt+er_B8eYcJn0UYDiXShz1eQ@mail.gmail.com>
References: <20180521122100.22602-1-michael@walle.cc>
	<20180521122100.22602-3-michael@walle.cc>
	<CAFEAcA-Q6c7Z49uxup1HdyaEvWt+er_B8eYcJn0UYDiXShz1eQ@mail.gmail.com>
Message-ID: <7bf9b59e7e457efc1a117597ab8d4aae@walle.cc>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/lm32: hold BQL in gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

Am 2018-05-21 14:25, schrieb Peter Maydell:
> On 21 May 2018 at 13:21, Michael Walle <michael@walle.cc> wrote:
>> Changing the IP/IM registers may cause interrupts, so hold the BQL.
>> 
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  target/lm32/gdbstub.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
>> index cf929dd392..dac9418a2b 100644
>> --- a/target/lm32/gdbstub.c
>> +++ b/target/lm32/gdbstub.c
>> @@ -18,6 +18,7 @@
>>   * License along with this library; if not, see 
>> <http://www.gnu.org/licenses/>.
>>   */
>>  #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>>  #include "exec/gdbstub.h"
>> @@ -82,10 +83,14 @@ int lm32_cpu_gdb_write_register(CPUState *cs, 
>> uint8_t *mem_buf, int n)
>>              env->ie = tmp;
>>              break;
>>          case 37:
>> +            qemu_mutex_lock_iothread();
>>              lm32_pic_set_im(env->pic_state, tmp);
>> +            qemu_mutex_unlock_iothread();
>>              break;
>>          case 38:
>> +            qemu_mutex_lock_iothread();
>>              lm32_pic_set_ip(env->pic_state, tmp);
>> +            qemu_mutex_unlock_iothread();
>>              break;
>>          }
>>      }
> 
> Are you sure this is necessary? I would have expected the gdbstub to
> be operating under the qemu lock anyway.


You're right. The gdbstub is already holding the lock. So i'll drop this 
and send the pull request right now.

-michael
