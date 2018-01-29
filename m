Received: from eggs.gnu.org ([2001:4830:134:3::10]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eg0Qy-0008PS-B9
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eg0Qx-0006Jn-8c
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:48:40 -0500
From: Liang Li <liliang.opensource@gmail.com>
Date: Mon, 29 Jan 2018 11:48:25 +0800
Message-ID: <20180129034823.GA20875@liangdeMacBook-Pro.local>
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
	<20180125045926.GA4720@localhost>
	<b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
	<20180126064647.GA12068@localhost>
	<b6f06c50-8b50-809c-0c7d-770db232d762@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f06c50-8b50-809c-0c7d-770db232d762@redhat.com>
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
Cc: Liang Li <liliang.opensource@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, Jan 26, 2018 at 08:04:08AM -0600, Eric Blake wrote:
> On 01/26/2018 12:46 AM, Liang Li wrote:
> > The current QMP command is:
> > 
> > { 'command': 'block-job-cancel', 'data': { 'device': 'str', '*force': 'bool' } }
> > 
> > 'force' has other meaning which is not used by libvirt, for the change, there
> > are 3 options:
> > 
> > a. Now that 'force' is not used by libvirt and it current semantic is not very useful,
> > we can change it's semantic to force-quit without syncing.
> 
> The current semantics are:
> 
> # @force: whether to allow cancellation of a paused job (default
> #         false).  Since 1.3.
> 
> You are right that libvirt is not using it at the moment; but that
> doesn't tell us whether someone else is using it.  On the other hand, it
> is a fairly easy argument to make that "a job which is paused is not
> complete, so forcing it to cancel means an unclean image left behind",
> which can then be reformulated as "the force flag says to cancel
> immediately, whether the job is paused or has pending data, and thus
> leave an unclean image behind".  In other words, I don't think it is too
> bad to just tidy up the wording, and allow the existing 'force':true
> parameter to be enabled to quit a job that won't converge.
> 
> > 
> > b. change 'force' from bool to flag, and bit 0 is used for it's original meaning.
> 
> Not possible.  You can't change from 'force':true to 'force':1 in JSON,
> at least not without rewriting the command to use an alternate that
> accepts both bool and int (actually, I seem to recall that we tightened
> QAPI to not permit alternates that might be ambiguous when parsed by
> QemuOpts, which may mean that is not even possible - although I haven't
> tried to see if it works or gives an error).
> 
> > 
> > c. add another bool parameter.
> 
> Also doable, if we are concerned that existing semantics of 'force'
> affecting only paused jobs must be preserved.
> 
> > 
> > 
> > which is the best one?
> 
> 1 is slightly less code, but 3 is more conservative.  I'd be okay with
> option 1 if no one else can provide a reason why it would break something.
> 

OK. I will send a patch based on the first option.

Thanks!

Liang
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
