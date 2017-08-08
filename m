Received: from eggs.gnu.org ([2001:4830:134:3::10]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2t1-0002Os-Sw
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2sx-0007Ns-0h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df2sw-0007NB-QR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96706C0587D3
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:41:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720102244.GF23385@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 20 Jul 2017 18:22:44 +0800")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-14-quintela@redhat.com>
	<20170720102244.GF23385@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 13:41:13 +0200
Message-ID: <8760dy9tie.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 13/17] migration: Create thread
 infrastructure for multifd recv side
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
> On Mon, Jul 17, 2017 at 03:42:34PM +0200, Juan Quintela wrote:

>> +static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
>> +{
>> +    int thread_count;
>> +    MultiFDRecvParams *p;
>> +    static multifd_pages_t pages;
>> +    static bool once;
>> +
>> +    if (!once) {
>> +        multifd_init_group(&pages);
>> +        once = true;
>> +    }
>> +
>> +    pages.iov[pages.num].iov_base = address;
>> +    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
>> +    pages.num++;
>> +
>> +    if (fd_num == UINT16_MAX) {
>
> (so this check is slightly mistery as well if we don't define
>  something... O:-)

It means that we continue sending pages on the same "group".  Will add a
comment.

>
>> +        return;
>> +    }
>> +
>> +    thread_count = migrate_multifd_threads();
>> +    assert(fd_num < thread_count);
>> +    p = multifd_recv_state->params[fd_num];
>> +
>> +    qemu_sem_wait(&p->ready);
>
> Shall we check for p->pages.num == 0 before wait? What if the
> corresponding thread is already finished its old work and ready?

this is a semaphore, not a condition variable.  We only use it with
values 0 and 1.  We only wait if the other thread hasn't done the post,
if it has done the post, the wait don't have to wait. (no, I didn't
invented the semaphore names).

>> +
>> +    qemu_mutex_lock(&p->mutex);
>> +    p->done = false;
>> +    iov_copy(p->pages.iov, pages.num, pages.iov, pages.num, 0,
>> +             iov_size(pages.iov, pages.num));
>
> Question: any reason why we don't use the same for loop in
> multifd-send codes, and just copy the IOVs in that loop? (offset is
> always zero, and we are copying the whole thing after all)

When I found the function, I only remembered to change one of the
loops.  Nice catch.

Later, Juan.
