Received: from eggs.gnu.org ([2001:4830:134:3::10]:52795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmiuJ-0002r2-7j
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmiuG-0005Ip-5Q
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:02:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:55442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmiuF-0005Fw-Q7
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:02:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmiuC-0005uB-Fu
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 17:02:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7E8B42E80D7
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 17:02:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Aug 2018 16:54:48 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1775555 <1775555@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152836238216.25020.6334059622433678386.malonedeb@gac.canonical.com>
Message-Id: <153357448881.28757.14708287337000339075.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1775555] Re: guest migration 100% cpu freeze bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Frank: If you're happy that http://lists.nongnu.org/archive/html/qemu-devel=
/2018-04/msg00820.html
then we should close this as 'fix released' since this was commit c2b01cfec=
1f which went in v2.12.0-rc2; although we could then ask for qemu-stable.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775555

Title:
  guest migration 100% cpu freeze bug

Status in QEMU:
  New

Bug description:
  # Investigate migration cpu hog(100%) bug

  I have some issues when migrating from qemu 2.6.2 to qemu 2.11.1.
  The hypervisors are running kernel 4.9.92 on debian stretch with libvirt =
v4.0.0.
  Linux, libvirt and qemu are all custom compiled.

  I migrated around 21.000 vms from qemu 2.6.2 to qemu 2.11.1 and every
  once in a while a vm is stuck at 100% cpu after the migration from
  2.6.2 to 2.11.1. This happend with about 50-60 vms so far.

  I attached gdb to a vcpu thread of one stuck vm, and a bt showed the foll=
owing info:
  #0  0x00007f4f19949dd7 in ioctl () at ../sysdeps/unix/syscall-template.S:=
84
  #1  0x0000557c9edede47 in kvm_vcpu_ioctl (cpu=3Dcpu@entry=3D0x557ca105884=
0, type=3Dtype@entry=3D0xae80) at /home/dbosschieter/src/qemu-pkg/src/accel=
/kvm/kvm-all.c:2050
  #2  0x0000557c9ededfb6 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x557ca1058840)=
 at /home/dbosschieter/src/qemu-pkg/src/accel/kvm/kvm-all.c:1887
  #3  0x0000557c9edcab44 in qemu_kvm_cpu_thread_fn (arg=3D0x557ca1058840) a=
t /home/dbosschieter/src/qemu-pkg/src/cpus.c:1128
  #4  0x00007f4f19c0f494 in start_thread (arg=3D0x7f4f053f3700) at pthread_=
create.c:333
  #5  0x00007f4f19951acf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:97

  The ioctl call is a ioctl(18, KVM_RUN and it looks like it is looping
  inside the vm itself.

  I saved the state of the VM (with `virsh save`) after I found it was hang=
ing on its vcpu threads. Then I restored this vm on a test environment runn=
ing the same kernel, QEMU and libvirt version). After the restore the VM st=
ill was haning at 100% cpu usage on all the vcpus.
  I tried to use the perf kvm guest option to trace the guest vm with a cop=
y of the kernel, modules and kallsyms files from inside the guest vm and I =
got the following trace:

  $ perf kvm --guest --guestkallsyms=3Dkallsyms --guestmodules=3Dmodules re=
cord -g -p 14471 -o perf.data
  $ perf kvm --guest --guestkallsyms=3Dkallsyms --guestmodules=3Dmodules re=
port -i perf.data --stdio > analyze

  # To display the perf.data header info, please use --header/--header-only=
 options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 105K of event 'cycles'
  # Event count (approx.): 67588147605
  #
  # Children      Self  Command  Shared Object            Symbol           =
                           Parent symbol
  # ........  ........  .......  .......................  .................=
.........................  .............
  #
      28.79%    28.79%  :16028   [guest.kernel.kallsyms]  [g] fuse_get_root=
