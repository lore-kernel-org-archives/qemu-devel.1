Received: from eggs.gnu.org ([2001:4830:134:3::10]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceJkr-0006vf-6K
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceJko-0003tD-23
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:57:41 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:53634)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceJkn-0003sZ-O9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:57:38 -0500
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <efb89578-ba8c-1f42-0ec3-79f769b3f1f1@genode-labs.com>
Date: Thu, 16 Feb 2017 11:57:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] x86 tlb_fill in memory_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

Hello,

I have a short question/observation and a longer story.

Short question:

Between qemu 2.4.1 and 2.5.0 following snippet of code vanished:

--- qemu-2.4.1/target-i386/mem_helper.c
+++ qemu-2.5.0/target-i386/mem_helper.c
@@ -122,11 +142,7 @@
         X86CPU *cpu =3D X86_CPU(cs);
         CPUX86State *env =3D &cpu->env;

-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        raise_exception_err(env, cs->exception_index, env->error_code);
+        raise_exception_err_ra(env, cs->exception_index,
env->error_code, retaddr);
     }
 }
 #endif

The special retaddr condition seems to be part in every other
architecture but not i386. Is there a specific reason ?

The point is - because I'm asking - beginning with qemu 2.5.0. the AMD
SVM virtualization (-cpu phenom) does not work anymore for us. Patching
the vanished retaddr condition back to 2.5.0, 2.8.0 and qemu devel git
branch makes it working again.



>From 87e061542205ac56cc485d13607db16239524e4b Mon Sep 17 00:00:00 2001
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Date: Thu, 16 Feb 2017 11:17:09 +0100
Subject: [PATCH] x86/tlb_fill: call cpu_restore_state on valid addr

Vanished between 2.4.1 and 2.5.0 release and breaks SVM virtualization.

Signed-off-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
---
 target/i386/mem_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 70f6766..d6267f9 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -209,6 +209,10 @@ void tlb_fill(CPUState *cs, target_ulong addr,
MMUAccessType access_type,
         X86CPU *cpu =3D X86_CPU(cs);
         CPUX86State *env =3D &cpu->env;

+        if (retaddr) {
+            /* now we have a real cpu fault */
+            cpu_restore_state(cs, retaddr);
+        }
         raise_exception_err_ra(env, cs->exception_index,
env->error_code, retaddr);
     }
 }
--=20
2.7.4



Thanks, in advance, (the longer story is below)

Alex.

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth






Long story:

We use Qemu for early debugging/developing of our Genode/Nova +
Virtualbox port. Genode [0] is a OS framework to build up own tailored
OSes, Nova [1] is a microkernel also being a hypervisor. We ported
Virtualbox on top of Genode/Nova [2] as a user-level VMM to run
unmodified VM Guests. We use AMD SVM (-cpu phenom) in Qemu for
debugging/developing hypervisor related virtualization related issues.

Beginning with 2.5.0 the setup suddenly don't run anymore and we get
mysterious triple faults originating from the guest (solely in Qemu,
same image runs fine on native hardware). We tested also 2.5.1, 2.8.0
and the current qemu.git repository
(5dae13cd71f0755a1395b5a4cde635b8a6ee3f58).

So, I made a diff from 2.4.1 to 2.5.0 and looked up what could be
potentially the change which effects us. The code snippet as above seems
to be the responsible change.

Below I attached the instructions if someone want to reproduce it. The
iso image can be found on my qemu git branch [3]. The ISO image contains
Genode/Nova + user-level port of Virtualbox as VMM + a 32bit VM running
Genode/Nova.


[0] https://www.genode.org
[1] http://www.hypervisor.org
[2]
https://genode.org/documentation/release-notes/14.02#VirtualBox_on_top_of=
_the_NOVA_microhypervisor
[3] https://github.com/alex-ab/qemu/blob/genode/virtualbox.iso




Instructions to reproduce:
--------------------------

~/local/qemu-<X>/bin/qemu-system-x86_64 -smp 1 -no-kvm -display sdl -m
512 -cpu phenom -serial mon:stdio -cdrom virtualbox.iso

<X> being:

2.3.1 - ok
2.4.1 - ok
2.5.0 - fails with triple fault in Guest
2.5.1 - fails with triple fault in Guest
2.8.0 - fails with triple fault in Guest
git   - fails with triple fault in Guest


The Qemu sources has been configured and build from the original release
tar.xz sources with
gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

./configure --prefix=3D~/local/qemu-<X> --disable-vnc
--target-list=3Di386-softmmu,arm-softmmu,x86_64-softmmu
make install


Bad/Failing UART output from Qemu:

...
[init -> virtualbox] fb resize : 640x480@16 -> 720x400@0
[init -> log_terminal] Bender: Hello World.
Need 001d1000 bytes to relocate modules.
Relocating to 0fe1f000:
Copying 1774420 bytes...
Copying 123492 bytes...
[init -> log_terminal]
Now we get the fault if I touch this 0xc001c09c ...
[ 0] Killed EC:0xffffffff832a4b80 SC:0xffffffff810e3e40 V:0x7f
CR0:0x8001003b CR3:0x421000 CR4:0x698 (PT not found)
...

Good UART output from Qemu:

...
[init -> virtualbox] fb resize : 640x480@16 -> 720x400@0
[init -> log_terminal] Bender: Hello World.
Need 001d1000 bytes to relocate modules.
Relocating to 0fe1f000:
Copying 1774420 bytes...
Copying 123492 bytes...
[init -> log_terminal]
Now we get the fault if I touch this 0xc001c09c ...
[init -> log_terminal]  - oh - no fault ? Eureka !
[init -> log_terminal]
                       NOVA Microhypervisor v7-dc6cf64 (x86_32): Feb 16
2017 08:57:37 [gcc 4.9.2]
[init -> log_terminal]
[init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550
Quad-Core Processor
...
