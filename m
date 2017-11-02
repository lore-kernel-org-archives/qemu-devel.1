Received: from eggs.gnu.org ([2001:4830:134:3::10]:35016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAG88-0006AK-OA
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAG7z-0003NF-Sm
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:06:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAG7z-0003My-JE
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:05:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAG7x-00044D-UI
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 14:05:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DD2462E8074
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 14:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Nov 2017 13:58:45 -0000
From: Liang Dai <1729501@bugs.launchpad.net>
Reply-To: Bug 1729501 <1729501@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150960325077.8724.2785366469980820788.malonedeb@wampee.canonical.com>
Message-Id: <150963112597.4486.7681925385680347381.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1729501] Re: qemu crashes with assertion error
 `off_cur_end >= off_cur' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  My host environment: Xen + QEMU
  =

- git clones today's xen git and qemut git (2017-10-31)
+ git clones today's xen git and qemu git (2017-11-02)
  =

  xen  -- git://xenbits.xen.org/xen.git
  commit 24fb44e971a62b345c7b6ca3c03b454a1e150abe
- 	=

- qemu -- https://github.com/qemu/qemu =

+ =

+ qemu -- https://github.com/qemu/qemu
  commit 47ba789c97c8d201d01058b00a14d8a9a85fcfe9
  =

  QEMU was compiled using:
  ./configure --prefix=3D/mnt/bin/ --enable-xen --target-list=3Di386-softmm=
u --extra-cflags=3D"-I/mnt/xen/tools/include -I/mnt/xen/tools/libxc -I/mnt/=
xen/tools/xenstore"        --extra-ldflags=3D"-L/mnt/xen/tools/libxc -L/mnt=
/xen/tools/xenstore" --enable-debug --enable-debug-stack-usage
  =

  Xen was configured with the above QEMU distribution:
  ./configure --with-system-qemu=3D/mnt/bin/bin/qemu-system-i386
  =

- QEMU command line: =

+ QEMU command line:
  /mnt/bin/bin/qemu-system-i386 -xen-domid 28 -chardev socket,id=3Dlibxl-cm=
d,path=3D/var/run/xen/qmp-libxl-28,server,nowait -no-shutdown -mon chardev=
=3Dlibxl-cmd,mode=3Dcontrol -chardev socket,id=3Dlibxenstat-cmd,path=3D/var=
/run/xen/qmp-libxenstat-28,server,nowait -mon chardev=3Dlibxenstat-cmd,mode=
=3Dcontrol -nodefaults -no-user-config -name ubu_hvm -vnc 0.0.0.0:1,to=3D99=
 -display none -serial pty -device cirrus-vga,vgamem_mb=3D8 -boot order=3Dc=
 -smp 2,maxcpus=3D2 -device rtl8139,id=3Dnic0,netdev=3Dnet0,mac=3D00:16:3e:=
74:34:32 -netdev type=3Dtap,id=3Dnet0,ifname=3Dvif28.0-emu,script=3Dno,down=
script=3Dno -device rtl8139,id=3Dnic1,netdev=3Dnet1,mac=3D00:16:3e:5f:48:e4=
 -netdev type=3Dtap,id=3Dnet1,ifname=3Dvif28.1-emu,script=3Dno,downscript=
=3Dno -machine xenfv -m 1504 -drive file=3D/mnt/10G.hdd,if=3Dide,index=3D0,=
media=3Ddisk,format=3Draw,cache=3Dwriteback
  =

  Produce:
  I run a fuzzer program in guest vm, it may set incorrect values for graph=
ics registers, sequencer registers and other registers.
  =

  Seeing the following error from /var/log/xen/qemu-dm-<vm-name>.log:
  qemu-system-i386: hw/display/cirrus_vga.c:712: cirrus_invalidate_region: =
Assertion `off_cur_end >=3D off_cur' failed.
  =

  I can reproduce it at anytime, if you need to gather more diagnostic
  information or try test patches, I'm happy to help.
  =

- =

  gdb bt:
  #0  0x00007f81a64f8c37 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sys=
deps/unix/sysv/linux/raise.c:56
  #1  0x00007f81a64fc028 in __GI_abort () at abort.c:89
- #2  0x00007f81a64f1bf6 in __assert_fail_base (fmt=3D0x7f81a6646018 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", =

-     assertion=3Dassertion@entry=3D0x55d70cf8cdf2 "off_cur_end >=3D off_cu=
r", file=3Dfile@entry=3D0x55d70cf8cda9 "hw/display/cirrus_vga.c", line=3Dli=
ne@entry=3D712, =

