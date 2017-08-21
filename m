Received: from eggs.gnu.org ([2001:4830:134:3::10]:47034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djoMS-00070B-VC
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djoMR-0005x1-4I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:49076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djoMQ-0005wV-SF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djoMP-0005AV-Fm
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 15:11:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6F18F2E80CE
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 15:11:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 14:55:54 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150332735470.8620.6098026655110082364.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As expected by David when I trace on process_incoming_migration_co which pr=
ints the "readable" error I see the error pop up on "qemu_loadvm_state"
It appears as "Thread 4 "CPU 0/KVM" received signal SIGUSR1" and similar wh=
ich is just the break down of the guest.


Diving "into" qemu_loadvm_state reveals that it gets until "cpu_synchronize=
_all_pre_loadvm".
In qemu_loadvm_state none of the initial checks fail.
Then the "ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm_sta=
te, 0);" seems to work fine was well.
It seems reproducible in "cpu_synchronize_all_pre_loadvm" where the crash h=
appens.

I can catch the incoming qemu easily with:
$ while ! pid=3D$(pidof qemu-system-x86_64); do /bin/true; done; gdb --pid =
${pid}
# Then in gdb break on "cpu_synchronize_all_pre_loadvm"
# And when I step over it I the next thing I see is the "beginning of the e=
nd" for the process
Thread 4 "CPU 0/KVM" received signal SIGUSR1, User defined signal 1.
[Switching to Thread 0x7f418136e700 (LWP 3887)]
__lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135

The guest only has one vcpu, so CPU_FOREACH(cpu) is not much of a loop.
Looking down that path I tracked it to along:
cpu_synchronize_all_pre_loadvm -> cpu_synchronize_pre_loadvm -> kvm_cpu_syn=
chronize_pre_loadvm -> do_run_on_cpu

Here it queues the function "do_kvm_cpu_synchronize_pre_loadvm" onto the vc=
pu.
That is done via queue_work_on_cpu(cpu, &wi); which in turn uses eventually=
 "qemu_cpu_kick_thread(cpu);"
That seems to trigger the first SIGUSR1

Following that I get the breakpoint that I set at "do_kvm_cpu_synchronize_p=
re_loadvm".
The actual function only sets "cpu->vcpu_dirty =3D true;" and works.

On the way out from there, there is a "qemu_kvm_wait_io_event" which
leads to the next SIGUSR1.

Going on I see another "do_run_on_cpu" with "vapic_do_enable_tpr_reporting"=
 as the function.
I set a breakpoint on that as well but took a full CPUstate before going on:
p *cpu
$4 =3D {parent_obj =3D {parent_obj =3D {class =3D 0x5ffe7170c0, free =3D 0x=
7f62328f15a0 <g_free>, properties =3D 0x5ffe736e40, ref =3D 1, =

      parent =3D 0x5ffe726160}, id =3D 0x0, realized =3D true, pending_dele=
ted_event =3D false, opts =3D 0x0, hotplugged =3D 0, parent_bus =3D 0x0, gp=
ios =3D {
      lh_first =3D 0x0}, child_bus =3D {lh_first =3D 0x0}, num_child_bus =
=3D 0, instance_id_alias =3D -1, alias_required_for_version =3D 0}, nr_core=
s =3D 1, =

  nr_threads =3D 1, thread =3D 0x5ffe803cd0, thread_id =3D 8498, running =
=3D false, has_waiter =3D false, halt_cond =3D 0x5ffe803cf0, thread_kicked =
=3D true, =

  created =3D true, stop =3D false, stopped =3D true, unplug =3D false, cra=
sh_occurred =3D false, exit_request =3D false, interrupt_request =3D 4, =

  singlestep_enabled =3D 0, icount_budget =3D 0, icount_extra =3D 0, jmp_en=
v =3D {{__jmpbuf =3D {0, 0, 0, 0, 0, 0, 0, 0}, __mask_was_saved =3D 0, =

      __saved_mask =3D {__val =3D {0 <repeats 16 times>}}}}, work_mutex =3D=
 {lock =3D {__data =3D {__lock =3D 0, __count =3D 0, __owner =3D 0, __nuser=
s =3D 0, =

        __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {__prev =
=3D 0x0, __next =3D 0x0}}, __size =3D '\000' <repeats 39 times>, __align =
=3D 0}, =

    initialized =3D true}, queued_work_first =3D 0x5fffefc990, queued_work_=
last =3D 0x5fffefc990, cpu_ases =3D 0x5ffe803c10, num_ases =3D 1, =

  as =3D 0x5ffe7f9690, memory =3D 0x5ffe725bd0, env_ptr =3D 0x5ffe7e44c0, t=
b_jmp_cache =3D {0x0 <repeats 4096 times>}, gdb_regs =3D 0x0, =

  gdb_num_regs =3D 57, gdb_num_g_regs =3D 57, node =3D {tqe_next =3D 0x0, t=
qe_prev =3D 0x5ffc1783f0 <cpus>}, breakpoints =3D {tqh_first =3D 0x0, =

    tqh_last =3D 0x5ffe7e4430}, watchpoints =3D {tqh_first =3D 0x0, tqh_las=
t =3D 0x5ffe7e4440}, watchpoint_hit =3D 0x0, opaque =3D 0x0, mem_io_pc =3D =
0, =

  mem_io_vaddr =3D 0, kvm_fd =3D 19, kvm_state =3D 0x5ffe7357a0, kvm_run =
=3D 0x7f62374bc000, trace_dstate_delayed =3D {0}, trace_dstate =3D {0}, =

  cpu_index =3D 0, halted =3D 1, can_do_io =3D 1, exception_index =3D -1, v=
cpu_dirty =3D true, throttle_thread_scheduled =3D false, icount_decr =3D {u=
32 =3D 0, =

    u16 =3D {low =3D 0, high =3D 0}}, hax_vcpu =3D 0x0, pending_tlb_flush =
=3D 7}

