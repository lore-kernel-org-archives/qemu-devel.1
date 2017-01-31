Received: from eggs.gnu.org ([2001:4830:134:3::10]:57581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYaA5-0007kK-U7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYaA4-0001At-NE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:16:01 -0500
Date: Tue, 31 Jan 2017 15:15:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170131151548.GJ2395@work-vm>
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-4-git-send-email-vsementsov@virtuozzo.com>
	<87mvegajzv.fsf@emacs.mitica>
	<7890fa87-faa1-fd99-e8c8-76b51f039ad6@virtuozzo.com>
	<20170124195334.GF2220@work-vm>
	<86b7650e-de88-e058-84cc-ce22b91eabff@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b7650e-de88-e058-84cc-ce22b91eabff@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 03/17] migration: split common postcopy out
 of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: quintela@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 24.01.2017 22:53, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > 24.01.2017 12:24, Juan Quintela wrote:
> > > > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > > > > Split common postcopy staff from ram postcopy staff.
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > > ---
> > > > >    include/migration/migration.h |  1 +
> > > > >    migration/migration.c         | 39 +++++++++++++++++++++++++++------------
> > > > >    migration/postcopy-ram.c      |  4 +++-
> > > > >    migration/savevm.c            | 31 ++++++++++++++++++++++---------
> > > > >    4 files changed, 53 insertions(+), 22 deletions(-)
> > > > > 
> > > > Hi
> > > > 
> > > > {
> > > > >        MigrationState *s;
> > > > > @@ -1587,9 +1592,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> > > > >         * need to tell the destination to throw any pages it's already received
> > > > >         * that are dirty
> > > > >         */
> > > > > -    if (ram_postcopy_send_discard_bitmap(ms)) {
> > > > > -        error_report("postcopy send discard bitmap failed");
> > > > > -        goto fail;
> > > > > +    if (migrate_postcopy_ram()) {
> > > > > +        if (ram_postcopy_send_discard_bitmap(ms)) {
> > > > > +            error_report("postcopy send discard bitmap failed");
> > > > > +            goto fail;
> > > > > +        }
> > > > I will have preffered that for the ram commands, to embed the
> > > > migrate_postocpy_ram() check inside them, but that is taste, and
> > > > everyone has its own O:-)
> > > > 
> > > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > > index e436cb2..c8a71c8 100644
> > > > > --- a/migration/savevm.c
> > > > > +++ b/migration/savevm.c
> > > > > @@ -73,7 +73,7 @@ static struct mig_cmd_args {
> > > > >        [MIG_CMD_INVALID]          = { .len = -1, .name = "INVALID" },
> > > > >        [MIG_CMD_OPEN_RETURN_PATH] = { .len =  0, .name = "OPEN_RETURN_PATH" },
> > > > >        [MIG_CMD_PING]             = { .len = sizeof(uint32_t), .name = "PING" },
> > > > > -    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = 16, .name = "POSTCOPY_ADVISE" },
> > > > > +    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = -1, .name = "POSTCOPY_ADVISE" },
> > > > >        [MIG_CMD_POSTCOPY_LISTEN]  = { .len =  0, .name = "POSTCOPY_LISTEN" },
> > > > >        [MIG_CMD_POSTCOPY_RUN]     = { .len =  0, .name = "POSTCOPY_RUN" },
> > > > >        [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
> > > > > @@ -827,12 +827,17 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
> > > > >    /* Send prior to any postcopy transfer */
> > > > >    void qemu_savevm_send_postcopy_advise(QEMUFile *f)
> > > > >    {
> > > > > -    uint64_t tmp[2];
> > > > > -    tmp[0] = cpu_to_be64(getpagesize());
> > > > > -    tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
> > > > > +    if (migrate_postcopy_ram()) {
> > > > > +        uint64_t tmp[2];
> > > > > +        tmp[0] = cpu_to_be64(getpagesize());
> > > > > +        tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
> > > > > -    trace_qemu_savevm_send_postcopy_advise();
> > > > > -    qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 16, (uint8_t *)tmp);
> > > > > +        trace_qemu_savevm_send_postcopy_advise();
> > > > > +        qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE,
> > > > > +                                 16, (uint8_t *)tmp);
> > > > > +    } else {
> > > > > +        qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 0, NULL);
> > > > > +    }
> > > > >    }
> > > > >    /* Sent prior to starting the destination running in postcopy, discard pages
> > > > I haven't yet figured out why you are reusing this command with a
> > > > different number of parameters.
> > > > For this to pass, I need that Dave comment on this.
> > > > 
> > > > So,
> > > > 
> > > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > > 
> > > > conditioned that Dave agrees with this.
> > > These parameters are unrelated if ram postcopy is disabled. So, I should be
> > > better to have a possibility of skipping them, then to send unneeded numbers
> > > and write separate code to read them from the stream (rewriting
> > > loadvm_postcopy_handle_advise to just read these two numbers and do nothing
> > > about ram postcopy for this case).
> > I think I'd prefer either a new command or keeping these fields (probably all 0 ?)
> > my worry is what happens in the case if we add a 3rd postcopy subfeature;
> > In your case we have three possibilities:
> > 
> >      a) Postcopy RAM only - 16 bytes
> >      b) Postcopy persistent-dirty-bitmap only - 0 bytes
> >      c) Both - 16 bytes
> > 
> > Lets say we added postcopy-foo in the future and it wanted to add
> > another 16 bytes, what would it send if it was foo+persistent-dirty-bitmap and no RAM?
> > We'd end up with 16 bytes sent but you'd have to be very careful
> > never to get that confused with case (a) above.
> > 
> > (I don't feel too strongly about it though)
> 
> Hmm.. Actually I use migrate_postcopy_ram() to distinct these thing in
> loadvm_postcopy_handle_advise.. And it seem like it is a mistake. Are
> migration capabilities available on target?.. On the other hand
> postcopy-test doesn't fail...

Libvirt does set it on the destination, and it's already useful for checking
the destination host has the appropriate kernel userfault support;
so I'm fine with requiring it.
However it's good where possible to fail nicely if someone doesn't set it.

Dave

> > 
> > Dave
> > 
> > > -- 
> > > Best regards,
> > > Vladimir
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
