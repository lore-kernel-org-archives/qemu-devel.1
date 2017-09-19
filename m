Received: from eggs.gnu.org ([2001:4830:134:3::10]:35018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duFID-0003jT-SH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duFIC-0008Qy-Dk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:58:13 -0400
Date: Tue, 19 Sep 2017 10:57:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919095750.GG9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
	<2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
	<20170918100626.GE31063@stefanha-x1.localdomain>
	<d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
	<20170919094416.GC22797@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919094416.GC22797@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/18] block/mirror: Add
 active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 19, 2017 at 10:44:16AM +0100, Stefan Hajnoczi wrote:
> On Mon, Sep 18, 2017 at 06:26:51PM +0200, Max Reitz wrote:
> > On 2017-09-18 12:06, Stefan Hajnoczi wrote:
> > > On Sat, Sep 16, 2017 at 03:58:01PM +0200, Max Reitz wrote:
> > >> On 2017-09-14 17:57, Stefan Hajnoczi wrote:
> > >>> On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
> > >>>> This patch implements active synchronous mirroring.  In active mode, the
> > >>>> passive mechanism will still be in place and is used to copy all
> > >>>> initially dirty clusters off the source disk; but every write request
> > >>>> will write data both to the source and the target disk, so the source
> > >>>> cannot be dirtied faster than data is mirrored to the target.  Also,
> > >>>> once the block job has converged (BLOCK_JOB_READY sent), source and
> > >>>> target are guaranteed to stay in sync (unless an error occurs).
> > >>>>
> > >>>> Optionally, dirty data can be copied to the target disk on read
> > >>>> operations, too.
> > >>>>
> > >>>> Active mode is completely optional and currently disabled at runtime.  A
> > >>>> later patch will add a way for users to enable it.
> > >>>>
> > >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> > >>>> ---
> > >>>>  qapi/block-core.json |  23 +++++++
> > >>>>  block/mirror.c       | 187 +++++++++++++++++++++++++++++++++++++++++++++++++--
> > >>>>  2 files changed, 205 insertions(+), 5 deletions(-)
> > >>>>
> > >>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> > >>>> index bb11815608..e072cfa67c 100644
> > >>>> --- a/qapi/block-core.json
> > >>>> +++ b/qapi/block-core.json
> > >>>> @@ -938,6 +938,29 @@
> > >>>>    'data': ['top', 'full', 'none', 'incremental'] }
> > >>>>  
> > >>>>  ##
> > >>>> +# @MirrorCopyMode:
> > >>>> +#
> > >>>> +# An enumeration whose values tell the mirror block job when to
> > >>>> +# trigger writes to the target.
> > >>>> +#
> > >>>> +# @passive: copy data in background only.
> > >>>> +#
> > >>>> +# @active-write: when data is written to the source, write it
> > >>>> +#                (synchronously) to the target as well.  In addition,
> > >>>> +#                data is copied in background just like in @passive
> > >>>> +#                mode.
> > >>>> +#
> > >>>> +# @active-read-write: write data to the target (synchronously) both
> > >>>> +#                     when it is read from and written to the source.
> > >>>> +#                     In addition, data is copied in background just
> > >>>> +#                     like in @passive mode.
> > >>>
> > >>> I'm not sure the terms "active"/"passive" are helpful.  "Active commit"
> > >>> means committing the top-most BDS while the guest is accessing it.  The
> > >>> "passive" mirror block still works on the top-most BDS while the guest
> > >>> is accessing it.
> > >>>
> > >>> Calling it "asynchronous" and "synchronous" is clearer to me.  It's also
> > >>> the terminology used in disk replication (e.g. DRBD).
> > >>
> > >> I'd be OK with that, too, but I think I remember that in the past at
> > >> least Kevin made a clear distinction between active/passive and
> > >> sync/async when it comes to mirroring.
> > >>
> > >>> Ideally the user wouldn't have to worry about async vs sync because QEMU
> > >>> would switch modes as appropriate in order to converge.  That way
> > >>> libvirt also doesn't have to worry about this.
> > >>
> > >> So here you mean async/sync in the way I meant it, i.e., whether the
> > >> mirror operations themselves are async/sync?
> > > 
> > > The meaning I had in mind is:
> > > 
> > > Sync mirroring means a guest write waits until the target write
> > > completes.
> > 
> > I.e. active-sync, ...
> > 
> > > Async mirroring means guest writes completes independently of target
> > > writes.
> > 
> > ... i.e. passive or active-async in the future.
> > 
> > So you really want qemu to decide whether to use active or passive mode
> > depending on what's enough to let the block job converge and not
> > introduce any switch for the user?
> > 
> > I'm not sure whether I like this too much, mostly because "libvirt
> > doesn't have to worry" doesn't feel quite right to me.  If we don't make
> > libvirt worry about this, then qemu has to worry.  I'm not sure whether
> > that's any better.
> > 
> > I think this really does get into policy territory.  Just switching to
> > active mode the instant target writes are slower than source writes may
> > not be what the user wants: Maybe it's OK for a short duration because
> > they don't care about hard convergence too much.  Maybe they want to
> > switch to active mode already when "only" twice as much is written to
> > the target as to the source.
> > 
> > I think this is a decision the management layer (or the user) has to make.
> 
> Eric: Does libvirt want to be involved with converging the mirror job
> (i.e. if the guest is writing to disk faster than QEMU can copy data to
> the target)?

Libvirt doesn't really want to set the policy - it will just need to expose
the mechansim & information to make such decisions upto the application.

I agree with Max that we don't want QEMU making this policy decision on
its own. Simply switching from passive to active mode is not an approach
that will be satisfactory to all scenarios. It might be preferrable to
apply CPU throttling of the guest, or I/O rate throttling, or temporarily
pause the guest to allow catch or any number of other policies. Neither
libvirt or QEMU knows which is best for the scenario at hand.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
