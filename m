Received: from eggs.gnu.org ([2001:4830:134:3::10]:54416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cddWj-0003Gb-Rn
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cddWf-0002gl-V1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:52:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cddWf-0002fx-Ol
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:52:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB6463D941
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:52:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <48bf2df3-49e4-00bc-1cc4-e44eda1039b8@redhat.com> (Paolo
	Bonzini's message of "Tue, 14 Feb 2017 14:37:34 +0100")
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
	<bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com>
	<8760kc531m.fsf@emacs.mitica>
	<48bf2df3-49e4-00bc-1cc4-e44eda1039b8@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Feb 2017 14:52:02 +0100
Message-ID: <87wpcs3mnx.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 14/02/2017 14:12, Juan Quintela wrote:
>>> On 13/02/2017 18:19, Juan Quintela wrote:
>>>> +        qemu_sem_init(&p->init, 0);
>>>>          p->quit = false;
>>>> +        p->c = socket_send_channel_create();
>>>> +        if (!p->c) {
>>>> +            error_report("Error creating a send channel");
>>>> +            exit(0);
>>>> +        }
>>>>          snprintf(thread_name, 15, "multifd_send_%d", i);
>>>>          qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
>>>>                             QEMU_THREAD_JOINABLE);
>>>> +        qemu_sem_wait(&p->init);
>>> Why do you need p->init here?  Could initialization proceed in parallel
>>> for all the threads?
>>
>> We need to make sure that the send thread number 2 goes to thread number
>> 2 on destination.  Yes, we could do a more complicated algorithm, but we
>> really care so much about this initialization time?
>
> I was wondering if p->init was needed in general, so it would simplify.
> But without a design document I cannot really understand the logic---as
> I said, I don't really grok the need for RAM_SAVE_FLAG_MULTIFD_PAGE.

will get some general documentation in /doc/.

Basically what we had on the only stream was:


{[page header][page]}+


And we moved to:

{[page header]+[where to receive]}: on the principal stream

[page]+: on the rest of the multifd

All nicely aligned and so.

My understanding is that we could optimize the receiving with splice to
not even touch userspace? (that part is not done).  That was the reason
why I didn't want to put header's footers there.  As the headers are so
small compared with the pages payload, the transmission of them should
be lost on the noise, no?

Later, Juan.
