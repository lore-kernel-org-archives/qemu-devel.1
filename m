Received: from eggs.gnu.org ([2001:4830:134:3::10]:44828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1fNg7T-0000U1-Ki
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1fNg7P-0004EM-89
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:01:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2103 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
	id 1fNg7O-00044w-L4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:00:59 -0400
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <7e6412ef-4f92-dafa-acaf-b61296740f3d@huawei.com>
Date: Tue, 29 May 2018 23:00:21 +0800
MIME-Version: 1.0
In-Reply-To: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
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
To: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On 2018/4/24 14:13, Wei Wang wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The devic=
e
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not transferred by the migration thread to the destination.
>
> - Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Guest: 8G RAM, 4 vCPU
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 se=
cond
>
> - Test Results
>      - Idle Guest Live Migration Time (results are averaged over 10 run=
s):
>          - Optimization v.s. Legacy =3D 271ms vs 1769ms --> ~86% reduct=
ion
>      - Guest with Linux Compilation Workload (make bzImage -j4):
>          - Live Migration Time (average)
>            Optimization v.s. Legacy =3D 1265ms v.s. 2634ms --> ~51% red=
uction
>          - Linux Compilation Time
>            Optimization v.s. Legacy =3D 4min56s v.s. 5min3s
>            --> no obvious difference
>
> - Source Code
>      - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
>      - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
>
> ChangeLog:
> v6->v7:
>        virtio-balloon/virtio_balloo_poll_free_page_hints:
>            - add virtio_notify() at the end to notify the driver that
>              the optimization is done, which indicates that the entries
>              have all been put back to the vq and ready to detach them.
> v5->v6:
>        virtio-balloon: use iothread to get free page hint
> v4->v5:
>      1) migration:
>          - bitmap_clear_dirty: update the dirty bitmap and dirty page
>            count under the bitmap mutex as what other functions are doi=
ng;
>          - qemu_guest_free_page_hint:
>              - add comments for this function;
>              - check the !block case;
>              - check "offset > block->used_length" before proceed;
>              - assign used_len inside the for{} body;
>              - update the dirty bitmap and dirty page counter under the
>                bitmap mutex;
>          - ram_state_reset:
>              - rs->free_page_support: && with use "migrate_postcopy"
>                instead of migration_in_postcopy;
>              - clear the ram_bulk_stage flag if free_page_support is tr=
ue;
>      2) balloon:
>           - add the usage documentation of balloon_free_page_start and
>             balloon_free_page_stop in code;
>           - the optimization thread is named "balloon_fpo" to meet the
>             requirement of "less than 14 characters";
>           - virtio_balloon_poll_free_page_hints:
>               - run on condition when runstate_is_running() is true;
>               - add a qemu spin lock to synchronize accesses to the fre=
e
>                 page reporting related fields shared among the migratio=
n
>                 thread and the optimization thread;
>            - virtio_balloon_free_page_start: just return if
>              runstate_is_running is false;
>            - virtio_balloon_free_page_stop: access to the free page
>              reporting related fields under a qemu spin lock;
>            - virtio_balloon_device_unrealize/reset: call
>              virtio_balloon_free_page_stop is the free page hint featur=
e is
>              used;
>            - virtio_balloon_set_status: call irtio_balloon_free_page_st=
op
>              in case the guest is stopped by qmp when the optimization =
is
>              running;
> v3->v4:
>      1) bitmap: add a new API to count 1s starting from an offset of a
>         bitmap
>      2) migration:
>          - qemu_guest_free_page_hint: calculate
>            ram_state->migration_dirty_pages by counting how many bits o=
f
>            free pages are truely cleared. If some of the bits were
>            already 0, they shouldn't be deducted by
>            ram_state->migration_dirty_pages. This wasn't needed for
>            previous versions since we optimized bulk stage only,
>            where all bits are guaranteed to be set. It's needed now
>            because we extened the usage of this optimizaton to all stag=
es
>            except the last stop&copy stage. From 2nd stage onward, ther=
e
>            are possibilities that some bits of free pages are already 0=
.
>       3) virtio-balloon:
>           - virtio_balloon_free_page_report_status: introduce a new sta=
tus,
>             FREE_PAGE_REPORT_S_EXIT. This status indicates that the
>             optimization thread has exited. FREE_PAGE_REPORT_S_STOP mea=
ns
>             the reporting is stopped, but the optimization thread still=
 needs
>             to be joined by the migration thread.
> v2->v3:
>      1) virtio-balloon
>          - virtio_balloon_free_page_start: poll the hints using a new
>            thread;
>          - use cmd id between [0x80000000, UINT_MAX];
>          - virtio_balloon_poll_free_page_hints:
>              - stop the optimization only when it has started;
>              - don't skip free pages when !poison_val;
>          - add poison_val to vmsd to migrate;
>          - virtio_balloon_get_features: add the F_PAGE_POISON feature w=
hen
>            host has F_FREE_PAGE_HINT;
>          - remove the timer patch which is not needed now.
>      2) migration
>         - new api, qemu_guest_free_page_hint;
>         - rs->free_page_support set only in the precopy case;
>         - use the new balloon APIs.
> v1->v2:
>      1) virtio-balloon
>          - use subsections to save free_page_report_cmd_id;
>          - poll the free page vq after sending a cmd id to the driver;
>          - change the free page vq size to VIRTQUEUE_MAX_SIZE;
>          - virtio_balloon_poll_free_page_hints: handle the corner case
>            that the free page block reported from the driver may cross
>            the RAMBlock boundary.
>      2) migration/ram.c
>          - use balloon_free_page_poll to start the optimization
>
>
> Wei Wang (5):
>    bitmap: bitmap_count_one_with_offset
>    migration: use bitmap_mutex in migration_bitmap_clear_dirty
>    migration: API to clear bits of guest free pages from the dirty bitm=
ap
>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>    migration: use the free page hint feature from balloon
>
>   balloon.c                                       |  58 +++++-
>   hw/virtio/virtio-balloon.c                      | 241 +++++++++++++++=
+++++++--
>   include/hw/virtio/virtio-balloon.h              |  27 ++-
>   include/migration/misc.h                        |   2 +
>   include/qemu/bitmap.h                           |  13 ++
>   include/standard-headers/linux/virtio_balloon.h |   7 +
>   include/sysemu/balloon.h                        |  15 +-
>   migration/ram.c                                 |  73 ++++++-
>   8 files changed, 406 insertions(+), 30 deletions(-)

Nice optimization, for the first stage of=C2=A0 current migration method,=
 we need to migrate all the pages of
VM to destination,=C2=A0 with this capability, we can reduce lots of unne=
cessary pages migrating.

Just a small piece of advice, it is better to split the fourth patch into=
 small ones, to make it more easy
for reviewing. Besides, should we make this capability an optional one, j=
ust like other migration capabilities do ?
