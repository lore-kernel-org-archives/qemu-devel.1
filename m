Received: from eggs.gnu.org ([2001:4830:134:3::10]:38629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq1GV-0008Bm-5k
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq1GP-0002Va-E5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:10:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:49444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dq1GP-0002V4-4O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:10:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dq1GO-0001as-7x
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 18:10:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 30F892E846D
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 18:10:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Sep 2017 18:02:28 -0000
From: Brad Parker <1715715@bugs.launchpad.net>
Reply-To: Bug 1715715 <1715715@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150480734842.32058.3488330551186130563.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715715] [NEW] [qemu-ppc] Segfault when booting
 from HD after OS install
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I created an empty 128G qcow2 image and booted from a Mac OS 9.2.1
Install CD, in which I was able to install the OS successfully to the
hard drive. Upon reboot, this time from the hard drive directly, qemu-
system-ppc segfaults. Host system is Ubuntu 16.04.2 with latest qemu
commit.

qemu --version reports "2.10.50 (v2.10.0-244-gb07d1c2-dirty)", but I
used git commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e and built with
"./configure --target-list=3Dppc-softmmu --enable-debug --disable-strip".

Here is the command-line arguments:

qemu-system-ppc -boot c -g 1024x768x32 -M mac99 -m 256 -prom-env 'auto-
boot?=3Dtrue' -prom-env 'boot-args=3D-v' -prom-env 'vga-ndrv?=3Dtrue' -drive
file=3D../os9.img,format=3Draw,media=3Dcdrom -drive
file=3DMacOS9.qcow2,format=3Dqcow2,media=3Ddisk -spice port=3D5901,password=
=3DXXX
-net nic,model=3Drtl8139 -net user -monitor stdio

And the GDB backtrace:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010) =
at util/qemu-timer.c:462
462         timer_mod_ns(ts, expire_time * ts->scale);
[Current thread is 1 (Thread 0x7f60e43cb700 (LWP 9853))]
(gdb) bt
#0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010) =
at util/qemu-timer.c:462
#1  0x0000559065d63769 in openpic_tmr_set_tmr (tmr=3D0x5590676fa7e0, val=3D=
96, enabled=3Dtrue) at hw/intc/openpic.c:861
#2  0x0000559065d63995 in openpic_tmr_write (opaque=3D0x5590676f71f0, addr=
=3D16, val=3D96, len=3D4) at hw/intc/openpic.c:912
#3  0x0000559065b02811 in memory_region_write_accessor (mr=3D0x5590676f7710=
, addr=3D32, value=3D0x7f60e43c7da8, size=3D4, shift=3D0, mask=3D4294967295=
, attrs=3D...) at /home/bp/qemu/memory.c:529
#4  0x0000559065b02a29 in access_with_adjusted_size (addr=3D32, value=3D0x7=
f60e43c7da8, size=3D1, access_size_min=3D4, access_size_max=3D4, access=3D0=
x559065b02727 <memory_region_write_accessor>, mr=3D0x5590676f7710, attrs=3D=
...) at /home/bp/qemu/memory.c:595
#5  0x0000559065b051eb in memory_region_dispatch_write (mr=3D0x5590676f7710=
, addr=3D32, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c:13=
37
#6  0x0000559065aa3a36 in address_space_write_continue (as=3D0x559067614d90=
, addr=3D2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", len=
=3D1, addr1=3D32, l=3D1, mr=3D0x5590676f7710) at /home/bp/qemu/exec.c:2942
#7  0x0000559065aa3b84 in address_space_write (as=3D0x559067614d90, addr=3D=
2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", len=3D1) at /=
home/bp/qemu/exec.c:2987
#8  0x0000559065aa2ec0 in subpage_write (opaque=3D0x7f60c8275fc0, addr=3D27=
2, value=3D96, len=3D1, attrs=3D...) at /home/bp/qemu/exec.c:2565
#9  0x0000559065b02906 in memory_region_write_with_attrs_accessor (mr=3D0x7=
f60c8275fc0, addr=3D272, value=3D0x7f60e43c7fc8, size=3D1, shift=3D0, mask=
=3D255, attrs=3D...) at /home/bp/qemu/memory.c:555
#10 0x0000559065b029d3 in access_with_adjusted_size (addr=3D272, value=3D0x=
7f60e43c7fc8, size=3D1, access_size_min=3D1, access_size_max=3D8, access=3D=
0x559065b02818 <memory_region_write_with_attrs_accessor>, mr=3D0x7f60c8275f=
c0, attrs=3D...) at /home/bp/qemu/memory.c:590
#11 0x0000559065b0523a in memory_region_dispatch_write (mr=3D0x7f60c8275fc0=
, addr=3D272, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c:1=
344
#12 0x0000559065b175db in io_writex (env=3D0x7f60e43d42a0, iotlbentry=3D0x7=
f60e43e8130, mmu_idx=3D3, val=3D96, addr=3D2147750160, retaddr=3D1400541582=
95744, size=3D1) at /home/bp/qemu/accel/tcg/cputlb.c:807
#13 0x0000559065b18055 in io_writeb (env=3D0x7f60e43d42a0, mmu_idx=3D3, ind=
ex=3D65, val=3D96 '`', addr=3D2147750160, retaddr=3D140054158295744) at /ho=
me/bp/qemu/softmmu_template.h:265
#14 0x0000559065b181ea in helper_ret_stb_mmu (env=3D0x7f60e43d42a0, addr=3D=
2147750160, val=3D96 '`', oi=3D3, retaddr=3D140054158295744) at /home/bp/qe=
mu/softmmu_template.h:300
#15 0x00007f60e65ac2c0 in code_gen_buffer ()
#16 0x0000559065b1ff26 in cpu_tb_exec (cpu=3D0x7f60e43cc010, itb=3D0x7f60e6=
5ac5c0 <code_gen_buffer+935318>) at /home/bp/qemu/accel/tcg/cpu-exec.c:166
#17 0x0000559065b20bfd in cpu_loop_exec_tb (cpu=3D0x7f60e43cc010, tb=3D0x7f=
60e65ac5c0 <code_gen_buffer+935318>, last_tb=3D0x7f60e43c8678, tb_exit=3D0x=
7f60e43c8674) at /home/bp/qemu/accel/tcg/cpu-exec.c:578
#18 0x0000559065b20eed in cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp/qemu/=
accel/tcg/cpu-exec.c:676
#19 0x0000559065aebc3d in tcg_cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp/q=
emu/cpus.c:1270
#20 0x0000559065aebe64 in qemu_tcg_rr_cpu_thread_fn (arg=3D0x7f60e43cc010) =
at /home/bp/qemu/cpus.c:1365
#21 0x00007f60f56f06ba in start_thread (arg=3D0x7f60e43cb700) at pthread_cr=
eate.c:333
#22 0x00007f60f542682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Any idea what is going on?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715715

