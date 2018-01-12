Received: from eggs.gnu.org ([2001:4830:134:3::10]:56074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea6FI-0001rR-Jo
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea6FD-0003vn-NJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:48:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ea6FD-0003ur-Cw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:48:07 -0500
Date: Fri, 12 Jan 2018 15:48:05 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1728988755.33187824.1515790085358.JavaMail.zimbra@redhat.com>
In-Reply-To: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> Hello QEMU Community!
> 
> Over the past few months the Hyper-V team at Microsoft has been working hard on
> a new user-mode API for our hypervisor that will be released as part of the
> upcoming SDK. This new API adds user-mode capabilities to create and manage
> partitions at the hypervisor level, configure memory mappings for the
> partition, and create and control execution of virtual processors.
> 
> With this new API we are now able to bring our hypervisor to the QEMU
> community! The following patches implement the Windows Hypervisor Platform
> accelerator (WHPX) for QEMU on Windows 10 hosts.
> 
> When compiling QEMU for x86_64 passing the --enable-whpx flag will compile
> the accelerator for use. At runtime using the '-accel whpx' should see a
> significant performance improvement over emulation, much like when using
> 'hax' on Windows.
> 
> Over the next few days the pre-release version of the documentation for this
> new API will be visible at https://docs.microsoft.com/en-us/virtualization under
> the 'Windows Hypervisor Platform' section. Here you will see the
> requirements, API, and examples.

That's great!  Accelerator galore. :)

>From a quick skim they patches seem to be generally pretty good!  I have a few quick
question on a couple features that seem to be missing:

- an important missing feature is support for CPU models (e.g. "-cpu Haswell").  Code
  for that was added recently for Hypervisor.framework and you should be able to copy
  some of it and then more for your CPUID intercept.  However, the question I have is:
  what interfaces does WHPX support to query the hypervisor's CPUID capabilities?

- is dirty memory support available?  The log_sync callback seems a bit incomplete :)
  If it's not, VGA output probably will not work.

- I might have missed this because the relevant code is quite repetitive - what about
  get/set of XSAVE areas?  If either this or dirty memory is not present, it's probably
  best to block migration (grep for migration_blockers).

Also, what versions of Windows will support WHPX?

Thanks,

Paolo
> Thank you for your feedback.
> 
> Justin Terry (VM) (4):
>   Add the Windows Hypervisor Platform accelerator.
>   Add the WHPX vcpu API
>   Introduce the WHPX impl
>   Add the WHPX acceleration enlightenments
> 
>  accel/stubs/Makefile.objs |    9 +-
>  accel/stubs/whpx-stub.c   |   48 ++
>  configure                 |   48 +-
>  cpus.c                    |   66 ++-
>  include/sysemu/hw_accel.h |   13 +
>  include/sysemu/whpx.h     |   40 ++
>  qemu-options.hx           |    8 +-
>  target/i386/Makefile.objs |    1 +
>  target/i386/helper.c      |    2 +-
>  target/i386/whpx-all.c    | 1395
>  +++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 1619 insertions(+), 11 deletions(-)
>  create mode 100644 accel/stubs/whpx-stub.c
>  create mode 100644 include/sysemu/whpx.h
>  create mode 100644 target/i386/whpx-all.c
> 
> --
> 2.7.4
> 
> 
