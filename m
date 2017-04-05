Received: from eggs.gnu.org ([2001:4830:134:3::10]:46571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cvagZ-0006M7-1j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 22:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cvagW-0006mQ-3j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 22:28:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49120
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cvagV-0006kO-UL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 22:28:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v352O0HQ023636
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 22:28:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29mbv38r78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 22:28:33 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 20:28:33 -0600
Date: Wed, 5 Apr 2017 10:28:26 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170329011637.89377-1-bjsdjshi@linux.vnet.ibm.com>
	<20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
	<e445fb5a-7076-a557-d0c0-94dbf60b289a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e445fb5a-7076-a557-d0c0-94dbf60b289a@redhat.com>
Message-Id: <20170405022825.GD22108@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

* Max Reitz <mreitz@redhat.com> [2017-03-29 23:07:22 +0200]:

> On 29.03.2017 03:16, Dong Jia Shi wrote:
> > raw_open() expects the caller always passing in the right actual
> > @options parameter. But when trying to applying snapshot on a RBD
> > image, bdrv_snapshot_goto() calls raw_open() (by calling the
> > bdrv_open callback on the BlockDriver) with a NULL @options, and
> > that will result in a Segmentation fault.
> > 
> > For the other non-raw format drivers, it also makes sense to passing
> > in the actual options, althought they don't trigger the problem so
> > far.
> > 
> > Let's prepare a @options by adding the "file" key-value pair to a
> > copy of the actual options that were given for the node (i.e.
> > bs->options), and pass it to the callback.
> > 
> > BlockDriver.bdrv_open() expects bs->file to be NULL and just
> > overwrites it with the result from bdrv_open_child(). If that
> > bdrv_open_child() fails, the field becomes NULL. While we are at
> > it, we also correct the cleanning up action for a call failure of
> > BlockDriver.bdrv_open() by replacing bdrv_unref() with
> > bdrv_unref_child().
> > 
> > Suggested-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  block/snapshot.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/snapshot.c b/block/snapshot.c
> > index bf5c2ca..281626c 100644
> > --- a/block/snapshot.c
> > +++ b/block/snapshot.c
> > @@ -27,6 +27,7 @@
> >  #include "block/block_int.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qmp/qerror.h"
> > +#include "qapi/qmp/qstring.h"
> >  
> >  QemuOptsList internal_snapshot_opts = {
> >      .name = "snapshot",
> > @@ -189,11 +190,20 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
> >      }
> >  
> >      if (bs->file) {
> > +        QDict *options = qdict_clone_shallow(bs->options);
> > +        QDict *file_options;
> > +
> > +        qdict_extract_subqdict(options, &file_options, "file.");
> > +        QDECREF(file_options);
> > +        qdict_put(options, "file",
> > +                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));
> > +
> >          drv->bdrv_close(bs);
> >          ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
> > -        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
> > +        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
> > +        QDECREF(options);
> >          if (open_ret < 0) {
> > -            bdrv_unref(bs->file->bs);
> > +            bdrv_unref_child(bs, bs->file);
> >              bs->drv = NULL;
> >              return open_ret;
> >          }
> 
> I just noticed another issue (sorry I did not before...):
Hi Max,
No need for sorry.

> 
> In drv->bdrv_open(), the block driver will generally overwrite bs->file
> without looking at it because it assumes that it's NULL. That means we
> should probably actually make sure it's NULL because otherwise we will
> the child BDS will have a reference count that is 1 too high.
> 
> (bdrv_open_inherit() (ultimately called from bdrv_open_child()) invokes
> bdrv_ref() for a child BDS specified by node-name reference.)
> 
> That means we should unconditionally invoke
> bdrv_unref_child(bs, bs->file) before calling drv->bdrv_open(). But we
> have to wrap everything in bdrv_ref()/bdrv_unref() so the BDS isn't
> deleted in the meantime.
Understood.

> 
> So I think it should look something like this:
> 
> BlockDriverState *file;
> QDict *options = ...;
> QDict *file_options;
> 
> file = bs->file->bs;
> /* Prevent it from getting deleted when detached from bs */
> bdrv_ref(file);
> 
> qdict_extract_subqdict(...);
> QDECREF(file_options);
> qdict_put(..., qstring_from_str(bdrv_get_node_name(file)));
> 
> drv->bdrv_close(bs);
> bdrv_unref_child(bs, bs->file);
> bs->file = NULL;
> 
> ret = bdrv_snapshot_goto(file, snapshot_id);
> open_ret = drv->bdrv_open(...);
Here, I think we'd still need a:
QDECREF(options);

> if (open_ret < 0) {
>     bdrv_unref(file);
>     bs->drv = NULL;
>     return open_ret;
> }
> 
> assert(bs->file->bs == file);
> bdrv_unref(file);

It looks convoluted, but I don't see a better solution. So I will
prepare a new patch based on your code.

Thanks for the help!

> 
> 
> Max
> 

-- 
Dong Jia Shi
