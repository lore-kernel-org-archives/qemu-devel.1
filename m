Received: from eggs.gnu.org ([2001:4830:134:3::10]:43301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raj.khem@gmail.com>) id 1dQZFL-00039L-NF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raj.khem@gmail.com>) id 1dQZFK-0000ck-0o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raj.khem@gmail.com>) id 1dQZFJ-0000bz-Nb
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:33 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so2498877wmh.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <927f7df8-7956-45b9-eb5e-0ea5f71779ea@vivier.eu>
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<927f7df8-7956-45b9-eb5e-0ea5f71779ea@vivier.eu>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 29 Jun 2017 06:12:02 -0700
Message-ID: <CAMKF1sqdJ0yyC2aG7wHipdGHZfXmL_kJrkd8-rCwQtuhr4hrJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jun 29, 2017 at 1:02 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 28/06/2017 =C3=A0 22:44, Khem Raj a =C3=A9crit :
>> The ucontext_t type had a tag struct ucontext until now
>> but newer glibc will drop it so we need to adjust and use
>> the exposed type instead
>
> I didn't find in glib git tree the commit dropping the struct tags for
> ucontext. Could you point it out?
>

see https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D251287734e89a5=
2da3db682a8241eb6bccc050c9

its also documented in (upcoming ) release notes

https://sourceware.org/glibc/wiki/Release/2.26#Removal_of_.27struct_ucontex=
t.27

