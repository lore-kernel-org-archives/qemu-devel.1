Received: from eggs.gnu.org ([2001:4830:134:3::10]:41356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etXPg-0002XT-K0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etXPd-0005nX-Ep
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:39:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etXPd-0005n9-BF
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:39:13 -0500
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5584e442-5081-1bbe-1849-2c4517a69aba@redhat.com>
Date: Wed, 7 Mar 2018 12:39:10 +0100
MIME-Version: 1.0
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/34] Misc patches for 2018-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

On 06.03.2018 14:18, Paolo Bonzini wrote:
> The following changes since commit 58e2e17dba49b43f4ac9de19468aeae1c787=
dcc2:
>=20
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into s=
taging (2018-03-06 11:20:44 +0000)
>=20
> are available in the git repository at:
>=20
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
[...]
> Paolo Bonzini (9):
>       g364fb: fix DirtyBitmapSnapshot leak
>       openpic_kvm: drop address_space_to_flatview call
>       memory: inline some performance-sensitive accessors
>       address_space_write: address_space_to_flatview needs RCU lock
>       address_space_read: address_space_to_flatview needs RCU lock
>       address_space_access_valid: address_space_to_flatview needs RCU l=
ock
>       address_space_map: address_space_to_flatview needs RCU lock
>       address_space_rw: address_space_to_flatview needs RCU lock
>       Revert "build-sys: compile with -Og or -O1 when --enable-debug"

 Hi Paolo,

something in this PULL request caused a regression with the 40p machine,
it crashes now when QEMU is quit:

$ ppc-softmmu/qemu-system-ppc -M 40p -monitor stdio
QEMU 2.11.50 monitor - type 'help' for more information
(qemu) quit
qemu-system-ppc: include/qemu/rcu.h:89: rcu_read_unlock: Assertion `p_rcu=
_reader->depth !=3D 0' failed.
Aborted (core dumped)

(gdb) bt
#0  0x00007ffff1e841b7 in raise () at /lib64/libc.so.6
#1  0x00007ffff1e858a8 in abort () at /lib64/libc.so.6
#2  0x00007ffff1e7cfd6 in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007ffff1e7d082 in  () at /lib64/libc.so.6
#4  0x000055555583f786 in cpu_exec () at include/qemu/rcu.h:89
#5  0x000055555583f786 in cpu_exec (cpu=3Dcpu@entry=3D0x7ffff7dff010) at =
accel/tcg/cpu-exec.c:740
#6  0x0000555555811e0d in qemu_tcg_rr_cpu_thread_fn (cpu=3D0x7ffff7dff010=
) at cpus.c:1341
#7  0x0000555555811e0d in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at cpus.c:1435
#8  0x00007ffff70d8dd5 in start_thread () at /lib64/libpthread.so.0
#9  0x00007ffff1f4caed in clone () at /lib64/libc.so.6

Any ideas how to fix this?

 Thomas
