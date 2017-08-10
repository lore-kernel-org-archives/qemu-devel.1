Received: from eggs.gnu.org ([2001:4830:134:3::10]:35280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dfieo-0002FH-0w
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dfiem-00023U-K2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:17:30 -0400
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dfiem-000236-AI
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:17:28 -0400
Received: by mail-yw0-x22c.google.com with SMTP id p68so333429ywg.0
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 01:17:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <723efea0-9256-0710-3d6c-8d8868b32550@redhat.com>
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721102059.14663-3-famz@redhat.com>
	<723efea0-9256-0710-3d6c-8d8868b32550@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 10 Aug 2017 10:16:56 +0200
Message-ID: <CAATJJ0JH6Hbv9HFqgtpr76Jya11TwhcWGNZVxSd0c1R0sQH2TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] file-posix: Do runtime check for ofd
 lock API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Jul 21, 2017 at 2:36 PM, Eric Blake <eblake@redhat.com> wrote:

> On 07/21/2017 05:20 AM, Fam Zheng wrote:
> > It is reported that on Windows Subsystem for Linux, ofd operations fail
> > with -EINVAL. In other words, QEMU binary built with system headers that
> > exports F_OFD_SETLK doesn't necessarily run in an environment that
> > actually supports it:
> >
> > $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 \
> >     -device virtio-blk-pci,drive=hd0
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to
> unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to
> unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to
> lock byte 100
> >
> > Let's do a runtime check to cope with that.
>
> You may want to mention that the same is possible on a system with old
> kernel but new glibc (ie. this issue is not necessarily specific to WSL).
>

I first thought that this combination hitting me as I run KVM in containers
which can diverge glibc (in container) a lot from kernel (in host).

My issue turned out to be an apparmor block instead.
But since I clearly see how my case could lead to the mentioned
old kernel but new glibc I wanted to ping here to refresh/reconsider
this change as well.

Also the reply might be worth as documentation if people search for the
error
message and get here that the following apparmor block leads to the same.

apparmor="DENIED" operation="file_lock"
namespace="root//lxd-testkvm-artful-from_<var-lib-lxd>"
profile="libvirt-f687a9b3-5bca-41bc-b206-6e616720cc5e"
name="/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow" pid=7001
comm="qemu-system-x86" requested_mask="k" denied_mask="k" fsuid=0 ouid=0

I'll work on libvirt's virt-aa-helper to generate a rule appropriate for
the new behavior.
