Received: from eggs.gnu.org ([2001:4830:134:3::10]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2cAI-0000MD-5o
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2cAG-0001X6-Sz
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:28:22 -0400
Date: Mon, 24 Apr 2017 19:28:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424112813.GF14416@lemon.lan>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-5-famz@redhat.com>
	<20170421132509.GD4318@noname.redhat.com>
	<20170424061030.GC316@lemon.lan>
	<20170424101356.GD4739@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424101356.GD4739@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 04/20] qemu-img: Add --share-rw option
 to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Mon, 04/24 12:13, Kevin Wolf wrote:
> Am 24.04.2017 um 08:10 hat Fam Zheng geschrieben:
> > On Fri, 04/21 15:25, Kevin Wolf wrote:
> > > Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> > > > Similar to share-rw qdev property, this will force the opened images to
> > > > allow shared write permission of other programs.
> > > > 
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > 
> > > General observation: We were considering to make share-rw require
> > > read-only. Some of the commands converted here always open the image
> > > read-write, so if we go ahead with the restriction, will the option
> > > become useless in many of the subcommands?
> > 
> > share-rw on qdev doesn't require read-only, so I personally perfer we
> > follow that manner.
> 
> It's not really completely comparable to qdev's share-rw because qdev
> only shares writes on the top level (and the qcow2 driver restricts this
> again down the tree), while this option propagates all the way down.
> Which is why you called the block layer option "force-shared-write".
> Maybe that would be the better name here as well.

Makes sense to me.

> 
> > Because even with --share-rw for the read-write commands, the image is
> > still protected from corruption by the fact that the other side
> > probably uses non-share-rw.
> 
> If the other side "probably" uses non-share-rw, then the image is only
> "probably" protected. I think you're right about the common case, but if
> two qemu instances use force-shared-write=on, then we get actual image
> corruption.
> 
> As far as I know, our real use cases for the option are read-only: We
> want to inspect images which are in use by a VM. Do we have any use
> cases for read-write access?
> 
> Note that this is different from qdev in that share-rw on the qdev level
> affects only the user data and can work e.g. if the guest uses a cluster
> file system. But this option affects metadata as well and qcow2 never
> supports this, so opening two images read-write at the same time is
> guaranteed to corrupt the image.

OK, I think that makes sense too.

> 
> > But on the other hand, we can always add the option when necessary, so
> > it's okay to leave them as is. If you insist, I can remove them in
> > next version.
> 
> Yes, I think we really need a check in bdrv_open_common() that forbids
> force-shared-write=on on writable images. And then, the options in
> qemu-img become useless when applied to writable images because they
> would only produce errors.
> 
> > > >  qemu-img.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++--------------
> > > >  1 file changed, 119 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/qemu-img.c b/qemu-img.c
> > > > index ed24371..df88a79 100644
> > > > --- a/qemu-img.c
> > > > +++ b/qemu-img.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include "qapi/qobject-output-visitor.h"
> > > >  #include "qapi/qmp/qerror.h"
> > > >  #include "qapi/qmp/qjson.h"
> > > > +#include "qapi/qmp/qbool.h"
> > > >  #include "qemu/cutils.h"
> > > >  #include "qemu/config-file.h"
> > > >  #include "qemu/option.h"
> > > > @@ -283,12 +284,15 @@ static int img_open_password(BlockBackend *blk, const char *filename,
> > > >  
> > > >  static BlockBackend *img_open_opts(const char *optstr,
> > > >                                     QemuOpts *opts, int flags, bool writethrough,
> > > > -                                   bool quiet)
> > > > +                                   bool quiet, bool share_rw)
> > > >  {
> > > >      QDict *options;
> > > >      Error *local_err = NULL;
> > > >      BlockBackend *blk;
> > > >      options = qemu_opts_to_qdict(opts, NULL);
> > > > +    if (share_rw) {
> > > > +        qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
> > > > +    }
> > > 
> > > It's interesting that you chose a conditional qdict_put for true rather
> > > than an unconditional one for share_rw here. The difference becomes
> > > visible when someone sets both -U and share-rw=off; we need to decide
> > > which one should take precedence.
> > 
> > I don't have a preference here.  Setting both -U and share-rw=off is
> > inconsistent, it's not a problem to yield an "undefined" result.
> 
> We could just check whether the entry already exists and error out.
> Maybe that's the best option.

Sounds good, will add the check.

Fam
