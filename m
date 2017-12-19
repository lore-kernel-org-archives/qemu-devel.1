Received: from eggs.gnu.org ([2001:4830:134:3::10]:53923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRAGq-0001jM-AC
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRAGn-0005JK-HF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRAGn-0005Hf-AL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:16:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97C13C04AC40
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 05:16:47 +0000 (UTC)
Date: Tue, 19 Dec 2017 13:16:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171219051642.GZ22308@xz-mi>
References: <20171215171655.7818-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215171655.7818-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] migration/channel errors and cancelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, quintela@redhat.com

On Fri, Dec 15, 2017 at 05:16:53PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   Where a channel fails asynchronously during connect, call
> back through the migration code so it can clean up.
>   In particular this causes the transition of a 'cancelling' state
> to 'cancelled' in the case of:
> 
>     migrate -d tcp:deadhost:port
>      <host tries to connect>
>     migrate_cancel
> 
> previously the status would get stuck in cancelling because
> the final cleanup didn't happen.
> 
>   This is the second part of the fix for:
> https://bugzilla.redhat.com/show_bug.cgi?id=1525899

IIUC this series tries to deliver the connection error a long way
until migrate_fd_connect() to handle it. But, haven't we already have
a function migrate_fd_error() to do that (which is faster, and
simpler)?

void migrate_fd_error(MigrationState *s, const Error *error)
{
    trace_migrate_fd_error(error_get_pretty(error));
    assert(s->to_dst_file == NULL);
    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                      MIGRATION_STATUS_FAILED);
    migrate_set_error(s, error);
    notifier_list_notify(&migration_state_notifiers, s);
    block_cleanup_parameters(s);
}

I think it's not handling the case when cancelling.  If we let it to
handle the cancelling case well, would it be a simpler fix?

Moreover, I think this is another good example that migration is not
handling the cleanup "cleanly" in general... I really hope we can do
this better in 2.12.  I'll see whether I can give it a shot, but in
all cases it'll be after the merging of existing patches since there
are already quite a lot of dangling patches.

Thanks,

-- 
Peter Xu
