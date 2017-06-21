Received: from eggs.gnu.org ([2001:4830:134:3::10]:40109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3382f85e5=roger.pau@citrix.com>)
	id 1dNbm4-0002mZ-T3
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3382f85e5=roger.pau@citrix.com>)
	id 1dNbm1-0001dp-Mc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:18:08 -0400
Date: Wed, 21 Jun 2017 10:17:43 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170621091743.qyhzt52t35y5oxek@dhcp-3-128.uk.xensource.com>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
	<20170620134756.9632-2-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize
 feature-persistent if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Paul Durrant <paul.durrant@citrix.com>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Jun 20, 2017 at 03:19:33PM -0700, Stefano Stabellini wrote:
> On Tue, 20 Jun 2017, Paul Durrant wrote:
> > If grant copy is available then it will always be used in preference to
> > persistent maps. In this case feature-persistent should not be advertized
> > to the frontend, otherwise it may needlessly copy data into persistently
> > granted buffers.
> > 
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> 
> CC'ing Roger.
> 
> It is true that using feature-persistent together with grant copies is a
> a very bad idea.
> 
> But this change enstablishes an explicit preference of
> feature_grant_copy over feature-persistent in the xen_disk backend. It
> is not obvious to me that it should be the case.
> 
> Why is feature_grant_copy (without feature-persistent) better than
> feature-persistent (without feature_grant_copy)? Shouldn't we simply
> avoid grant copies to copy data to persistent grants?

When using persistent grants the frontend must always copy data from
the buffer to the persistent grant, there's no way to avoid this.

Using grant_copy we move the copy from the frontend to the backend,
which means the CPU time of the copy is accounted to the backend. This
is not ideal, but IMHO it's better than persistent grants because it
avoids keeping a pool of mapped grants that consume memory and make
the code more complex.

Do you have some performance data showing the difference between
persistent grants vs grant copy?

Roger.
