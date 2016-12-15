Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHbA9-0000Cg-Gn
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHbA5-0007DE-Le
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:53:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cHbA5-0007Cr-D3
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:53:49 -0500
Date: Thu, 15 Dec 2016 20:53:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161215205122-mutt-send-email-mst@kernel.org>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<20161215175533-mutt-send-email-mst@kernel.org>
	<20161215160740.GN2509@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215160740.GN2509@work-vm>
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce a new --only-migratable
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Thu, Dec 15, 2016 at 04:07:41PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Thu, Dec 15, 2016 at 12:36:59AM +0530, Ashijeet Acharya wrote:
> > > This series adds a new command line option "--only-migratable" which will only
> > > allow addition of those devices to a QEMU instance which are migratable and do
> > > not abruptly fail QEMU after migration.
> > > 
> > > Patch 1 adds the new option "-only-migratable".
> > > 
> > > Patch 2 adds compatibility for various "device adding" options for both via
> > > command line and hotplug methods.
> > > 
> > > Patch 3 handles the special case of devices which become unmigratable dynamically
> > > by making call to "migrate_add_blocker". Here we fail the particular action of the
> > > device which results in an unmigratable VM.
> > > Eg: 9pfs fails to mount the filesystem.
> > 
> > I guess that's possible but wouldn't it be cleaner to add introspection
> > so management can find out what can migrate?
> > Further, what should be removed (e.g. by hotplug) if you do want
> > to migrate.
> > 
> > As it is, you get a failure but no easy way for tools to
> > find out what was the failure reason.
> 
> You get the device name of the device that's failed don't you?

As a string but I'm not sure it's machine readable.

> Where would you add introspection?
> 
> Dave

monitor and command line.

> > 
> > > Ashijeet Acharya (3):
> > >   migration: Add a new option to enable only-migratable
> > >   migration: Allow "device add" options to only add migratable devices
> > >   migration: disallow migrate_add_blocker during migration
> > > 
> > >  block/qcow.c                  | 11 ++++++++++-
> > >  block/vdi.c                   | 11 ++++++++++-
> > >  block/vhdx.c                  | 20 ++++++++++++++------
> > >  block/vmdk.c                  | 12 +++++++++++-
> > >  block/vpc.c                   | 15 ++++++++++++---
> > >  block/vvfat.c                 | 24 ++++++++++++++++--------
> > >  hw/9pfs/9p.c                  | 22 ++++++++++++++++++----
> > >  hw/display/virtio-gpu.c       | 35 ++++++++++++++++++++++-------------
> > >  hw/intc/arm_gic_kvm.c         | 20 ++++++++++++++------
> > >  hw/intc/arm_gicv3_its_kvm.c   | 21 ++++++++++++++-------
> > >  hw/intc/arm_gicv3_kvm.c       | 22 +++++++++++++++-------
> > >  hw/misc/ivshmem.c             | 17 +++++++++++++----
> > >  hw/scsi/vhost-scsi.c          | 27 +++++++++++++++++++++------
> > >  hw/usb/bus.c                  | 15 +++++++++++++++
> > >  hw/virtio/vhost.c             | 11 ++++++++++-
> > >  include/migration/migration.h |  9 ++++++++-
> > >  migration/migration.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
> > >  qdev-monitor.c                |  9 +++++++++
> > >  qemu-options.hx               | 10 ++++++++++
> > >  stubs/migr-blocker.c          |  3 ++-
> > >  target-i386/kvm.c             | 19 ++++++++++++++++---
> > >  vl.c                          |  4 ++++
> > >  22 files changed, 304 insertions(+), 75 deletions(-)
> > > 
> > > -- 
> > > 2.6.2
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
