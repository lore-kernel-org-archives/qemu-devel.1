Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <avi@cloudius-systems.com>) id 1cEZdX-0000aE-Sq
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <avi@cloudius-systems.com>) id 1cEZdS-0003Ha-Sn
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:39:43 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <avi@cloudius-systems.com>)
	id 1cEZdS-0003Fx-Jp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:39:38 -0500
Received: by mail-wm0-f41.google.com with SMTP id g23so161131657wme.1
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 02:39:38 -0800 (PST)
References: <20161124151225.GA11963@stefanha-x1.localdomain>
	<325f739a-05bd-c437-b9a2-e371a8cbf50d@linux.intel.com>
	<20161128152921.GA11196@stefanha-x1.localdomain>
	<73fa904a-7064-d692-6e8d-39161eaa8786@redhat.com>
	<20161129104505.GA1300@stefanha-x1.localdomain>
	<32e560b9-779a-3cd9-9320-2faf68e00107@scylladb.com>
	<20161201114529.GA10441@stefanha-x1.localdomain>
	<9b1bf34e-e33b-777d-ef02-00b50b03440f@scylladb.com>
	<1469768236.987810.1480602927225.JavaMail.zimbra@redhat.com>
	<20161202101235.GB14548@stefanha-x1.localdomain>
From: Avi Kivity <avi@scylladb.com>
Message-ID: <3cdee89e-5d3f-c473-6c0b-4bb6b622d13f@scylladb.com>
Date: Wed, 7 Dec 2016 12:38:34 +0200
MIME-Version: 1.0
In-Reply-To: <20161202101235.GB14548@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Linux kernel polling for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Fam Zheng <famz@redhat.com>, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jens Axboe <axboe@fb.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Hellwig <hch@lst.de>



On 12/02/2016 12:12 PM, Stefan Hajnoczi wrote:
> On Thu, Dec 01, 2016 at 09:35:27AM -0500, Paolo Bonzini wrote:
>>>>> Maybe we could do the same for sockets?  When data is available on a
>>>>> socket (or when it becomes writable), write to a user memory location.
>>>>>
>>>>> I, too, have an interest in polling; in my situation most of the polling
>>>>> happens in userspace.
>>>> You are trying to improve on the latency of non-blocking
>>>> ppoll(2)/epoll_wait(2) call?
>>> Yes, but the concern is for throughput, not latency.
>>>
>>> My main loop looks like
>>>
>>>      execute some tasks
>>>      poll from many sources
>>>
>>> Since epoll_wait(..., 0) has non-trivial costs, I have to limit the
>>> polling rate, and even so it shows up in the profile.  If the cost were
>>> lower, I could poll at a higher frequency, resulting in lower worst-case
>>> latencies for high-priority tasks.
>> IMHO, the ideal model wouldn't enter the kernel at all unless you _want_
>> to go to sleep.
> Something like mmapping an epoll file descriptor to get a ring of
> epoll_events.  It has to play nice with blocking epoll_wait(2) and
> ppoll(2) of an eventpoll file descriptor so that the userspace process
> can go to sleep without a lot of work to switch epoll wait vs mmap
> modes.

I think that's overkill; as soon as data is returned, you're going to be 
talking to the kernel in order to get it.  Besides, leave something for 
userspace tcp stack implementations.

> I'm bothered by the fact that the kernel will not be able to poll NIC or
> storage controller rings if userspace is doing the polling :(.


Yes, that's a concern.

We have three conflicting requirements:
  - fast inter-thread IPC (or guest/host IPC) -> shared memory+polling
  - kernel multiplexing of hardware -> kernel interfaces + kernel poll / 
sleep
  - composable interfaces that allow you to use the two methods

You could use something like Flow Director to move interesting flows 
directly to the application, let the application poll those queues (and 
maybe tell the kernel if something interesting happens), while the 
kernel manages the other queues.  It gets ugly very quickly.
