Received: from eggs.gnu.org ([2001:4830:134:3::10]:33154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d2tNm-0003Xp-U6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d2tNi-0008Oi-0C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:51:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:17888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d2tNh-0008MT-NE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:51:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OOY0000CAXGSO10@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:51:16 +0100 (BST)
Date: Tue, 25 Apr 2017 08:51:13 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170425055113.GA18016@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170424172630.GO2362@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p28f240a4e6c78fb56be52f2641c3e5af6@eucas1p2.samsung.com>
	<1492175840-5021-6-git-send-email-a.perevalov@samsung.com>
	<20170424172630.GO2362@work-vm>
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: send postcopy downtime back
 to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org

On Mon, Apr 24, 2017 at 06:26:31PM +0100, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > Right now to initiate postcopy live migration need to
> > send request to source machine and specify destination.
> > 
> > User could request migration status by query-migrate qmp command on
> > source machine, but postcopy downtime is being evaluated on destination,
> > so it should be transmitted back to source. For this purpose return path
> > socket was shosen.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> 
> That will break a migration from an older QEMU to a newer QEMU with this feature
> since the old QEMU won't know the message type and fail with a
>   'Received invalid message'
> 
> near the start of source_return_path_thread.
> 
> The simpler solution is to let the stat be read on the destination side
> and not bother sending it backwards over the wire.
Yes, the simplest solution was just to trace_ it. And in this patch set,
I'll keep it.

Looks like, yes, current code couldn't just skip unknown header_type.
Mmm, binary protocol and it have to know the *length*, and length is not
transmitted with header_type, it's hard coded per header type. So
MIG_RP_MSG isn't scalable.
BTW, are you going to replace that protocol in the future?
I think it's even possible to keep MIG_RP_MSG protocol as is, but just
need to send before RP opening an RP_METADATE, header_type and field length,
in the first approximation. But, again, old QEMU will not know about
RP_METADATA and will fail. Or json based, I had coming across on json based encapsulation
for devices.


As a total alternative, I could suggest to send request every time user
request query-migration on src, but in this case MigrationIncomingState
should live forever.

> 
> Dave
> 
> > ---
> >  include/migration/migration.h |  4 +++-
> >  migration/migration.c         | 20 ++++++++++++++++++--
> >  migration/postcopy-ram.c      |  1 +
> >  3 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index 5d2c628..5535aa6 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -55,7 +55,8 @@ enum mig_rp_message_type {
> >  
> >      MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
> >      MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
> > -
> > +    MIG_RP_MSG_DOWNTIME,    /* downtime value from destination,
> > +                               calculated and sent in case of post copy */
> >      MIG_RP_MSG_MAX
> >  };
> >  
> > @@ -364,6 +365,7 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
> >                            uint32_t value);
> >  void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
> >                                ram_addr_t start, size_t len);
> > +void migrate_send_rp_downtime(MigrationIncomingState *mis, uint64_t downtime);
> >  
> >  void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
> >  void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5bac434..3134e24 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -553,6 +553,19 @@ void migrate_send_rp_message(MigrationIncomingState *mis,
> >  }
> >  
> >  /*
> > + * Send postcopy migration downtime,
> > + * at the moment of calling this function migration should
> > + * be completed.
> > + */
> > +void migrate_send_rp_downtime(MigrationIncomingState *mis, uint64_t downtime)
> > +{
> > +    uint64_t buf;
> > +
> > +    buf = cpu_to_be64(downtime);
> > +    migrate_send_rp_message(mis, MIG_RP_MSG_DOWNTIME, sizeof(downtime), &buf);
> > +}
> > +
> > +/*
> >   * Send a 'SHUT' message on the return channel with the given value
> >   * to indicate that we've finished with the RP.  Non-0 value indicates
> >   * error.
> > @@ -1483,6 +1496,7 @@ static struct rp_cmd_args {
> >      [MIG_RP_MSG_PONG]           = { .len =  4, .name = "PONG" },
> >      [MIG_RP_MSG_REQ_PAGES]      = { .len = 12, .name = "REQ_PAGES" },
> >      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
> > +    [MIG_RP_MSG_DOWNTIME]       = { .len =  8, .name = "DOWNTIME" },
> >      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
> >  };
> >  
> > @@ -1613,6 +1627,10 @@ static void *source_return_path_thread(void *opaque)
> >              migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len);
> >              break;
> >  
> > +        case MIG_RP_MSG_DOWNTIME:
> > +            ms->downtime = ldq_be_p(buf);
> > +            break;
> > +
> >          default:
> >              break;
> >          }
> > @@ -1677,7 +1695,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> >      int ret;
> >      QIOChannelBuffer *bioc;
> >      QEMUFile *fb;
> > -    int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >      bool restart_block = false;
> >      migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > @@ -1779,7 +1796,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> >       */
> >      ms->postcopy_after_devices = true;
> >      notifier_list_notify(&migration_state_notifiers, ms);
> > -    ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
> >  
> >      qemu_mutex_unlock_iothread();
> >  
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index ea89f4e..42330fd 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -330,6 +330,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
> >      }
> >  
> >      postcopy_state_set(POSTCOPY_INCOMING_END);
> > +    migrate_send_rp_downtime(mis, get_postcopy_total_downtime());
> >      migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
> >  
> >      if (mis->postcopy_tmp_page) {
> > -- 
> > 1.8.3.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

-- 

BR
Alexey
