Received: from eggs.gnu.org ([2001:4830:134:3::10]:35026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eOeT2-0006ds-Jj
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eOeSz-00050E-GA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:55:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:17720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eOeSz-0004zc-76
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:55:01 -0500
Date: Tue, 12 Dec 2017 14:54:19 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171212065419.GB26607@yangzhon-Virtual>
References: <20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual>
	<5A253EF5.6040300@huawei.com>
	<20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
	<6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
	<20171207150629.GA7387@yangzhon-Virtual>
	<af4a7e59-ac0a-1d5f-3cc5-458dd5fc6fc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4a7e59-ac0a-1d5f-3cc5-458dd5fc6fc9@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, zhaoshenglong@huawei.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, yang.zhong@intel.com

On Mon, Dec 11, 2017 at 05:31:43PM +0100, Paolo Bonzini wrote:
> On 07/12/2017 16:06, Yang Zhong wrote:
> >  Which show trim cost time less than 1ms and call_rcu_thread() do 10 times batch free, the trim also 10 times.
> > 
> >  I also did below changes: 
> >     delta=1000,  and 
> >     next_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta * last_trim_time
> > 
> >  The whole VM bootup will trim 3 times.
> 
> For any adaptive mechanism (either this one or the simple "if (n == 0)"
> one), the question is:
> 
> 1) what effect it has on RSS in your case
  Hello Paolo,

  I list those two TEMP patch here,

  (1). if (n==0) patch
  /*
   * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
   * Bits 1 and above are defined in synchronize_rcu.
  @@ -246,6 +246,7 @@ static void *call_rcu_thread(void *opaque)
                  qemu_event_reset(&rcu_call_ready_event);
                  n = atomic_read(&rcu_call_count);
                  if (n == 0) {
  +                    malloc_trim(4 * 1024 * 1024);
                      qemu_event_wait(&rcu_call_ready_event);
                  }
              }

  (2). adaptive patch

       rcu_register_thread();

  @@ -272,6 +273,21 @@ static void *call_rcu_thread(void *opaque)
             node->func(node);
         }
         qemu_mutex_unlock_iothread();
  +
  +        static uint64_t next_trim_time, last_trim_time;
  +        int delta=1000;
  +
  +        if ( qemu_clock_get_ns(QEMU_CLOCK_HOST) < next_trim_time ) {
  +            next_trim_time -= last_trim_time / delta;   /* or higher */
  +            last_trim_time -= last_trim_time / delta;   /* same as previous line */
  +        } else {
  +            uint64_t trim_start_time = qemu_clock_get_ns(QEMU_CLOCK_HOST);
  +            malloc_trim(4 * 1024 *1024);
  +            last_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) - trim_start_time;
  +            next_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta * last_trim_time;
  +       }
  +


   I used those two TEMP patch to test and results as below:

   My test command
   sudo ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,threads=1,sockets=1 \
    -drive format=raw,file=/home/yangzhon/icx/workspace/eywa.img,index=0,media=disk -nographic
  
  (1) if (n==0) patch
    563015d84000-563016fd6000 rw-p 00000000 00:00 0                          [heap]
    Size:              18760 kB
    KernelPageSize:        4 kB
    MMUPageSize:           4 kB
    Rss:                3176 kB
    Pss:                3176 kB

  (2)adaptive patch
    55bd5975a000-55bd5a9ac000 rw-p 00000000 00:00 0                          [heap]
    Size:              18760 kB
    KernelPageSize:        4 kB
    MMUPageSize:           4 kB
    Rss:                3196 kB
    Pss:                3196 kB

  if set delta=10, then get below result

    56043a2e1000-56043b533000 rw-p 00000000 00:00 0                          [heap]
    Size:              18760 kB
    KernelPageSize:        4 kB
    MMUPageSize:           4 kB
    Rss:                3168 kB
    Pss:                3168 kB

 
  With my test command, if used the n==0 patch, the trim times decresed to 1/2,
  if delta=1000 in patch2, the trim time is 3. If delta=10, the trim time is 10.

  Regards,

  Yang 

> 2) what effect it has on boot time in Shannon's case.
  Hello Shannon,

  It's hard for me to reproduce your commands in my x86 enviornment, as a compare test,
  would you please help me use above two TEMP patches to verify VM bootup time again?

  Those data can help Paolo to decide which patch will be used or how to adjust delta
  parameter.  Many thanks!

  Regards,

  Yang


> Either patch is okay if you can justify it with these two performance
> indices.
> 
> Thanks,
> 
> Paolo
