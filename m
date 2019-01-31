Received: from eggs.gnu.org ([209.51.188.92]:49566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gpEGm-0001UM-2c
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gpEGl-0003Dq-0F
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gpEGk-0003DF-Ov
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:28:46 -0500
Date: Thu, 31 Jan 2019 16:28:28 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190131152828.GA5111@beluga.usersys.redhat.com>
References: <20190123132413.GG27270@redhat.com>
	<20190123133301.GB20002@beluga.usersys.redhat.com>
	<20190123133614.GH27270@redhat.com>
	<25dd3d83-dbf9-5b8d-59d4-79501fe03f3c@amd.com>
	<20190129161542.GG5315@beluga.usersys.redhat.com>
	<20190129184008.GM30796@redhat.com>
	<20190130080630.GI5315@beluga.usersys.redhat.com>
	<20190130103719.GF15904@redhat.com>
	<20190130133954.GA30553@beluga.usersys.redhat.com>
	<20190130181822.GB15904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130181822.GB15904@redhat.com>
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jan 30, 2019 at 06:18:22PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 30, 2019 at 02:39:54PM +0100, Erik Skultety wrote:
> > > > > though, we need a #ifdef check for existance of PR_CAP_AMBIENT
> > > > >
> > > > > > An alternative question I've been playing ever since we excha=
nged the last few
> > > > > > emails is that can't we wait until the ioctls are compared ag=
ainst permissions
> > > > > > in kernel so that upstream libvirt (and downstream too for th=
at matter) doesn't
> > > > > > have to work around it and stick with that workaround for ete=
rnity?
> > > > >
> > > > > IIUC, the SEV feature has already shipped with distros, so we'd=
 effectively
> > > > > be saying that what we already shipped is unusable to libvirt. =
This doesn't
> > > > > feel like a desirable story to me.
> > > >
> > > > It was, but it never worked, it always has been broken in this wa=
y. When we
> > > > were merging this upstream, we had a terrible shortage of machine=
s and we had
> > > > to share, so the first person to provision the machine had alread=
y taken care
> > > > of the permissions in order to test so that led to this issue hav=
ing been
> > > > overlooked until now. If it ever worked as expected and then we b=
roke it, then
> > > > any fix from our side would make sense but otherwise I believe we=
 should fix
> > > > this bottom up.
> > >
> > > Well technically it would work if libvirt was configured to run as
> > > root:root, but yes, that is not a normal or recommended configurati=
on.
> > >
> > > Personally I have a preference for userspace solutions, as those ar=
e
> > > pretty straightforward to roll out to people as patches in existing
> > > releases. Deploying kernel updates is a higher bar to cross for an
> > > existing release.
> >
> > So, can you compile the prctl stuff in kernel conditionally? If so, t=
hen that's
> > a problem because you may end up with a platform where SEV is support=
ed within
> > kernel, but you don't have the ambient stuff we have to conditionally=
 compile
> > in libvirt, so you end up with broken SEV support anyway, I wanted to=
 argue
> > with centos 7, but the ambient set support was backported to 3.10, so=
 the only
> > distro where we'd have a problem from userspace POV would be debian 8=
, but then
> > again the kernel there is so old that neither SEV is supported there.
> >
> > I understand your point, but it also sounds very agile and I don't th=
ink that
> > compensating with "something that is fast" for "something that is rig=
ht" is the
> > way to go in the long term. Especially since we almost never deprecat=
e stuff
> > and we can't break compatibility. Trying to work around every issue c=
oming
> > from your dependencies in your project is highly unsustainable.
>
> With the launching of VMs we've got to a place where libvirt is pretty
> robust about being able to grant access regardless of what the host OS
> has done for permissions in /dev.  I think its desirable that this same
> flexibility extends to capabilities probing, which is somethign the
> dac_override approach allows. IOW, even if the kernel changes /dev/sev
> as previously discussed, I would keep the dac_override stuff for probin=
g
> capabilities forever. This makes sure we'll work even if the distro in
> question has strictly locked down permissions on /dev/kvm or /dev/sev,
> diverging from the default udev settup

Fair enough, I resent the series where I only exposed /dev/sev to machine=
s that
need it and applied the DAC_OVERRIDE_PATCH on top of that.
https://www.redhat.com/archives/libvir-list/2019-January/msg01343.html

Erik
