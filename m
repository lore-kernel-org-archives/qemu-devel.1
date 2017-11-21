Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHDhL-0007IM-GI
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHDhH-0003st-Jq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:55:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eHDhH-0003sY-B2
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:55:03 -0500
Date: Tue, 21 Nov 2017 18:54:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171121185457.GA2913@work-vm>
References: <20171110203516.17027-1-danielhb@linux.vnet.ibm.com>
	<87vai3pj9e.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vai3pj9e.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v1] migration/ram.c: do not set
 'postcopy_running' in POSTCOPY_INCOMING_END
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

* Juan Quintela (quintela@redhat.com) wrote:
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
> > When migrating a VM with 'migrate_set_capability postcopy-ram on'
> > a postcopy_state is set during the process, ending up with the
> > state POSTCOPY_INCOMING_END when the migration is over. This
> > postcopy_state is taken into account inside ram_load to check
> > how it will load the memory pages. This same ram_load is called when
> > in a loadvm command.
> >
> > Inside ram_load, the logic to see if we're at postcopy_running state
> > is:
> >
> > postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING
> >
> > postcopy_state_get() returns this enum type:
> >
> > typedef enum {
> >     POSTCOPY_INCOMING_NONE = 0,
> >     POSTCOPY_INCOMING_ADVISE,
> >     POSTCOPY_INCOMING_DISCARD,
> >     POSTCOPY_INCOMING_LISTENING,
> >     POSTCOPY_INCOMING_RUNNING,
> >     POSTCOPY_INCOMING_END
> > } PostcopyState;
> >
> > In the case where ram_load is executed and postcopy_state is
> > POSTCOPY_INCOMING_END, postcopy_running will be set to 'true' and
> > ram_load will behave like a postcopy is in progress. This scenario isn't
> > achievable in a migration but it is reproducible when executing
> > savevm/loadvm after migrating with 'postcopy-ram on', causing loadvm
> > to fail with Error -22:
> >
> > Source:
> >
> > (qemu) migrate_set_capability postcopy-ram on
> > (qemu) migrate tcp:127.0.0.1:4444
> >
> > Dest:
> >
> > (qemu) migrate_set_capability postcopy-ram on
> > (qemu)
> > ubuntu1704-intel login:
> > Ubuntu 17.04 ubuntu1704-intel ttyS0
> >
> > ubuntu1704-intel login: (qemu)
> > (qemu) savevm test1
> > (qemu) loadvm test1
> > Unknown combination of migration flags: 0x4 (postcopy mode)
> > error while loading state for instance 0x0 of device 'ram'
> > Error -22 while loading VM state
> > (qemu)
> >
> > This patch fixes this problem by changing a bit the semantics
> > of postcopy_running inside ram_load, verifying first if
> > we're not in the POSTCOPY_INCOMING_END state. In this case,
> > postcopy_running is set to 'false'.
> >
> > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> queued

Wrong version; v3 is:

http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg03188.html

Dave

> > ---
> >  migration/ram.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 8620aa400a..43ed719668 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2803,13 +2803,21 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >      int flags = 0, ret = 0, invalid_flags = 0;
> >      static uint64_t seq_iter;
> >      int len = 0;
> > -    /*
> > -     * If system is running in postcopy mode, page inserts to host memory must
> > -     * be atomic
> > -     */
> > -    bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
> > -    /* ADVISE is earlier, it shows the source has the postcopy capability on */
> > -    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
> > +    bool postcopy_advised = false, postcopy_running = false;
> > +    uint8_t postcopy_state = postcopy_state_get();
> > +
> > +    if (postcopy_state != POSTCOPY_INCOMING_END) {
> > +        /*
> > +         * If system is running in postcopy mode, page inserts to host memory
> > +         * must be atomic
> > +         */
> > +        postcopy_running = postcopy_state >= POSTCOPY_INCOMING_LISTENING;
> > +
> > +        /* ADVISE is earlier, it shows the source has the postcopy
> > +         * capability on
> > +         */
> > +        postcopy_advised = postcopy_state >= POSTCOPY_INCOMING_ADVISE;
> > +    }
> >  
> >      seq_iter++;
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
