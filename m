Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvIN4-0007wK-Po
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvIN1-0005Bb-Jn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dvIN1-0005B1-A6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:27:31 -0400
Date: Fri, 22 Sep 2017 09:27:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170922072724.GA12295@localhost.localdomain>
References: <CAATJJ0KLaR6VUrPZZSQxwb6niF5YY0UMB5sWDq9b=OeeC5=1Xw@mail.gmail.com>
	<20170921123320.GG32364@stefanha-x1.localdomain>
	<20170921124317.GB15693@redhat.com>
	<20170921131839.GC15693@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921131839.GC15693@redhat.com>
Subject: Re: [Qemu-devel] need to resurrect no-lock option?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Ehrhardt <christian.ehrhardt@canonical.com>

Am 21.09.2017 um 15:18 hat Daniel P. Berrange geschrieben:
> On Thu, Sep 21, 2017 at 01:43:17PM +0100, Daniel P. Berrange wrote:
> > On Thu, Sep 21, 2017 at 01:33:20PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Sep 20, 2017 at 11:26:11AM +0200, Christian Ehrhardt wrote:
> > > > Hi,
> > > > this might have been discussed in the wake of the lock changes that took
> > > > place in 2.10 but I can't find anything clear enough to follow in the
> > > > current case.
> > > > There was an old submission [1] by Fam to make it possible to no-lock
> > > > qemu-img and others if needed. But it seems nothing like it made it along
> > > > to the locking we have in 2.10.
> > > > 
> > > > One (maybe more) case where missing this causes pain is e.g. running an
> > > > info check on a running guest.
> > > > In general info shouldn't need a write lock anyway, but without --no-lock
> > > > that use case is broken.
> > > 
> > > It's still an invalid use case.  There is no guarantee that qemu-img
> > > will see a consistent version of the image file.  Metadata could change
> > > underneath qemu-img because QEMU may still write to it.  QEMU may also
> > > have some metadata cached so there's no guarantee that qemu-img sees an
> > > up-to-date image.
> > > 
> > > Why do you need to run qemu-img on a disk image that is in use?
> > 
> > You have a directory full of images and you want to understand current usage
> > vs potential future usage. For this you need to get the virtual size, which
> > rquires 'qemu-img info' for non-raw files. Actually it would be even better
> > served by the new 'measure' command recently added.
> > 
> > The job analyzing this directory of images may not have any context as to
> > whether each file is in use by a running QEMU, so would just blindly call
> > 'qemu-img info' on each file it finds.  There's of course potential that
> > opening the image in 'qemu-img info' could hit problems if the running QEMU
> > changed qcow2 metadata, but generally that would not have serious negative
> > impact and would be self-correcting next time the job analysed the directory.
> 
> FYI this scenario has already hit OpenStack with breakage on new QMEU
> 
>   https://bugs.launchpad.net/nova/+bug/1718295
> 
> and thus they're just going to add '--force-shared' for all usage of
> qemu-img info.

As you know, the information returned by qemu-img with --force-shared is
not reliable if a VM is writing to the image. If you're okay with that,
you can use it, but I think it's appropriate to require an option for
this.

If you need something that works reliably with images that are in use,
we should be talking about QMP commands instead and libvirt should
decide which method needs to be used for each call.

Kevin
