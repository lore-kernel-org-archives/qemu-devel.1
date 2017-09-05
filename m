Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp51i-0005Eo-JG
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp51c-00036a-Ps
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:59:50 -0400
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:36541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dp51c-00036Q-JD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:59:44 -0400
Received: by mail-vk0-x22a.google.com with SMTP id v203so3862910vkv.3
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 20:59:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
From: =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?=
	<sergio.g.delreal@gmail.com>
Date: Mon, 4 Sep 2017 22:59:43 -0500
Message-ID: <CAMzKsXuXQW9yQMX__3neQwZkwRaDRs6WgYW2DpyHVXRMVNu-aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/14] add support for
 Hypervisor.framework in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patchset didn't address every issue, so it won't be the definite
version.
Hopefully however the licensing issue will get fixed with this version.

On Mon, Sep 4, 2017 at 10:54 PM, Sergio Andres Gomez Del Real <
sergio.g.delreal@gmail.com> wrote:

> ================
> Changes in v3:
>  (1) Fixed licensing issues in patch 3.
>  (2) Revert to late adding of compilation rules in Makefile.objs (patch
> 8/14);
>      files aren't ready to compile earlier.
>  (3) Make a single patch just for fixing style (patch 4/14).
>  (4) Fix data type for hvf_fd field.
>  (5) Add comment that return value of -1 in apic function added in 7/14
> means
>      "no interrupt".
> ================
>
> ================
> Changes in v2:
>  (1) Removed legacy option "-enable-hvf" in favor of "-M accel=hvf"
>  (2) Added missing copyright headers; replace fprintfs for error_report;
>      improved commit description.
>  (3) Moved patch that adds compilation rules in Makefile.objs right after
>      the patch that adds the new files from Google's repo.
>  (4) Removed conditional macros from cpus.c and cpu.c
>  (5) Moved patch that fixes coding style to patch # 3
>  (6) Fix commit message in apic patch
>  (7) Squash some commits to avoid code churn
> ================
>
> The following patchset adds to QEMU the supporting for macOS's native
> hypervisor, Hypervisor.framework (hvf). The code base is taken from
> Google's Android emulator at
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev.
>
> Apart from general code refactoring, some additional features were
> implemented:
> retrieve the set of features supported by host cpu and hvf (cpuid);
> dirty page tracking for VGA memory area; reimplementation of the event
> injection mechanism to allow injection of exceptions during vmexits, which
> is
> exemplified by the injection of a GP fault when the guest vmexits due to
> execution of the vmcall instruction; changing the emulator's use of
> CPUState
> structure in favor of CPUX86State, so as to in the future remove data
> structures
> that are uselessly specific to hvf and unified some of the state between
> kvm/tcg
> and hvf.
> Some features initially planned to implement that didn't make it include:
> page fault handling in the emulator and implementing the dummy_signal to
> handle
> the SIG_IPI signal without race conditions. Hopefully these can be
> implemented
> in the near future.
>
> Sergio Andres Gomez Del Real (14):
>   hvf: add support for Hypervisor.framework in the configure script
>   hvf: add code base from Google's QEMU repository
>   hvf: fix licensing issues; isolate task handling code (GPL v2-only)
>   hvf: run hvf code through checkpatch.pl and fix style issues
>   hvf: add code to cpus.c and do refactoring in preparation for
>     compiling
>   hvf: handle fields from CPUState and CPUX86State
>   apic: add function to apic that will be used by hvf
>   hvf: add compilation rules to Makefile.objs
>   hvf: use new helper functions for put/get xsave
>   hvf: implement hvf_get_supported_cpuid
>   hvf: refactor cpuid code
>   hvf: implement vga dirty page tracking
>   hvf: refactor event injection code for hvf
>   hvf: inject General Protection Fault when vmexit through vmcall
>
>  configure                           |   38 +
>  cpus.c                              |   86 ++
>  hw/intc/apic.c                      |   12 +
>  include/hw/i386/apic.h              |    1 +
>  include/qom/cpu.h                   |    2 +
>  include/sysemu/hvf.h                |  107 ++
>  qemu-options.hx                     |   10 +-
>  target/i386/Makefile.objs           |    1 +
>  target/i386/cpu-qom.h               |    4 +-
>  target/i386/cpu.c                   |   79 +-
>  target/i386/cpu.h                   |   38 +-
>  target/i386/hvf-all.c               |  963 +++++++++++++++
>  target/i386/hvf-i386.h              |   48 +
>  target/i386/hvf-utils/Makefile.objs |    1 +
>  target/i386/hvf-utils/README.md     |    7 +
>  target/i386/hvf-utils/vmcs.h        |  371 ++++++
>  target/i386/hvf-utils/vmx.h         |  222 ++++
>  target/i386/hvf-utils/x86.c         |  184 +++
>  target/i386/hvf-utils/x86.h         |  476 ++++++++
>  target/i386/hvf-utils/x86_cpuid.c   |  417 +++++++
>  target/i386/hvf-utils/x86_cpuid.h   |   52 +
>  target/i386/hvf-utils/x86_decode.c  | 2186 ++++++++++++++++++++++++++++++
> +++++
>  target/i386/hvf-utils/x86_decode.h  |  325 ++++++
>  target/i386/hvf-utils/x86_descr.c   |  124 ++
>  target/i386/hvf-utils/x86_descr.h   |   55 +
>  target/i386/hvf-utils/x86_emu.c     | 1536 ++++++++++++++++++++++++
>  target/i386/hvf-utils/x86_emu.h     |   49 +
>  target/i386/hvf-utils/x86_flags.c   |  333 ++++++
>  target/i386/hvf-utils/x86_flags.h   |  243 ++++
>  target/i386/hvf-utils/x86_gen.h     |   53 +
>  target/i386/hvf-utils/x86_mmu.c     |  273 +++++
>  target/i386/hvf-utils/x86_mmu.h     |   45 +
>  target/i386/hvf-utils/x86_task.c    |  201 ++++
>  target/i386/hvf-utils/x86_task.h    |   18 +
>  target/i386/hvf-utils/x86hvf.c      |  463 ++++++++
>  target/i386/hvf-utils/x86hvf.h      |   39 +
>  target/i386/kvm.c                   |    2 -
>  37 files changed, 9031 insertions(+), 33 deletions(-)
>  create mode 100644 include/sysemu/hvf.h
>  create mode 100644 target/i386/hvf-all.c
>  create mode 100644 target/i386/hvf-i386.h
>  create mode 100644 target/i386/hvf-utils/Makefile.objs
>  create mode 100644 target/i386/hvf-utils/README.md
>  create mode 100644 target/i386/hvf-utils/vmcs.h
>  create mode 100644 target/i386/hvf-utils/vmx.h
>  create mode 100644 target/i386/hvf-utils/x86.c
>  create mode 100644 target/i386/hvf-utils/x86.h
>  create mode 100644 target/i386/hvf-utils/x86_cpuid.c
>  create mode 100644 target/i386/hvf-utils/x86_cpuid.h
>  create mode 100644 target/i386/hvf-utils/x86_decode.c
>  create mode 100644 target/i386/hvf-utils/x86_decode.h
>  create mode 100644 target/i386/hvf-utils/x86_descr.c
>  create mode 100644 target/i386/hvf-utils/x86_descr.h
>  create mode 100644 target/i386/hvf-utils/x86_emu.c
>  create mode 100644 target/i386/hvf-utils/x86_emu.h
>  create mode 100644 target/i386/hvf-utils/x86_flags.c
>  create mode 100644 target/i386/hvf-utils/x86_flags.h
>  create mode 100644 target/i386/hvf-utils/x86_gen.h
>  create mode 100644 target/i386/hvf-utils/x86_mmu.c
>  create mode 100644 target/i386/hvf-utils/x86_mmu.h
>  create mode 100644 target/i386/hvf-utils/x86_task.c
>  create mode 100644 target/i386/hvf-utils/x86_task.h
>  create mode 100644 target/i386/hvf-utils/x86hvf.c
>  create mode 100644 target/i386/hvf-utils/x86hvf.h
>
> --
> 2.14.1
>
>