Title:
  [qemu-ppc] Segfault when booting from HD after OS install

Status in QEMU:
  New

Bug description:
  I created an empty 128G qcow2 image and booted from a Mac OS 9.2.1
  Install CD, in which I was able to install the OS successfully to the
  hard drive. Upon reboot, this time from the hard drive directly, qemu-
  system-ppc segfaults. Host system is Ubuntu 16.04.2 with latest qemu
  commit.

  qemu --version reports "2.10.50 (v2.10.0-244-gb07d1c2-dirty)", but I
  used git commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e and built
  with "./configure --target-list=3Dppc-softmmu --enable-debug --disable-
  strip".

  Here is the command-line arguments:

  qemu-system-ppc -boot c -g 1024x768x32 -M mac99 -m 256 -prom-env
  'auto-boot?=3Dtrue' -prom-env 'boot-args=3D-v' -prom-env 'vga-ndrv?=3Dtru=
e'
  -drive file=3D../os9.img,format=3Draw,media=3Dcdrom -drive
  file=3DMacOS9.qcow2,format=3Dqcow2,media=3Ddisk -spice
  port=3D5901,password=3DXXX -net nic,model=3Drtl8139 -net user -monitor st=
dio

  And the GDB backtrace:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010=
) at util/qemu-timer.c:462
  462         timer_mod_ns(ts, expire_time * ts->scale);
  [Current thread is 1 (Thread 0x7f60e43cb700 (LWP 9853))]
  (gdb) bt
  #0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010=
) at util/qemu-timer.c:462
  #1  0x0000559065d63769 in openpic_tmr_set_tmr (tmr=3D0x5590676fa7e0, val=
=3D96, enabled=3Dtrue) at hw/intc/openpic.c:861
  #2  0x0000559065d63995 in openpic_tmr_write (opaque=3D0x5590676f71f0, add=
r=3D16, val=3D96, len=3D4) at hw/intc/openpic.c:912
  #3  0x0000559065b02811 in memory_region_write_accessor (mr=3D0x5590676f77=