-     function=3Dfunction@entry=3D0x55d70cf8db60 <__PRETTY_FUNCTION__.40643=
> "cirrus_invalidate_region") at assert.c:92
- #3  0x00007f81a64f1ca2 in __GI___assert_fail (assertion=3D0x55d70cf8cdf2 =
"off_cur_end >=3D off_cur", file=3D0x55d70cf8cda9 "hw/display/cirrus_vga.c"=
, line=3D712, =

-     function=3D0x55d70cf8db60 <__PRETTY_FUNCTION__.40643> "cirrus_invalid=
ate_region") at assert.c:101
+ #2  0x00007f81a64f1bf6 in __assert_fail_base (fmt=3D0x7f81a6646018 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n",
+ =C2=A0=C2=A0=C2=A0=C2=A0assertion=3Dassertion@entry=3D0x55d70cf8cdf2 "off=
_cur_end >=3D off_cur", file=3Dfile@entry=3D0x55d70cf8cda9 "hw/display/cirr=
us_vga.c", line=3Dline@entry=3D712,
+ =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x55d70cf8db60 <__PRE=
TTY_FUNCTION__.40643> "cirrus_invalidate_region") at assert.c:92
+ #3  0x00007f81a64f1ca2 in __GI___assert_fail (assertion=3D0x55d70cf8cdf2 =
"off_cur_end >=3D off_cur", file=3D0x55d70cf8cda9 "hw/display/cirrus_vga.c"=
, line=3D712,
+ =C2=A0=C2=A0=C2=A0=C2=A0function=3D0x55d70cf8db60 <__PRETTY_FUNCTION__.40=
643> "cirrus_invalidate_region") at assert.c:101
  #4  0x000055d70cb66445 in cirrus_invalidate_region (s=3D0x55d70ee3a4b0, o=
ff_begin=3D4190568, off_pitch=3D1842, bytesperline=3D5056, lines=3D2922) at=
 hw/display/cirrus_vga.c:712
  #5  0x000055d70cb6660c in cirrus_bitblt_common_patterncopy (s=3D0x55d70ee=
3a4b0) at hw/display/cirrus_vga.c:752
  #6  0x000055d70cb6676d in cirrus_bitblt_videotovideo_patterncopy (s=3D0x5=
5d70ee3a4b0) at hw/display/cirrus_vga.c:786
  #7  0x000055d70cb670c5 in cirrus_bitblt_videotovideo (s=3D0x55d70ee3a4b0)=
 at hw/display/cirrus_vga.c:986
  #8  0x000055d70cb678bf in cirrus_bitblt_start (s=3D0x55d70ee3a4b0) at hw/=
display/cirrus_vga.c:1136
  #9  0x000055d70cb6880b in cirrus_vga_write_gr (s=3D0x55d70ee3a4b0, reg_in=
dex=3D42, reg_value=3D228) at hw/display/cirrus_vga.c:1652
  #10 0x000055d70cb6ab86 in cirrus_vga_ioport_write (opaque=3D0x55d70ee3a4b=
0, addr=3D975, val=3D228, size=3D1) at hw/display/cirrus_vga.c:2754
  #11 0x000055d70c91d9c0 in memory_region_write_accessor (mr=3D0x55d70ee4af=
70, addr=3D31, value=3D0x7fffdaaeaf38, size=3D1, shift=3D8, mask=3D255, att=
rs=3D...)
-     at /mnt/qemu/memory.c:560
- #12 0x000055d70c91dc3a in access_with_adjusted_size (addr=3D30, value=3D0=
x7fffdaaeaf38, size=3D2, access_size_min=3D1, access_size_max=3D1, =

-     access_fn=3D0x55d70c91d8c9 <memory_region_write_accessor>, mr=3D0x55d=
70ee4af70, attrs=3D...) at /mnt/qemu/memory.c:627
+ =C2=A0=C2=A0=C2=A0=C2=A0at /mnt/qemu/memory.c:560
+ #12 0x000055d70c91dc3a in access_with_adjusted_size (addr=3D30, value=3D0=
x7fffdaaeaf38, size=3D2, access_size_min=3D1, access_size_max=3D1,
+ =C2=A0=C2=A0=C2=A0=C2=A0access_fn=3D0x55d70c91d8c9 <memory_region_write_a=
ccessor>, mr=3D0x55d70ee4af70, attrs=3D...) at /mnt/qemu/memory.c:627
  #13 0x000055d70c920f48 in memory_region_dispatch_write (mr=3D0x55d70ee4af=
