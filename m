Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFyBd-0006LU-04
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFyBZ-0004TM-2W
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFyBY-0004TA-Sq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C874C8123D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:36:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170531073133.GF14845@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 31 May 2017 15:31:33 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-5-git-send-email-peterx@redhat.com>
	<871sr6finw.fsf@secure.mitica>
	<20170531073133.GF14845@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 31 May 2017 09:36:48 +0200
Message-ID: <87vaohcwa7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> On Tue, May 30, 2017 at 05:50:27PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > We were do the shutting off only for postcopy. Now we do this as long as
>> > the source return path is there.
>> >
>> > Moving the cleanup of from_src_file there too.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/migration.c    | 8 +++++++-
>> >  migration/postcopy-ram.c | 1 -
>> >  2 files changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 92617fc..a4006b4 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -131,10 +131,17 @@ void migration_incoming_state_destroy(void)
>> >      struct MigrationIncomingState *mis = migration_incoming_get_current();
>> >  
>> >      if (mis->to_src_file) {
>> > +        /* Tell source that we are done */
>> > +        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
>> 
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> 
>> 
>> I think this one belongs to previous patch (with accompaining line from below).
>> But just if you want to change it.
>
> I separated it since these two patches were actually doing different
> things:
>
> - previous patch fixed one possible leak, while
>
> - this patch postponed MIG_RP_MSG_SHUT a bit to the end, and let it
>   not depending on postcopy, but the return path itself (so that we
>   can enable the return path even without postcopy then)
>
> Meanwhile, there might be problem if we just put this single line into
> previous patch, since this line depends on below change [1]
> (from_src_file should better be closed after this
> qemu_file_get_error() call). So... I would still prefer to separate
> them using current way. Even if we really want to merge them, I would
> prefer directly squashing current patch into previous one.

ok, it is up to you.
