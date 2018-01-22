Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edfzu-0004Nn-Ie
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edfzt-0001cD-6C
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:35:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1edfzs-0001bm-Sh
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:35:05 -0500
Received: by mail-wr0-x242.google.com with SMTP id 16so9564448wry.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:35:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <584986dc-eeb6-4cfe-8ee3-330b17c55c09@redhat.com>
References: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
	<1515924416-9266-3-git-send-email-ghammer@redhat.com>
	<584986dc-eeb6-4cfe-8ee3-330b17c55c09@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2018 18:35:03 +0100
Message-ID: <CAJ+F1CL+_zXOW1920UcU3d0E4Sv3yA2pYUrDQFHW8nLbk2QcDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Gal Hammer <ghammer@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Mon, Jan 22, 2018 at 12:53 PM, Michal Privoznik <mprivozn@redhat.com> wr=
ote:
> On 01/14/2018 11:06 AM, Gal Hammer wrote:
>> Use the EventNotifier's cleanup callback function to execute the
>> event_notifier_cleanup function after kvm unregistered the eventfd.
>>
>> This change supports running the virtio_bus_set_host_notifier
>> function inside a memory region transaction. Otherwise, a closed
>> fd is sent to kvm, which results in a failure.
>>
>> Signed-off-by: Gal Hammer <ghammer@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c    |  4 ++++
>>  hw/virtio/virtio-bus.c | 19 +++++++++++--------
>>  2 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index f290f48..071f4f5 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -812,6 +812,10 @@ static void kvm_mem_ioeventfd_del(MemoryListener *l=
istener,
>>      if (r < 0) {
>>          abort();
>>      }
>> +
>> +    if (e->cleanup) {
>> +        e->cleanup(e);
>> +    }
>>  }
>>
>>  static void kvm_io_ioeventfd_add(MemoryListener *listener,
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index 3042232..8106346 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -256,6 +256,15 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *b=
us)
>>      return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
>>  }
>>
>> +static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
>> +{
>> +    /* Test and clear notifier after disabling event,
>> +     * in case poll callback didn't have time to run.
>> +     */
>> +    virtio_queue_host_notifier_read(notifier);
>> +    event_notifier_cleanup(notifier);
>> +}
>> +
>>  /*
>>   * This function switches ioeventfd on/off in the device.
>>   * The caller must set or clear the handlers for the EventNotifier.
>> @@ -283,19 +292,13 @@ int virtio_bus_set_host_notifier(VirtioBusState *b=
us, int n, bool assign)
>>          r =3D k->ioeventfd_assign(proxy, notifier, n, true);
>>          if (r < 0) {
>>              error_report("%s: unable to assign ioeventfd: %d", __func__=
, r);
>> -            goto cleanup_event_notifier;
>> +            virtio_bus_cleanup_event_notifier(notifier);
>>          }
>> -        return 0;
>>      } else {
>> +        notifier->cleanup =3D virtio_bus_cleanup_event_notifier;
>>          k->ioeventfd_assign(proxy, notifier, n, false);
>>      }
>>
>> -cleanup_event_notifier:
>> -    /* Test and clear notifier after disabling event,
>> -     * in case poll callback didn't have time to run.
>> -     */
>> -    virtio_queue_host_notifier_read(notifier);
>> -    event_notifier_cleanup(notifier);
>>      return r;
>>  }
>>
>>
>
> This causes abort() to me:
>
> Thread 7 "CPU 3/KVM" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7f78fa1f4700 (LWP 13737)]
> __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:51
> 51      }
> __GI_raise 7 # bt
> #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:51
> #1  0x00007f7a09ff5c1a in __GI_abort () at abort.c:89
> #2  0x000055f2a70bce9d in kvm_io_ioeventfd_del (listener=3D0x55f2a7d19200=
 <kvm_io_listener>, section=3D0x7f78fa1f10f0, match_data=3Dtrue, data=3D0, =
