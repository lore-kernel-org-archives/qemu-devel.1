Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fNgUP-0001qu-Hp
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fNgUM-0007yG-4z
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:24:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fNgUL-0007xS-UO
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:24:42 -0400
Date: Tue, 29 May 2018 18:24:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180529182411-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<7e6412ef-4f92-dafa-acaf-b61296740f3d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7e6412ef-4f92-dafa-acaf-b61296740f3d@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Tue, May 29, 2018 at 11:00:21PM +0800, Hailiang Zhang wrote:
> On 2018/4/24 14:13, Wei Wang wrote:
> > This is the deivce part implementation to add a new feature,
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The dev=
ice
> > receives the guest free page hints from the driver and clears the
> > corresponding bits in the dirty bitmap, so that those free pages are
> > not transferred by the migration thread to the destination.
> >=20
> > - Test Environment
> >      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> >      Guest: 8G RAM, 4 vCPU
> >      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 =
second
> >=20
> > - Test Results
> >      - Idle Guest Live Migration Time (results are averaged over 10 r=
uns):
> >          - Optimization v.s. Legacy =3D 271ms vs 1769ms --> ~86% redu=
ction
> >      - Guest with Linux Compilation Workload (make bzImage -j4):
> >          - Live Migration Time (average)
> >            Optimization v.s. Legacy =3D 1265ms v.s. 2634ms --> ~51% r=
eduction
> >          - Linux Compilation Time
> >            Optimization v.s. Legacy =3D 4min56s v.s. 5min3s
> >            --> no obvious difference
> >=20
> > - Source Code
> >      - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
> >      - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
> >=20
> > ChangeLog:
> > v6->v7:
> >        virtio-balloon/virtio_balloo_poll_free_page_hints:
> >            - add virtio_notify() at the end to notify the driver that
> >              the optimization is done, which indicates that the entri=
es
> >              have all been put back to the vq and ready to detach the=
m.
> > v5->v6:
> >        virtio-balloon: use iothread to get free page hint
> > v4->v5:
> >      1) migration:
> >          - bitmap_clear_dirty: update the dirty bitmap and dirty page
> >            count under the bitmap mutex as what other functions are d=
oing;
> >          - qemu_guest_free_page_hint:
> >              - add comments for this function;
> >              - check the !block case;
> >              - check "offset > block->used_length" before proceed;
> >              - assign used_len inside the for{} body;
> >              - update the dirty bitmap and dirty page counter under t=
he
> >                bitmap mutex;
> >          - ram_state_reset:
> >              - rs->free_page_support: && with use "migrate_postcopy"
> >                instead of migration_in_postcopy;
> >              - clear the ram_bulk_stage flag if free_page_support is =
true;
> >      2) balloon:
> >           - add the usage documentation of balloon_free_page_start an=
d
> >             balloon_free_page_stop in code;
> >           - the optimization thread is named "balloon_fpo" to meet th=
e
> >             requirement of "less than 14 characters";
> >           - virtio_balloon_poll_free_page_hints:
> >               - run on condition when runstate_is_running() is true;
> >               - add a qemu spin lock to synchronize accesses to the f=
ree
> >                 page reporting related fields shared among the migrat=
ion
> >                 thread and the optimization thread;
> >            - virtio_balloon_free_page_start: just return if
> >              runstate_is_running is false;
> >            - virtio_balloon_free_page_stop: access to the free page
> >              reporting related fields under a qemu spin lock;
> >            - virtio_balloon_device_unrealize/reset: call
> >              virtio_balloon_free_page_stop is the free page hint feat=
ure is
> >              used;
> >            - virtio_balloon_set_status: call irtio_balloon_free_page_=
stop
> >              in case the guest is stopped by qmp when the optimizatio=
n is
> >              running;
> > v3->v4:
> >      1) bitmap: add a new API to count 1s starting from an offset of =
a
> >         bitmap
> >      2) migration:
> >          - qemu_guest_free_page_hint: calculate
> >            ram_state->migration_dirty_pages by counting how many bits=
 of
> >            free pages are truely cleared. If some of the bits were
> >            already 0, they shouldn't be deducted by
> >            ram_state->migration_dirty_pages. This wasn't needed for
> >            previous versions since we optimized bulk stage only,
> >            where all bits are guaranteed to be set. It's needed now
> >            because we extened the usage of this optimizaton to all st=
ages
> >            except the last stop&copy stage. From 2nd stage onward, th=
ere
> >            are possibilities that some bits of free pages are already=
 0.
> >       3) virtio-balloon:
> >           - virtio_balloon_free_page_report_status: introduce a new s=
tatus,
> >             FREE_PAGE_REPORT_S_EXIT. This status indicates that the
> >             optimization thread has exited. FREE_PAGE_REPORT_S_STOP m=
eans
> >             the reporting is stopped, but the optimization thread sti=
ll needs
> >             to be joined by the migration thread.
> > v2->v3:
> >      1) virtio-balloon
> >          - virtio_balloon_free_page_start: poll the hints using a new
> >            thread;
> >          - use cmd id between [0x80000000, UINT_MAX];
> >          - virtio_balloon_poll_free_page_hints:
> >              - stop the optimization only when it has started;
> >              - don't skip free pages when !poison_val;
> >          - add poison_val to vmsd to migrate;
> >          - virtio_balloon_get_features: add the F_PAGE_POISON feature=
 when
> >            host has F_FREE_PAGE_HINT;
> >          - remove the timer patch which is not needed now.
> >      2) migration
> >         - new api, qemu_guest_free_page_hint;
> >         - rs->free_page_support set only in the precopy case;
> >         - use the new balloon APIs.
> > v1->v2:
> >      1) virtio-balloon
> >          - use subsections to save free_page_report_cmd_id;
> >          - poll the free page vq after sending a cmd id to the driver=
;
> >          - change the free page vq size to VIRTQUEUE_MAX_SIZE;
> >          - virtio_balloon_poll_free_page_hints: handle the corner cas=
e
> >            that the free page block reported from the driver may cros=
s
> >            the RAMBlock boundary.
> >      2) migration/ram.c
> >          - use balloon_free_page_poll to start the optimization
> >=20
> >=20
> > Wei Wang (5):
> >    bitmap: bitmap_count_one_with_offset
> >    migration: use bitmap_mutex in migration_bitmap_clear_dirty
> >    migration: API to clear bits of guest free pages from the dirty bi=
tmap
> >    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >    migration: use the free page hint feature from balloon
> >=20
> >   balloon.c                                       |  58 +++++-
> >   hw/virtio/virtio-balloon.c                      | 241 +++++++++++++=
+++++++++--
> >   include/hw/virtio/virtio-balloon.h              |  27 ++-
> >   include/migration/misc.h                        |   2 +
> >   include/qemu/bitmap.h                           |  13 ++
> >   include/standard-headers/linux/virtio_balloon.h |   7 +
> >   include/sysemu/balloon.h                        |  15 +-
> >   migration/ram.c                                 |  73 ++++++-
> >   8 files changed, 406 insertions(+), 30 deletions(-)
>=20
> Nice optimization, for the first stage of=A0 current migration method, =
we need to migrate all the pages of
> VM to destination,=A0 with this capability, we can reduce lots of unnec=
essary pages migrating.
>=20
> Just a small piece of advice, it is better to split the fourth patch in=
to small ones, to make it more easy
> for reviewing. Besides, should we make this capability an optional one,=
 just like other migration capabilities do ?

That's already the case, one has to enable it in the balloon, and set
the iothread.

--=20
MST
