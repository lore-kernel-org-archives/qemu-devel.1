Received: from eggs.gnu.org ([2001:4830:134:3::10]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfXa-0001kK-Jk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfXX-00021v-2r
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNfXW-00021J-R0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:19:23 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a92a314-983c-7fe5-dc92-c18b514f32bc@redhat.com>
Date: Wed, 21 Jun 2017 15:19:19 +0200
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/15] add disable-tcg option for x86 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com



On 21/06/2017 12:19, Yang Zhong wrote:
> This patchset rebased from Paolo's below patchset, which was based on
> QEMU 2.0.50 version. 
> https://github.com/bonzini/qemu/tree/disable-tcg

Patches 7/8/11 seems fine, I have already queued them (though I still
have to test everything).

Paolo

> Since qemu-system-x86_64 enabled kvm and TCG accelators by default, in 
> fact, the TCG accelator is NOT useful in the system build of x86 platform. 
> This patchset will disable TCG for x86 platform if --disable-tcg option is 
> added into ./configure command.
> 
> The new configure build command like below
> (1)./configure
>    tcg is enabled by default
> 
> (2)./configure --disable-tcg
>    tcg is disabled in i386 and x86_64 softmmu build
>    tcg is enabled in others softmmu and all users build
> 
> (3)./configure --disable-tcg --target-list=x86_64-softmmu, x86_64-linux-user
>    tcg is disabled in x86_64 softmmu build
>    tcg is enabled in x86_64 linux user build 
> 
> How to verify disable-tcg option
> (1)./configure
>    a)all user and softmmu build are okay.
>    b) CONFIG_TCG=y is set in $config_target_mak in all user and softmmu directory
>    c)kvm starting vm is okay
>      ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,threads=1,\
>        sockets=1 -drive format=raw,file=eywa.img,index=0,media=disk -nographic -serial \
>        stdio -nodefaults
>    d)tcg starting vm is okay
>      ./qemu-system-x86_64 -m 2G -smp cpus=4,cores=4,threads=1,sockets=1 -drive format=raw,\
>         file=eywa.img,index=0,media=disk -nographic -serial stdio -nodefaults
> 
> (2) ./configure --disable-tcg  
>    a) all user and softmmu build are okay.
>    b) CONFIG_TCG=y is not set in $config_target_mak in i386_softmmu and x86_64-softmmu 
>       directory
>    c) kvm starting vm is okay
>      ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,threads=1,\
>        sockets=1 -drive format=raw,file=eywa.img,index=0,media=disk -nographic -serial \
>        stdio -nodefaults
>    d) tcg starting vm is aborted
>       The log as below:
>       "tcg" accelerator not found.
>       No accelerator found!
> 
> 
> Yang Zhong (15):
>   configure: add the disable-tcg option
>   vl: add CONFIG_TCG for tcg related code
>   tcg: tcg_handle_interrupt() function
>   tcg: change tcg_enabled()
>   tcg: move page_size_init() function
>   kvmvapic: remove tcg related code
>   tcg: move cpu_sync_bndcs_hflags() function
>   tcg: make cpu_get_fp80()/cpu_set_fp80() static
>   tcg: add the tcg-stub.c file into accel/stubs/
>   tcg: move tb related lock functions
>   tcg: split cpu_set_mxcsr()/cpu_set_fpuc()
>   tcg: remove inline definition of flush_icache_range()
>   tcg: disable tcg in CPUX86State struct
>   tcg: add the CONFIG_TCG for header
>   tcg: add the CONFIG_TCG into Makefiles
> 
>  Makefile.target              |   4 +-
>  accel/Makefile.objs          |   2 +-
>  accel/stubs/Makefile.objs    |   1 +
>  accel/stubs/tcg-stub.c       | 129 +++++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/Makefile.objs      |   2 +-
>  accel/tcg/cpu-exec.c         |   1 +
>  accel/tcg/cputlb.c           |   1 +
>  accel/tcg/tcg-all.c          |   2 +-
>  accel/tcg/translate-all.c    |  54 ++++++++++--------
>  accel/tcg/translate-all.h    |   3 +
>  accel/tcg/translate-common.c |  56 -------------------
>  bsd-user/main.c              |   1 +
>  configure                    |  28 +++++++++-
>  cpus.c                       |   4 +-
>  exec.c                       |  20 +++++++
>  hw/i386/kvmvapic.c           |  24 --------
>  include/exec/cpu-defs.h      |   4 +-
>  include/exec/cputlb.h        |   2 +-
>  include/exec/exec-all.h      |  53 +++++++++---------
>  include/exec/helper-proto.h  |   2 +
>  include/qemu-common.h        |   7 ++-
>  linux-user/main.c            |   2 +-
>  target/i386/Makefile.objs    |   7 ++-
>  target/i386/cpu.h            |  22 ++++++--
>  target/i386/fpu_helper.c     |  26 +--------
>  target/i386/helper.c         |  34 +++++++++++-
>  target/i386/machine.c        |  18 ++++++
>  target/i386/mpx_helper.c     |  30 ----------
>  tcg/i386/tcg-target.h        |   5 +-
>  tcg/i386/tcg-target.inc.c    |   4 ++
>  tcg/tcg.h                    |   4 --
>  trace/control-target.c       |   1 -
>  vl.c                         |  12 ++++
>  33 files changed, 356 insertions(+), 209 deletions(-)
>  create mode 100644 accel/stubs/tcg-stub.c
>  delete mode 100644 accel/tcg/translate-common.c
> 