10, addr=3D32, value=3D0x7f60e43c7da8, size=3D4, shift=3D0, mask=3D42949672=
95, attrs=3D...) at /home/bp/qemu/memory.c:529
  #4  0x0000559065b02a29 in access_with_adjusted_size (addr=3D32, value=3D0=
x7f60e43c7da8, size=3D1, access_size_min=3D4, access_size_max=3D4, access=
=3D0x559065b02727 <memory_region_write_accessor>, mr=3D0x5590676f7710, attr=
s=3D...) at /home/bp/qemu/memory.c:595
  #5  0x0000559065b051eb in memory_region_dispatch_write (mr=3D0x5590676f77=
10, addr=3D32, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c:=
1337
  #6  0x0000559065aa3a36 in address_space_write_continue (as=3D0x559067614d=
90, addr=3D2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", le=
n=3D1, addr1=3D32, l=3D1, mr=3D0x5590676f7710) at /home/bp/qemu/exec.c:2942
  #7  0x0000559065aa3b84 in address_space_write (as=3D0x559067614d90, addr=
=3D2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", len=3D1) a=
t /home/bp/qemu/exec.c:2987
  #8  0x0000559065aa2ec0 in subpage_write (opaque=3D0x7f60c8275fc0, addr=3D=
272, value=3D96, len=3D1, attrs=3D...) at /home/bp/qemu/exec.c:2565
  #9  0x0000559065b02906 in memory_region_write_with_attrs_accessor (mr=3D0=
x7f60c8275fc0, addr=3D272, value=3D0x7f60e43c7fc8, size=3D1, shift=3D0, mas=
k=3D255, attrs=3D...) at /home/bp/qemu/memory.c:555
  #10 0x0000559065b029d3 in access_with_adjusted_size (addr=3D272, value=3D=
0x7f60e43c7fc8, size=3D1, access_size_min=3D1, access_size_max=3D8, access=
=3D0x559065b02818 <memory_region_write_with_attrs_accessor>, mr=3D0x7f60c82=
75fc0, attrs=3D...) at /home/bp/qemu/memory.c:590
  #11 0x0000559065b0523a in memory_region_dispatch_write (mr=3D0x7f60c8275f=
c0, addr=3D272, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c=
:1344
  #12 0x0000559065b175db in io_writex (env=3D0x7f60e43d42a0, iotlbentry=3D0=
x7f60e43e8130, mmu_idx=3D3, val=3D96, addr=3D2147750160, retaddr=3D14005415=
8295744, size=3D1) at /home/bp/qemu/accel/tcg/cputlb.c:807
  #13 0x0000559065b18055 in io_writeb (env=3D0x7f60e43d42a0, mmu_idx=3D3, i=
ndex=3D65, val=3D96 '`', addr=3D2147750160, retaddr=3D140054158295744) at /=
home/bp/qemu/softmmu_template.h:265
  #14 0x0000559065b181ea in helper_ret_stb_mmu (env=3D0x7f60e43d42a0, addr=
=3D2147750160, val=3D96 '`', oi=3D3, retaddr=3D140054158295744) at /home/bp=
/qemu/softmmu_template.h:300
  #15 0x00007f60e65ac2c0 in code_gen_buffer ()
  #16 0x0000559065b1ff26 in cpu_tb_exec (cpu=3D0x7f60e43cc010, itb=3D0x7f60=
e65ac5c0 <code_gen_buffer+935318>) at /home/bp/qemu/accel/tcg/cpu-exec.c:166
  #17 0x0000559065b20bfd in cpu_loop_exec_tb (cpu=3D0x7f60e43cc010, tb=3D0x=
7f60e65ac5c0 <code_gen_buffer+935318>, last_tb=3D0x7f60e43c8678, tb_exit=3D=
0x7f60e43c8674) at /home/bp/qemu/accel/tcg/cpu-exec.c:578
  #18 0x0000559065b20eed in cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp/qem=
u/accel/tcg/cpu-exec.c:676
  #19 0x0000559065aebc3d in tcg_cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp=
/qemu/cpus.c:1270
  #20 0x0000559065aebe64 in qemu_tcg_rr_cpu_thread_fn (arg=3D0x7f60e43cc010=
) at /home/bp/qemu/cpus.c:1365
  #21 0x00007f60f56f06ba in start_thread (arg=3D0x7f60e43cb700) at pthread_=
create.c:333
  #22 0x00007f60f542682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109

  Any idea what is going on?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715715/+subscriptions
