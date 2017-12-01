Received: from eggs.gnu.org ([2001:4830:134:3::10]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoLW-0006ym-3X
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoLR-0005D3-3V
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKoLQ-0005C0-S5
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:21 -0500
Date: Fri, 1 Dec 2017 17:30:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201093046.GE2712@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-9-peterx@redhat.com>
	<20171130121357.GD2248@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130121357.GD2248@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 08/32] migration: allow send_rq to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Nov 30, 2017 at 12:13:57PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > We will not allow failures to happen when sending data from destination
> > to source via the return path. However it is possible that there can be
> > errors along the way.  This patch allows the migrate_send_rp_message()
> > to return error when it happens, and further extended it to
> > migrate_send_rp_req_pages().
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 38 ++++++++++++++++++++++++++++++--------
> >  migration/migration.h |  2 +-
> >  2 files changed, 31 insertions(+), 9 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 8d93b891e3..db896233f6 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -199,17 +199,35 @@ static void deferred_incoming_migration(Error **errp)
> >   * Send a message on the return channel back to the source
> >   * of the migration.
> >   */
> > -static void migrate_send_rp_message(MigrationIncomingState *mis,
> > -                                    enum mig_rp_message_type message_type,
> > -                                    uint16_t len, void *data)
> > +static int migrate_send_rp_message(MigrationIncomingState *mis,
> > +                                   enum mig_rp_message_type message_type,
> > +                                   uint16_t len, void *data)
> >  {
> > +    int ret = 0;
> > +
> >      trace_migrate_send_rp_message((int)message_type, len);
> >      qemu_mutex_lock(&mis->rp_mutex);
> > +
> > +    /*
> > +     * It's possible that the file handle got lost due to network
> > +     * failures.
> > +     */
> > +    if (!mis->to_src_file) {
> > +        ret = -EIO;
> > +        goto error;
> > +    }
> > +
> >      qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
> >      qemu_put_be16(mis->to_src_file, len);
> >      qemu_put_buffer(mis->to_src_file, data, len);
> >      qemu_fflush(mis->to_src_file);
> > +
> > +    /* It's possible that qemu file got error during sending */
> > +    ret = qemu_file_get_error(mis->to_src_file);
> > +
> > +error:
> >      qemu_mutex_unlock(&mis->rp_mutex);
> > +    return ret;
> >  }
> >  
> >  /* Request a range of pages from the source VM at the given
> > @@ -219,26 +237,30 @@ static void migrate_send_rp_message(MigrationIncomingState *mis,
> >   *   Start: Address offset within the RB
> >   *   Len: Length in bytes required - must be a multiple of pagesize
> >   */
> > -void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> > -                               ram_addr_t start, size_t len)
> > +int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> > +                              ram_addr_t start, size_t len)
> >  {
> >      uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
> >      size_t msglen = 12; /* start + len */
> > +    int rbname_len;
> > +    enum mig_rp_message_type msg_type;
> >  
> >      *(uint64_t *)bufc = cpu_to_be64((uint64_t)start);
> >      *(uint32_t *)(bufc + 8) = cpu_to_be32((uint32_t)len);
> >  
> >      if (rbname) {
> > -        int rbname_len = strlen(rbname);
> > +        rbname_len = strlen(rbname);
> 
> I don't think that move of the declaration of rbname_len is necessary;
> it's only msglen that you need to keep for longer.

Yes it's not necessary.  I'll avoid touching it.  Thanks,

-- 
Peter Xu
