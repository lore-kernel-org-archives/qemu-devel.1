Received: from eggs.gnu.org ([2001:4830:134:3::10]:36747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <avi@cloudius-systems.com>) id 1cEZYQ-0005yW-9R
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <avi@cloudius-systems.com>) id 1cEZYL-0001NE-9u
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:34:26 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <avi@cloudius-systems.com>)
	id 1cEZYL-0001In-2Z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:34:21 -0500
Received: by mail-wj0-f178.google.com with SMTP id v7so356414914wjy.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 02:33:59 -0800 (PST)
References: <20161124151225.GA11963@stefanha-x1.localdomain>
	<325f739a-05bd-c437-b9a2-e371a8cbf50d@linux.intel.com>
	<20161128152921.GA11196@stefanha-x1.localdomain>
	<73fa904a-7064-d692-6e8d-39161eaa8786@redhat.com>
	<20161129104505.GA1300@stefanha-x1.localdomain>
	<32e560b9-779a-3cd9-9320-2faf68e00107@scylladb.com>
	<20161201114529.GA10441@stefanha-x1.localdomain>
	<9b1bf34e-e33b-777d-ef02-00b50b03440f@scylladb.com>
	<1469768236.987810.1480602927225.JavaMail.zimbra@redhat.com>
From: Avi Kivity <avi@scylladb.com>
Message-ID: <de7d7214-d477-468c-0ab7-ada174c8154c@scylladb.com>
Date: Wed, 7 Dec 2016 12:32:55 +0200
MIME-Version: 1.0
In-Reply-To: <1469768236.987810.1480602927225.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Willem de Bruijn <willemb@google.com>, Fam Zheng <famz@redhat.com>, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jens Axboe <axboe@fb.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Hellwig <hch@lst.de>



On 12/01/2016 04:35 PM, Paolo Bonzini wrote:
>>>> Maybe we could do the same for sockets?  When data is available on a
>>>> socket (or when it becomes writable), write to a user memory location.
>>>>
>>>> I, too, have an interest in polling; in my situation most of the polling
>>>> happens in userspace.
>>> You are trying to improve on the latency of non-blocking
>>> ppoll(2)/epoll_wait(2) call?
>> Yes, but the concern is for throughput, not latency.
>>
>> My main loop looks like
>>
>>      execute some tasks
>>      poll from many sources
>>
>> Since epoll_wait(..., 0) has non-trivial costs, I have to limit the
>> polling rate, and even so it shows up in the profile.  If the cost were
>> lower, I could poll at a higher frequency, resulting in lower worst-case
>> latencies for high-priority tasks.
> IMHO, the ideal model wouldn't enter the kernel at all unless you _want_
> to go to sleep.

Right.  Note that if data is available, it doesn't really matter, 
because you'd have to read() it anyway.  It matters for the case where 
data is not available.
