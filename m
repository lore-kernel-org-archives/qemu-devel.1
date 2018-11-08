Received: from eggs.gnu.org ([2001:4830:134:3::10]:45363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKm81-0004nz-7B
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKm7z-0002Oo-57
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:21:53 -0500
Date: Thu, 8 Nov 2018 16:21:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181108152120.GE6006@linux.fritz.box>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<152b8d37c7d54de687f4ced536ba6a10@AMSPEX02CL03.citrite.net>
	<871s7z5xg4.fsf@dusky.pond.sub.org>
	<24d1c322d3ac4ee2af32efacb486e608@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d1c322d3ac4ee2af32efacb486e608@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] xen_disk qdevification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Markus Armbruster' <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Tim Smith <tim.smith@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

Am 08.11.2018 um 15:00 hat Paul Durrant geschrieben:
> > -----Original Message-----
> > From: Markus Armbruster [mailto:armbru@redhat.com]
> > Sent: 05 November 2018 15:58
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: 'Kevin Wolf' <kwolf@redhat.com>; Tim Smith <tim.smith@citrix.com>;
> > Stefano Stabellini <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-
> > devel@nongnu.org; Max Reitz <mreitz@redhat.com>; Anthony Perard
> > <anthony.perard@citrix.com>; xen-devel@lists.xenproject.org
> > Subject: Re: [Qemu-devel] xen_disk qdevification
> > 
> > Paul Durrant <Paul.Durrant@citrix.com> writes:
> > 
> > >> -----Original Message-----
> > >> From: Kevin Wolf [mailto:kwolf@redhat.com]
> > >> Sent: 02 November 2018 11:04
> > >> To: Tim Smith <tim.smith@citrix.com>
> > >> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; qemu-
> > >> block@nongnu.org; Anthony Perard <anthony.perard@citrix.com>; Paul
> > Durrant
> > >> <Paul.Durrant@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > >> Max Reitz <mreitz@redhat.com>; armbru@redhat.com
> > >> Subject: xen_disk qdevification (was: [PATCH 0/3] Performance
> > improvements
> > >> for xen_disk v2)
> > >>
> > >> Am 02.11.2018 um 11:00 hat Tim Smith geschrieben:
> > >> > A series of performance improvements for disks using the Xen PV ring.
> > >> >
> > >> > These have had fairly extensive testing.
> > >> >
> > >> > The batching and latency improvements together boost the throughput
> > >> > of small reads and writes by two to six percent (measured using fio
> > >> > in the guest)
> > >> >
> > >> > Avoiding repeated calls to posix_memalign() reduced the dirty heap
> > >> > from 25MB to 5MB in the case of a single datapath process while also
> > >> > improving performance.
> > >> >
> > >> > v2 removes some checkpatch complaints and fixes the CCs
> > >>
> > >> Completely unrelated, but since you're the first person touching
> > >> xen_disk in a while, you're my victim:
> > >>
> > >> At KVM Forum we discussed sending a patch to deprecate xen_disk because
> > >> after all those years, it still hasn't been converted to qdev. Markus
> > is
> > >> currently fixing some other not yet qdevified block device, but after
> > >> that xen_disk will be the only one left.
> > >>
> > >> A while ago, a downstream patch review found out that there are some
> > QMP
> > >> commands that would immediately crash if a xen_disk device were present
> > >> because of the lacking qdevification. This is not the code quality
> > >> standard I envision for QEMU. It's time for non-qdev devices to go.
> > >>
> > >> So if you guys are still interested in the device, could someone please
> > >> finally look into converting it?
> > >>
> > >
> > > I have a patch series to do exactly this. It's somewhat involved as I
> > > need to convert the whole PV backend infrastructure. I will try to
> > > rebase and clean up my series a.s.a.p.
> > 
> > Awesome!  Please coordinate with Anthony Prerard to avoid duplicating
> > work if you haven't done so already.
> 
> I've come across a bit of a problem that I'm not sure how best to deal
> with and so am looking for some advice.
> 
> I now have a qdevified PV disk backend but I can't bring it up because
> it fails to acquire a write lock on the qcow2 it is pointing at. This
> is because there is also an emulated IDE drive using the same qcow2.
> This does not appear to be a problem for the non-qdev xen-disk,
> presumably because it is not opening the qcow2 until the emulated
> device is unplugged and I don't really want to introduce similar
> hackery in my new backend (i.e. I want it to attach to its drive, and
> hence open the qcow2, during realize).
> 
> So, I'm not sure what to do... It is not a problem that both a PV
> backend and an emulated device are using the same qcow2 because they
> will never actually operate simultaneously so is there any way I can
> bypass the qcow2 lock check when I create the drive for my PV backend?
> (BTW I tried re-using the drive created for the emulated device, but
> that doesn't work because there is a check if a drive is already
> attached to something).
> 
> Any ideas?

I think the clean solution is to keep the BlockBackend open in xen-disk
from the beginning, but not requesting write permissions yet.

The BlockBackend is created in parse_drive(), when qdev parses the
-device drive=... option. At this point, no permissions are requested
yet. That is done in blkconf_apply_backend_options(), which is manually
called from the devices; specifically from ide_dev_initfn() in IDE, and
I assume you call the function from xen-disk as well.

xen-disk should then call this function with readonly=true, and at the
point of the handover (when the IDE device is already gone) it can call
blk_set_perm() to request BLK_PERM_WRITE in addition to the permissions
it already holds.


The other option I see would be that you simply create both devices with
share-rw=on (which results in conf->share_rw == true and therefore
shared BLK_PERM_WRITE in blkconf_apply_backend_options()), but that
feels like a hack because you don't actually want to have two writers at
the same time.

Kevin