_inode                     [other]
      23.48%    23.48%  :16030   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_init          [other]
       7.32%     7.32%  :16029   [guest.kernel.kallsyms]  [g] do_sysfs_unre=
gistration                 [other]
       4.82%     4.82%  :16029   [guest.kernel.kallsyms]  [g] posix_cpu_clo=
ck_get                     [other]
       4.20%     4.20%  :16030   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_timer_expire_entry    [other]
       3.87%     3.87%  :16029   [guest.kernel.kallsyms]  [g] kvm_init_debu=
gfs                        [other]
       3.66%     3.66%  :16029   [guest.kernel.kallsyms]  [g] fat_msg      =
                           [other]
       3.11%     3.11%  :16029   [guest.kernel.kallsyms]  [g] match_token  =
                           [other]
       3.07%     3.07%  :16029   [guest.kernel.kallsyms]  [g] load_balance =
                           [other]
       1.87%     1.87%  :16029   [guest.kernel.kallsyms]  [g] kvm_pv_guest_=
cpu_reboot                 [other]
       1.69%     1.69%  :16031   [guest.kernel.kallsyms]  [g] kvm_init_debu=
gfs                        [other]
       1.59%     1.59%  :16029   [guest.kernel.kallsyms]  [g] sys_kcmp     =
                           [other]
       1.19%     1.19%  :16031   [guest.kernel.kallsyms]  [g] save_paranoid=
                           [other]
       0.82%     0.82%  :16031   [guest.kernel.kallsyms]  [g] kvm_pv_guest_=
cpu_reboot                 [other]
       0.69%     0.69%  :16031   [guest.kernel.kallsyms]  [g] kvm_cpu_notif=
y                          [other]
       0.54%     0.54%  :16031   [guest.kernel.kallsyms]  [g] rcu_process_c=
allbacks                   [other]
       0.46%     0.46%  :16030   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_start         [other]
       0.43%     0.43%  :16031   [guest.kernel.kallsyms]  [g] tg_set_cfs_ba=
ndwidth                    [other]
       0.42%     0.42%  :16030   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_expire_entry  [other]
       0.37%     0.37%  :16029   [guest.kernel.kallsyms]  [g] amd_get_mmcon=
fig_range                  [other]
       0.35%     0.35%  :16031   [guest.kernel.kallsyms]  [g] sys_kcmp     =
                           [other]
       0.35%     0.35%  :16031   [guest.kernel.kallsyms]  [g] console_unloc=
k                          [other]
       0.34%     0.34%  :16029   [guest.kernel.kallsyms]  [g] __fat_fs_erro=
r                          [other]
       0.31%     0.31%  :16031   [guest.kernel.kallsyms]  [g] do_sysfs_unre=
gistration                 [other]
       0.24%     0.24%  :16031   [guest.kernel.kallsyms]  [g] paravirt_writ=
e_msr                      [other]
       0.24%     0.24%  :16029   [guest.kernel.kallsyms]  [g] parse_no_kvmc=
lock                       [other]
       0.24%     0.24%  :16029   [guest.kernel.kallsyms]  [g] kvm_save_sche=
d_clock_state              [other]
       0.21%     0.21%  :16030   [guest.kernel.kallsyms]  [g] ptrace_reques=
t                          [other]
       0.20%     0.20%  :16031   [guest.kernel.kallsyms]  [g] print_stack_t=
race                       [other]
       0.20%     0.20%  :16031   [guest.kernel.kallsyms]  [g] build_sched_d=
omains                     [other]
       0.20%     0.20%  :16031   [guest.kernel.kallsyms]  [g] __synchronize=
_srcu                      [other]
       0.17%     0.17%  :16031   [guest.kernel.kallsyms]  [g] do_cpu_nanosl=
eep                        [other]
       0.16%     0.16%  :16031   [guest.kernel.kallsyms]  [g] amd_get_mmcon=
fig_range                  [other]
       0.16%     0.16%  :16031   [guest.kernel.kallsyms]  [g] irq_node_proc=