70, addr=3D30, data=3D58410, size=3D2, attrs=3D...) at /mnt/qemu/memory.c:1=
503
- #14 0x000055d70c8c51e0 in flatview_write_continue (fv=3D0x55d70ecb66d0, a=
ddr=3D974, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377\177", len=3D4,=
 addr1=3D30, l=3D2, =

-     mr=3D0x55d70ee4af70) at /mnt/qemu/exec.c:2951
+ #14 0x000055d70c8c51e0 in flatview_write_continue (fv=3D0x55d70ecb66d0, a=
ddr=3D974, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377\177", len=3D4,=
 addr1=3D30, l=3D2,
+ =C2=A0=C2=A0=C2=A0=C2=A0mr=3D0x55d70ee4af70) at /mnt/qemu/exec.c:2951
  #15 0x000055d70c8c5390 in flatview_write (fv=3D0x55d70ecb66d0, addr=3D974=
, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377\177", len=3D4) at /mnt/=
qemu/exec.c:3002
  #16 0x000055d70c8c5406 in address_space_write (as=3D0x55d70d70d5e0 <addre=
ss_space_io>, addr=3D974, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377=
\177", len=3D4)
-     at /mnt/qemu/exec.c:3014
+ =C2=A0=C2=A0=C2=A0=C2=A0at /mnt/qemu/exec.c:3014
  #17 0x000055d70c914fb3 in cpu_outl (addr=3D974, val=3D374858794) at /mnt/=
qemu/ioport.c:81
  #18 0x000055d70ca0253f in do_outp (addr=3D974, size=3D4, val=3D374858794)=
 at /mnt/qemu/hw/i386/xen/xen-hvm.c:782
  #19 0x000055d70ca02888 in cpu_ioreq_pio (req=3D0x7fffdaaeb210) at /mnt/qe=
mu/hw/i386/xen/xen-hvm.c:852
  #20 0x000055d70ca02f2e in handle_ioreq (state=3D0x55d70e0cf3d0, req=3D0x7=
fffdaaeb210) at /mnt/qemu/hw/i386/xen/xen-hvm.c:961
  #21 0x000055d70ca0343e in cpu_handle_ioreq (opaque=3D0x55d70e0cf3d0) at /=
mnt/qemu/hw/i386/xen/xen-hvm.c:1089
  #22 0x000055d70ce75d69 in aio_dispatch_handlers (ctx=3D0x55d70e098550) at=
 util/aio-posix.c:406
  #23 0x000055d70ce75f0b in aio_dispatch (ctx=3D0x55d70e098550) at util/aio=
-posix.c:437
  #24 0x000055d70ce70b46 in aio_ctx_dispatch (source=3D0x55d70e098550, call=
back=3D0x0, user_data=3D0x0) at util/async.c:261
  #25 0x00007f81a7215e04 in g_main_context_dispatch () from /lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
  #26 0x000055d70ce74455 in glib_pollfds_poll () at util/main-loop.c:214
  #27 0x000055d70ce7456a in os_host_main_loop_wait (timeout=3D16061710) at =
util/main-loop.c:261
  #28 0x000055d70ce7463f in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:515
  #29 0x000055d70ca8e6a6 in main_loop () at vl.c:1995
  #30 0x000055d70ca96815 in main (argc=3D42, argv=3D0x7fffdaaeb888, envp=3D=
0x7fffdaaeb9e0) at vl.c:4897

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1729501