e=3D0x7f79fc81f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:8=
52
> #3  0x000055f2a70a6fac in address_space_add_del_ioeventfds (as=3D0x55f2a7=
e86620 <address_space_io>, fds_new=3D0x7f78e40b9e80, fds_new_nb=3D2, fds_ol=
d=3D0x7f78e40b9f10, fds_old_nb=3D3) at /home/zippy/work/qemu/qemu.git/memor=
y.c:832
> #4  0x000055f2a70a744d in address_space_update_ioeventfds (as=3D0x55f2a7e=
86620 <address_space_io>) at /home/zippy/work/qemu/qemu.git/memory.c:895
> #5  0x000055f2a70a7f04 in memory_region_transaction_commit () at /home/zi=
ppy/work/qemu/qemu.git/memory.c:1097
> #6  0x000055f2a70ab0d1 in memory_region_del_eventfd (mr=3D0x55f2a9422250,=
 addr=3D16, size=3D2, match_data=3Dtrue, data=3D0, e=3D0x7f79fc81f080) at /=
home/zippy/work/qemu/qemu.git/memory.c:2273
> #7  0x000055f2a7411f18 in virtio_pci_ioeventfd_assign (d=3D0x55f2a9421970=
, notifier=3D0x7f79fc81f080, n=3D0, assign=3Dfalse) at hw/virtio/virtio-pci=
.c:280
> #8  0x000055f2a7418e6f in virtio_bus_set_host_notifier (bus=3D0x55f2a9429=
a68, n=3D0, assign=3Dfalse) at hw/virtio/virtio-bus.c:299
> #9  0x000055f2a710236a in virtio_scsi_dataplane_stop (vdev=3D0x55f2a9429a=
e0) at /home/zippy/work/qemu/qemu.git/hw/scsi/virtio-scsi-dataplane.c:215
> #10 0x000055f2a7418bb3 in virtio_bus_stop_ioeventfd (bus=3D0x55f2a9429a68=
) at hw/virtio/virtio-bus.c:246
> #11 0x000055f2a7411f63 in virtio_pci_stop_ioeventfd (proxy=3D0x55f2a94219=
70) at hw/virtio/virtio-pci.c:294
> #12 0x000055f2a74144ab in virtio_pci_common_write (opaque=3D0x55f2a942197=
0, addr=3D20, val=3D0, size=3D1) at hw/virtio/virtio-pci.c:1262
> #13 0x000055f2a70a6016 in memory_region_write_accessor (mr=3D0x55f2a94223=
40, addr=3D20, value=3D0x7f78fa1f1558, size=3D1, shift=3D0, mask=3D255, att=
rs=3D...) at /home/zippy/work/qemu/qemu.git/memory.c:560
> #14 0x000055f2a70a622e in access_with_adjusted_size (addr=3D20, value=3D0=
x7f78fa1f1558, size=3D1, access_size_min=3D1, access_size_max=3D4, access_f=
n=3D0x55f2a70a5f2c <memory_region_write_accessor>, mr=3D0x55f2a9422340, att=
rs=3D...) at /home/zippy/work/qemu/qemu.git/memory.c:627
> #15 0x000055f2a70a8eb0 in memory_region_dispatch_write (mr=3D0x55f2a94223=
40, addr=3D20, data=3D0, size=3D1, attrs=3D...) at /home/zippy/work/qemu/qe=
mu.git/memory.c:1503
> #16 0x000055f2a7058b2b in flatview_write_continue (fv=3D0x7f78e405eba0, a=
ddr=3D4269834260, attrs=3D..., buf=3D0x7f7a26c36028 "", len=3D1, addr1=3D20=
, l=3D1, mr=3D0x55f2a9422340) at /home/zippy/work/qemu/qemu.git/exec.c:3038
> #17 0x000055f2a7058c79 in flatview_write (fv=3D0x7f78e405eba0, addr=3D426=
9834260, attrs=3D..., buf=3D0x7f7a26c36028 "", len=3D1) at /home/zippy/work=
/qemu/qemu.git/exec.c:3083
> #18 0x000055f2a7059050 in flatview_rw (fv=3D0x7f78e405eba0, addr=3D426983=
4260, attrs=3D..., buf=3D0x7f7a26c36028 "", len=3D1, is_write=3Dtrue) at /h=
ome/zippy/work/qemu/qemu.git/exec.c:3192
> #19 0x000055f2a7059108 in address_space_rw (as=3D0x55f2a7e86680 <address_=
space_memory>, addr=3D4269834260, attrs=3D..., buf=3D0x7f7a26c36028 "", len=
=3D1, is_write=3Dtrue) at /home/zippy/work/qemu/qemu.git/exec.c:3202
> #20 0x000055f2a70bf42c in kvm_cpu_exec (cpu=3D0x55f2a850cda0) at /home/zi=
ppy/work/qemu/qemu.git/accel/kvm/kvm-all.c:1941
> #21 0x000055f2a708d455 in qemu_kvm_cpu_thread_fn (arg=3D0x55f2a850cda0) a=
t /home/zippy/work/qemu/qemu.git/cpus.c:1196
> #22 0x000055f2a75ce829 in qemu_thread_start (args=3D0x55f2a852e260) at ut=
il/qemu-thread-posix.c:504
> #23 0x00007f7a0a375887 in start_thread (arg=3D0x7f78fa1f4700) at pthread_=
create.c:456
> #24 0x00007f7a0a0b7d4f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:97
> __GI_raise 7 # up
> #1  0x00007f7a09ff5c1a in __GI_abort () at abort.c:89
> 89            raise (SIGABRT);
> __GI_abort 7 #
> #2  0x000055f2a70bce9d in kvm_io_ioeventfd_del (listener=3D0x55f2a7d19200=
 <kvm_io_listener>, section=3D0x7f78fa1f10f0, match_data=3Dtrue, data=3D0, =
