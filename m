Received: from eggs.gnu.org ([2001:4830:134:3::10]:44135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpX35-0003aV-UL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpX35-0000Py-40
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:59:40 -0400
Date: Tue, 14 Aug 2018 12:59:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814105929.GG5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
	<e455a609a0842489d08b5e8d08902fe92bb3c79a.1530270904.git.berto@igalia.com>
	<20180814090742.GE5025@dhcp-200-186.str.redhat.com>
	<w5136vhp83y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w5136vhp83y.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] block: Simplify bdrv_reopen_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 14.08.2018 um 12:15 hat Alberto Garcia geschrieben:
> On Tue 14 Aug 2018 11:07:42 AM CEST, Kevin Wolf wrote:
> > Am 29.06.2018 um 13:37 hat Alberto Garcia geschrieben:
> >> If a bdrv_reopen_multiple() call fails, then the explicit_options
> >> QDict has to be deleted for every entry in the reopen queue. This must
> >> happen regardless of whether that entry's bdrv_reopen_prepare() call
> >> succeeded or not.
> >> 
> >> This patch simplifies the cleanup code a bit.
> >> 
> >> Signed-off-by: Alberto Garcia <berto@igalia.com>
> >> ---
> >>  block.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/block.c b/block.c
> >> index 5aaed424b9..48e8f4814c 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -3060,9 +3060,10 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
> >>  
> >>  cleanup:
> >>      QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
> >> -        if (ret && bs_entry->prepared) {
> >> -            bdrv_reopen_abort(&bs_entry->state);
> >> -        } else if (ret) {
> >> +        if (ret) {
> >> +            if (bs_entry->prepared) {
> >> +                bdrv_reopen_abort(&bs_entry->state);
> >> +            }
> >>              qobject_unref(bs_entry->state.explicit_options);
> >>          }
> >>          qobject_unref(bs_entry->state.options);
> >> @@ -3351,8 +3352,6 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
> >>          drv->bdrv_reopen_abort(reopen_state);
> >>      }
> >>  
> >> -    qobject_unref(reopen_state->explicit_options);
> >> -
> >>      bdrv_abort_perm_update(reopen_state->bs);
> >>  }
> >
> > I think this is only correct if we make bdrv_reopen_prepare/commit/abort
> > private. At the moment they are public interfaces, so we must have
> > thought that some callers might want to integrate them into other
> > transactions.
> 
> But that's not a problem as long as the new callers unref
> state.explicit_options when bdrv_reopen_prepare() fails. They need to do
> it with state.options anyway.

Actually that makes sense because the code creating the object isn't
even in bdrv_reopen_prepare(), but in bdrv_reopen_queue_child(). So it's
the caller that owns the object and should free them too. I just
confused the two functions.

Kevin
