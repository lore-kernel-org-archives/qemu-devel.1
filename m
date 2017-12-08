Received: from eggs.gnu.org ([2001:4830:134:3::10]:51244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNGVO-0002TM-JN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNGVL-0001x8-De
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:07:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:1897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eNGVL-0001tC-2w
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:07:43 -0500
Date: Fri, 8 Dec 2017 19:06:59 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171208110659.GB8672@yangzhon-Virtual>
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com>
	<20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual>
	<5A253EF5.6040300@huawei.com>
	<20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
	<6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, zhaoshenglong@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, yang.zhong@intel.com

On Wed, Dec 06, 2017 at 10:48:45AM +0100, Paolo Bonzini wrote:
> On 06/12/2017 10:26, Yang Zhong wrote:
> >   Hello Paolo,
> > 
> >   The best option is only trim one time after guest kernel bootup or VM bootup, and as for
> >   hotplug/unhotplug operations during the VM running, the trim still can do for each batch
> >   memory free because trim will not impact VM performance during VM running status.
> > 
> >   So, the key point is qemu is hard to know when guest ernel bootup is over. If you have some 
> >   suggestions, please let me know. thanks!
> 
> It shouldn't be hard.  Does QEMU's RCU thread actually get any
> significant activity after bootup?  Hence the suggestion of keeping
> malloc_trim in the RCU thread, but only do it if some time has passed
> since the last time.
> 
> Maybe something like this every time the RCU thread runs:
> 
>  static uint64_t next_trim_time, last_trim_time;
>  if (current time < next_trim_time) {
>      next_trim_time -= last_trim_time / 2    /* or higher */
>      last_trim_time -= last_trim_time / 2    /* same as previous line */
>  } else {
>      trim_start_time = current time
>      malloc_trim(...)
>      last_trim_time = current time - trim_start_time
>      next_trim_time = current time + last_trim_time
>  }
> 
> Where the "2" factor should be tuned so that both your and Shannon's
> scenario work fine.
>
  Hello Paolo,

  As for your patch, i have commented on another mail.

  Please help check below TEMP patch.

  +++ b/util/rcu.c
  @@ -32,7 +32,7 @@
  #include "qemu/atomic.h"
  #include "qemu/thread.h"
  #include "qemu/main-loop.h"
 -
+#if defined(CONFIG_MALLOC_TRIM)
+#include <malloc.h>
+#endif
  /*
   * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
   * Bits 1 and above are defined in synchronize_rcu.
  @@ -246,6 +246,7 @@ static void *call_rcu_thread(void *opaque)
                  qemu_event_reset(&rcu_call_ready_event);
                  n = atomic_read(&rcu_call_count);
                  if (n == 0) {
 +                    #if defined(CONFIG_MALLOC_TRIM)
 +                       malloc_trim(4 * 1024 * 1024);
 +                    #endif
                      qemu_event_wait(&rcu_call_ready_event);
                  }
              }

  If there is no rcu_call(), the n=0 and call_rcu_thread() will trim memory 
  and then enter sleep to wait for rcu_call() to wakeup this thread.

  Once the VM bootup, if there is not any activity like hotplug, rcu thread
  is always in sleep status.

  As for the VM bootup, if the n!=0, the rcu thread will not call trim.

  If use this method, the trim times will decrease to around 1/2 of previous. 

  Regards,

  Yang
 
> Thanks,
> 
> Paolo
