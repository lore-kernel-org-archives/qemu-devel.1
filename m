Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df6uP-0003dh-Gp
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df6uM-0007v8-CH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df6uM-0007uh-64
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17479806B4
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 15:59:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720114812.GH2101@work-vm> (David Alan Gilbert's message of
	"Thu, 20 Jul 2017 12:48:12 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm>
	<20170720081005.GB23385@pxdev.xzpeter.org>
	<20170720114812.GH2101@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 17:58:55 +0200
Message-ID: <87h8xi830g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> On Wed, Jul 19, 2017 at 08:02:39PM +0100, Dr. David Alan Gilbert wrote:
>> ... here can we just do this?
>> 
>> retry:
>>     // don't take any lock, only read each p->address
>>     for (i = 0; i < multifd_send_state->count; i++) {
>>         p = &multifd_send_state->params[i];
>>         if (!p->address) {
>>             // we found one IDLE send thread
>>             break;
>>         }
>>     }
>>     if (!p) {
>>         qemu_sem_wait(&multifd_send_state->sem);
>>         goto retry;
>>     }
>>     // we switch its state, IDLE -> ACTIVE
>>     atomic_set(&p->address, address);
>>     // tell the thread to start work
>>     qemu_sem_post(&p->sem);
>> 
>> Above didn't really use any lock at all (either the per thread lock,
>> or the global lock). Would it work?
>
> I think what's there can certainly be simplified;  but also note
> that the later patch gets rid of 'address' and turns it into a count.
> My suggest was to keep the 'done' and stop using 'address' as something
> special; i.e. never write address in the thread; but I think yours might
> work as well.

I substitute the test from address == 0 to page.num == 0.

Notice that this is temporal, just to check that I am doing the things
right.  we end sending the pages here.

Later, Juan.
