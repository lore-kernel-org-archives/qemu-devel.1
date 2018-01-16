Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebQps-0006gV-E9
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebQpp-0002tS-Cn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebQpp-0002qk-3x
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:59:25 -0500
Date: Tue, 16 Jan 2018 12:59:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180116125909.GA2520@work-vm>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
	<CAFEAcA9xYNvJ5rwog7HCV=WYfC8n5aR=xc0i9Uc3WS3xkmz7tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9xYNvJ5rwog7HCV=WYfC8n5aR=xc0i9Uc3WS3xkmz7tw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/33] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 16 January 2018 at 04:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> > A large pull due to patch buildup over the holiday period.
> > Most notable here is probably the addition of vhost-user-blk.
> >
> > The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
> >
> >   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 631ae6adb1fcea786e0db8c6f1b19570bad0f90c:
> >
> >   vhost: remove assertion to prevent crash (2018-01-16 06:36:19 +0200)
> >
> > ----------------------------------------------------------------
> > pc, pci, virtio: features, fixes, cleanups
> >
> > A bunch of fixes, cleanus and new features all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> Build failure, 32 bit:
> 
> /home/peter.maydell/qemu/hw/virtio/vhost.c: In function 'vhost_commit':
> /home/peter.maydell/qemu/hw/virtio/vhost.c:666:28: error: cast to
> pointer from integer of different size [-Werror=int-to-pointer-cast]
>                             (void *)dev->mem->regions[i].userspace_addr,
>                             ^

Hmm yes that's from my 'vhost: Simplify ring verficiation checks'
and will need a (uintptr_t) adding.

Dave

> 
> Test failures, ppc64, s390x, sparc64 hosts (so likely all bigendian):
> 
> TEST: tests/device-introspect-test... (pid=57202)
>   /s390x/device/introspect/list:                                       OK
>   /s390x/device/introspect/list-fields:                                OK
>   /s390x/device/introspect/none:                                       OK
>   /s390x/device/introspect/abstract:                                   OK
>   /s390x/device/introspect/concrete:                                   **
> ERROR:/home/linux1/qemu/qom/object.c:372:object_initialize_with_type:
> assertion failed: (type != NULL)
> Broken pipe
> FAIL
> GTester: last random seed: R02S51c433c8a3c2fab5dd7233079b9dac7f
> (pid=57214)
>   /s390x/device/introspect/abstract-interfaces:                        OK
> FAIL: tests/device-introspect-test
> 
> Looks like vhost-user-blk-pci is at fault:
> 
> $ gdb --args s390x-softmmu/qemu-system-s390x -device
> vhost-user-blk-pci -display none
> 
> Thread 1 "qemu-system-s39" received signal SIGABRT, Aborted.
> 0x000003ffe91381b8 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x000003ffe91381b8 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x000003ffe9139726 in __GI_abort () at abort.c:89
> #2  0x000003ffe96f9d1c in g_assertion_message () from
> /lib/s390x-linux-gnu/libglib-2.0.so.0
> #3  0x000003ffe96f9dc6 in g_assertion_message_expr () from
> /lib/s390x-linux-gnu/libglib-2.0.so.0
> #4  0x000002aa002f7f82 in object_initialize_with_type (data=<optimized
> out>, size=<optimized out>,
>     type=<optimized out>) at /home/linux1/qemu/qom/object.c:372
> #5  0x000002aa0018f84e in virtio_instance_init_common
> (proxy_obj=0x2aa00d49e10, data=0x2aa00d51f60,
>     vdev_size=<optimized out>, vdev_name=<optimized out>) at
> /home/linux1/qemu/hw/virtio/virtio.c:2232
> #6  0x000002aa002881fe in vhost_user_blk_pci_instance_init (obj=0x2aa00d49e10)
>     at /home/linux1/qemu/hw/virtio/virtio-pci.c:2018
> #7  0x000002aa002f7e02 in object_initialize_with_type
> (data=data@entry=0x2aa00d49e10, size=34200,
>     type=type@entry=0x2aa00c87c90) at /home/linux1/qemu/qom/object.c:384
> #8  0x000002aa002f7fd8 in object_new_with_type (type=0x2aa00c87c90) at
> /home/linux1/qemu/qom/object.c:492
> #9  0x000002aa001fb344 in qdev_device_add (opts=<optimized out>,
> errp=<optimized out>)
>     at /home/linux1/qemu/qdev-monitor.c:612
> #10 0x000002aa001fe2fc in device_init_func (opaque=<optimized out>,
> opts=<optimized out>,
>     errp=<optimized out>) at /home/linux1/qemu/vl.c:2387
> #11 0x000002aa003f59b6 in qemu_opts_foreach (list=<optimized out>,
> func=0x2aa001fe2c8 <device_init_func>,
>     opaque=0x0, errp=0x0) at /home/linux1/qemu/util/qemu-option.c:1070
> #12 0x000002aa000ebc40 in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>)
>     at /home/linux1/qemu/vl.c:4648
> 
> (required QOM type not compiled in ?)
> 
> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
