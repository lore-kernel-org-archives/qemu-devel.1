Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHYij-0002sC-2X
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHYif-0005tI-3e
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:25 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:32968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHYie-0005sf-Up
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:21 -0500
Received: by mail-io0-f193.google.com with SMTP id p13so8974592ioi.0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:17:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215160740.GN2509@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<20161215175533-mutt-send-email-mst@kernel.org>
	<20161215160740.GN2509@work-vm>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 21:46:18 +0530
Message-ID: <CAC2QTZa=Be6pcOUtxfBz+YHmj8sfF7CcB35ATjjd_ErCJSNY7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 15, 2016 at 9:37 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Thu, Dec 15, 2016 at 12:36:59AM +0530, Ashijeet Acharya wrote:
>> > This series adds a new command line option "--only-migratable" which will only
>> > allow addition of those devices to a QEMU instance which are migratable and do
>> > not abruptly fail QEMU after migration.
>> >
>> > Patch 1 adds the new option "-only-migratable".
>> >
>> > Patch 2 adds compatibility for various "device adding" options for both via
>> > command line and hotplug methods.
>> >
>> > Patch 3 handles the special case of devices which become unmigratable dynamically
>> > by making call to "migrate_add_blocker". Here we fail the particular action of the
>> > device which results in an unmigratable VM.
>> > Eg: 9pfs fails to mount the filesystem.
>>
>> I guess that's possible but wouldn't it be cleaner to add introspection
>> so management can find out what can migrate?
>> Further, what should be removed (e.g. by hotplug) if you do want
>> to migrate.

Actually, I think user never gets to add devices which are
unmigratable in the first place. So there won't be a possibility to
remove them because they never get added in the first place.

>>
>> As it is, you get a failure but no easy way for tools to
>> find out what was the failure reason.
>
> You get the device name of the device that's failed don't you?

Yes, I have included error messages explaining the cause and the name
of the device which failed it. Also, I would like opinions of everyone
on whether they give satisfactory explanation in each case.

Ashijeet

> Where would you add introspection?
>
> Dave
>
>>
>> > Ashijeet Acharya (3):
>> >   migration: Add a new option to enable only-migratable
>> >   migration: Allow "device add" options to only add migratable devices
>> >   migration: disallow migrate_add_blocker during migration
>> >
>> >  block/qcow.c                  | 11 ++++++++++-
>> >  block/vdi.c                   | 11 ++++++++++-
>> >  block/vhdx.c                  | 20 ++++++++++++++------
>> >  block/vmdk.c                  | 12 +++++++++++-
>> >  block/vpc.c                   | 15 ++++++++++++---
>> >  block/vvfat.c                 | 24 ++++++++++++++++--------
>> >  hw/9pfs/9p.c                  | 22 ++++++++++++++++++----
>> >  hw/display/virtio-gpu.c       | 35 ++++++++++++++++++++++-------------
>> >  hw/intc/arm_gic_kvm.c         | 20 ++++++++++++++------
>> >  hw/intc/arm_gicv3_its_kvm.c   | 21 ++++++++++++++-------
>> >  hw/intc/arm_gicv3_kvm.c       | 22 +++++++++++++++-------
>> >  hw/misc/ivshmem.c             | 17 +++++++++++++----
>> >  hw/scsi/vhost-scsi.c          | 27 +++++++++++++++++++++------
>> >  hw/usb/bus.c                  | 15 +++++++++++++++
>> >  hw/virtio/vhost.c             | 11 ++++++++++-
>> >  include/migration/migration.h |  9 ++++++++-
>> >  migration/migration.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
>> >  qdev-monitor.c                |  9 +++++++++
>> >  qemu-options.hx               | 10 ++++++++++
>> >  stubs/migr-blocker.c          |  3 ++-
>> >  target-i386/kvm.c             | 19 ++++++++++++++++---
>> >  vl.c                          |  4 ++++
>> >  22 files changed, 304 insertions(+), 75 deletions(-)
>> >
>> > --
>> > 2.6.2
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