_show                      [other]
       0.15%     0.15%  :16031   [guest.kernel.kallsyms]  [g] __srcu_read_l=
ock                        [other]
       0.15%     0.15%  :16031   [guest.kernel.kallsyms]  [g] posix_cpu_nsl=
eep_restart                [other]
       0.11%     0.11%  :16031   [guest.kernel.kallsyms]  [g] parse_no_kvmc=
lock                       [other]
       0.11%     0.11%  :16031   [guest.kernel.kallsyms]  [g] __irq_domain_=
add                        [other]
       0.11%     0.11%  :16031   [guest.kernel.kallsyms]  [g] print_tickdev=
ice.isra.4                 [other]
       0.10%     0.10%  :16031   [guest.kernel.kallsyms]  [g] kvm_save_sche=
d_clock_state              [other]
       0.09%     0.09%  :16031   [guest.kernel.kallsyms]  [g] sysfs_unbind_=
tick_dev                   [other]
       0.09%     0.09%  :16029   [guest.kernel.kallsyms]  [g] __sched_setsc=
heduler                    [other]
       0.09%     0.09%  :16031   [guest.kernel.kallsyms]  [g] process_srcu =
                           [other]
       0.08%     0.08%  :16031   [guest.kernel.kallsyms]  [g] avc_compute_a=
v                          [other]
       0.08%     0.08%  :16031   [guest.kernel.kallsyms]  [g] arch_remove_r=
eservations                [other]
       0.08%     0.08%  :16031   [guest.kernel.kallsyms]  [g] __switch_to_x=
tra                        [other]
       0.08%     0.08%  :16031   [guest.kernel.kallsyms]  [g] __create_irqs=
                           [other]
       0.08%     0.08%  :16031   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_exit      [other]
       0.07%     0.07%  :16031   [guest.kernel.kallsyms]  [g] posix_clock_r=
ead                        [other]
       0.07%     0.07%  :16031   [guest.kernel.kallsyms]  [g] posix_clock_p=
oll                        [other]
       0.07%     0.07%  :16031   [guest.kernel.kallsyms]  [g] native_cpu_up=
                           [other]
       0.06%     0.06%  :16031   [guest.kernel.kallsyms]  [g] do_nmi       =
                           [other]
       0.06%     0.06%  :16031   [guest.kernel.kallsyms]  [g] rcu_try_advan=
ce_all_cbs                 [other]
       0.06%     0.06%  :16031   [guest.kernel.kallsyms]  [g] fat_msg      =
                           [other]
       0.05%     0.05%  :16031   [guest.kernel.kallsyms]  [g] check_tsc_war=
p                          [other]
       0.04%     0.04%  :16031   [guest.kernel.kallsyms]  [g] tick_handle_o=
neshot_broadcast           [other]
       0.03%     0.03%  :16031   [guest.kernel.kallsyms]  [g] set_cpu_itime=
r                          [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] arp_ignore   =
                           [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] store_powersa=
ve_bias_gov_sys            [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] cleanup_srcu_=
struct                     [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] create_prof_c=
pu_mask                    [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] alarm_timer_n=
sleep                      [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] time_cpufreq_=
notifier                   [other]
       0.02%     0.02%  :16030   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_itimer_state          [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] tick_check_ne=
w_device                   [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] init_timer_ke=
y                          [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] tick_setup_de=
vice                       [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] clockevents_r=
egister_device             [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] __srcu_read_u=
nlock                      [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] hpet_rtc_inte=
rrupt                      [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] init_srcu_str=
uct                        [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] irq_spurious_=
proc_show                  [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] rcu_jiffies_t=
ill_stall_check            [other]
       0.02%     0.02%  :16031   [guest.kernel.kallsyms]  [g] ksoftirqd_sho=