e=3D0x7f79fc81f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:8=
52
> 852             abort();
> kvm_io_ioeventfd_del 7 # p *e
> $1 =3D {rfd =3D -1, wfd =3D -1, cleanup =3D 0x0}
>
>
> I think the problem is that event_notifier_cleanup() is called before
> kvm_io_ioeventfd_del() and both are called over the same EventNotifier.
> This is supported by another data I was able to collect in a different
> run:
>
> Thread 4 "CPU 0/KVM" hit Breakpoint 1, event_notifier_cleanup (e=3D0x7fc6=
ac26f080) at util/event_notifier-posix.c:83
> 83          if (e->rfd !=3D e->wfd) {
> event_notifier_cleanup 4 # p *e
> $1 =3D {rfd =3D 48, wfd =3D 48, cleanup =3D 0x55c91c76ac87 <virtio_bus_cl=
eanup_event_notifier>}
> event_notifier_cleanup 4 # c
> Continuing.
>
> Thread 4 "CPU 0/KVM" received signal SIGABRT, Aborted.
> __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:51
> 51      }
> __GI_raise 4 # up
> #1  0x00007fc6b9a45c1a in __GI_abort () at abort.c:89
> 89            raise (SIGABRT);
> __GI_abort 4 #
> #2  0x000055c91c40ee9d in kvm_io_ioeventfd_del (listener=3D0x55c91d06b200=
 <kvm_io_listener>, section=3D0x7fc5ab1fa0f0, match_data=3Dtrue, data=3D0, =
e=3D0x7fc6ac26f080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:8=
52
> 852             abort();
> kvm_io_ioeventfd_del 4 # p *e
> $2 =3D {rfd =3D -1, wfd =3D -1, cleanup =3D 0x0}
>
>
> So I drafted dirty workaround:
>
> index 071f4f57c0..bf15344533 100644
> --- i/accel/kvm/kvm-all.c
> +++ w/accel/kvm/kvm-all.c
> @@ -845,6 +845,9 @@ static void kvm_io_ioeventfd_del(MemoryListener *list=
ener,
>      int fd =3D event_notifier_get_fd(e);
>      int r;
>
> +    if (fd =3D=3D -1)
> +        return;
> +
>      r =3D kvm_set_ioeventfd_pio(fd, section->offset_within_address_space=
,
>                                data, false, int128_get64(section->size),
>                                match_data);
>
> But this time I'm getting following error:
>
> kvm_io_ioeventfd_add: error adding ioeventfd: File exists
>
> __GI_raise 7 # up
> #1  0x00007f3ccd579c1a in __GI_abort () at abort.c:89
> 89            raise (SIGABRT);
> __GI_abort 7 #
> #2  0x000055c68ac84e08 in kvm_io_ioeventfd_add (listener=3D0x55c68b8e1200=
 <kvm_io_listener>, section=3D0x7f3bbd7f1090, match_data=3Dtrue, data=3D0, =
e=3D0x7f3bbcf8d080) at /home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:8=
35
> 835             abort();
> kvm_io_ioeventfd_add 7 # p *e
> $1 =3D {rfd =3D 48, wfd =3D 48, cleanup =3D 0x0}
>

I was about to report the same error when booting an uefi guest, I
bisected down to the same first bad commit.

Thanks Michal

--=20
Marc-Andr=C3=A9 Lureau
