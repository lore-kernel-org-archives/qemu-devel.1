Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbeDg-0006zl-FR
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbeDf-0004sn-Ic
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:24 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:33342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cbeDf-0004sh-DN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:23 -0500
Received: by mail-vk0-x22f.google.com with SMTP id k127so114627428vke.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 18:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209014728.GF22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
	<20170209014728.GF22807@lemon.lan>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 8 Feb 2017 18:11:42 -0800
Message-ID: <CAO_EM_mJYNoxTLjKmTy18JhrL_zs_VLA32Y=Cw+LYqAGPzLN=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Feb 8, 2017 at 5:47 PM, Fam Zheng <famz@redhat.com> wrote:
> No, something is wrong. The polling shouldn't keep running when there is no I/O
> activity.
>
> Can you try "perf top" to see what poll handlers are spinning?

Samples: 288K of event 'cycles', Event count (approx.): 57149970643
Overhead  Shared Object            Symbol
  16.96%  qemu-system-x86_64       [.] lduw_le_phys
  15.77%  [vdso]                   [.] __vdso_clock_gettime
   7.25%  qemu-system-x86_64       [.] qemu_lockcnt_cmpxchg_or_wait
   7.16%  qemu-system-x86_64       [.] aio_poll
   3.94%  qemu-system-x86_64       [.] address_space_translate
   3.69%  qemu-system-x86_64       [.] qemu_lockcnt_dec
   3.46%  qemu-system-x86_64       [.] virtio_queue_host_notifier_aio_poll
   3.32%  qemu-system-x86_64       [.] address_space_translate_internal
   2.54%  qemu-system-x86_64       [.] run_poll_handlers_once
   2.54%  libpthread-2.19.so       [.] pthread_mutex_lock
   2.53%  libpthread-2.19.so       [.] __pthread_mutex_unlock_usercnt
   2.53%  qemu-system-x86_64       [.] aio_notify_accept
   2.40%  qemu-system-x86_64       [.] timerlist_deadline_ns
   2.38%  qemu-system-x86_64       [.] address_space_lookup_region
   2.23%  qemu-system-x86_64       [.] timerlistgroup_deadline_ns
   2.21%  qemu-system-x86_64       [.] qemu_lockcnt_inc
   2.08%  qemu-system-x86_64       [.] qemu_clock_get_ns
   1.91%  qemu-system-x86_64       [.] object_dynamic_cast_assert
   1.54%  qemu-system-x86_64       [.] virtio_queue_notify_aio_vq.part.16
   1.21%  qemu-system-x86_64       [.] qemu_map_ram_ptr
   1.16%  libc-2.19.so             [.] __clock_gettime
   1.02%  qemu-system-x86_64       [.] event_notifier_poll
   1.02%  qemu-system-x86_64       [.] timerlistgroup_run_timers
   1.02%  qemu-system-x86_64       [.] virtio_queue_set_notification
   0.82%  qemu-system-x86_64       [.] aio_bh_poll
   0.81%  qemu-system-x86_64       [.] timerlist_run_timers
   0.70%  qemu-system-x86_64       [.] aio_dispatch
   0.66%  qemu-system-x86_64       [.] virtio_queue_empty.part.32
   0.62%  qemu-system-x86_64       [.] aio_compute_timeout
   0.50%  qemu-system-x86_64       [.] virtio_scsi_data_plane_handle_event
   0.32%  qemu-system-x86_64       [.] clock_gettime@plt
   0.26%  qemu-system-x86_64       [.] memory_region_is_ram_device
   0.21%  qemu-system-x86_64       [.] qemu_mutex_unlock
   0.12%  qemu-system-x86_64       [.] aio_context_acquire
   0.12%  qemu-system-x86_64       [.] iothread_run
   0.12%  qemu-system-x86_64       [.] qemu_lockcnt_count
   0.11%  qemu-system-x86_64       [.] pthread_mutex_lock@plt
   0.11%  qemu-system-x86_64       [.] qemu_mutex_lock
   0.11%  [kernel]                 [k] vmx_vcpu_run
   0.10%  libpthread-2.19.so       [.] pthread_mutex_unlock
   0.09%  qemu-system-x86_64       [.] aio_context_release
   0.09%  qemu-system-x86_64       [.] pthread_mutex_unlock@plt
   0.09%  [kernel]                 [k] native_write_msr_safe
   0.08%  [kernel]                 [k] ksm_do_scan
   0.07%  qemu-system-x86_64       [.] virtio_scsi_handle_event_vq

--Ed
