Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcup-0001JC-KM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcum-0003SJ-Et
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:13:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdcum-0003R5-8y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:13:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CBAB3D956
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:13:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com> (Paolo
	Bonzini's message of "Tue, 14 Feb 2017 13:57:31 +0100")
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
	<bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Feb 2017 14:12:53 +0100
Message-ID: <8760kc531m.fsf@emacs.mitica>
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
> On 13/02/2017 18:19, Juan Quintela wrote:
>> +        qemu_sem_init(&p->init, 0);
>>          p->quit = false;
>> +        p->c = socket_send_channel_create();
>> +        if (!p->c) {
>> +            error_report("Error creating a send channel");
>> +            exit(0);
>> +        }
>>          snprintf(thread_name, 15, "multifd_send_%d", i);
>>          qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
>>                             QEMU_THREAD_JOINABLE);
>> +        qemu_sem_wait(&p->init);
>
> Why do you need p->init here?  Could initialization proceed in parallel
> for all the threads?

We need to make sure that the send thread number 2 goes to thread number
2 on destination.  Yes, we could do a more complicated algorithm, but we
really care so much about this initialization time?

Later, Juan.
