Received: from eggs.gnu.org ([2001:4830:134:3::10]:48038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cddIZ-0004r9-K8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cddIU-0003SL-Ne
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cddIU-0003Rd-Ic
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:34 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75A958047B
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:37:34 +0000 (UTC)
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
	<bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com>
	<8760kc531m.fsf@emacs.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48bf2df3-49e4-00bc-1cc4-e44eda1039b8@redhat.com>
Date: Tue, 14 Feb 2017 14:37:34 +0100
MIME-Version: 1.0
In-Reply-To: <8760kc531m.fsf@emacs.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com



On 14/02/2017 14:12, Juan Quintela wrote:
>> On 13/02/2017 18:19, Juan Quintela wrote:
>>> +        qemu_sem_init(&p->init, 0);
>>>          p->quit = false;
>>> +        p->c = socket_send_channel_create();
>>> +        if (!p->c) {
>>> +            error_report("Error creating a send channel");
>>> +            exit(0);
>>> +        }
>>>          snprintf(thread_name, 15, "multifd_send_%d", i);
>>>          qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
>>>                             QEMU_THREAD_JOINABLE);
>>> +        qemu_sem_wait(&p->init);
>> Why do you need p->init here?  Could initialization proceed in parallel
>> for all the threads?
>
> We need to make sure that the send thread number 2 goes to thread number
> 2 on destination.  Yes, we could do a more complicated algorithm, but we
> really care so much about this initialization time?

I was wondering if p->init was needed in general, so it would simplify.
But without a design document I cannot really understand the logic---as
I said, I don't really grok the need for RAM_SAVE_FLAG_MULTIFD_PAGE.

Paolo
