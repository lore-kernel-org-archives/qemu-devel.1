Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cePvP-0001Z0-2t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cePvO-0006ZQ-0Q
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:32:59 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cePvN-0006YV-Ps
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:32:57 -0500
Received: by mail-wr0-x22d.google.com with SMTP id i10so16600287wrb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:32:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 17:32:36 +0000
Message-ID: <CAFEAcA-na4tRT79jT+U8GgR8qekZUnxR2WyJzOE4dxzvFRPSDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/23] Misc patches for 2017-02-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2017 at 14:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 395d41a549f69f4ec603afa3d3ade1e2005777d5:
>
>   target-i386: correctly propagate retaddr into SVM helpers (2017-02-16 15:30:49 +0100)
>
> ----------------------------------------------------------------
> * GUEST_PANICKED improvements (Anton)
> * vCont gdbstub rewrite (Claudio)
> * Fix CPU creation with -device (Liyang)
> * Logging fixes for pty chardevs (Ed)
> * Makefile "move if changed" fix (Lin)
> * First part of cpu_exec refactoring (me)
> * SVM emulation fix (me)
> * apic_delivered fix (Pavel)
> * "info ioapic" fix (Peter)
> * qemu-nbd socket activation (Richard)
> * QOMification of mcf_uart (Thomas)

Fails to build on 32-bit ARM:

/home/petmay01/qemu/target/i386/svm_helper.c:63:6: error: conflicting
types for 'cpu_v
mexit'
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
      ^
In file included from /home/petmay01/qemu/target/i386/svm_helper.c:21:0:
/home/petmay01/qemu/target/i386/cpu.h:1625:6: note: previous
declaration of 'cpu_vmexit' was here
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
      ^
/home/petmay01/qemu/rules.mak:69: recipe for target
'target/i386/svm_helper.o' failed

The problem is in the bit of the prototype the error message
doesn't quote:

Prototype in cpu.h:
  void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                  uintptr_t retaddr);

svm_helper.c stub version;
  void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                  uint64_t retaddr)

svm_helper.c real version:
  void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
                  uintptr_t retaddr)

On 32-bit uintptr_t and uint64_t aren't the same thing.

thanks
-- PMM
