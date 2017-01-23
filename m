Received: from eggs.gnu.org ([2001:4830:134:3::10]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cViDh-0001xC-NJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cViDg-0004PO-QB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:15:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cViDg-0004P1-Kz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:15:52 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D51CE6445B
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 17:15:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161026184326.GH6456@work-vm> (David Alan Gilbert's message of
	"Wed, 26 Oct 2016 19:43:26 +0100")
References: <1477078935-7182-1-git-send-email-quintela@redhat.com>
	<1477078935-7182-6-git-send-email-quintela@redhat.com>
	<20161026184326.GH6456@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 23 Jan 2017 18:15:49 +0100
Message-ID: <87fuk9bsu2.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/13] migration: create multifd migration
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Creation of the threads, nothing inside yet.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> +void migrate_multifd_send_threads_join(void)
>> +{
>> +    int i, thread_count;
>> +
>> +    if (!migrate_multifd()){
>
> You've missed the space prior to the  { (and then copied
> it everywhere in this patch).

Fixed.  As guessed, copy & paste O:-)


>> +    thread_count = migrate_multifd_threads();
>> +    multifd_send = g_new0(MultiFDSendParams, thread_count);
>> +    for (i = 0; i < thread_count; i++) {
>> +        qemu_mutex_init(&multifd_send[i].mutex);
>> +        qemu_cond_init(&multifd_send[i].cond);
>> +        multifd_send[i].quit = false;
>> +        qemu_thread_create(&multifd_send[i].thread, "multifd_send",
>
> You could make the name of the thread include the thread number,
> that way you could easily see in top if any one of the threads
> was getting particularly busy (although be careful with the length
> I think linux will ignore the name if it's over 14 characters).

Until 99 thread will be show correctly :p
