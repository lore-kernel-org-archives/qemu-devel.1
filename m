Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM5ZY-0002YE-Ap
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM5ZX-0002al-Ck
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:47:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180521063516.5479-1-famz@redhat.com>
	<677208b5-586b-354a-5fd4-67468152510e@redhat.com>
	<20180525021641.GD12594@lemon.usersys.redhat.com>
Date: Fri, 25 May 2018 07:47:20 +0200
In-Reply-To: <20180525021641.GD12594@lemon.usersys.redhat.com> (Fam Zheng's
	message of "Fri, 25 May 2018 10:16:41 +0800")
Message-ID: <87a7soxp5j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Fam Zheng <famz@redhat.com> writes:

> On Thu, 05/24 19:16, Paolo Bonzini wrote:
>> On 21/05/2018 08:35, Fam Zheng wrote:
>> > Coverity doesn't like the tests under fail label (report CID 1385847).
>> > Reset the fields so the clean up order is more apparent.
>> > 
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > ---
>> >  block/nvme.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> > 
>> > diff --git a/block/nvme.c b/block/nvme.c
>> > index 6f71122bf5..8239b920c8 100644
>> > --- a/block/nvme.c
>> > +++ b/block/nvme.c
>> > @@ -560,6 +560,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>> >      qemu_co_queue_init(&s->dma_flush_queue);
>> >      s->nsid = namespace;
>> >      s->aio_context = bdrv_get_aio_context(bs);
>> > +
>> > +    /* Fields we've not touched should be zero-initialized by block layer
>> > +     * already, but reset them anyway to make the error handling code easier to
>> > +     * reason. */
>> > +    s->regs = NULL;
>> > +    s->vfio = NULL;
>> > +
>> >      ret = event_notifier_init(&s->irq_notifier, 0);
>> >      if (ret) {
>> >          error_setg(errp, "Failed to init event notifier");
>> > 
>> 
>> I think we should just mark it as a false positive or do something like
>> 
>> fail_regs:
>>     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
>> fail_vfio:
>>     qemu_vfio_close(s->vfio);
>> fail:
>>     g_free(s->queues);
>>     event_notifier_cleanup(&s->irq_notifier);
>>     return ret;
>> 
>> even though it's a larger patch.
>
> And that makes five labels in total, I'm not sure I like it:
>
> fail_handler:
>     aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
>                            false, NULL, NULL);
> fail_queue:
>     nvme_free_queue_pair(bs, s->queues[0]);
> fail_regs:
>     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> fail_vfio:
>     qemu_vfio_close(s->vfio);
> fail:
>     g_free(s->queues);
>     event_notifier_cleanup(&s->irq_notifier);
>     return ret;

Doesn't look materially worse to me :)

With nice cleanup functions that detect "hasn't been set up" and do
nothing then, like free(NULL), you can use just one label.  Sadly,
cleanup functions are often not nice that way.

> Maybe we just mark it as false positive then?
>
> Fam
