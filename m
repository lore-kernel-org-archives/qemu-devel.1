Received: from eggs.gnu.org ([2001:4830:134:3::10]:33813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvvH9-0001D1-OB
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 20:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvvH8-0004OK-Si
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 20:27:47 -0400
Date: Wed, 5 Apr 2017 20:27:34 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170406002734.GM1135@localhost.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<abc6320f80ff4af4788fe33b12bb12cbfa83d980.1491416061.git.jcody@redhat.com>
	<a82f1619-7815-dc8c-279c-ed40b7da505d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82f1619-7815-dc8c-279c-ed40b7da505d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 6/9] block: use
 bdrv_try_set_read_only() during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Wed, Apr 05, 2017 at 04:25:39PM -0400, John Snow wrote:
> 
> 
> On 04/05/2017 02:28 PM, Jeff Cody wrote:
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block.c b/block.c
> > index ad958b9..3245fae 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -2785,6 +2785,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
> >      BlockDriver *drv;
> >      QemuOpts *opts;
> >      const char *value;
> > +    bool read_only;
> >  
> >      assert(reopen_state != NULL);
> >      assert(reopen_state->bs->drv != NULL);
> > @@ -2813,12 +2814,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
> >          qdict_put(reopen_state->options, "driver", qstring_from_str(value));
> >      }
> >  
> > -    /* if we are to stay read-only, do not allow permission change
> > -     * to r/w */
> > -    if (!(reopen_state->bs->open_flags & BDRV_O_ALLOW_RDWR) &&
> > -        reopen_state->flags & BDRV_O_RDWR) {
> 
> So the current code checks reopen_state->flags & BDRV_O_RDWR;
> 
> > -        error_setg(errp, "Node '%s' is read only",
> > -                   bdrv_get_device_or_node_name(reopen_state->bs));
> > +    /* If we are to stay read-only, do not allow permission change
> > +     * to r/w. Attempting to set to r/w may fail if either BDRV_O_ALLOW_RDWR is
> > +     * not set, or if the BDS still has copy_on_read enabled */
> > +    read_only = !(reopen_state->bs->open_flags & BDRV_O_RDWR);
> 
> And the proposed change checks reopen_state->bs->open_flags &
> BDRV_O_RDWR. (It's negated again inside of bdrv_try_set_read_only.)
> 
> Both check against !(reopen_state->bs->open_flags & BDRV_O_ALLOW_RDWR).
> 
> What's the functional difference of doing so, and is it intentional?
>

Good catch; unintentional.  That line should read:

+    read_only = !(reopen_state->flags & BDRV_O_RDWR);

The functional difference is we would be testing against the open_flags of
the current BS to see if we are requesting r/w or r/o, rather than checking
against the reopen requested flags.

> > +    ret = bdrv_try_set_read_only(reopen_state->bs, read_only, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> >          goto error;
> >      }
> >  
> > 
