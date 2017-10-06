Received: from eggs.gnu.org ([2001:4830:134:3::10]:45677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0ReJ-0007hj-Ac
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0ReE-0001Lf-Cu
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1e0ReE-0001Ko-3H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:22:34 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-25-dgilbert@redhat.com>
	<2f4c1067-14a4-d943-0dff-790d705778f1@redhat.com>
	<20170707115353.GD2451@work-vm> <20171003132351.GA2935@work-vm>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <0c312c2e-2ef1-07cb-10cc-69e21d38077d@redhat.com>
Date: Fri, 6 Oct 2017 14:22:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171003132351.GA2935@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 24/29] vhost+postcopy: Lock around
 set_mem_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com



On 10/03/2017 03:23 PM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
>>>
>>>
>>> On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
>>>> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>>>
>>>> **HACK - better solution needed **
>>>> We have the situation where:
>>>>
>>>>        qemu                      bridge
>>>>
>>>>        send set_mem_table
>>>>                                 map memory
>>>>     a)                          mark area with UFD
>>>>                                 send reply with map addresses
>>>>     b)                          start using
>>>>     c) receive reply
>>>>
>>>>     As soon as (a) happens qemu might start seeing faults
>>>> from memory accesses (but doesn't until b); but it can't
>>>> process those faults until (c) when it's received the
>>>> mmap addresses.
>>>>
>>>> Make the fault handler spin until it gets the reply in (c).
>>>>
>>>> At the very least this needs some proper locks, but preferably
>>>> we need to split the message.
>>>
>>> Yes, maybe the slave channel could be used to send the ufds with
>>> a dedicated request? The backend would set the reply-ack flag, so that
>>> it starts accessing the guest memory only when Qemu is ready to handle
>>> faults.
>>
>> Yes, that would make life a lot easier.
>>
>>> Note that the slave channel support has not been implemented in Qemu's
>>> libvhost-user yet, but this is something I can do if we feel the need.
>>
>> Can you tell me a bit about how the slave channel works?
> 
> I've looked at the slave-channel; and I'm worried that it's not suitable
> for this case.
> The problem is that 'slave_read' is wired to a fd_handler that I think
> is serviced by the main thread,
I confirm, this is serviced by the main thread.

> and while postcopy is running I don't
> want to rely on the operation of the main thread (since it could be
> blocked by a page fault).

IIUC, you mean QEMU being blocked by a page fault.
In this case, I don't think this is an issue, because QEMU doesn't rely
on the backend to handle the page fault, so the slave request can be
handled only once QEMU has handled the fault.

Maybe I am missing something?

> I could still use an explicit ack at that point though over the main
> channel I think (or use the slave synchronously?).

Can you please elaborate, I'm not sure to understand what you mean.

Thanks,
Maxime

> Dave
> 
>> Dave
>>
>>> Maxime
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
