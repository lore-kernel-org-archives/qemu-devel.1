Received: from eggs.gnu.org ([2001:4830:134:3::10]:48282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZdV-0000qs-3L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZdQ-0004Py-2U
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:42:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVZdP-0004Pp-Ty
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E18D805A531
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:42:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180620090127.GB2549@work-vm> (David Alan Gilbert's message of
	"Wed, 20 Jun 2018 10:01:28 +0100")
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-12-quintela@redhat.com>
	<20180611164516.GI2661@work-vm> <87d0wlyle1.fsf@secure.mitica>
	<20180620090127.GB2549@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 20 Jun 2018 11:42:35 +0200
Message-ID: <87r2l1lrp0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v13 11/12] migration: Remove not needed
 semaphore and quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> > * Juan Quintela (quintela@redhat.com) wrote:
>> >> We know quit closing the QIO.
>> >
>> > This patch does two different things; one of which I think I understand.
>> >
>> > The 'quit' has been removed - I think that makes sense because the
>> > multifd threads terminate when either they come to the end of a stream
>> > or hit an error; there's no case of asking them to quit explicitly.
>> > The 'sem' was basically for kicking the recv-thread to quit; which again
>> > isn't needed.
>> >
>> > Now, what about the object_unref on p->c ?
>> > If I've got this right multifd_recv_terminate_threads is only called in
>> > the error case; but doesn't multifd_load_cleanup also get called in that
>> > case - it does the unref and p->c = NULL as well.
>> 
>> Adding another comment O:-)
>> 
>> In normal exit case: we don't care.
>> 
>> In error case, we do a close of the p->c.  Doing a close, means that the
>> channel threads that are waiting on qio_channel_read_all_eof() will stop
>> the waiting and return an error, so we are safe.
>> 
>>         ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>>                                        p->packet_len, &local_err);
>>         if (ret == 0) {   /* EOF */
>>             break;
>>         }
>>         if (ret == -1) {   /* Error */
>>             break;
>>         }
>> 
>> We have to wait for three things:
>> - we receive a synchronization packet
>> - we receive EOF and finish
>> - we got somehow an error and have to quit.
>> 
>> Old versions have a semaphore, and we have three places where we set
>> that semaphore "we are ready", when we receive one error, when we have
>> data waiting to be read (it had a qio whatcher) or we just got a normal
>> exit.
>> 
>> Waiting on two things make code more complex that it used to be (and
>> whatchers are really lame, because we know there are data ready, but not
>> how much, dealing with non-whole packets/pages is a real mess).  So we
>> moved to:
>> -  quit is gone: we just close the channel, that makes the *_read_eof()
>>    to end.  Notice that we don't care if the close is due to one error
>>    or because we have finished.  It is just done.
>> - Now reception channel only have to wait on _read_eof(), the three
>>   cases that we talked before are handled correctly.
>> 
>> I understand the confusion, this only makes sense when you came from the
>> previous version of the patchset.
>
> Two questions from that then:
>   a) Are you sure it's safe to close the qio_channel while another
> thread is in qio_channel_read_all_eof?  Is it really defined that it
> causes the other thread to exit with an error;  close() in some stuff
> frees data structures that the other thread is still reading; that's
> why I've used shutdown(2) in the past rather than close on fd's

Dunno if it is safe (I think it is), but I agree that shutdown will also
get what I need.

>   b) I don't think your answer explains why it's an object_unref?

That is the standard way to closing qios to not have to take into
account who have it oppened.  See previous paragraph, it is better to
use shutdown, done.

Thanks, Juan.

> Dave
>
>> Later, Juan.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
