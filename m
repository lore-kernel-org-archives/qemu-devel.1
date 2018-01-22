Received: from eggs.gnu.org ([2001:4830:134:3::10]:49623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1edaf7-00075Q-9e
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1edaf4-0001pU-6f
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:53:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1edaf3-0001ol-Tu
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:53:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8304E83F42
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 11:53:11 +0000 (UTC)
References: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
	<1515924416-9266-3-git-send-email-ghammer@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <584986dc-eeb6-4cfe-8ee3-330b17c55c09@redhat.com>
Date: Mon, 22 Jan 2018 12:53:04 +0100
MIME-Version: 1.0
In-Reply-To: <1515924416-9266-3-git-send-email-ghammer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] virtio: postpone the execution of
 event_notifier_cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 01/14/2018 11:06 AM, Gal Hammer wrote:
> Use the EventNotifier's cleanup callback function to execute the
> event_notifier_cleanup function after kvm unregistered the eventfd.
> 
> This change supports running the virtio_bus_set_host_notifier
> function inside a memory region transaction. Otherwise, a closed
> fd is sent to kvm, which results in a failure.
> 
> Signed-off-by: Gal Hammer <ghammer@redhat.com>
> ---
>  accel/kvm/kvm-all.c    |  4 ++++
>  hw/virtio/virtio-bus.c | 19 +++++++++++--------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f48..071f4f5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -812,6 +812,10 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
>      if (r < 0) {
>          abort();
>      }
> +
> +    if (e->cleanup) {
> +        e->cleanup(e);
> +    }
>  }
>  
>  static void kvm_io_ioeventfd_add(MemoryListener *listener,
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 3042232..8106346 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -256,6 +256,15 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
>      return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
>  }
>  
> +static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
> +{
> +    /* Test and clear notifier after disabling event,
> +     * in case poll callback didn't have time to run.
> +     */
> +    virtio_queue_host_notifier_read(notifier);
> +    event_notifier_cleanup(notifier);
> +}
> +
>  /*
>   * This function switches ioeventfd on/off in the device.
>   * The caller must set or clear the handlers for the EventNotifier.
> @@ -283,19 +292,13 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
>          r = k->ioeventfd_assign(proxy, notifier, n, true);
>          if (r < 0) {
>              error_report("%s: unable to assign ioeventfd: %d", __func__, r);
> -            goto cleanup_event_notifier;
> +            virtio_bus_cleanup_event_notifier(notifier);
>          }
> -        return 0;
>      } else {
> +        notifier->cleanup = virtio_bus_cleanup_event_notifier;
>          k->ioeventfd_assign(proxy, notifier, n, false);
>      }
>  
> -cleanup_event_notifier:
> -    /* Test and clear notifier after disabling event,
> -     * in case poll callback didn't have time to run.
> -     */
> -    virtio_queue_host_notifier_read(notifier);
> -    event_notifier_cleanup(notifier);
>      return r;
>  }
>  
> 

This causes abort() to me:

Thread 7 "CPU 3/KVM" received signal SIGABRT, Aborted.
[Switching to Thread 0x7f78fa1f4700 (LWP 13737)]
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51      }
__GI_raise 7 # bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007f7a09ff5c1a in __GI_abort () at abort.c:89
#2  0x000055f2a70bce9d in kvm_io_ioeventfd_del (listener=0x55f2a7d19200 <kvm_io_listener>, section=0x7f78fa1f10f0, match_data=true, data=0, e=0x7f79fc81f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:852
#3  0x000055f2a70a6fac in address_space_add_del_ioeventfds (as=0x55f2a7e86620 <address_space_io>, fds_new=0x7f78e40b9e80, fds_new_nb=2, fds_old=0x7f78e40b9f10, fds_old_nb=3) at /home/zippy/work/qemu/qemu.git/memory.c:832
#4  0x000055f2a70a744d in address_space_update_ioeventfds (as=0x55f2a7e86620 <address_space_io>) at /home/zippy/work/qemu/qemu.git/memory.c:895
#5  0x000055f2a70a7f04 in memory_region_transaction_commit () at /home/zippy/work/qemu/qemu.git/memory.c:1097
#6  0x000055f2a70ab0d1 in memory_region_del_eventfd (mr=0x55f2a9422250, addr=16, size=2, match_data=true, data=0, e=0x7f79fc81f080) at /home/zippy/work/qemu/qemu.git/memory.c:2273
#7  0x000055f2a7411f18 in virtio_pci_ioeventfd_assign (d=0x55f2a9421970, notifier=0x7f79fc81f080, n=0, assign=false) at hw/virtio/virtio-pci.c:280
#8  0x000055f2a7418e6f in virtio_bus_set_host_notifier (bus=0x55f2a9429a68, n=0, assign=false) at hw/virtio/virtio-bus.c:299
#9  0x000055f2a710236a in virtio_scsi_dataplane_stop (vdev=0x55f2a9429ae0) at /home/zippy/work/qemu/qemu.git/hw/scsi/virtio-scsi-dataplane.c:215
#10 0x000055f2a7418bb3 in virtio_bus_stop_ioeventfd (bus=0x55f2a9429a68) at hw/virtio/virtio-bus.c:246
#11 0x000055f2a7411f63 in virtio_pci_stop_ioeventfd (proxy=0x55f2a9421970) at hw/virtio/virtio-pci.c:294
#12 0x000055f2a74144ab in virtio_pci_common_write (opaque=0x55f2a9421970, addr=20, val=0, size=1) at hw/virtio/virtio-pci.c:1262
#13 0x000055f2a70a6016 in memory_region_write_accessor (mr=0x55f2a9422340, addr=20, value=0x7f78fa1f1558, size=1, shift=0, mask=255, attrs=...) at /home/zippy/work/qemu/qemu.git/memory.c:560
#14 0x000055f2a70a622e in access_with_adjusted_size (addr=20, value=0x7f78fa1f1558, size=1, access_size_min=1, access_size_max=4, access_fn=0x55f2a70a5f2c <memory_region_write_accessor>, mr=0x55f2a9422340, attrs=...) at /home/zippy/work/qemu/qemu.git/memory.c:627
#15 0x000055f2a70a8eb0 in memory_region_dispatch_write (mr=0x55f2a9422340, addr=20, data=0, size=1, attrs=...) at /home/zippy/work/qemu/qemu.git/memory.c:1503
#16 0x000055f2a7058b2b in flatview_write_continue (fv=0x7f78e405eba0, addr=4269834260, attrs=..., buf=0x7f7a26c36028 "", len=1, addr1=20, l=1, mr=0x55f2a9422340) at /home/zippy/work/qemu/qemu.git/exec.c:3038
#17 0x000055f2a7058c79 in flatview_write (fv=0x7f78e405eba0, addr=4269834260, attrs=..., buf=0x7f7a26c36028 "", len=1) at /home/zippy/work/qemu/qemu.git/exec.c:3083
#18 0x000055f2a7059050 in flatview_rw (fv=0x7f78e405eba0, addr=4269834260, attrs=..., buf=0x7f7a26c36028 "", len=1, is_write=true) at /home/zippy/work/qemu/qemu.git/exec.c:3192
#19 0x000055f2a7059108 in address_space_rw (as=0x55f2a7e86680 <address_space_memory>, addr=4269834260, attrs=..., buf=0x7f7a26c36028 "", len=1, is_write=true) at /home/zippy/work/qemu/qemu.git/exec.c:3202
#20 0x000055f2a70bf42c in kvm_cpu_exec (cpu=0x55f2a850cda0) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:1941
#21 0x000055f2a708d455 in qemu_kvm_cpu_thread_fn (arg=0x55f2a850cda0) at /home/zippy/work/qemu/qemu.git/cpus.c:1196
#22 0x000055f2a75ce829 in qemu_thread_start (args=0x55f2a852e260) at util/qemu-thread-posix.c:504
#23 0x00007f7a0a375887 in start_thread (arg=0x7f78fa1f4700) at pthread_create.c:456
#24 0x00007f7a0a0b7d4f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
__GI_raise 7 # up
#1  0x00007f7a09ff5c1a in __GI_abort () at abort.c:89
89            raise (SIGABRT);
__GI_abort 7 # 
#2  0x000055f2a70bce9d in kvm_io_ioeventfd_del (listener=0x55f2a7d19200 <kvm_io_listener>, section=0x7f78fa1f10f0, match_data=true, data=0, e=0x7f79fc81f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:852
852             abort();
kvm_io_ioeventfd_del 7 # p *e
$1 = {rfd = -1, wfd = -1, cleanup = 0x0}


I think the problem is that event_notifier_cleanup() is called before
kvm_io_ioeventfd_del() and both are called over the same EventNotifier.
This is supported by another data I was able to collect in a different
run:

Thread 4 "CPU 0/KVM" hit Breakpoint 1, event_notifier_cleanup (e=0x7fc6ac26f080) at util/event_notifier-posix.c:83
83          if (e->rfd != e->wfd) {
event_notifier_cleanup 4 # p *e
$1 = {rfd = 48, wfd = 48, cleanup = 0x55c91c76ac87 <virtio_bus_cleanup_event_notifier>}
event_notifier_cleanup 4 # c
Continuing.

Thread 4 "CPU 0/KVM" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51      }
__GI_raise 4 # up
#1  0x00007fc6b9a45c1a in __GI_abort () at abort.c:89
89            raise (SIGABRT);
__GI_abort 4 # 
#2  0x000055c91c40ee9d in kvm_io_ioeventfd_del (listener=0x55c91d06b200 <kvm_io_listener>, section=0x7fc5ab1fa0f0, match_data=true, data=0, e=0x7fc6ac26f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:852
852             abort();
kvm_io_ioeventfd_del 4 # p *e
$2 = {rfd = -1, wfd = -1, cleanup = 0x0}


So I drafted dirty workaround:

index 071f4f57c0..bf15344533 100644
--- i/accel/kvm/kvm-all.c
+++ w/accel/kvm/kvm-all.c
@@ -845,6 +845,9 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
     int fd = event_notifier_get_fd(e);
     int r;
 
+    if (fd == -1)
+        return;
+
     r = kvm_set_ioeventfd_pio(fd, section->offset_within_address_space,
                               data, false, int128_get64(section->size),
                               match_data);

But this time I'm getting following error:

kvm_io_ioeventfd_add: error adding ioeventfd: File exists

__GI_raise 7 # up
#1  0x00007f3ccd579c1a in __GI_abort () at abort.c:89
89            raise (SIGABRT);
__GI_abort 7 # 
#2  0x000055c68ac84e08 in kvm_io_ioeventfd_add (listener=0x55c68b8e1200 <kvm_io_listener>, section=0x7f3bbd7f1090, match_data=true, data=0, e=0x7f3bbcf8d080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:835
835             abort();
kvm_io_ioeventfd_add 7 # p *e
$1 = {rfd = 48, wfd = 48, cleanup = 0x0}




Michal
