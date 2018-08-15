Received: from eggs.gnu.org ([2001:4830:134:3::10]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQG-0001LA-22
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQE-00076v-LN
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqQE-00074P-8n
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqQD-0006e2-El
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 660962E851B
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:27:55 -0000
From: Thomas Huth <1766896@bugs.launchpad.net>
Reply-To: Bug 1766896 <1766896@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152466768982.22103.16834353019629751249.malonedeb@soybean.canonical.com>
Message-Id: <153431807512.24099.4971253319687127896.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1766896] Re: qemu-system-arm segfault in
 arm_v7m_mmu_idx_for_secstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D95f875654ae8b433b5

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766896

Title:
  qemu-system-arm segfault in arm_v7m_mmu_idx_for_secstate

Status in QEMU:
  Fix Released

Bug description:
  Attempting to emulate some baremetal ARM cortex-M* firmware with gdb
  causes a segfault every time.

  qemu invocation:
  qemu-system-arm -machine none -cpu cortex-m3 -nographic -monitor null -se=
rial null -s -S -device loader,file=3Dfirmware.elf

  qemu seems to startup fine with that command. Segfault happens as soon
  as I connect from another console with

  arm-none-eabi-gdb firmware.elf
  > target remote localhost:1234
  # qemu segfaults, and kills arm-none-eabi-gdb along with it

  Here's a bt from qemu-system-arm :

  *********************************
  #0  armv7m_nvic_neg_prio_requested (opaque=3D0x0, secure=3Dfalse)
      at /home/sac/qemu/src/qemu/hw/intc/armv7m_nvic.c:383
          s =3D 0x0
  #1  0x006e4806 in arm_v7m_mmu_idx_for_secstate (secstate=3D<optimized out=
>, env=3D0xb620263c)
      at /home/sac/qemu/src/qemu/target/arm/cpu.h:2345
          el =3D <optimized out>
          mmu_idx =3D ARMMMUIdx_MPriv
          el =3D <optimized out>
          mmu_idx =3D <optimized out>
  #2  cpu_mmu_index (ifetch=3Dfalse, env=3D0xb620263c) at /home/sac/qemu/sr=
c/qemu/target/arm/cpu.h:2358
          mmu_idx =3D <optimized out>
          el =3D <optimized out>
          ifetch =3D <optimized out>
          env =3D 0xb620263c
          el =3D <optimized out>
          mmu_idx =3D <optimized out>
          el =3D <optimized out>
          el =3D <optimized out>
          mmu_idx =3D <optimized out>
  #3  arm_cpu_get_phys_page_attrs_debug (cs=3D0xb61fe480, addr=3D0, attrs=
=3D0xbfffc668)
      at /home/sac/qemu/src/qemu/target/arm/helper.c:9858
          cpu =3D 0xb61fe480
          __func__ =3D "arm_cpu_get_phys_page_attrs_debug"
          env =3D 0xb620263c
          phys_addr =3D 6402535376434480864
          page_size =3D 5
          prot =3D -1239242724
          ret =3D <optimized out>
          fsr =3D 4294967041
          fi =3D {s2addr =3D 0, stage2 =3D false, s1ptw =3D false, ea =3D f=
alse}
          mmu_idx =3D <optimized out>
  #4  0x005729d1 in cpu_get_phys_page_attrs_debug (attrs=3D<optimized out>,=
 addr=3D<optimized out>, =

      cpu=3D<optimized out>) at /home/sac/qemu/src/qemu/include/qom/cpu.h:5=
80
          cc =3D <optimized out>
          cc =3D <optimized out>
  #5  cpu_memory_rw_debug (cpu=3D0xb61fe480, addr=3D0, buf=3D0xbfffd6dc "",=
 len=3D4, is_write=3D0)
      at /home/sac/qemu/src/qemu/exec.c:3524
          asidx =3D <optimized out>
          attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, requester=
_id =3D 15525}
          l =3D <optimized out>
          phys_addr =3D <optimized out>
          page =3D 0
          __PRETTY_FUNCTION__ =3D "cpu_memory_rw_debug"
  #6  0x005b4c5e in target_memory_rw_debug (is_write=3Dfalse, len=3D4, buf=
=3D<optimized out>, addr=3D0, =

      cpu=3D0xb61fe480) at /home/sac/qemu/src/qemu/gdbstub.c:56
          cc =3D <optimized out>
          cc =3D <optimized out>
  #7  gdb_handle_packet (s=3Ds@entry=3D0xb6229800, line_buf=3Dline_buf@entr=
