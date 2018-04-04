Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f3iYz-0001f5-An
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f3iYw-00085Z-8t
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:34:57 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:53041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f3iYw-000856-1g
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:34:54 -0400
Received: by mail-wm0-x234.google.com with SMTP id g8so17274421wmd.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 06:34:53 -0700 (PDT)
Date: Wed, 4 Apr 2018 15:34:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180404133450.GP25124@toto>
References: <20c56323-b199-9fe1-8f1f-4f7247da0442@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c56323-b199-9fe1-8f1f-4f7247da0442@vivier.eu>
Subject: Re: [Qemu-devel] microblaze stack pointer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, Apr 04, 2018 at 02:30:26PM +0200, Laurent Vivier wrote:
> Hi,

Hi Laurent,

> 
> cleaning up linux-user signal handling functions, I found something weird.
> 
> In get_sp_from_cpustate(), SP is regs[14]:
> 
> linux-user/microblaze/target_signal.h
> 
>  24) static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
>  25) {
>  26)     return state->regs[14];
>  27) }
> 
> But in get_sigframe(), SP is regs[1];
> 
>  4128) static abi_ulong get_sigframe(struct target_sigaction *ka,
>  4129)                               CPUMBState *env, int frame_size)
>  4130) {
>  4131)     abi_ulong sp = env->regs[1];
>  4132)
>  4133)     if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 &&
> !on_sig_stack(sp)) {
>  4134)         sp = target_sigaltstack_used.ss_sp +
> target_sigaltstack_used.ss
>  4135)     }
>  4136)
>  4137)     return ((sp - frame_size) & -8UL);
>  4138) }
> 
> Is this correct?


get_sp_from_cpustate() is wrong, it should be regs[1]...

Cheers,
Edgar
