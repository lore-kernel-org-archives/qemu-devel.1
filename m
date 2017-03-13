Received: from eggs.gnu.org ([2001:4830:134:3::10]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnN0o-0002Zp-Tz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnN0o-0007ad-0f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:15:34 -0400
Date: Mon, 13 Mar 2017 11:15:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170313101522.GA5545@noname.redhat.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
	<20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
	<20170308091346.GB5211@noname.redhat.com>
	<20170308093105.GC7563@bjsdjshi@linux.vnet.ibm.com>
	<20170313033105.GA6756@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313033105.GA6756@bjsdjshi@linux.vnet.ibm.com>
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

Am 13.03.2017 um 04:31 hat Dong Jia Shi geschrieben:
> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-03-08 17:31:05 +0800]:
> 
> > * Kevin Wolf <kwolf@redhat.com> [2017-03-08 10:13:46 +0100]:
> > 
> > > Am 08.03.2017 um 03:15 hat Dong Jia Shi geschrieben:
> > > > A normal call for raw_open should always pass in a non-NULL @options,
> > > > but for some certain cases (e.g. trying to applying snapshot on a RBD
> > > > image), they call raw_open with a NULL @options right after the calling
> > > > for raw_close.
> > > > 
> > > > Let's take the NULL @options as a sign of trying to do raw_open again,
> > > > and just simply return a success code.
> > > > 
> > > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > 
> > > I think we rather need to fix bdrv_snapshot_goto() so that it doesn't
> > > pass NULL, but the actual options that were given for the node (i.e.
> > > bs->options).
> > I've tried that before the current try. bs->options does not have the
> > "file" key-value pair, so that leads to a fail too. Should we put "file"
> > in to the options manually? I noticed that it was removed from
> > bs->options during the calling of bdrv_open_inherit.
> > 
> Hi Kevin,
> 
> After thinking for quite some time, I still don't think we need to fix
> the caller. The reason is that raw_close always does nothing, so no
> matter what the caller passing in, raw_open should do nothing but just
> return 0.

raw is not the only format driver in qemu.

Kevin