Title:
  qemu crashes with assertion error `off_cur_end >=3D off_cur' failed

Status in QEMU:
  New

Bug description:
  My host environment: Xen + QEMU

  git clones today's xen git and qemu git (2017-11-02)

  xen  -- git://xenbits.xen.org/xen.git
  commit 24fb44e971a62b345c7b6ca3c03b454a1e150abe

  qemu -- https://github.com/qemu/qemu
  commit 47ba789c97c8d201d01058b00a14d8a9a85fcfe9

  QEMU was compiled using:
  ./configure --prefix=3D/mnt/bin/ --enable-xen --target-list=3Di386-softmm=
u --extra-cflags=3D"-I/mnt/xen/tools/include -I/mnt/xen/tools/libxc -I/mnt/=
xen/tools/xenstore"        --extra-ldflags=3D"-L/mnt/xen/tools/libxc -L/mnt=
/xen/tools/xenstore" --enable-debug --enable-debug-stack-usage

  Xen was configured with the above QEMU distribution:
  ./configure --with-system-qemu=3D/mnt/bin/bin/qemu-system-i386

  QEMU command line:
  /mnt/bin/bin/qemu-system-i386 -xen-domid 28 -chardev socket,id=3Dlibxl-cm=
d,path=3D/var/run/xen/qmp-libxl-28,server,nowait -no-shutdown -mon chardev=
=3Dlibxl-cmd,mode=3Dcontrol -chardev socket,id=3Dlibxenstat-cmd,path=3D/var=
/run/xen/qmp-libxenstat-28,server,nowait -mon chardev=3Dlibxenstat-cmd,mode=
=3Dcontrol -nodefaults -no-user-config -name ubu_hvm -vnc 0.0.0.0:1,to=3D99=
 -display none -serial pty -device cirrus-vga,vgamem_mb=3D8 -boot order=3Dc=
 -smp 2,maxcpus=3D2 -device rtl8139,id=3Dnic0,netdev=3Dnet0,mac=3D00:16:3e:=
74:34:32 -netdev type=3Dtap,id=3Dnet0,ifname=3Dvif28.0-emu,script=3Dno,down=
script=3Dno -device rtl8139,id=3Dnic1,netdev=3Dnet1,mac=3D00:16:3e:5f:48:e4=
 -netdev type=3Dtap,id=3Dnet1,ifname=3Dvif28.1-emu,script=3Dno,downscript=
=3Dno -machine xenfv -m 1504 -drive file=3D/mnt/10G.hdd,if=3Dide,index=3D0,=
media=3Ddisk,format=3Draw,cache=3Dwriteback

  Produce:
  I run a fuzzer program in guest vm, it may set incorrect values for graph=
ics registers, sequencer registers and other registers.

  Seeing the following error from /var/log/xen/qemu-dm-<vm-name>.log:
  qemu-system-i386: hw/display/cirrus_vga.c:712: cirrus_invalidate_region: =
Assertion `off_cur_end >=3D off_cur' failed.

  I can reproduce it at anytime, if you need to gather more diagnostic
  information or try test patches, I'm happy to help.

  gdb bt:
  #0  0x00007f81a64f8c37 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sys=
deps/unix/sysv/linux/raise.c:56
  #1  0x00007f81a64fc028 in __GI_abort () at abort.c:89
  #2  0x00007f81a64f1bf6 in __assert_fail_base (fmt=3D0x7f81a6646018 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n",
  =C2=A0=C2=A0=C2=A0=C2=A0assertion=3Dassertion@entry=3D0x55d70cf8cdf2 "off=
_cur_end >=3D off_cur", file=3Dfile@entry=3D0x55d70cf8cda9 "hw/display/cirr=
us_vga.c", line=3Dline@entry=3D712,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x55d70cf8db60 <__PRE=
TTY_FUNCTION__.40643> "cirrus_invalidate_region") at assert.c:92
  #3  0x00007f81a64f1ca2 in __GI___assert_fail (assertion=3D0x55d70cf8cdf2 =
"off_cur_end >=3D off_cur", file=3D0x55d70cf8cda9 "hw/display/cirrus_vga.c"=
, line=3D712,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3D0x55d70cf8db60 <__PRETTY_FUNCTION__.40=
643> "cirrus_invalidate_region") at assert.c:101
  #4  0x000055d70cb66445 in cirrus_invalidate_region (s=3D0x55d70ee3a4b0, o=
ff_begin=3D4190568, off_pitch=3D1842, bytesperline=3D5056, lines=3D2922) at=
 hw/display/cirrus_vga.c:712
  #5  0x000055d70cb6660c in cirrus_bitblt_common_patterncopy (s=3D0x55d70ee=
3a4b0) at hw/display/cirrus_vga.c:752
  #6  0x000055d70cb6676d in cirrus_bitblt_videotovideo_patterncopy (s=3D0x5=
5d70ee3a4b0) at hw/display/cirrus_vga.c:786
  #7  0x000055d70cb670c5 in cirrus_bitblt_videotovideo (s=3D0x55d70ee3a4b0)=
 at hw/display/cirrus_vga.c:986
  #8  0x000055d70cb678bf in cirrus_bitblt_start (s=3D0x55d70ee3a4b0) at hw/=
display/cirrus_vga.c:1136
  #9  0x000055d70cb6880b in cirrus_vga_write_gr (s=3D0x55d70ee3a4b0, reg_in=