uld_run                    [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_entry     [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] avc_denied.is=
ra.0                       [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] __fat_fs_erro=
r                          [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] wakeme_after_=
rcu                        [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] prof_cpu_mask=
_proc_write                [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] srcu_barrier =
                           [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] tick_get_devi=
ce                         [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] irq_domain_ad=
d_simple                   [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] synchronize_s=
rcu_expedited              [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] sysfs_show_cu=
rrent_tick_dev             [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] tick_is_onesh=
ot_available               [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] tick_check_re=
placement                  [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] clockevents_n=
otify                      [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] show_stack   =
                           [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] debug_kfree  =
                           [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] tick_do_broad=
cast.constprop.6           [other]
       0.01%     0.01%  :16031   [guest.kernel.kallsyms]  [g] sock_rps_save=
_rxhash.isra.28.part.29    [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] store_ignore_=
nice_load.isra.3           [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] perf_trace_it=
imer_expire                [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] hrtick_start =
                           [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] parse_probe_a=
rg                         [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] wakeup_softir=
qd                         [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] tick_install_=
replacement                [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] detach_if_pen=
ding                       [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] default_affin=
ity_show                   [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] tick_do_perio=
dic_broadcast              [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_softirq               [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] tasklet_kill =
                           [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] update_rq_clo=
ck                         [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] tasklet_init =
                           [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] arch_local_ir=
q_enable                   [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] irq_affinity_=
proc_show                  [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] store_samplin=
g_down_factor.isra.4       [other]
       0.00%     0.00%  :16031   [guest.kernel.kallsyms]  [g] amd_get_subca=
ches                       [other]

  Also tried a `virsh restore` with the `--bypass-cache` option and ran
  a perf trace. Noticable is the different trace. See output below:

  # perf trace without filesystem cache:
  # To display the perf.data header info, please use --header/--header-only=
 options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 1M of event 'cycles'
  # Event count (approx.): 798928823821
  #
  # Children      Self  Command  Shared Object            Symbol
  # ........  ........  .......  .......................  .................=
.........................
  #
      25.32%    25.32%  :34335   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_init
       9.55%     9.55%  :34334   [guest.kernel.kallsyms]  [g] do_sysfs_unre=
gistration
       5.83%     5.83%  :34335   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_timer_expire_entry
       5.60%     5.60%  :34334   [guest.kernel.kallsyms]  [g] posix_cpu_clo=
ck_get
       4.37%     4.37%  :34334   [guest.kernel.kallsyms]  [g] kvm_init_debu=
gfs
       4.30%     4.30%  :34334   [guest.kernel.kallsyms]  [g] fat_msg
       3.63%     3.63%  :34334   [guest.kernel.kallsyms]  [g] match_token
       3.44%     3.44%  :34334   [guest.kernel.kallsyms]  [g] load_balance
       3.28%     3.28%  :34333   [guest.kernel.kallsyms]  [g] save_paranoid
       2.25%     2.25%  :34334   [guest.kernel.kallsyms]  [g] kvm_pv_guest_=
cpu_reboot
       2.19%     2.19%  :34335   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_expire_entry
       1.89%     1.89%  :34334   [guest.kernel.kallsyms]  [g] sys_kcmp
       1.73%     1.73%  :34336   [guest.kernel.kallsyms]  [g] kvm_init_debu=
gfs
       1.58%     1.58%  :34335   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_hrtimer_start
       1.26%     1.26%  :34336   [guest.kernel.kallsyms]  [g] save_paranoid
       1.09%     1.09%  :34333   [guest.kernel.kallsyms]  [g] kvm_init_debu=
gfs
       1.01%     1.01%  :34333   [unknown]                [u] 0x00000000004=
34c1b
       0.94%     0.94%  :34336   [guest.kernel.kallsyms]  [g] tg_set_cfs_ba=
ndwidth
       0.88%     0.88%  :34333   [guest.kernel.kallsyms]  [g] avc_denied.is=
ra.0
       0.87%     0.87%  :34336   [guest.kernel.kallsyms]  [g] kvm_pv_guest_=
cpu_reboot
       0.73%     0.73%  :34333   [guest.kernel.kallsyms]  [g] kvm_pv_guest_=
cpu_reboot
       0.68%     0.68%  :34336   [guest.kernel.kallsyms]  [g] kvm_cpu_notify
       0.65%     0.65%  :34336   [guest.kernel.kallsyms]  [g] rcu_process_c=
allbacks
       0.57%     0.57%  :34333   [guest.kernel.kallsyms]  [g] paravirt_writ=
e_msr
       0.56%     0.56%  :34333   [guest.kernel.kallsyms]  [g] avc_compute_av
       0.40%     0.40%  :34334   [guest.kernel.kallsyms]  [g] __fat_fs_error
       0.39%     0.39%  :34334   [guest.kernel.kallsyms]  [g] amd_get_mmcon=
fig_range
       0.39%     0.39%  :34335   [guest.kernel.kallsyms]  [g] ptrace_request
       0.38%     0.38%  :34336   [guest.kernel.kallsyms]  [g] sys_kcmp
       0.34%     0.34%  :34333   [guest.kernel.kallsyms]  [g] posix_cpu_nsl=
eep_restart
       0.32%     0.32%  :34336   [guest.kernel.kallsyms]  [g] do_sysfs_unre=
gistration
       0.31%     0.31%  :34336   [guest.kernel.kallsyms]  [g] console_unlock
       0.30%     0.30%  :34334   [guest.kernel.kallsyms]  [g] kvm_save_sche=
d_clock_state
       0.29%     0.29%  :34334   [guest.kernel.kallsyms]  [g] parse_no_kvmc=
lock
       0.27%     0.27%  :34333   [guest.kernel.kallsyms]  [g] do_sysfs_unre=
gistration
       0.27%     0.27%  :34333   [guest.kernel.kallsyms]  [g] check_tsc_warp
       0.26%     0.26%  :34333   [guest.kernel.kallsyms]  [g] ksoftirqd_sho=
uld_run
       0.26%     0.26%  :34336   [guest.kernel.kallsyms]  [g] paravirt_writ=
e_msr
       0.26%     0.26%  :34333   [guest.kernel.kallsyms]  [g] amd_get_mmcon=
fig_range
       0.25%     0.25%  :34333   [guest.kernel.kallsyms]  [g] sys_kcmp
       0.22%     0.22%  :34336   [guest.kernel.kallsyms]  [g] build_sched_d=
omains
       0.22%     0.22%  :34333   [guest.kernel.kallsyms]  [g] do_cpu_nanosl=
eep
       0.22%     0.22%  :34333   [guest.kernel.kallsyms]  [g] print_stack_t=
race
       0.21%     0.21%  :34336   [guest.kernel.kallsyms]  [g] irq_node_proc=
_show
       0.19%     0.19%  :34336   [guest.kernel.kallsyms]  [g] print_stack_t=
race
       0.19%     0.19%  :34336   [guest.kernel.kallsyms]  [g] __srcu_read_l=
ock
       0.18%     0.18%  :34336   [guest.kernel.kallsyms]  [g] __synchronize=
_srcu
       0.17%     0.17%  :34333   [guest.kernel.kallsyms]  [g] __create_irqs
       0.17%     0.17%  :34336   [guest.kernel.kallsyms]  [g] do_cpu_nanosl=
eep
       0.17%     0.17%  :34336   [guest.kernel.kallsyms]  [g] amd_get_mmcon=
fig_range
       0.15%     0.15%  :34336   [guest.kernel.kallsyms]  [g] posix_cpu_nsl=
eep_restart
       0.14%     0.14%  :34333   [guest.kernel.kallsyms]  [g] rcu_process_c=
allbacks
       0.14%     0.14%  :34333   [guest.kernel.kallsyms]  [g] rcu_try_advan=
ce_all_cbs
       0.13%     0.13%  :34336   [guest.kernel.kallsyms]  [g] parse_no_kvmc=
lock
       0.11%     0.11%  :34333   [guest.kernel.kallsyms]  [g] tasklet_init
       0.11%     0.11%  :34336   [guest.kernel.kallsyms]  [g] process_srcu
       0.11%     0.11%  :34336   [guest.kernel.kallsyms]  [g] kvm_save_sche=
d_clock_state
       0.11%     0.11%  :34333   [guest.kernel.kallsyms]  [g] sysfs_unbind_=
tick_dev
       0.10%     0.10%  :34336   [guest.kernel.kallsyms]  [g] __switch_to_x=
tra
       0.10%     0.10%  :34334   [guest.kernel.kallsyms]  [g] __sched_setsc=
heduler
       0.10%     0.10%  :34333   [guest.kernel.kallsyms]  [g] print_tickdev=
ice.isra.4
       0.10%     0.10%  :34336   [guest.kernel.kallsyms]  [g] sysfs_unbind_=
tick_dev
       0.10%     0.10%  :34336   [guest.kernel.kallsyms]  [g] print_tickdev=
ice.isra.4
       0.10%     0.10%  :34336   [guest.kernel.kallsyms]  [g] posix_clock_r=
ead
       0.09%     0.09%  :34333   [guest.kernel.kallsyms]  [g] parse_no_kvmc=
lock
       0.09%     0.09%  :34333   [guest.kernel.kallsyms]  [g] posix_clock_p=
oll
       0.09%     0.09%  :34336   [guest.kernel.kallsyms]  [g] __irq_domain_=
add
       0.09%     0.09%  :34336   [guest.kernel.kallsyms]  [g] avc_compute_av
       0.09%     0.09%  :34333   [guest.kernel.kallsyms]  [g] posix_clock_r=
ead
       0.09%     0.09%  :34333   [guest.kernel.kallsyms]  [g] hpet_rtc_inte=
rrupt
       0.09%     0.09%  :34336   [guest.kernel.kallsyms]  [g] __create_irqs
       0.08%     0.08%  :34336   [guest.kernel.kallsyms]  [g] posix_clock_p=
oll
       0.08%     0.08%  :34336   [guest.kernel.kallsyms]  [g] rcu_try_advan=
ce_all_cbs
       0.07%     0.07%  :34336   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_exit
       0.07%     0.07%  :34336   [guest.kernel.kallsyms]  [g] arch_remove_r=
eservations
       0.07%     0.07%  :34333   [guest.kernel.kallsyms]  [g] native_cpu_up
       0.07%     0.07%  :34336   [guest.kernel.kallsyms]  [g] native_cpu_up
       0.07%     0.07%  :34336   [guest.kernel.kallsyms]  [g] check_tsc_warp
       0.07%     0.07%  :34333   [guest.kernel.kallsyms]  [g] kvm_save_sche=
d_clock_state
       0.07%     0.07%  :34333   [guest.kernel.kallsyms]  [g] do_nmi
       0.06%     0.06%  :34336   [guest.kernel.kallsyms]  [g] do_nmi
       0.06%     0.06%  :34335   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_itimer_state
       0.05%     0.05%  :34336   [guest.kernel.kallsyms]  [g] fat_msg
       0.04%     0.04%  :34336   [guest.kernel.kallsyms]  [g] store_powersa=
ve_bias_gov_sys
       0.04%     0.04%  :34336   [guest.kernel.kallsyms]  [g] tick_handle_o=
neshot_broadcast
       0.04%     0.04%  :34336   [guest.kernel.kallsyms]  [g] set_cpu_itimer
       0.04%     0.04%  :34336   [guest.kernel.kallsyms]  [g] cleanup_srcu_=
struct
       0.03%     0.03%  :34336   [guest.kernel.kallsyms]  [g] __srcu_read_u=
nlock
       0.03%     0.03%  :34336   [guest.kernel.kallsyms]  [g] time_cpufreq_=
notifier
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] irq_spurious_=
proc_show
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] alarm_timer_n=
sleep
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] ksoftirqd_sho=
uld_run
       0.02%     0.02%  :34333   [guest.kernel.kallsyms]  [g] tg_set_cfs_ba=
