Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqcUU-0001Ew-S6
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqcUR-0000tN-F2
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:00:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqcUR-0000tB-A0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:00:23 -0400
Date: Fri, 17 Aug 2018 12:00:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817110018.GI11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
	<20180817104706.GH11124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817104706.GH11124@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vm-tests images disks filling up?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Aug 17, 2018 at 11:47:06AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 17, 2018 at 11:26:39AM +0100, Peter Maydell wrote:
> > I just ran into a build failure using the tests/vm/ BSD build tests,
> > because the NetBSD build image's disk filled up.
> >=20
> > Looking more closely there seemed to be 9 stale build trees in
> > the VM's /var/tmp/qemu-test.* , which is why the disk was full
> > (they'd used up about 18GB between them).
> >=20
> > The other VMs (freebsd, openbsd) also had the same problem of
> > /var/tmp gradually filling with stale trees, they just hadn't
> > quite run out of space yet...
> >=20
> > What's the process for managing the disk space on these images?
> > How are stale or completed build trees deleted ?
>=20
> I'd prefer to see the test process honouring the build directory instea=
d
> of putting stuff in /var/tmp, so that a developer's normal approach to
> cleaning up build artifacts works.

Oh, wait I'm stupid,  you're talking about the /var/tmp inside the guest
disk images, not the host !

IIUC, the problem is that we create the tests/vm/freebsd.img file
by deep copying the template cached under $HOME and never purge it,
so it gradually fills up.

It would be desirable to guarantee a clean image for every build test
to avoid risk of previous problems affecting subsequent builds.

So how about we create tests/vm/freebsd.img as a qcow2 overlay that
points back to the cached image in $HOME. That makes it cheap to create,
so on every test we can just throw away the previous overlay to get
pristine state.

NB, don't delete the overlay at end of build - only start of the next
build. That gives devs a way to launch the VM to debug a failed build

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