> Thanks,
> Laurent
>
>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>> Cc: Kamil Rytarowski <kamil@netbsd.org>
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  linux-user/host/aarch64/hostdep.h |  2 +-
>>  linux-user/host/arm/hostdep.h     |  2 +-
>>  linux-user/host/i386/hostdep.h    |  2 +-
>>  linux-user/host/ppc64/hostdep.h   |  2 +-
>>  linux-user/host/s390x/hostdep.h   |  2 +-
>>  linux-user/host/x86_64/hostdep.h  |  2 +-
>>  linux-user/signal.c               | 10 +++++-----
>>  tests/tcg/test-i386.c             |  4 ++--
>>  user-exec.c                       | 18 +++++++++---------
>>  9 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/linux-user/host/aarch64/hostdep.h b/linux-user/host/aarch64=
/hostdep.h
>> index 64f75cef49..a8d41a21ad 100644
>> --- a/linux-user/host/aarch64/hostdep.h
>> +++ b/linux-user/host/aarch64/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      __u64 *pcreg =3D &uc->uc_mcontext.pc;
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/host/arm/hostdep.h b/linux-user/host/arm/hostdep=
.h
>> index 5c1ae60120..9276fe6ceb 100644
>> --- a/linux-user/host/arm/hostdep.h
>> +++ b/linux-user/host/arm/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      unsigned long *pcreg =3D &uc->uc_mcontext.arm_pc;
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/host/i386/hostdep.h b/linux-user/host/i386/hostd=
ep.h
>> index d834bd80ea..073be74d87 100644
>> --- a/linux-user/host/i386/hostdep.h
>> +++ b/linux-user/host/i386/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      greg_t *pcreg =3D &uc->uc_mcontext.gregs[REG_EIP];
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/host/ppc64/hostdep.h b/linux-user/host/ppc64/hos=
tdep.h
>> index 0b0f5f7821..98979ad917 100644
>> --- a/linux-user/host/ppc64/hostdep.h
>> +++ b/linux-user/host/ppc64/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      unsigned long *pcreg =3D &uc->uc_mcontext.gp_regs[PT_NIP];
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/host/s390x/hostdep.h b/linux-user/host/s390x/hos=
tdep.h
>> index 6f9da9c608..4f0171f36f 100644
>> --- a/linux-user/host/s390x/hostdep.h
>> +++ b/linux-user/host/s390x/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      unsigned long *pcreg =3D &uc->uc_mcontext.psw.addr;
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/host/x86_64/hostdep.h b/linux-user/host/x86_64/h=
ostdep.h
>> index 3b4259633e..a4fefb5114 100644
>> --- a/linux-user/host/x86_64/hostdep.h
>> +++ b/linux-user/host/x86_64/hostdep.h
>> @@ -24,7 +24,7 @@ extern char safe_syscall_end[];
>>  /* Adjust the signal context to rewind out of safe-syscall if we're in =
it */
>>  static inline void rewind_if_in_safe_syscall(void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      greg_t *pcreg =3D &uc->uc_mcontext.gregs[REG_RIP];
>>
>>      if (*pcreg > (uintptr_t)safe_syscall_start
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 3d18d1b3ee..2c55a4f600 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -3346,7 +3346,7 @@ static void setup_rt_frame(int sig, struct target_=
sigaction *ka,
>>      *
>>      *   a0 =3D signal number
>>      *   a1 =3D pointer to siginfo_t
>> -    *   a2 =3D pointer to struct ucontext
>> +    *   a2 =3D pointer to ucontext_t
>>      *
>>      * $25 and PC point to the signal handler, $29 points to the
>>      * struct sigframe.
>> @@ -3733,7 +3733,7 @@ struct target_signal_frame {
>>
>>  struct rt_signal_frame {
>>      siginfo_t info;
>> -    struct ucontext uc;
>> +    ucontext_t uc;
>>      uint32_t tramp[2];
>>  };
>>
>> @@ -3949,7 +3949,7 @@ struct rt_signal_frame {
>>      siginfo_t *pinfo;
>>      void *puc;
>>      siginfo_t info;
>> -    struct ucontext uc;
>> +    ucontext_t uc;
>>      uint16_t retcode[4];      /* Trampoline code. */
>>  };
>>
>> @@ -4484,7 +4484,7 @@ static void setup_rt_frame(int sig, struct target_=
sigaction *ka,
>>          tswap_siginfo(&frame->info, info);
>>      }
>>
>> -    /*err |=3D __clear_user(&frame->uc, offsetof(struct ucontext, uc_mc=
ontext));*/
>> +    /*err |=3D __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontex=
t));*/
>>      __put_user(0, &frame->uc.tuc_flags);
>>      __put_user(0, &frame->uc.tuc_link);
>>      __put_user(target_sigaltstack_used.ss_sp,
>> @@ -4976,7 +4976,7 @@ enum {
>>
>>  struct target_ucontext {
>>      target_ulong tuc_flags;
>> -    target_ulong tuc_link;    /* struct ucontext __user * */
>> +    target_ulong tuc_link;    /* ucontext_t __user * */
>>      struct target_sigaltstack tuc_stack;
>>  #if !defined(TARGET_PPC64)
>>      int32_t tuc_pad[7];
>> diff --git a/tests/tcg/test-i386.c b/tests/tcg/test-i386.c
>> index 0f7b943b0c..9599204895 100644
>> --- a/tests/tcg/test-i386.c
>> +++ b/tests/tcg/test-i386.c
>> @@ -1720,7 +1720,7 @@ int tab[2];
>>
>>  void sig_handler(int sig, siginfo_t *info, void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>
>>      printf("si_signo=3D%d si_errno=3D%d si_code=3D%d",
>>             info->si_signo, info->si_errno, info->si_code);
>> @@ -1912,7 +1912,7 @@ void test_exceptions(void)
>>  /* specific precise single step test */
>>  void sig_trap_handler(int sig, siginfo_t *info, void *puc)
>>  {
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      printf("EIP=3D" FMTLX "\n", (long)uc->uc_mcontext.gregs[REG_EIP]);
>>  }
>>
>> diff --git a/user-exec.c b/user-exec.c
>> index a8f95fa1e1..2a975eaf69 100644
>> --- a/user-exec.c
>> +++ b/user-exec.c
>> @@ -167,7 +167,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>  #elif defined(__OpenBSD__)
>>      struct sigcontext *uc =3D puc;
>>  #else
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>  #endif
>>      unsigned long pc;
>>      int trapno;
>> @@ -222,7 +222,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>  #elif defined(__OpenBSD__)
>>      struct sigcontext *uc =3D puc;
>>  #else
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>  #endif
>>
>>      pc =3D PC_sig(uc);
>> @@ -289,7 +289,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>  #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
>>      ucontext_t *uc =3D puc;
>>  #else
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>  #endif
>>      unsigned long pc;
>>      int is_write;
>> @@ -316,7 +316,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>                             void *puc)
>>  {
>>      siginfo_t *info =3D pinfo;
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      uint32_t *pc =3D uc->uc_mcontext.sc_pc;
>>      uint32_t insn =3D *pc;
>>      int is_write =3D 0;
>> @@ -414,7 +414,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>  #if defined(__NetBSD__)
>>      ucontext_t *uc =3D puc;
>>  #else
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>  #endif
>>      unsigned long pc;
>>      int is_write;
>> @@ -441,7 +441,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>  int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
>>  {
>>      siginfo_t *info =3D pinfo;
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      uintptr_t pc =3D uc->uc_mcontext.pc;
>>      uint32_t insn =3D *(uint32_t *)pc;
>>      bool is_write;
>> @@ -474,7 +474,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,=
 void *puc)
>>  int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
>>  {
>>      siginfo_t *info =3D pinfo;
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      unsigned long ip;
>>      int is_write =3D 0;
>>
>> @@ -505,7 +505,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>                         void *puc)
>>  {
>>      siginfo_t *info =3D pinfo;
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      unsigned long pc;
>>      uint16_t *pinsn;
>>      int is_write =3D 0;
>> @@ -558,7 +558,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>>                         void *puc)
>>  {
>>      siginfo_t *info =3D pinfo;
>> -    struct ucontext *uc =3D puc;
>> +    ucontext_t *uc =3D puc;
>>      greg_t pc =3D uc->uc_mcontext.pc;
>>      int is_write;
>>
>>
>
