Received: from eggs.gnu.org ([2001:4830:134:3::10]:34466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YZR-0002Dw-C5
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YZQ-00051g-AY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:50:13 -0400
Date: Thu, 27 Apr 2017 09:50:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427015002.GG9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-19-famz@redhat.com>
	<20170426125227.GF4538@noname.str.redhat.com>
	<20170426131517.GB9205@lemon.lan>
	<20170426143402.GK4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426143402.GK4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 18/21] block: Reuse bs as backing hd
 for drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 04/26 16:34, Kevin Wolf wrote:
> Am 26.04.2017 um 15:15 hat Fam Zheng geschrieben:
> > On Wed, 04/26 14:52, Kevin Wolf wrote:
> > > Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > 
> > > The commit message is a bit terse. :-)
> > > 
> > > So I think this means that instead of opening the backing file of the
> > > backup (which is probably the active file of the VM) a second time, we
> > > instead take a reference on the existing node. Very good idea.
> > > 
> > > In fact, my question is: How did this ever work? Did we just neglect to
> > > test this? The backup backing file will use stale qcow2 metadata when we
> > > continue to write to the source.
> > 
> > Reading from the target BDS would be a problem, but I guess it's relatively
> > uncommon:
> > 
> > - In QEMU code, COW is always done manually in backup_do_cow, so no reading from
> >   target->backing in block layer.
> > 
> > - Writing to target is done in target cluster granularity so no COW too.
> > 
> > But it's still a fully valid point, for example it can be exported to NBD, etc.
> 
> Which I believe is the exact setup for fleecing.

Hmm, yes you must be right. Though IMO I've always considered blockdev-add with
backing reference to be the only valid way to do fleecing, this one is IMHO a
hack. And when it was added, there was no way to export it in NBD because it
didn't have a device id.

> 
> And actually, if we were sure that we never read from the file, we
> wouldn't even have to attach the backing file in the first place.

OK, fair enough.

> 
> > > Unless I'm missing something, I'd propose this for qemu-stable.
> > 
> > Yes, sounds good.
> > 
> > > 
> > > Also, mirror with MIRROR_OPEN_BACKING_CHAIN probably has a similar
> > > problem with opening the images in the backing chain a second time.
> > 
> > Seems so. But if there was such a test case, image locking would have
> > complained.
> > 
> > Is that a practical use case?  Mirror target image uses the active image as
> > backign file? (It's a bit late in the evening, please remind me :-)
> 
> I believe storage migration uses a mode like this, but to be honest I
> don't remember the details at the moment either.
> 
> But I do see that NEW_IMAGE_MODE_ABSOLUTE_PATHS enters the source as the
> backing file of the target and opens it (a second instance of it) when
> the mirror completes. Hopefully, by that time the source doesn't have
> another user that keeps it alive (and I think op blockers should
> actually ensure this), but it looks a bit fishy. Probably worth a closer
> look.

Mirror has many graph manipulation magic, which seems even darker than commit.
We should perhaps allocate sometime to see if there are cleaner ways to do them,
with all the new infrastructure we have. Hopefully it's not hard to do, like
this one.

Fam
