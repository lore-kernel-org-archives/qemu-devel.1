Received: from eggs.gnu.org ([209.51.188.92]:42194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1goq6f-0007HC-V9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1goq6f-0000x3-22
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:40:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1goq6Z-0000tD-KR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:40:41 -0500
Date: Wed, 30 Jan 2019 14:39:54 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190130133954.GA30553@beluga.usersys.redhat.com>
References: <20190123131042.GF27270@redhat.com>
	<20190123132212.GA20002@beluga.usersys.redhat.com>
	<20190123132413.GG27270@redhat.com>
	<20190123133301.GB20002@beluga.usersys.redhat.com>
	<20190123133614.GH27270@redhat.com>
	<25dd3d83-dbf9-5b8d-59d4-79501fe03f3c@amd.com>
	<20190129161542.GG5315@beluga.usersys.redhat.com>
	<20190129184008.GM30796@redhat.com>
	<20190130080630.GI5315@beluga.usersys.redhat.com>
	<20190130103719.GF15904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130103719.GF15904@redhat.com>
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dinechin@redhat.com" <dinechin@redhat.com>, "mkletzan@redhat.com" <mkletzan@redhat.com>

> > > though, we need a #ifdef check for existance of PR_CAP_AMBIENT
> > >
> > > > An alternative question I've been playing ever since we exchanged the last few
> > > > emails is that can't we wait until the ioctls are compared against permissions
> > > > in kernel so that upstream libvirt (and downstream too for that matter) doesn't
> > > > have to work around it and stick with that workaround for eternity?
> > >
> > > IIUC, the SEV feature has already shipped with distros, so we'd effectively
> > > be saying that what we already shipped is unusable to libvirt. This doesn't
> > > feel like a desirable story to me.
> >
> > It was, but it never worked, it always has been broken in this way. When we
> > were merging this upstream, we had a terrible shortage of machines and we had
> > to share, so the first person to provision the machine had already taken care
> > of the permissions in order to test so that led to this issue having been
> > overlooked until now. If it ever worked as expected and then we broke it, then
> > any fix from our side would make sense but otherwise I believe we should fix
> > this bottom up.
>
> Well technically it would work if libvirt was configured to run as
> root:root, but yes, that is not a normal or recommended configuration.
>
> Personally I have a preference for userspace solutions, as those are
> pretty straightforward to roll out to people as patches in existing
> releases. Deploying kernel updates is a higher bar to cross for an
> existing release.

So, can you compile the prctl stuff in kernel conditionally? If so, then that's
a problem because you may end up with a platform where SEV is supported within
kernel, but you don't have the ambient stuff we have to conditionally compile
in libvirt, so you end up with broken SEV support anyway, I wanted to argue
with centos 7, but the ambient set support was backported to 3.10, so the only
distro where we'd have a problem from userspace POV would be debian 8, but then
again the kernel there is so old that neither SEV is supported there.

I understand your point, but it also sounds very agile and I don't think that
compensating with "something that is fast" for "something that is right" is the
way to go in the long term. Especially since we almost never deprecate stuff
and we can't break compatibility. Trying to work around every issue coming
from your dependencies in your project is highly unsustainable.

Thanks,
Erik