y=3D0xb6229810 "m0,4")
      at /home/sac/qemu/src/qemu/gdbstub.c:1109
          cpu =3D <optimized out>
          cc =3D <optimized out>
          p =3D 0xb6229813 "4"
          thread =3D <optimized out>
          ch =3D <optimized out>
          reg_size =3D <optimized out>
          type =3D <optimized out>
          res =3D <optimized out>
          buf =3D "m1\000", '\060' <repeats 109 times>, "ffffffff00000000d3=
010040\000t modification,\n     are permitted in any medium without royalt"=
...
          mem_buf =3D '\000' <repeats 56 times>, "\377\377\377\377\000\000\=
000\000\323\001\000@", '\000' <repeats 716 times>...
          registers =3D <optimized out>
          addr =3D 0
          len =3D 4
          __func__ =3D "gdb_handle_packet"
  #8  0x005b55b3 in gdb_read_byte (ch=3D100, s=3D0xb6229800) at /home/sac/q=
emu/src/qemu/gdbstub.c:1664
          reply =3D 43 '+'
          reply =3D <optimized out>
          repeat =3D <optimized out>
  #9  gdb_chr_receive (opaque=3D<optimized out>, buf=3D<optimized out>, siz=
e=3D<optimized out>)
      at /home/sac/qemu/src/qemu/gdbstub.c:1868
          i =3D <optimized out>
  #10 0x00980319 in tcp_chr_read (chan=3D0xb6c86200, cond=3DG_IO_IN, opaque=
=3D0xb63fc6e0)
      at chardev/char-socket.c:440
          chr =3D <optimized out>
          __func__ =3D "tcp_chr_read"
          s =3D 0xb63fc6e0
          buf =3D "$m0,4#fddInfo#c8read:arm-core.xml:0,ffb#08+;qRelocInsn+;=
fork-events+;vfork-events+;exec-events+;vContSupported+;QThreadEvents+;no-r=
esumed+#df\363\377\377\000\000\000\000\274\354\377\277", '\000' <repeats 16=
 times>, "\272\356\377 \274\354\377\277", '\000' <repeats 16 times>, "\373\=
377\377\377\005\000\000\000"...
          len =3D <optimized out>
          size =3D <optimized out>
  #11 0xb7808c44 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so=
.0
  No symbol table info available.
  #12 0x009e14d2 in glib_pollfds_poll () at util/main-loop.c:214
          context =3D 0xb645f740
          pfds =3D <optimized out>
          context =3D <optimized out>
          pfds =3D <optimized out>
  #13 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loop.=
c:261
          context =3D 0xb645f740
          ret =3D 1
          spin_counter =3D 0
          context =3D <optimized out>
          ret =3D <optimized out>
          spin_counter =3D 0
          notified =3D false
  #14 main_loop_wait (nonblocking=3D0) at util/main-loop.c:515
          ret =3D <optimized out>
          timeout =3D 1000
          timeout_ns =3D <optimized out>
  #15 0x00561781 in main_loop () at vl.c:1995
  No locals.
  #16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>) at vl.c:4911
          i =3D <optimized out>
          snapshot =3D <optimized out>
          linux_boot =3D <optimized out>
          initrd_filename =3D <optimized out>
          kernel_filename =3D <optimized out>
          kernel_cmdline =3D <optimized out>
          boot_order =3D <optimized out>
          boot_once =3D <optimized out>
          ds =3D <optimized out>
          cyls =3D <optimized out>
          heads =3D <optimized out>
          secs =3D <optimized out>
          translation =3D <optimized out>
          opts =3D <optimized out>
          machine_opts =3D <optimized out>
          hda_opts =3D <optimized out>
          icount_opts =3D <optimized out>
          accel_opts =3D <optimized out>
          olist =3D <optimized out>
          optind =3D 14
          optarg =3D 0xbffffcf6 "loader,file=3Dfirmware.elf"
          loadvm =3D <optimized out>
          machine_class =3D <optimized out>
          cpu_model =3D <optimized out>
          vga_model =3D <optimized out>
          qtest_chrdev =3D <optimized out>
          qtest_log =3D <optimized out>
          pid_file =3D <optimized out>
          incoming =3D <optimized out>
          userconfig =3D <optimized out>
          nographic =3D <optimized out>
          display_type =3D <optimized out>
          display_remote =3D <optimized out>
          log_mask =3D <optimized out>
          log_file =3D <optimized out>
          trace_file =3D <optimized out>
          maxram_size =3D <optimized out>
          ram_slots =3D <optimized out>
          vmstate_dump_file =3D <optimized out>
          main_loop_err =3D 0x0
          err =3D 0x0
          list_data_dirs =3D <optimized out>
          dirs =3D <optimized out>
          bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0xbffff918}
          __func__ =3D "main"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1766896/+subscriptions
