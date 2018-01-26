Received: from eggs.gnu.org ([2001:4830:134:3::10]:38207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eeyXs-0003Pz-CW
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 02:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eeyXq-00080Q-Uy
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 02:35:32 -0500
From: Liang Li <liliang.opensource@gmail.com>
Date: Fri, 26 Jan 2018 14:46:50 +0800
Message-ID: <20180126064647.GA12068@localhost>
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
	<20180125045926.GA4720@localhost>
	<b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM
 has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, Jan 25, 2018 at 08:48:22AM -0600, Eric Blake wrote:
> On 01/24/2018 10:59 PM, Liang Li wrote:
> >>
> >> There's ongoing work on adding async mirroring; this may be a better
> >> solution to the issue you are seeing.
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05419.html
> >>
> > Hi Eric,
> > 
> > Thinks for your information, I didn't know libvirt depends on 'block-job-cancel'
> > for some of the block related operations.
> > 
> > It's seems a new interface should provided by qemu for use case that just
> > for aborting block job and don't care abort the mirror data integrality, and
> > libvirt can make use of this new interface.
> > 
> > Do you think this is the right direction?
> 
> I don't know if it is better to wait for the new async mirroring code to
> land, or to just propose a new QMP command that can force-quit an
> ongoing mirror in the READY state, but you are correct that the only
> safe way to do it is by adding a new command (or a new optional flag to
> the existing block-job-cancel command).
> 

Active sync does not conflict with the new QMP command, no need to wait.
The current QMP command is:

{ 'command': 'block-job-cancel', 'data': { 'device': 'str', '*force': 'bool' } }

'force' has other meaning which is not used by libvirt, for the change, there
are 3 options:

a. Now that 'force' is not used by libvirt and it current semantic is not very useful,
we can change it's semantic to force-quit without syncing.

b. change 'force' from bool to flag, and bit 0 is used for it's original meaning.

c. add another bool parameter.


which is the best one?

Thanks!

Liang 


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
