Received: from eggs.gnu.org ([2001:4830:134:3::10]:50035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffgdK-000071-Jo
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffgdF-0001vD-LY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:12:22 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ffgdF-0001ub-Bc
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:12:17 -0400
Received: by mail-pl0-x243.google.com with SMTP id m16-v6so1629358pls.11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 00:12:17 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-11-xiaoguangrong@tencent.com>
	<20180620065202.GG18985@xz-mi> <20180713162439.GB2434@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <00851995-beb7-0aa1-593b-c725f28e0726@gmail.com>
Date: Wed, 18 Jul 2018 15:12:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180713162439.GB2434@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/12] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/14/2018 12:24 AM, Dr. David Alan Gilbert wrote:

>>> +static void *thread_run(void *opaque)
>>> +{
>>> +    ThreadLocal *self_data = (ThreadLocal *)opaque;
>>> +    Threads *threads = self_data->threads;
>>> +    void (*handler)(ThreadRequest *data) = threads->thread_request_handler;
>>> +    ThreadRequest *request;
>>> +    int count, ret;
>>> +
>>> +    for ( ; !atomic_read(&self_data->quit); ) {
>>> +        qemu_event_reset(&self_data->ev);
>>> +
>>> +        count = 0;
>>> +        while ((request = ring_get(self_data->request_ring)) ||
>>> +            count < BUSY_WAIT_COUNT) {
>>> +             /*
>>> +             * wait some while before go to sleep so that the user
>>> +             * needn't go to kernel space to wake up the consumer
>>> +             * threads.
>>> +             *
>>> +             * That will waste some CPU resource indeed however it
>>> +             * can significantly improve the case that the request
>>> +             * will be available soon.
>>> +             */
>>> +             if (!request) {
>>> +                cpu_relax();
>>> +                count++;
>>> +                continue;
>>> +            }
>>> +            count = 0;
> 
> Things like busywait counts probably need isolating somewhere;
> getting those counts right is quite hard.

Okay, i will make it to be a separated function.
