Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3hYg-0005xZ-EJ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3hYc-0005q4-GF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:30:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f3hYc-0005os-64
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:30:30 -0400
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20c56323-b199-9fe1-8f1f-4f7247da0442@vivier.eu>
Date: Wed, 4 Apr 2018 14:30:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] microblaze stack pointer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi,

cleaning up linux-user signal handling functions, I found something weird.

In get_sp_from_cpustate(), SP is regs[14]:

linux-user/microblaze/target_signal.h

 24) static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
 25) {
 26)     return state->regs[14];
 27) }

But in get_sigframe(), SP is regs[1];

 4128) static abi_ulong get_sigframe(struct target_sigaction *ka,
 4129)                               CPUMBState *env, int frame_size)
 4130) {
 4131)     abi_ulong sp = env->regs[1];
 4132)
 4133)     if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 &&
!on_sig_stack(sp)) {
 4134)         sp = target_sigaltstack_used.ss_sp +
target_sigaltstack_used.ss
 4135)     }
 4136)
 4137)     return ((sp - frame_size) & -8UL);
 4138) }

Is this correct?

Thanks,
Laurent