ndwidth
       0.02%     0.02%  :34333   [guest.kernel.kallsyms]  [g] create_prof_c=
pu_mask
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] create_prof_c=
pu_mask
       0.02%     0.02%  :34333   [guest.kernel.kallsyms]  [g] fat_msg
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] tick_check_ne=
w_device
       0.02%     0.02%  :34333   [guest.kernel.kallsyms]  [g] __switch_to_x=
tra
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] tick_setup_de=
vice
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] init_timer_key
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] rcu_jiffies_t=
ill_stall_check
       0.02%     0.02%  :34333   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_exit
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] arp_ignore
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] clockevents_r=
egister_device
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] hpet_rtc_inte=
rrupt
       0.02%     0.02%  :34336   [guest.kernel.kallsyms]  [g] init_srcu_str=
uct
       0.01%     0.01%  :34333   [guest.kernel.kallsyms]  [g] irq_node_proc=
_show
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] __fat_fs_error
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] tick_check_re=
placement
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] avc_denied.is=
ra.0
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] tick_get_devi=
ce
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] irq_affinity_=
proc_show
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] sysfs_show_cu=
rrent_tick_dev
       0.01%     0.01%  :34333   [guest.kernel.kallsyms]  [g] __fat_fs_error
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_entry
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] tick_is_onesh=
ot_available
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] irq_domain_ad=
d_simple
       0.01%     0.01%  :34333   [guest.kernel.kallsyms]  [g] irq_spurious_=
