Received: from eggs.gnu.org ([2001:4830:134:3::10]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUYjc-0002lo-Gk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUYjY-0000mN-IT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUYjY-0000lE-93
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7348916C4
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:28:14 +0000 (UTC)
Date: Mon, 10 Jul 2017 14:28:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170710132805.GB16073@work-vm>
References: <20170628095228.4661-1-quintela@redhat.com>
	<20170628095228.4661-4-quintela@redhat.com>
	<20170628111504.GC2130@work-vm> <87d19o5njl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d19o5njl.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] migration: Create
 load_setup()/cleanup() methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We need to do things at load time and at cleanup time.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> --
> >> 
> >> Move the printing of the error message so we can print the device
> >> giving the error.
> >> Add call to postcopy stuff
> >> ---
> >>  include/migration/register.h |  2 ++
> >>  migration/savevm.c           | 45 +++++++++++++++++++++++++++++++++++++++++++-
> >>  migration/savevm.h           |  1 +
> >>  migration/trace-events       |  2 ++
> >>  4 files changed, 49 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/include/migration/register.h b/include/migration/register.h
> >> index 938ea2b..a0f1edd 100644
> >> --- a/include/migration/register.h
> >> +++ b/include/migration/register.h
> >> @@ -39,6 +39,8 @@ typedef struct SaveVMHandlers {
> >>                                uint64_t *non_postcopiable_pending,
> >>                                uint64_t *postcopiable_pending);
> >>      LoadStateHandler *load_state;
> >> +    int (*load_setup)(QEMUFile *f, void *opaque);
> >> +    int (*load_cleanup)(void *opaque);
> >>  } SaveVMHandlers;
> >>  
> >>  int register_savevm_live(DeviceState *dev,
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index fee11c5..fdd15fa 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -1541,7 +1541,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >>       * got a bad migration state).
> >>       */
> >>      migration_incoming_state_destroy();
> >> -
> >> +    qemu_loadvm_state_cleanup();
> >
> > Is that order right? It seems wrong to call the cleanup
> > code after MIS is destroyed.
> > (The precopy path seems to call mis_destroy at the end of
> > process_incoming_migration_bh which is much later).
> 
> we can do either way, for now it don't matters.

OK, yes, for now it doesn't matter, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> Once there, it got me thinking that we are doing things in a very
> "interesting" way on the incoming side:
> 
> (postcopy)
> 
> postcopy_ram_incoming_cleanup()
> migration_incoming_state_destroy()
> qemu_loadvm_state_cleanup()
> 
> (Ok, probably it is better to exchange the last two).
> 
> But I *think* that we should move the postcopy_ram_incoming_cleanup()
> inside ram_load_cleanup(), no?
> 
> And we don't have a postcopy_ram_incoming_setup() We could put there the
> mmap of mis->postcopy_tmp_zero_page and mis->largest_page_size, no?
> 
> I am trying to understand if the postcopy_ram_incoming_init() can be
> moved soon, but I think no.
> 
> Later, Juan.
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
