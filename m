Received: from eggs.gnu.org ([2001:4830:134:3::10]:37038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdbDL-0001ao-TQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdbDK-00018Z-IQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:24:07 -0500
Date: Tue, 14 Feb 2017 19:23:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214112356.GG6428@lemon.lan>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-7-git-send-email-kwolf@redhat.com>
	<20170214055142.GB6428@lemon.lan>
	<20170214103610.GA6189@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214103610.GA6189@noname.redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/41] block: Involve block drivers in
 permission granting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/14 11:36, Kevin Wolf wrote:
> Am 14.02.2017 um 06:51 hat Fam Zheng geschrieben:
> > On Mon, 02/13 18:22, Kevin Wolf wrote:
> > > +int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
> > > +                            Error **errp)
> > > +{
> > > +    int ret;
> > > +
> > > +    ret = bdrv_child_check_perm(c, perm, shared, errp);
> > > +    if (ret < 0) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    bdrv_child_set_perm(c, perm, shared);
> > 
> > This has an issue of TOCTOU, which means image locking cannot fit in easily.
> > Maybe squash them into one callback (.bdrv_try_set_perm) that can return error?
> 
> That doesn't work, it would leave us with broken error handling. If one
> driver in the middle of the update process fails to update the
> permissions, we would end up with half of the nodes having the old
> permissions and half having the new ones.
> 
> I think the file driver needs to lock the file already on check, and
> then we need to add a callback for the failure case so that it gives up
> the lock again. In other words, we might need a transaction with
> prepare/commit/abort here (*sigh*). Hm, or maybe just prepare/abort
> could be enough? Needs some thinking about.

Can perm change be wedged into the reopen transaction? RO flag change there
already requires transactional lock mode update in file driver. I wonder if
the bdrv_reopen call sites can ever have (transactional) perm change
requirements as well..

Fam
