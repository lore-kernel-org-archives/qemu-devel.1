Received: from eggs.gnu.org ([2001:4830:134:3::10]:56629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cnGhu-0007Z9-Br
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cnGhV-0000eO-Ow
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:31:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47381
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cnGhV-0000ad-Df
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:31:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2D3SaoJ087760
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 23:31:10 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 294ea23ebs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 23:31:10 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 12 Mar 2017 23:31:09 -0400
Date: Mon, 13 Mar 2017 11:31:05 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
	<20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
	<20170308091346.GB5211@noname.redhat.com>
	<20170308093105.GC7563@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308093105.GC7563@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170313033105.GA6756@bjsdjshi@linux.vnet.ibm.com>
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

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-03-08 17:31:05 +0800]:

> * Kevin Wolf <kwolf@redhat.com> [2017-03-08 10:13:46 +0100]:
> 
> > Am 08.03.2017 um 03:15 hat Dong Jia Shi geschrieben:
> > > A normal call for raw_open should always pass in a non-NULL @options,
> > > but for some certain cases (e.g. trying to applying snapshot on a RBD
> > > image), they call raw_open with a NULL @options right after the calling
> > > for raw_close.
> > > 
> > > Let's take the NULL @options as a sign of trying to do raw_open again,
> > > and just simply return a success code.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > 
> > I think we rather need to fix bdrv_snapshot_goto() so that it doesn't
> > pass NULL, but the actual options that were given for the node (i.e.
> > bs->options).
> I've tried that before the current try. bs->options does not have the
> "file" key-value pair, so that leads to a fail too. Should we put "file"
> in to the options manually? I noticed that it was removed from
> bs->options during the calling of bdrv_open_inherit.
> 
Hi Kevin,

After thinking for quite some time, I still don't think we need to fix
the caller. The reason is that raw_close always does nothing, so no
matter what the caller passing in, raw_open should do nothing but just
return 0.

The following is another proposal. Looking forward for your comments.
Thanks,

diff --git a/block/raw-format.c b/block/raw-format.c
index 86fbc65..c309d4c 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -384,6 +384,11 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
     int ret;
 
+    if (!bs->file) {
+        return 0;
+    }
+
+    assert(options != NULL);
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {

> > 
> > Kevin
> > 
> 
> -- 
> Dong Jia

-- 
Dong Jia
