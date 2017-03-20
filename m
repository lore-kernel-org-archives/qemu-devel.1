Received: from eggs.gnu.org ([2001:4830:134:3::10]:44788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cpmIZ-0000Or-10
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cpmIV-00041H-2q
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:39:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cpmIU-00040q-Pf
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:39:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2K1cvdv062469
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 21:39:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 298wsfphae-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 21:39:44 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 19 Mar 2017 21:39:43 -0400
Date: Mon, 20 Mar 2017 09:39:37 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
	<20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
	<20170308091346.GB5211@noname.redhat.com>
	<20170308093105.GC7563@bjsdjshi@linux.vnet.ibm.com>
	<20170313033105.GA6756@bjsdjshi@linux.vnet.ibm.com>
	<20170313101522.GA5545@noname.redhat.com>
	<20170314032312.GF6756@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314032312.GF6756@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170320013937.GW6839@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block: Handle NULL options
 correctly in raw_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-03-14 11:23:12 +0800]:

> * Kevin Wolf <kwolf@redhat.com> [2017-03-13 11:15:22 +0100]:
> 
> > Am 13.03.2017 um 04:31 hat Dong Jia Shi geschrieben:
> > > * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-03-08 17:31:05 +0800]:
> > > 
> > > > * Kevin Wolf <kwolf@redhat.com> [2017-03-08 10:13:46 +0100]:
> > > > 
> > > > > Am 08.03.2017 um 03:15 hat Dong Jia Shi geschrieben:
> > > > > > A normal call for raw_open should always pass in a non-NULL @options,
> > > > > > but for some certain cases (e.g. trying to applying snapshot on a RBD
> > > > > > image), they call raw_open with a NULL @options right after the calling
> > > > > > for raw_close.
> > > > > > 
> > > > > > Let's take the NULL @options as a sign of trying to do raw_open again,
> > > > > > and just simply return a success code.
> > > > > > 
> > > > > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > > 
> > > > > I think we rather need to fix bdrv_snapshot_goto() so that it doesn't
> > > > > pass NULL, but the actual options that were given for the node (i.e.
> > > > > bs->options).
> > > > I've tried that before the current try. bs->options does not have the
> > > > "file" key-value pair, so that leads to a fail too. Should we put "file"
> > > > in to the options manually? I noticed that it was removed from
> > > > bs->options during the calling of bdrv_open_inherit.
> > > > 
> > > Hi Kevin,
> > > 
> > > After thinking for quite some time, I still don't think we need to fix
> > > the caller. The reason is that raw_close always does nothing, so no
> > > matter what the caller passing in, raw_open should do nothing but just
> > > return 0.
> > 
> > raw is not the only format driver in qemu.
> > 
> Hi Kevin,
> 
> Before this I assumed that the long existing code in bdrv_snapshot_goto
> which passes in a NULL options to raw_open is on purpose, and that
> implies to me raw_open (and any other .bdrv_open callback) takes the
> responsibility to handle NULL options well. So at a first glance, I read
> your above comment as:
> "You should also fix .bdrv_open callback for every other formats to
> handle NULL options as well."
> 
> But after staring it for a while, I read it from another point around:
> "You should fix the caller."
> If this is what you actually meant to tell, I have the following
> proposal then:
> diff --git a/block/snapshot.c b/block/snapshot.c
> index bf5c2ca..dfec139 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -27,6 +27,7 @@
>  #include "block/block_int.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qstring.h"
> 
>  QemuOptsList internal_snapshot_opts = {
>      .name = "snapshot",
> @@ -189,9 +190,14 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>      }
> 
>      if (bs->file) {
> +        QDict *options = qdict_clone_shallow(bs->options);
> +        qdict_put(options, "file",
> +                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));
> +
>          drv->bdrv_close(bs);
>          ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
> -        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
> +        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
> +        QDECREF(options);
>          if (open_ret < 0) {
>              bdrv_unref(bs->file->bs);
>              bs->drv = NULL;
> 
> I know I'm a little wordy, but that's because I want to make things
> clear. Anyway, I have to rely on your advice on this, since you are the
> expert.
> 
Ping. :>

-- 
Dong Jia
