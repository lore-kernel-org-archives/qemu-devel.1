Received: from eggs.gnu.org ([2001:4830:134:3::10]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dfOuq-0000to-Tj
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dfOun-0002S6-Tp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dfOun-0002RY-LL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB702F86D6
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 11:12:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170809080838.GK13486@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 9 Aug 2017 16:08:38 +0800")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-10-quintela@redhat.com>
	<20170720093455.GC23385@pxdev.xzpeter.org>
	<874ltibemw.fsf@secure.mitica>
	<20170809080838.GK13486@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 09 Aug 2017 13:12:36 +0200
Message-ID: <87k22d6lln.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 09/17] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Aug 08, 2017 at 11:19:35AM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Mon, Jul 17, 2017 at 03:42:30PM +0200, Juan Quintela wrote:
>> >
>> > [...]
>> >
>> >>  int multifd_load_setup(void)
>> >>  {
>> >>      int thread_count;
>> >> -    uint8_t i;
>> >>  
>> >>      if (!migrate_use_multifd()) {
>> >>          return 0;
>> >>      }
>> >>      thread_count = migrate_multifd_threads();
>> >>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>> >> -    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>> >> +    multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
>> >>      multifd_recv_state->count = 0;
>> >> -    for (i = 0; i < thread_count; i++) {
>> >> -        char thread_name[16];
>> >> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
>> >> -
>> >> -        qemu_mutex_init(&p->mutex);
>> >> -        qemu_sem_init(&p->sem, 0);
>> >> -        p->quit = false;
>> >> -        p->id = i;
>> >> -        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
>> >> -        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
>> >> -                           QEMU_THREAD_JOINABLE);
>> >> -        multifd_recv_state->count++;
>> >> -    }
>> >
>> > Could I ask why we explicitly switched from MultiFDRecvParams[] array
>> > into a pointer array? Can we still use the old array?  Thanks,
>> 
>> Now, we could receive the channels out of order (the wonders of
>> networking).  So, we have two options that I can see:
>> 
>> * Add interesting global locking to be able to modify inplace (I know
>>   that it should be safe, but yet).
>> * Create a new struct in the new connection, and then atomically switch
>>   the pointer to the right instruction.
>> 
>> I can assure you that the second one makes it much more easier to detect
>> when you use the "channel" before you have fully created it O:-)
>
> Oh, so it's possible that we start to recv pages even if the recv
> channel has not yet been established...
>
> Then would current code be problematic? Like in multifd_recv_page() we
> have:
>
> static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
> {
>     ...
>     p = multifd_recv_state->params[fd_num];
>     qemu_sem_wait(&p->ready);
>     ...
> }
>
> Here can p==NULL if channel is not ready yet?
>
> (If so, I think a static array makes more sense...)

Yeap.  If we make an error (and believe me that I did), we  get a "nice"
segmentation fault, where we can see what fd_num is.  Otherwise we
receive a hang qemu.  I know what I preffer O:-)

Later, Juan.
