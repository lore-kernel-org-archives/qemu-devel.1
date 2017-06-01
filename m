Received: from eggs.gnu.org ([2001:4830:134:3::10]:35235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGCo-0000td-PU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGCl-0003EH-Hh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGGCl-0003Dj-8p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E221281F01
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 02:51:17 +0000 (UTC)
Date: Thu, 1 Jun 2017 10:51:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170601025113.GB32741@pxdev.xzpeter.org>
References: <1496226934-29752-1-git-send-email-peterx@redhat.com>
	<20170531170538.GF3342@work-vm> <87efv4c1wi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efv4c1wi.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH] migration: isolate return path on src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

On Wed, May 31, 2017 at 08:33:01PM +0200, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> >> There are some places that binded "return path" with postcopy. Let's be
> >> prepared for its usage even without postcopy. This patch mainly did this
> >> on source side.
> >> 
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >> standalone patch isolated from the return path series. ok to be picked
> >> up in case one day we'll re-face the return path enablement.
> >> With it, we are ready on source side. The dst side change has been queued.
> >> ---
> >>  migration/migration.c  | 11 ++++++-----
> >>  migration/trace-events |  4 ++--
> >>  2 files changed, 8 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index ad29e53..96e549e 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1850,13 +1850,12 @@ static void migration_completion(MigrationState *s, int current_active_state,
> >>       * cleaning everything else up (since if there are no failures
> >>       * it will wait for the destination to send it's status in
> >>       * a SHUT command).
> >> -     * Postcopy opens rp if enabled (even if it's not avtivated)
> >>       */
> >> -    if (migrate_postcopy_ram()) {
> >> +    if (s->rp_state.from_dst_file) {
> >>          int rp_error;
> >> -        trace_migration_completion_postcopy_end_before_rp();
> >> +        trace_migration_return_path_end_before();
> >>          rp_error = await_return_path_close_on_source(s);
> >> -        trace_migration_completion_postcopy_end_after_rp(rp_error);
> >> +        trace_migration_return_path_end_after(rp_error);
> >>          if (rp_error) {
> >>              goto fail_invalidate;
> >>          }
> >> @@ -1931,13 +1930,15 @@ static void *migration_thread(void *opaque)
> >>  
> >>      qemu_savevm_state_header(s->to_dst_file);
> >>  
> >> -    if (migrate_postcopy_ram()) {
> >> +    if (s->to_dst_file) {
> >>          /* Now tell the dest that it should open its end so it can reply */
> >>          qemu_savevm_send_open_return_path(s->to_dst_file);
> >>  
> >>          /* And do a ping that will make stuff easier to debug */
> >>          qemu_savevm_send_ping(s->to_dst_file, 1);
> >
> > I'm confused.
> > The migration_thread on the source will always have a s->to_dst_file
> > there so why test?
> >
> > But also, we can't send the 'open return path' and 'send ping' messages
> > without a guard; sending them to old QEMUs will cause them to fail when
> > they don't know what the message is.   I suspect sending them to
> > slightly-old QEMUs will cause them to fail when they try and send a 
> > return message if the destination can't send it.
> >
> > I can see a  if (s->rp_state.from_dst_file) making some sense if it's
> > done at the right point.
> 
> You are right.
> 
> Second chunk makes no sense.  I told Peter to split the
> "objectification" of migration state and this patch.  This made more
> sense when the user *had* required a return path.

Oops! I believe it should be what Dave mentioned
(s->rp_state.from_dst_file rather than s->to_dst_file). Sorry!

I'll repost to see whether we'd like the new one. Thanks,

-- 
Peter Xu
