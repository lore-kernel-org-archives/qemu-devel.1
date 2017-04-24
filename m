Received: from eggs.gnu.org ([2001:4830:134:3::10]:41069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2jOg-0006TY-S4
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2jOd-0005c3-H1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:11:42 -0400
Received: from mail.kernel.org ([198.145.29.136]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d2jOd-0005bD-80
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:11:39 -0400
Date: Mon, 24 Apr 2017 12:11:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <d5282601-a396-4493-3de5-395e25a69bb1@redhat.com>
Message-ID: <alpine.DEB.2.10.1704241210340.16723@sstabellini-ThinkPad-X260>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<d5282601-a396-4493-3de5-395e25a69bb1@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC 0/7] Move accel, KVM, Xen,
 qtest files to accel/ subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org, xen-devel@lists.xensource.com, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Mon, 24 Apr 2017, Thomas Huth wrote:
> On 20.12.2016 18:43, Eduardo Habkost wrote:
> > This moves the KVM and Xen files to the an accel/ subdir.
> > 
> > Instead of moving the *-stubs.c file to accel/ as-is, I tried to
> > move most of the stub code to libqemustub.a. This way the obj-y
> > logic for accel/ is simpler: obj-y includes accel/ only if
> > CONFIG_SOFTMMU is set.
> > 
> > The Xen stubs could be moved completely to stubs/, but some of
> > the KVM stubs depend on cpu.h. So most of the kvm-stub.c code was
> > moved to stubs/kvm.c, but some of that code was kept in
> > accel/kvm-stub.c.
> > 
> > About TCG:
> > ----------
> > 
> > It is not obvious to me which TCG-related files could be moved to
> > accel/, so this series don't move any of them yet.
> > 
> > About other CONFIG_SOFTMMU top-level files:
> > -------------------------------------------
> > 
> > I would like to know what we should do with the top-level
> > CONFIG_SOFTMMU-only files that don't belong to hw/. Some
> > candidates: arch_init.c cpus.c monitor.c gdbstub.c balloon.c
> > ioport.c bootdevice.c memory.c cputlb.c memory_mapping.c dump.c.
> > 
> > Maybe a sysemu/ subdir? In that case, should we still create an
> > accel/ subdir, or move xen-*, kvm-* and friends to sysemu/ too?
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xensource.com
> > 
> > Eduardo Habkost (7):
> >   xen: Move xen-*-stub.c to stubs/
> >   xen: Move xen files to accel/
> >   kvm: Move some kvm-stub.c code to stubs/kvm.c
> >   kvm: Include kvm-stub.o only on CONFIG_SOFTMMU
> >   kvm: Move kvm*.c files to accel/
> >   accel: Move accel.c to accel/
> >   accel: Move qtest.c to accel/
> > 
> >  Makefile.objs                          |  2 +-
> >  Makefile.target                        | 10 ++----
> >  accel.c => accel/accel.c               |  0
> >  kvm-all.c => accel/kvm-common.c        |  0
> >  kvm-stub.c => accel/kvm-stub.c         | 51 --------------------------
> >  qtest.c => accel/qtest.c               |  0
> >  xen-common.c => accel/xen-common.c     |  0
> >  xen-hvm.c => accel/xen-hvm.c           |  0
> >  xen-mapcache.c => accel/xen-mapcache.c |  0
> >  stubs/kvm.c                            | 65 ++++++++++++++++++++++++++++++++++
> >  xen-hvm-stub.c => stubs/xen-hvm.c      |  0
> >  xen-common-stub.c => stubs/xen.c       |  0
> >  MAINTAINERS                            |  4 +--
> >  accel/Makefile.objs                    |  9 +++++
> >  stubs/Makefile.objs                    |  2 ++
> >  15 files changed, 80 insertions(+), 63 deletions(-)
> >  rename accel.c => accel/accel.c (100%)
> >  rename kvm-all.c => accel/kvm-common.c (100%)
> >  rename kvm-stub.c => accel/kvm-stub.c (71%)
> >  rename qtest.c => accel/qtest.c (100%)
> >  rename xen-common.c => accel/xen-common.c (100%)
> >  rename xen-hvm.c => accel/xen-hvm.c (100%)
> >  rename xen-mapcache.c => accel/xen-mapcache.c (100%)
> >  rename xen-hvm-stub.c => stubs/xen-hvm.c (100%)
> >  rename xen-common-stub.c => stubs/xen.c (100%)
> >  create mode 100644 accel/Makefile.objs
> 
> Now that the development tree is open again ... any chance that we could
> get this series into 2.10 ?

FYI I took Anothony Xu's patches to move the xen files under hw/xen/ and
hw/i386/xen, see the last 3 patches of
alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260. 
