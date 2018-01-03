Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWh4Y-0000zT-OT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWh4W-0000lN-3X
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:19:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWh4V-0000ky-U0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:19:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DD02356E1
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 11:18:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103102632.GJ2557@xz-mi> (Peter Xu's message of "Wed, 3 Jan
	2018 18:26:32 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-3-peterx@redhat.com>
	<87efn72the.fsf@secure.laptop> <20180103093619.GH2557@xz-mi>
	<87shbn1bv8.fsf@secure.laptop> <20180103102632.GJ2557@xz-mi>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 12:18:54 +0100
Message-ID: <87k1wz197l.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/11] migration:
 qemu_savevm_state_cleanup() in cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jan 03, 2018 at 11:21:31AM +0100, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Wed, Jan 03, 2018 at 10:15:41AM +0100, Juan Quintela wrote:
>> >> Peter Xu <peterx@redhat.com> wrote:
>> >> > Moving existing callers all into migrate_fd_cleanup().  It simplifies
>> >> > migration_thread() a bit.
>> >> >
>> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> >> 
>> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> >
>> > Thanks.
>> >
>> >> 
>> >> I am trying to see if we can call migrate_fd_cleanup() twice.  As far as
>> >> I can see, we are not doing it.  But, and it is a big but, we are not
>> >> checking that we are not calling qemu_savevm_state_cleanup() twice.  If
>> >> that happens, we can get double frees and similar.
>> >> 
>> >> I put the reviewed-by anyways, because I *think* that we are doing it
>> >> right now, and otherwise, we should make sure that we are not calling it
>> >> twice, not papering over it.
>> >> 
>> >> Once here, I have notice that we call block_cleanup_parameters() in
>> >> *three* places.  We call notifier_list_notify() on two of this places (I
>> >> can't see any good reason *why* we don't call the notifier for
>> >> migrate_fd_cancel).
>> >
>> > Indeed.
>> >
>> > IMHO we can remove two calls of block_cleanup_parameters(), only keep
>> > the one in migrate_fd_cleanup(), and remove on notifier_list_notify()
>> > in migrate_fd_error() (these can be two more patches).  What do you
>> > think?
>> 
>> I think we need to make sure that we have a function that we always
>> call at the end.  I think that we have that on migration_fd_cleanup(),
>> so put everything there should be ok, no?
>
> IMHO that's exactly what I mean, no? :)
>
> For notifier_list_notify(), it's different - I just remove the extra
> one in migrate_fd_error() because it'll be called in
> migrate_fd_cleanup() as well, which is a duplicate.

then what call the one when we do a cancel?  the one in cleanup also?

Thanks, Juan.