Continuing I hit the "vapic_do_enable_tpr_reporting" with qemu still
running.

Things go on, the next candidate for "do_run_on_cpu" is "kvm_apic_put"
Another SIGUSR1 to get that kicked it seems.
"kvm_apic_put" breakpoint is reached after that kick.

Next for "do_run_on_cpu"  is "do_kvm_cpu_synchronize_post_init". And
that triggered the fourth SIGUSR1. Before I only saw four, hopefully
that is the same with so much breakpoints.

Checked the cpu state again:
1880    static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_=
cpu_data arg)
1881    {
1882        kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
1883        cpu->vcpu_dirty =3D false;
1884    }
1885
(gdb) p cpu
$5 =3D (CPUState *) 0x5ffe7dc230
(gdb) p *cpu
$6 =3D {parent_obj =3D {parent_obj =3D {class =3D 0x5ffe7170c0, free =3D 0x=
7f62328f15a0 <g_free>, properties =3D 0x5ffe736e40, ref =3D 1, =

      parent =3D 0x5ffe726160}, id =3D 0x0, realized =3D true, pending_dele=
ted_event =3D false, opts =3D 0x0, hotplugged =3D 0, parent_bus =3D 0x0, gp=
ios =3D {
      lh_first =3D 0x0}, child_bus =3D {lh_first =3D 0x0}, num_child_bus =
=3D 0, instance_id_alias =3D -1, alias_required_for_version =3D 0}, nr_core=
s =3D 1, =

  nr_threads =3D 1, thread =3D 0x5ffe803cd0, thread_id =3D 8498, running =
=3D false, has_waiter =3D false, halt_cond =3D 0x5ffe803cf0, thread_kicked =
=3D false, =

  created =3D true, stop =3D false, stopped =3D true, unplug =3D false, cra=
sh_occurred =3D false, exit_request =3D false, interrupt_request =3D 4, =

  singlestep_enabled =3D 0, icount_budget =3D 0, icount_extra =3D 0, jmp_en=
v =3D {{__jmpbuf =3D {0, 0, 0, 0, 0, 0, 0, 0}, __mask_was_saved =3D 0, =

      __saved_mask =3D {__val =3D {0 <repeats 16 times>}}}}, work_mutex =3D=
 {lock =3D {__data =3D {__lock =3D 0, __count =3D 0, __owner =3D 0, __nuser=
s =3D 0, =

        __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {__prev =
=3D 0x0, __next =3D 0x0}}, __size =3D '\000' <repeats 39 times>, __align =
=3D 0}, =

    initialized =3D true}, queued_work_first =3D 0x0, queued_work_last =3D =
0x0, cpu_ases =3D 0x5ffe803c10, num_ases =3D 1, as =3D 0x5ffe7f9690, =

  memory =3D 0x5ffe725bd0, env_ptr =3D 0x5ffe7e44c0, tb_jmp_cache =3D {0x0 =
<repeats 4096 times>}, gdb_regs =3D 0x0, gdb_num_regs =3D 57, =

  gdb_num_g_regs =3D 57, node =3D {tqe_next =3D 0x0, tqe_prev =3D 0x5ffc178=
3f0 <cpus>}, breakpoints =3D {tqh_first =3D 0x0, tqh_last =3D 0x5ffe7e4430}=
, =

  watchpoints =3D {tqh_first =3D 0x0, tqh_last =3D 0x5ffe7e4440}, watchpoin=
t_hit =3D 0x0, opaque =3D 0x0, mem_io_pc =3D 0, mem_io_vaddr =3D 0, kvm_fd =
=3D 19, =

  kvm_state =3D 0x5ffe7357a0, kvm_run =3D 0x7f62374bc000, trace_dstate_dela=
yed =3D {0}, trace_dstate =3D {0}, cpu_index =3D 0, halted =3D 1, can_do_io=
 =3D 1, =

  exception_index =3D -1, vcpu_dirty =3D true, throttle_thread_scheduled =
=3D false, icount_decr =3D {u32 =3D 0, u16 =3D {low =3D 0, high =3D 0}}, =

  hax_vcpu =3D 0x0, pending_tlb_flush =3D 7}

And from here stepping into kvm_arch_put_registers:
kvm_arch_put_registers (cpu=3Dcpu@entry=3D0x5ffe7dc230, level=3Dlevel@entry=
=3D3) at ./target/i386/kvm.c:2591

That still is the same vcpu as all the time, x86_cpu is optimized out
unfortunately as I had no full debug build with -O0.

I see it setting up regs in kvm_arch_put_registers without error (all ret=
=3D0) and return to do_kvm_cpu_synchronize_post_init.
This eventually sets "cpu->vcpu_dirty =3D false;"

After this seems all good I steped through the "way out" and there came ano=
ther "qemu_kvm_wait_io_event(cpu);".
Without considering this being critical I stepped with "n" and qemu was gon=
e with all its threads.

qemu_kvm_cpu_thread_fn (arg=3D0x5ffe7dc230) at ./cpus.c:1134
1134        } while (!cpu->unplug || cpu_can_run(cpu));
(gdb) n
1127            if (cpu_can_run(cpu)) {
(gdb) n
1133            qemu_kvm_wait_io_event(cpu);
(gdb) n
[Thread 0x7f6227857700 (LWP 8498) exited]

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