proc_show
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] tick_do_broad=
cast.constprop.6
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] sock_rps_save=
_rxhash.isra.28.part.29
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] prof_cpu_mask=
_proc_write
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] perf_trace_it=
imer_expire
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] srcu_barrier
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] store_ignore_=
nice_load.isra.3
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] wakeme_after_=
rcu
       0.01%     0.01%  :34333   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_irq_handler_entry
       0.01%     0.01%  :34333   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_softirq
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] debug_kfree
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] clockevents_n=
otify
       0.01%     0.01%  :34336   [guest.kernel.kallsyms]  [g] parse_probe_a=
rg
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] hrtick_start
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] detach_if_pen=
ding
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] tasklet_init
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] show_stack
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] wakeup_softir=
qd
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] arch_local_ir=
q_enable
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] tasklet_kill
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] default_affin=
ity_show
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] ftrace_raw_ou=
tput_softirq
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] store_samplin=
g_down_factor.isra.4
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] synchronize_s=
rcu_expedited
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] update_rq_clo=
ck
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] tick_do_perio=
dic_broadcast
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] tick_install_=
replacement
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] amd_get_subca=
ches
       0.00%     0.00%  :34334   [guest.kernel.kallsyms]  [g] amd_get_subca=
ches
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] tick_handle_p=
eriodic
       0.00%     0.00%  :34336   [guest.kernel.kallsyms]  [g] __page_cache_=
