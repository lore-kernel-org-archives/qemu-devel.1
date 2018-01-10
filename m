Received: from eggs.gnu.org ([2001:4830:134:3::10]:47721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZH2R-0003XQ-Un
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZH2Q-0003jv-Vn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:07:31 -0500
Date: Wed, 10 Jan 2018 15:07:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180110140712.GB3638@localhost.localdomain>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<20180110124913.GK3205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110124913.GK3205@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img: Let "info" warn and go ahead
 without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 10.01.2018 um 13:49 hat Daniel P. Berrange geschrieben:
> On Mon, Jan 08, 2018 at 03:41:36PM +0100, Kevin Wolf wrote:
> > Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> > > Management and users are accustomed to "qemu-img info" to query status of
> > > images even when they are used by guests. Since image locking was added, the -U
> > > (--force-share) option is needed for that to work. The reason has been that due
> > > to possible race with image header update, the output can be misleading.
> > > 
> > > But what are likely to happen after we emit the error are that, for interactive
> > > users, '-U' will be used and the command retried; for management (nova, RHV,
> > > etc.), the operation is broken with no knob to workaround this.
> > > 
> > > This series changes that error to a warning so that it doesn't get in the way.
> > 
> > Are management tools actually doing this? There is no good reason to
> > call 'qemu-img info' for an image that is in use by a VM.
> 
> OpenStack will frequently call 'qemu-img info' for disks that are in use by
> VMs. It is looking at the sizes to understand the relation between the current
> size used by qcow2 vs the possible future usage. In this context, it does not
> matter if the data is slightly outdated, as it will catch up next time it reads
> it a few mins later.
> 
> It has been patched to just retry with -U to avoid this error on new
> QEMU.

The proper, though somewhat more intrusive fix would be to use QMP
commands for images of running VMs. You already need to do the same for
anything modifying the image (to avoid corruption), so I think doing the
same with 'query-block' instead of 'qemu-img info' for guaranteed
consistent results on running VMs only makes sense.

Kevin
