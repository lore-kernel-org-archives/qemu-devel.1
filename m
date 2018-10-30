Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHcLu-0001QK-CI
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHcLr-0003mJ-42
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gHcLq-0003ly-Qv
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:19:06 -0400
Date: Wed, 31 Oct 2018 06:18:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181030221858.GB2032@xz-x1>
References: <20181029125818.28720-1-fli@suse.com>
	<20181029125818.28720-6-fli@suse.com>
	<20181030060502.GG22523@xz-x1>
	<0273e52f-ba16-fef0-22bc-bb3103dbdab2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0273e52f-ba16-fef0-22bc-bb3103dbdab2@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 5/7] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com

On Tue, Oct 30, 2018 at 06:05:18PM +0800, Fei Li wrote:

[...]

> > > @@ -1366,6 +1373,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
> > >                          QEMU_THREAD_JOINABLE);
> > >       atomic_inc(&multifd_recv_state->count);
> > >       return multifd_recv_state->count == migrate_multifd_channels();
> > > +fail:
> > > +    qemu_fclose(mis->from_src_file);
> > > +    mis->from_src_file = NULL;
> > > +    return false;
> > Do we need this?
> > 
> > I'd suggest to put all cleanups into a single function.  For dest vm
> > I say it's process_incoming_migration_bh.
> > 
> > Regards,
> > 
> Not sure whether I understand correctly, if multifd_recv_new_channel()
> fails,
> that means migration_incoming_process() will not be called, then
> process_incoming_migration_co() and process_incoming_migration_bh()
> will not be called either. In that way, there is no cleanup.

Sorry the funtion name I wanted to paste is something like
migration_incoming_state_destroy()...  Anyway I still don't feel that
right to close the mis->from_src_file in a multifd special path.

For now, I'll either ignore the cleanup part (AFAIU the TLS failure
will also ignore it when migration_tls_channel_process_incoming fails)
and just print the extra error message, or you can also look into how
to cleanup the dest vm in a better way.  That could be someting like
calling migration_incoming_state_destroy() somewhere in
migration_channel_process_incoming() when failure happens but I'm not
sure.

Regards,

-- 
Peter Xu