alloc

  I am not sure how correct the symbol mapping of perf is, so I don't
  know if this is usable at all.

  I have dumped info registers with the `qemu-monitor-command` command
  after the  migration problematic VM and this gave the following
  output:

  RAX=3D0000000000001975 RBX=3Dffff8802342fc000 RCX=3D000000000000beac RDX=
=3D000000000000beaa
  RSI=3D000000000000beac RDI=3Dffff8802342fc000 RBP=3Dffff880233d3fb18 RSP=
=3Dffff880233d3fb18
  R8 =3D0000000000000286 R9 =3Dffff8800a71eee40 R10=3Dffff8800a71eeed4 R11=
=3D000000000000000a
  R12=3Dffff8802342fc000 R13=3Dffffffff81cdf010 R14=3Dffff880233d3fb58 R15=
=3Dffff88003672b200
  RIP=3Dffffffff817360b7 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
  ES =3D0000 0000000000000000 000fffff 00000000
  CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
  SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  DS =3D0000 0000000000000000 000fffff 00000000
  FS =3D0000 0000000000000000 000fffff 00000000
  GS =3D0000 ffff88023fc00000 000fffff 00000000
  LDT=3D0000 0000000000000000 000fffff 00000000
  TR =3D0040 ffff88023fc04440 00002087 00008b00 DPL=3D0 TSS64-busy
  GDT=3D     ffff88023fc0c000 0000007f
  IDT=3D     ffffffffff576000 00000fff
  CR0=3D8005003b CR2=3D0000000000408950 CR3=3D0000000232098000 CR4=3D000006=
