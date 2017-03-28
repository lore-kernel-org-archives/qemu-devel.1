Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cskn5-0003Lq-3N
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 02:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cskn1-0006X5-To
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 02:39:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cskn1-0006Ws-KV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 02:39:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S6XiG9025067
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:39:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fje9h1wu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:39:33 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 28 Mar 2017 02:39:32 -0400
Date: Tue, 28 Mar 2017 14:39:25 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
	<20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
	<e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
Message-Id: <20170328063925.GB22108@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/1] block: pass the right options
 for BlockDriver.bdrv_open
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

* Max Reitz <mreitz@redhat.com> [2017-03-27 17:27:16 +0200]:

> On 27.03.2017 05:05, Dong Jia Shi wrote:
> > raw_open() expects the caller always passing in the right actual
> > @options parameter. But when trying to applying snapshot on a RBD
> > image, bdrv_snapshot_goto() calls raw_open() (by calling the
> > bdrv_open callback on the BlockDriver) with a NULL @options, and
> > that will result in a Segmentation fault.
> > 
> > For the other non-raw format drivers, it also make sense to passing
> > in the actual options, althought they don't trigger the problem so
> > far.
> > 
> > Let's prepare a @options by adding the "file" key-value pair to a
> > copy of the actual options that were given for the node (i.e.
> > bs->options), and pass it to the callback.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  block/snapshot.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/snapshot.c b/block/snapshot.c
> > index bf5c2ca..dfec139 100644
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
> > @@ -189,9 +190,14 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
> >      }
> >  
> >      if (bs->file) {
> > +        QDict *options = qdict_clone_shallow(bs->options);
> > +        qdict_put(options, "file",
> > +                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));
> 
> I don't think you're guaranteed that "file" is a a nested QDict (if it
> has been specified as a nested dict). Then you'd have both options like
> "file.driver" and "file" here which will break later on.
> 
> Compare:
> 
> $ ./qemu-img snapshot -a foo
> "json:{'driver':'raw','file':{'driver':'qcow2','file':{'driver':'file','filename':'foo.qcow2'}}}"
> qemu-img: Cannot reference an existing block device with additional
> options or a new filename
> 
> $ ./qemu-img snapshot -a foo --image-opts
> driver=raw,file.driver=qcow2,file.file.driver=file,file.file.filename=foo.qcow2
> qemu-img: Cannot reference an existing block device with additional
> options or a new filename
> 
> By the way, afterwards both commands segfault (and I had to add a manual
Hi Max,

You are right. Using your commands, I can easily reproduce the segfaults
problem.

> error_report_err() in this function to see the error message because
> normally this just passes NULL for errp...). The segfault comes from...
> 
> > +
> >          drv->bdrv_close(bs);
> >          ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
> > -        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
> > +        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
> > +        QDECREF(options);
> >          if (open_ret < 0) {
> >              bdrv_unref(bs->file->bs);
> 
> ...here. bs->file is NULL. This is because BlockDriver.bdrv_open()
> expects bs->file to be NULL and just overwrites it with the result from
> bdrv_open_child().
> 
> Now if that bdrv_open_child() fails, the field becomes NULL, the old
> child is leaked and the above bdrv_unref() fails.
Nod.

> 
> I get that this is never supposed to happen because bdrv_open_child()
> should always succeed with the node name of the existing BDS given as a
> reference... but we shouldn't rely on that, I guess.
> 
> 
> All of this is a horrible mess. It kind of worked in the past when all
> of this bdrv_open()/bdrv_close() stuff was a horrible mess but now it
> stands out as exceptionally ugly (and obviously broken).
> 
> 
> Of course, we can't fix all of this for 2.9, so what I'd propose for
> this patch is:
I definitely will listen to your suggestions on this.

> 
> (1) Remove every option in "options" that has a "file." prefix before
> the qdict_put() call.
> 
> (2) Use bdrv_unref_child(bs->file) instead of bdrv_unref(bs->file->bs).
:> You must mean:
bdrv_unref_child(bs, bs->file);

> 
> I guess it should work with those changes. At least I hope it will.
Yes, with my test results, it works!

> 
> By the way, the easiest way to do (1) is probably:
> 
> QDict *file_options;
> 
> qdict_extract_subqdict(options, &file_options, "file.");
> QDECREF(file_options);
Cool. I adopted your code and it works well.

Thanks for these very detailed analysis and the code example.

Mind if I add a:
Suggested-by: Max Reitz <mreitz@redhat.com>
in the following version?

> 
> 
> Max
> 
> >              bs->drv = NULL;
> > 
> 
> 




-- 
Dong Jia Shi
