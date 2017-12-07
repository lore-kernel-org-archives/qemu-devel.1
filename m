Received: from eggs.gnu.org ([2001:4830:134:3::10]:35862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eMxle-00087t-6t
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eMxla-00027p-49
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:07:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:50050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eMxlZ-00026b-M1
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:07:14 -0500
Date: Thu, 7 Dec 2017 23:06:29 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171207150629.GA7387@yangzhon-Virtual>
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhaoshenglong@huawei.com, yang.zhong@intel.com

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

  Thanks for your help!
  I changed the patch per your advice, and new TEMP patch as below:

  static void *call_rcu_thread(void *opaque)
  {
     struct rcu_head *node;
 +    int num=1;

     rcu_register_thread();

  @@ -272,6 +273,21 @@ static void *call_rcu_thread(void *opaque)
             node->func(node);
         }
         qemu_mutex_unlock_iothread();
 +
 +        static uint64_t next_trim_time, last_trim_time;
 +        int delta=100;
 +
 +        if ( qemu_clock_get_ns(QEMU_CLOCK_HOST) < next_trim_time ) {
 +            next_trim_time -= last_trim_time / delta;   /* or higher */
 +            last_trim_time -= last_trim_time / delta;   /* same as previous line */
 +        } else {
 +            uint64_t trim_start_time = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 +            malloc_trim(4 * 1024 *1024);
 +            last_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) - trim_start_time;
 +            next_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) + last_trim_time;
 +            printf("---------memory trim----------num=%d------last_trim_time=%ld next_trim_time=%ld --\n", num++,last_trim_time,next_trim_time);
 +       }
 +
 
 The print log for your reference
 ---------memory trim----------num=1------last_trim_time=165000 next_trim_time=1512658205270477000 --
 ---------memory trim----------num=2------last_trim_time=656000 next_trim_time=1512658205278032000 --
 ---------memory trim----------num=3------last_trim_time=620000 next_trim_time=1512658205298888000 --
 ---------memory trim----------num=4------last_trim_time=635000 next_trim_time=1512658205339967000 --
 ---------memory trim----------num=6------last_trim_time=526000 next_trim_time=1512658207659599000 --
 ---------memory trim----------num=7------last_trim_time=744000 next_trim_time=1512658208121249000 --
 ---------memory trim----------num=8------last_trim_time=872000 next_trim_time=1512658208132805000 --
 ---------memory trim----------num=9------last_trim_time=380000 next_trim_time=1512658208376950000 --
 ---------memory trim----------num=10------last_trim_time=521000 next_trim_time=1512658210648843000 --

 Which show trim cost time less than 1ms and call_rcu_thread() do 10 times batch free, the trim also 10 times.

 I also did below changes: 
    delta=1000,  and 
    next_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta * last_trim_time

 The whole VM bootup will trim 3 times.

 Regards,

 Yang


> Thanks,
> 
> Paolo
