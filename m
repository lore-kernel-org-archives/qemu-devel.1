Received: from eggs.gnu.org ([2001:4830:134:3::10]:52749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewkxe-0007JU-KD
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewkxb-0005e2-Er
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:43:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewkxb-0005cp-AC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92417402277A
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 08:43:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180316030722.GA2477@xz-mi> (Peter Xu's message of "Fri, 16 Mar
	2018 11:07:22 +0800")
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-20-quintela@redhat.com>
	<20180312091913.GG5234@xz-mi> <878tata431.fsf@secure.mitica>
	<20180316030722.GA2477@xz-mi>
Reply-To: quintela@redhat.com
Date: Fri, 16 Mar 2018 09:43:46 +0100
Message-ID: <87muz8s94t.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 19/24] migration: Create multifd
 channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 15, 2018 at 01:57:54PM +0100, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Wed, Mar 07, 2018 at 12:00:05PM +0100, Juan Quintela wrote:
>> >> In both sides.  We still don't transmit anything through them.
>> >
>> > s/In/On/?

>> >> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>> >> +{
>> >> +    MultiFDSendParams *p = opaque;
>> >> +    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>> >> +    Error *local_err = NULL;
>> >> +
>> >> +    if (qio_task_propagate_error(task, &local_err)) {
>> >> +        if (multifd_save_cleanup(&local_err) != 0) {
>> >
>> > Do we need to call multifd_save_cleanup() explicitly here?
>> 
>> Is the easiest way of stoping all multifd threads, no?
>
> Yeah, but again, I thought it would be called later too, since...

But we are not stopping the threads.  Only if you preffer to call there
terminate_multifd_send_threads().  Probably it is better to call
terminate_multifd_send_threads(), it is what we do on the rest of
errors.

Changing it.

>> > Asked since I saw that it would also be called in migrate_fd_cleanup(),
>> > and it seems that we should call migrate_fd_cleanup() soon too when
>> > this happens?
>> 
>> We need to stop migraiton. thtat migrate_set_error() is only used for
>> reporting in info migrate, it is not acted upon.
>> 
>> Yes, perhaps it should, but as it is, it is not.  So, I think it is
>> right O:-)
>
> ... after Dave's 688a3dcba9 ("migration: Route errors down through
> migration_channel_connect", 2018-02-06), all these channel errors
> should finally be routed to migrate_fd_connect(), and in that we have:
>
> void migrate_fd_connect(MigrationState *s, Error *error_in)
> {
>     s->expected_downtime = s->parameters.downtime_limit;
>     s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
>     if (error_in) {
>         migrate_fd_error(s, error_in);
>         migrate_fd_cleanup(s);
>         return;
>     }
>     ...
> }
>
> Then, in migrate_fd_cleanup() we have multifd_save_cleanup().  That's
> why I thought we can skip the cleanup here since after all we'll do it
> in other places (and we can keep the cleanup code unified).

Ok, it is better, changing to terminate_multifd_send_threads.

Thanks, Juan.