70
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000d01
  FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001fa0
  FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
  FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
  FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
  FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
  XMM00=3Dffffffffff0000ff0000000000000000 XMM01=3D0000010101000000ffffffff=
ffffffff
  XMM02=3D00007fe302de17006776615f64616f6c XMM03=3D000000000000000000000000=
00000000
  XMM04=3D00000000000000000000000000000000 XMM05=3D000000000000000000000000=
00ff0000
  XMM06=3D5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b XMM07=3D202020202020202020202020=
20202020
  XMM08=3D00000000000000000000000000000000 XMM09=3D000000000000000000000000=
00000000
  XMM10=3D00000000000000000000000000000000 XMM11=3D000000000000000000000000=
00000000
  XMM12=3D00ff000000ff0000000000000000ff00 XMM13=3D000000000000000000000000=
00000000
  XMM14=3D00000000000000000000000000000000 XMM15=3D000000000000000000000000=
00000000

  And I looped this for a minute to check were the RIP is changing to:
  136 RIP=3D0000000000434c1b
  173 RIP=3Dffffffff8105144a
    2 RIP=3Dffffffff810521ff
    1 RIP=3Dffffffff81070816

  =

  I tried to reproduce this with some manual actions prior to migrating bet=
ween qemu 2.6.2 and 2.11.1 on our testing environment using similar hardwar=
e (56 core model name: Intel(R) Xeon(R) Gold 6126 CPU @ 2.60GHz)
  And I was not able to reproduce this, i tried the following:
  - restore without filesystem caches (see new perf traces below)
  - create vm with same kernel as stuck vm
  - restore paused detach net device and virtio block device (detach doesn'=
t work)
  - try to do a lot of network and disk io while migrating
  - ecrypt fs actions during migration
  - migrate 4000 times between 2.6.2 -> 2.11 using loop
  - add extra timer calls inside guest for migrate loop (done using cyclict=
est)
  - try with guest kernel 3.13.0-145-generic, same kernel vm was running wi=
th this issue
  - try host clock/timer calls on 2.11.1 host prior and during migration bo=
und on first cpu core (cyclictest -a 0 -c 1 -d 200 -H -l 1 -t 2)

  I asked the vm owner what he is doing on his vm, and he told me that
  he is using 80% of his mem around 14G of the 16G, the vm is running a
  tomcat 7 server and a libreoffice deamon the vm has a load of 1.0 and
  runs Ubuntu 14.04 with kernel 3.13.0-145.

  The other vms were running centos 6, centos 7, debian 7, debian 8,
  ubuntu 13.10, ubuntu 14.04, ubuntu 12.04 the majority of these vms are
  running linux kernel 3.*.

  The thing is I am actually out of ideas for reproducing this, and I am
  not sure how to pinpoint this issue, I would like some help and
  possible some extra tips on debugging.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1775555/+subscriptions
