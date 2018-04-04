Received: from eggs.gnu.org ([2001:4830:134:3::10]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3Xid-0002r5-Cc
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3XiY-0007XX-I6
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3XiY-0007XN-CM
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:06 -0400
Date: Wed, 4 Apr 2018 09:59:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180404015953.GH26441@xz-mi>
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
	<20180403061040.GD26441@xz-mi>
	<4b9793192f7007913e7fb9bb210524fb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b9793192f7007913e7fb9bb210524fb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bala24 <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

On Tue, Apr 03, 2018 at 11:00:00PM +0530, bala24 wrote:
> On 2018-04-03 11:40, Peter Xu wrote:
> > On Sun, Apr 01, 2018 at 12:25:36AM +0530, Balamuruhan S wrote:
> > > expected_downtime value is not accurate with dirty_pages_rate *
> > > page_size,
> > > using ram_bytes_remaining would yeild it correct.
> > > 
> > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > ---
> > >  migration/migration.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 58bd382730..4e43dc4f92 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2245,8 +2245,7 @@ static void
> > > migration_update_counters(MigrationState *s,
> > >       * recalculate. 10000 is a small enough number for our purposes
> > >       */
> > >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > > -        s->expected_downtime = ram_counters.dirty_pages_rate *
> > > -            qemu_target_page_size() / bandwidth;
> > > +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
> > 
> > This field was removed in e4ed1541ac ("savevm: New save live migration
> > method: pending", 2012-12-20), in which remaing RAM was used.
> > 
> > And it was added back in 90f8ae724a ("migration: calculate
> > expected_downtime", 2013-02-22), in which dirty rate was used.
> > 
> > However I didn't find a clue on why we changed from using remaining
> > RAM to using dirty rate...  So I'll leave this question to Juan.
> > 
> > Besides, I'm a bit confused on when we'll want such a value.  AFAIU
> > precopy is mostly used by setting up the target downtime before hand,
> > so we should already know the downtime before hand.  Then why we want
> > to observe such a thing?
> 
> Thanks Peter Xu for reviewing,
> 
> I tested precopy migration with 16M hugepage backed ppc guest and
> granularity
> of page size in migration is 4K so any page dirtied would result in 4096
> pages
> to be transmitted again, this led for migration to continue endless,
> 
> default migrate_parameters:
> downtime-limit: 300 milliseconds
> 
> info migrate:
> expected downtime: 1475 milliseconds
> 
> Migration status: active
> total time: 130874 milliseconds
> expected downtime: 1475 milliseconds
> setup: 3475 milliseconds
> transferred ram: 18197383 kbytes
> throughput: 866.83 mbps
> remaining ram: 376892 kbytes
> total ram: 8388864 kbytes
> duplicate: 1678265 pages
> skipped: 0 pages
> normal: 4536795 pages
> normal bytes: 18147180 kbytes
> dirty sync count: 6
> page size: 4 kbytes
> dirty pages rate: 39044 pages
> 
> In order to complete migration I configured downtime-limit to 1475
> milliseconds but still migration was endless. Later calculated expected
> downtime by remaining ram 376892 Kbytes / 866.83 mbps yeilded 3478.34
> milliseconds and configuring it as downtime-limit succeeds the migration
> to complete. This led to the conclusion that expected downtime is not
> accurate.

Hmm, thanks for the information.  I'd say your calculation seems
reasonable to me: it shows how long time will it need if we stop the
VM now on source immediately and migrate the rest. However Juan might
have an explanation on existing algorithm which I would like to know
too. So still I'll put aside the "which one is better" question.

For your use case, you can have a look on either of below way to
have a converged migration:

- auto-converge: that's a migration capability that throttles CPU
  usage of guests

- postcopy: that'll let you start the destination VM even without
  transferring all the RAMs before hand

Either of the technique can be configured via "migrate_set_capability"
HMP command or "migrate-set-capabilities" QMP command (some googling
would show detailed steps). And, either of above should help you to
migrate successfully in this hard-to-converge scenario, instead of
your current way (observing downtime, set downtime).

Meanwhile, I'm thinking whether instead of observing the downtime in
real time, whether we should introduce a command to stop the VM
immediately to migrate the rest when we want, or, a new parameter to
current "migrate" command.

-- 
Peter Xu