dex=3D42, reg_value=3D228) at hw/display/cirrus_vga.c:1652
  #10 0x000055d70cb6ab86 in cirrus_vga_ioport_write (opaque=3D0x55d70ee3a4b=
0, addr=3D975, val=3D228, size=3D1) at hw/display/cirrus_vga.c:2754
  #11 0x000055d70c91d9c0 in memory_region_write_accessor (mr=3D0x55d70ee4af=
70, addr=3D31, value=3D0x7fffdaaeaf38, size=3D1, shift=3D8, mask=3D255, att=
rs=3D...)
  =C2=A0=C2=A0=C2=A0=C2=A0at /mnt/qemu/memory.c:560
  #12 0x000055d70c91dc3a in access_with_adjusted_size (addr=3D30, value=3D0=
x7fffdaaeaf38, size=3D2, access_size_min=3D1, access_size_max=3D1,
  =C2=A0=C2=A0=C2=A0=C2=A0access_fn=3D0x55d70c91d8c9 <memory_region_write_a=
ccessor>, mr=3D0x55d70ee4af70, attrs=3D...) at /mnt/qemu/memory.c:627
  #13 0x000055d70c920f48 in memory_region_dispatch_write (mr=3D0x55d70ee4af=
70, addr=3D30, data=3D58410, size=3D2, attrs=3D...) at /mnt/qemu/memory.c:1=
503
  #14 0x000055d70c8c51e0 in flatview_write_continue (fv=3D0x55d70ecb66d0, a=
ddr=3D974, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377\177", len=3D4,=
 addr1=3D30, l=3D2,
  =C2=A0=C2=A0=C2=A0=C2=A0mr=3D0x55d70ee4af70) at /mnt/qemu/exec.c:2951
  #15 0x000055d70c8c5390 in flatview_write (fv=3D0x55d70ecb66d0, addr=3D974=
, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377\177", len=3D4) at /mnt/=
qemu/exec.c:3002
  #16 0x000055d70c8c5406 in address_space_write (as=3D0x55d70d70d5e0 <addre=
ss_space_io>, addr=3D974, attrs=3D..., buf=3D0x7fffdaaeb0f0 "*\344W\026\377=
\177", len=3D4)
  =C2=A0=C2=A0=C2=A0=C2=A0at /mnt/qemu/exec.c:3014
  #17 0x000055d70c914fb3 in cpu_outl (addr=3D974, val=3D374858794) at /mnt/=
qemu/ioport.c:81
  #18 0x000055d70ca0253f in do_outp (addr=3D974, size=3D4, val=3D374858794)=
 at /mnt/qemu/hw/i386/xen/xen-hvm.c:782
  #19 0x000055d70ca02888 in cpu_ioreq_pio (req=3D0x7fffdaaeb210) at /mnt/qe=
mu/hw/i386/xen/xen-hvm.c:852
  #20 0x000055d70ca02f2e in handle_ioreq (state=3D0x55d70e0cf3d0, req=3D0x7=
fffdaaeb210) at /mnt/qemu/hw/i386/xen/xen-hvm.c:961
  #21 0x000055d70ca0343e in cpu_handle_ioreq (opaque=3D0x55d70e0cf3d0) at /=
mnt/qemu/hw/i386/xen/xen-hvm.c:1089
  #22 0x000055d70ce75d69 in aio_dispatch_handlers (ctx=3D0x55d70e098550) at=
 util/aio-posix.c:406
  #23 0x000055d70ce75f0b in aio_dispatch (ctx=3D0x55d70e098550) at util/aio=
-posix.c:437
  #24 0x000055d70ce70b46 in aio_ctx_dispatch (source=3D0x55d70e098550, call=
back=3D0x0, user_data=3D0x0) at util/async.c:261
  #25 0x00007f81a7215e04 in g_main_context_dispatch () from /lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
  #26 0x000055d70ce74455 in glib_pollfds_poll () at util/main-loop.c:214
  #27 0x000055d70ce7456a in os_host_main_loop_wait (timeout=3D16061710) at =
util/main-loop.c:261
  #28 0x000055d70ce7463f in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:515
  #29 0x000055d70ca8e6a6 in main_loop () at vl.c:1995
  #30 0x000055d70ca96815 in main (argc=3D42, argv=3D0x7fffdaaeb888, envp=3D=
0x7fffdaaeb9e0) at vl.c:4897

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1729501/+subscriptions
