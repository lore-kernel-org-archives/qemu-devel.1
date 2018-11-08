Received: from eggs.gnu.org ([2001:4830:134:3::10]:44894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8435f2cfc=Paul.Durrant@citrix.com>)
	id 1gKksJ-0004vw-T0
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8435f2cfc=Paul.Durrant@citrix.com>)
	id 1gKksG-0005Nu-EG
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:01:35 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 8 Nov 2018 14:00:31 +0000
Message-ID: <24d1c322d3ac4ee2af32efacb486e608@AMSPEX02CL03.citrite.net>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<152b8d37c7d54de687f4ced536ba6a10@AMSPEX02CL03.citrite.net>
	<871s7z5xg4.fsf@dusky.pond.sub.org>
In-Reply-To: <871s7z5xg4.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] xen_disk qdevification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Kevin Wolf' <kwolf@redhat.com>, Anthony Perard <anthony.perard@citrix.com>
Cc: Tim Smith <tim.smith@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: 05 November 2018 15:58
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Kevin Wolf' <kwolf@redhat.com>; Tim Smith <tim.smith@citrix.com>;
> Stefano Stabellini <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Max Reitz <mreitz@redhat.com>; Anthony Perard
> <anthony.perard@citrix.com>; xen-devel@lists.xenproject.org
> Subject: Re: [Qemu-devel] xen_disk qdevification
>=20
> Paul Durrant <Paul.Durrant@citrix.com> writes:
>=20
> >> -----Original Message-----
> >> From: Kevin Wolf [mailto:kwolf@redhat.com]
> >> Sent: 02 November 2018 11:04
> >> To: Tim Smith <tim.smith@citrix.com>
> >> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; qemu-
> >> block@nongnu.org; Anthony Perard <anthony.perard@citrix.com>; Paul
> Durrant
> >> <Paul.Durrant@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>=
;
> >> Max Reitz <mreitz@redhat.com>; armbru@redhat.com
> >> Subject: xen_disk qdevification (was: [PATCH 0/3] Performance
> improvements
> >> for xen_disk v2)
> >>
> >> Am 02.11.2018 um 11:00 hat Tim Smith geschrieben:
> >> > A series of performance improvements for disks using the Xen PV ring=
.
> >> >
> >> > These have had fairly extensive testing.
> >> >
> >> > The batching and latency improvements together boost the throughput
> >> > of small reads and writes by two to six percent (measured using fio
> >> > in the guest)
> >> >
> >> > Avoiding repeated calls to posix_memalign() reduced the dirty heap
> >> > from 25MB to 5MB in the case of a single datapath process while also
> >> > improving performance.
> >> >
> >> > v2 removes some checkpatch complaints and fixes the CCs
> >>
> >> Completely unrelated, but since you're the first person touching
> >> xen_disk in a while, you're my victim:
> >>
> >> At KVM Forum we discussed sending a patch to deprecate xen_disk becaus=
e
> >> after all those years, it still hasn't been converted to qdev. Markus
> is
> >> currently fixing some other not yet qdevified block device, but after
> >> that xen_disk will be the only one left.
> >>
> >> A while ago, a downstream patch review found out that there are some
> QMP
> >> commands that would immediately crash if a xen_disk device were presen=
t
> >> because of the lacking qdevification. This is not the code quality
> >> standard I envision for QEMU. It's time for non-qdev devices to go.
> >>
> >> So if you guys are still interested in the device, could someone pleas=
e
> >> finally look into converting it?
> >>
> >
> > I have a patch series to do exactly this. It's somewhat involved as I
> > need to convert the whole PV backend infrastructure. I will try to
> > rebase and clean up my series a.s.a.p.
>=20
> Awesome!  Please coordinate with Anthony Prerard to avoid duplicating
> work if you haven't done so already.

I've come across a bit of a problem that I'm not sure how best to deal with=
 and so am looking for some advice.

I now have a qdevified PV disk backend but I can't bring it up because it f=
ails to acquire a write lock on the qcow2 it is pointing at. This is becaus=
e there is also an emulated IDE drive using the same qcow2. This does not a=
ppear to be a problem for the non-qdev xen-disk, presumably because it is n=
ot opening the qcow2 until the emulated device is unplugged and I don't rea=
lly want to introduce similar hackery in my new backend (i.e. I want it to =
attach to its drive, and hence open the qcow2, during realize).

So, I'm not sure what to do... It is not a problem that both a PV backend a=
nd an emulated device are using the same qcow2 because they will never actu=
ally operate simultaneously so is there any way I can bypass the qcow2 lock=
 check when I create the drive for my PV backend? (BTW I tried re-using the=
 drive created for the emulated device, but that doesn't work because there=
 is a check if a drive is already attached to something).

Any ideas?

  Paul
