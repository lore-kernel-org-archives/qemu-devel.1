Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAFkp-0002dr-Ba
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAFkk-00036u-CV
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAFkk-00036n-57
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 583BA13AA1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:09:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170515130202.GG2089@work-vm> (David Alan Gilbert's message of
	"Mon, 15 May 2017 14:02:03 +0100")
References: <20170503104257.5127-1-dgilbert@redhat.com>
	<87pofpizmj.fsf@secure.mitica> <20170515130202.GG2089@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 15:09:29 +0200
Message-ID: <8737c6fera.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com, kashyap@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > Many users now prefer to use drive_mirror over NBD as an
>> > alternative to the older migrate -b option; drive_mirror is
>> > more complex to setup but gives you more options (e.g. only
>> > migrating some of the disks if some of them are shared).
>> >
>> > Allow the large chunk of block migration code to be compiled
>> > out for those who don't use it.
>> >
>> > Based on a downstream-patch we've had for a while by Jeff Cody.
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> 
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 353f2728cf..ffce72aabc 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -692,6 +692,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>> >  
>> >          populate_ram_info(info, s);
>> >  
>> > +#ifdef CONFIG_LIVE_BLOCK_MIGRATION
>> >          if (blk_mig_active()) {
>> >              info->has_disk = true;
>> >              info->disk = g_malloc0(sizeof(*info->disk));
>> > @@ -699,6 +700,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>> >              info->disk->remaining = blk_mig_bytes_remaining();
>> >              info->disk->total = blk_mig_bytes_total();
>> >          }
>> > +#endif
>> 
>> I think it can be cleaner to move this inside block.c and just export a
>> function that is empty in case it is compiled out, but that it is just
>> me, so you got the revieweb by anyways.
>> 
>> >          }
>> >      }
>> >  
>> > +#ifdef CONFIG_LIVE_BLOCK_MIGRATION
>> >      blk_mig_init();
>> > +#endif
>> >      ram_mig_init();
>> >  
>> >      /* If the currently selected machine wishes to override the units-per-bus
>> 
>> Same here, I preffer the ifdef in the header than here.
>
> OK, done I've now got the block.h header having:
> #ifdef CONFIG_LIVE_BLOCK_MIGRATION
> void blk_mig_init(void);
> int blk_mig_active(void);
> uint64_t blk_mig_bytes_transferred(void);
> uint64_t blk_mig_bytes_remaining(void);
> uint64_t blk_mig_bytes_total(void);
>
> #else
> static inline void blk_mig_init(void) { };
> static inline int blk_mig_active(void)
> {
>     return false;
> }
> static inline uint64_t blk_mig_bytes_transferred(void)
> {
>     return 0;
> }
>
> static inline uint64_t blk_mig_bytes_remaining(void)
> {
>     return 0;
> }
>
> static inline uint64_t blk_mig_bytes_total(void)
> {
>     return 0;
> }
> #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
>
> Dave

good for me.  Thanks.
