Received: from eggs.gnu.org ([2001:4830:134:3::10]:57410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1e9ZFX-00047V-3k
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1e9ZFT-0004bk-4u
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:18:47 -0400
Received: from bitwagon.com ([74.82.39.175]:50695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1e9ZFS-0004Zb-RZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:18:43 -0400
Received: from f25e64.local ([71.36.99.203]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 09:18:38 -0700
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <92e2caac-31e2-d32f-1b71-810b8297736c@bitwagon.com>
Date: Tue, 31 Oct 2017 09:18:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] unfaithful emulation of system calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was surprised that my user-mode applications ran successfully under qemu-ppc64 2.10.1
running on Linux on x86_64, but crashed when run directly under Linux on 64-bit PowerPC.
Investigation showed that qemu-ppc64 does not emulate system calls faithfully.

On real Linux on PowerPC64, a system call trashes registers {r0, r4-r12, ctr};
qemu-ppc64 preserves them.  [Both preserve: r13-r31, r1 (sp), r2 (TOC), r3 (set to
return value), lr (link register).]  Looking at the code in qemu/linux-user/syscall.c
(tip commit 92c7ec5cd4d15c76218703f7bd3ca75bd46353b7), I do not see anything which
"enforces the ABI", such as by setting all volatile registers to a random value,
or a flag such as 0xA5A5A5...A5A5, or at least to 0.  qemu-user should.

This raises the question, "What *is* the ABI for system calls?".
The documentation  http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#REG
does not state explicitly that a system call is the same as a subroutine call.
Indeed it isn't, because a system call preserves the link register lr,
but a subroutine call need not.

So, how about qemu-user enforcing the ABI for system calls?

-- 
