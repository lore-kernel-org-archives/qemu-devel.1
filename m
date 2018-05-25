Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMCRZ-0008JM-Fi
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMCRW-00076W-8v
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:07:41 -0400
References: <20180521063516.5479-1-famz@redhat.com>
	<677208b5-586b-354a-5fd4-67468152510e@redhat.com>
	<20180525021641.GD12594@lemon.usersys.redhat.com>
	<87a7soxp5j.fsf@dusky.pond.sub.org>
	<20180525062503.GE28589@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f89ee2a6-03e1-ee56-4d7d-e6d0d513094d@redhat.com>
Date: Fri, 25 May 2018 08:07:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180525062503.GE28589@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvme: Make nvme_init error handling code
 more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 05/25/2018 01:25 AM, Fam Zheng wrote:

>>> And that makes five labels in total, I'm not sure I like it:
>>>
>>> fail_handler:
>>>      aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
>>>                             false, NULL, NULL);
>>> fail_queue:
>>>      nvme_free_queue_pair(bs, s->queues[0]);
>>> fail_regs:
>>>      qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
>>> fail_vfio:
>>>      qemu_vfio_close(s->vfio);
>>> fail:
>>>      g_free(s->queues);
>>>      event_notifier_cleanup(&s->irq_notifier);
>>>      return ret;
>>
>> Doesn't look materially worse to me :)
> 
> The labels themselves are not ugly or bad, but the goto statements above will be
> harder to manage.
> 
>>
>> With nice cleanup functions that detect "hasn't been set up" and do
>> nothing then, like free(NULL), you can use just one label.  Sadly,
>> cleanup functions are often not nice that way.
> 
> nvme_free_queue_pair and qemu_vfio_close are cleanup functions and we can
> improve them, but to make qemu_vfio_pci_unmap_bar behave similarly is just odd:
> it's not a clean up function, at least not for s->vfio.

But even then, you can do:

fail:
     if (s->vfio) {
         qemu_vfio_close(s->vfio);
     }

That is, there are ways to make a single cleanup path more applicable, 
regardless of where you decided you needed an early cleanup.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
