Received: from eggs.gnu.org ([2001:4830:134:3::10]:57461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cfdxU-0002cB-PH
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 21:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cfdxR-0007H9-JE
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 21:44:12 -0500
Received: from [45.249.212.188] (port=2472 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cfdxP-0007CK-PA
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 21:44:09 -0500
Message-ID: <58AA51D6.6020508@huawei.com>
Date: Mon, 20 Feb 2017 10:17:58 +0800
From: hangaohuai <hangaohuai@huawei.com>
MIME-Version: 1.0
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com>
In-Reply-To: <589DDC05.9010807@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kai.huang@linux.intel.com, guangrong.xiao@linux.intel.com, xudong.hao@linux.intel.com
Cc: Chris Friesen <chris.friesen@windriver.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, pbonzini@redhat.com, rkrcmar@redhat.com, fangying1@huawei.com, "wangxin (U)" <wangxinxin.wang@huawei.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi, Kai Huang and Xiao Guangrong.

For the problem mentioned above, there may be a bug related to PML and probably on Broadwell CPUs.

I've been reading the code for PML for days, but I haven't found any clews. Do you have any idea about this BUG ?

Hope you can help!

On 2017/2/10 23:28, Chris Friesen wrote:
>
> Well, not so much solved as worked around it.
>
> It seems that the problem only showed up on Broadwell, which made us wonder about something hardware specific.
>
> Setting "kvm-intel.eptad=0" in the kernel boot args seems to mask the problem for us.
>
> Chris
>
> On 02/10/2017 03:11 AM, Herongguang (Stephen) wrote:
>> Hi, Chris Friesen, did you solve the problem?
>>
>> On 2017/2/9 22:37, Herongguang (Stephen) wrote:
>>> Hi.
>>> I had a problem when I just repeatedly live migrate a vm between two compute
>>> nodes.
>>> The phenomenon was that the KVM module was crashed and then the host rebooted.
>>> However I cannot reliably trigger this BUG.
>>>
>>> The backtrace is the same as http://www.spinics.net/lists/kvm/msg138475.html.
>>>
>>> The crash is triggered when function __rmap_clear_dirty is invoked and an
>>> invalid page(0x000000007f183000) is visited.
>>> The value %rdi is 0x000000007f183000, which is obviously not a valid kernel
>>> pointer for x86_64.
>>> The assembly of __rmap_clear_dirty is:
>>>      0xffffffffa04d9ac0 <__rmap_clear_dirty>:        callq 0xffffffff816543d0
>>> <ftrace_caller>
>>>      0xffffffffa04d9ac5 <__rmap_clear_dirty+5>:      push %rbp
>>>      0xffffffffa04d9ac6 <__rmap_clear_dirty+6>:      mov %rsp,%rbp
>>>      0xffffffffa04d9ac9 <__rmap_clear_dirty+9>:      push %rbx
>>>      0xffffffffa04d9aca <__rmap_clear_dirty+10>:     sub $0x18,%rsp
>>>      0xffffffffa04d9ace <__rmap_clear_dirty+14>:     mov (%rsi),%rdi
>>>      0xffffffffa04d9ad1 <__rmap_clear_dirty+17>:     mov %gs:0x28,%rax
>>>      0xffffffffa04d9ada <__rmap_clear_dirty+26>:     mov %rax,-0x10(%rbp)
>>>      0xffffffffa04d9ade <__rmap_clear_dirty+30>:     xor %eax,%eax
>>>      0xffffffffa04d9ae0 <__rmap_clear_dirty+32>:     test %rdi,%rdi
>>>      0xffffffffa04d9ae3 <__rmap_clear_dirty+35>:     je 0xffffffffa04d9b78
>>>      0xffffffffa04d9ae9 <__rmap_clear_dirty+41>:     test $0x1,%dil
>>>      0xffffffffa04d9aed <__rmap_clear_dirty+45>:     je 0xffffffffa04d9b98
>>>      0xffffffffa04d9af3 <__rmap_clear_dirty+51>:     and $0xfffffffffffffffe,%rdi
>>>      0xffffffffa04d9af7 <__rmap_clear_dirty+55>:     movl $0x0,-0x18(%rbp)
>>>      0xffffffffa04d9afe <__rmap_clear_dirty+62>:     mov %rdi,-0x20(%rbp)
>>>      0xffffffffa04d9b02 <__rmap_clear_dirty+66>:     mov (%rdi),%rdi
>>>      0xffffffffa04d9b05 <__rmap_clear_dirty+69>:     test %rdi,%rdi
>>>                                     ...
>>>
>>> The details of the environment is:
>>> Host info: x86_64 CentOS 7 kernel (3.10.0-327.36.58.10_2.x86_64, slightly
>>> modified). The CPU is Broadwell Intel(R) Xeon(R) CPU E5-2618L v4 @ 2.20GHz.
>>> Kmod info: version is 4.4.36
>>> What I know is that the parameter PML(Page Modification Logging) is enabled by
>>> default.
>>>      # cat /sys/module/kvm_intel/parameters/pml
>>>      # Y
>>>
>>> Below is the crash message:
>>> [1548777.924180] kvm: zapping shadow pages for mmio generation wraparound
>>> [1548777.947844] HTB: quantum of class 10001 is big. Consider r2q change.
>>> [1548778.185389] kvm: zapping shadow pages for mmio generation wraparound
>>> [1548778.994801] BUG: unable to handle kernel paging request at 000000007f183000
>>> [1548779.002135] IP: [<ffffffffa04d9b0a>] __rmap_clear_dirty+0x4a/0xf0 [kvm]
>>> [1548779.009151] PGD 1f8452067 PUD 0
>>> [1548779.012774] Thread overran stack, or stack corrupted
>>> [1548779.018076] Oops: 0000 [#1] SMP
>>> [1548779.027050] collected_len = 1048570, LOG_BUF_LEN_LOCAL = 1048576
>>> [1548779.042039] kbox: no notify die func register. no need to notify
>>> [1548779.048392] do nothing after die!
>>> [1548779.052071] Modules linked in: kboxdriver(O) kbox(O) sch_htb
>>> ip_set_hash_net ip6table_filter ip6_tables iptable_filter igb_uio(OE) uio
>>> bridge dm_service_time dm_multipath iscsi_tcp libiscsi_tcp libiscsi
>>> scsi_transport_iscsi 8021q garp stp mrp llc vfat fat isofs ext4 jbd2 xfs
>>> sha512_generic dev_connlimit(O) bum(O) ip_set nfnetlink prio(O) nat(O)
>>> vport_vxlan(O) openvswitch(O) nf_defrag_ipv6 gre ib_uverbs(OVE) hotpatch(OE)
>>> sigma_serial(O) pmcint(O) guest_kbox_ram(O) signo_catch(O) mlx4_ib(OVE)
>>> mlx4_en(OVE) vxlan ip6_udp_tunnel udp_tunnel ib_sa(OVE) ib_mad(OVE) ptp
>>> ib_core(OVE) ib_addr(OVE) pps_core ib_netlink(OVE) intel_powerclamp coretemp
>>> intel_rapl crc32_pclmul crc32c_intel ipmi_devintf(OVE) ghash_clmulni_intel
>>> mlx4_core(OVE) aesni_intel kvm_intel(O) igb(OVE) lrw gf128mul i2c_algo_bit
>>> glue_helper
>>> [1548779.125577]  iTCO_wdt ablk_helper kvm(O) iTCO_vendor_support sg cryptd
>>> compat(OVE) dca sb_edac i2c_i801 kbox_pci(OVE) i2c_core edac_core pcspkr
>>> lpc_ich shpchp mfd_core ipmi_si(OVE) ipmi_msghandler(OVE) nf_conntrack_ipv4
>>> nf_defrag_ipv4 vhost_net(O) tun(O) vhost(O) macvtap macvlan vfio_pci irqbypass
>>> vfio_iommu_type1 vfio xt_sctp nf_conntrack_proto_sctp nf_nat_proto_sctp nf_nat
>>> nf_conntrack sctp libcrc32c ip_tables ext3 mbcache jbd sd_mod crc_t10dif
>>> crct10dif_generic ahci crct10dif_pclmul crct10dif_common libahci mpt2sas(OVE)
>>> libata raid_class scsi_transport_sas dm_mod [last unloaded: kbox]
>>> [1548779.178704] CPU: 35 PID: 33769 Comm: migration Tainted: G           OE
>>> ----V-------   3.10.0-327.36.58.10_2.x86_64 #1
>>> [1548779.189855] Hardware name: HUAWEI TECHNOLOGIES CO.,LTD.
>>> CH80GPUB8/CH80GPUB8, BIOS GPUBV201 06/18/2015
>>> [1548779.199585] task: ffff880123da0000 ti: ffff8801a8068000 task.ti:
>>> ffff8801a8068000
>>> [1548779.207596] RIP: 0010:[<ffffffffa04d9b0a>] [<ffffffffa04d9b0a>]
>>> __rmap_clear_dirty+0x4a/0xf0 [kvm]
>>> [1548779.217209] RSP: 0018:ffff8801a806bba0  EFLAGS: 00010206
>>> [1548779.222879] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [1548779.230543] RDX: ffffc90059d64000 RSI: ffffc90059f2efd0 RDI:
>>> 000000007f183000
>>> [1548779.238211] RBP: ffff8801a806bbc0 R08: ffff8801a806bd60 R09:
>>> 0000000000000100
>>> [1548779.245878] R10: 0000000000003649 R11: 0000000000000006 R12:
>>> ffff88027a7f0000
>>> [1548779.253524] R13: ffffffffa04d9ac0 R14: ffff8801a806bfd8 R15:
>>> 0000000000000000
>>> [1548779.261125] FS:  00007f3dd6aff700(0000) GS:ffff883ffe3c0000(0000)
>>> knlGS:0000000000000000
>>> [1548779.269733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [1548779.275795] CR2: 000000007f183000 CR3: 00000001f50ab000 CR4:
>>> 00000000003427e0
>>> [1548779.283444] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [1548779.291040] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>> 0000000000000400
>>> [1548779.298689] Stack:
>>> [1548779.301045]  0000000000000000 0000000000000297 0000000009b989ac
>>> 0000000000000000
>>> [1548779.309033]  ffff8801a806bc48 ffffffffa04d9206 00ff8801a806bd10
>>> ffff8801a806bd60
>>> [1548779.317023]  0000000000000100 00000000000bffff 0000000100000001
>>> 00000000000396fa
>>> [1548779.325012] Call Trace:
>>> [1548779.327856]  [<ffffffffa04d9206>] slot_handle_level_range+0x76/0x100 [kvm]
>>> [1548779.335090]  [<ffffffffa04dac34>] kvm_mmu_slot_leaf_clear_dirty+0x54/0x80
>>> [kvm]
>>> [1548779.342922]  [<ffffffffa03f8967>] vmx_slot_enable_log_dirty+0x17/0x30
>>> [kvm_intel]
>>> [1548779.350943]  [<ffffffffa04d5d2f>] kvm_arch_commit_memory_region+0x5f/0xe0
>>> [kvm]
>>> [1548779.358776]  [<ffffffffa04be7c5>] __kvm_set_memory_region+0x665/0xa90 [kvm]
>>> [1548779.366099]  [<ffffffffa04be160>] ? kvm_kvzalloc+0x30/0x30 [kvm]
>>> [1548779.372457]  [<ffffffffa04bec1b>] kvm_set_memory_region+0x2b/0x40 [kvm]
>>> [1548779.379423]  [<ffffffffa04bf084>] kvm_vm_ioctl+0x454/0x700 [kvm]
>>> [1548779.385777]  [<ffffffff8112f083>] ? ftrace_ops_list_func+0x83/0x110
>>> [1548779.392406]  [<ffffffffa04bec30>] ? kvm_set_memory_region+0x40/0x40 [kvm]
>>> [1548779.399538]  [<ffffffff811fceb5>] do_vfs_ioctl+0x2e5/0x4c0
>>> [1548779.405340]  [<ffffffff811fd131>] SyS_ioctl+0xa1/0xc0
>>> [1548779.410736]  [<ffffffff81652809>] system_call_fastpath+0x16/0x1b
>>> [1548779.417086] Code: c0 48 85 ff 0f 84 8f 00 00 00 40 f6 c7 01 0f 84 a5 00
>>> 00 00 48 83 e7 fe c7 45 e8 00 00 00 00 48 89 7d e0 48 8b 3f 48 85 ff 74 6e
>>> <48> 8b 17 f6 c2 01 74 5d 48 8b 05 c7 40 04 00 48 89 d1 31 db 48
>>> [1548779.438015] RIP  [<ffffffffa04d9b0a>] __rmap_clear_dirty+0x4a/0xf0 [kvm]
>>> [1548779.445109]  RSP <ffff8801a806bba0>
>>> [1548779.448915] CR2: 000000007f183000
>>> [1548779.453070] ---[ end trace d99f28b71290c64c ]---
>>> [1548779.523937] Kernel panic - not syncing: Fatal exception
>>> [1548779.523945] perf interrupt took too long (124114 > 17857), lowering
>>> kernel.perf_event_max_sample_rate to 7000
>>> [1548779.524826] perf interrupt took too long (123163 > 31250), lowering
>>> kernel.perf_event_max_sample_rate to 4000
>>> [1548779.525717] perf interrupt took too long (122216 > 62500), lowering
>>> kernel.perf_event_max_sample_rate to 2000
>>> [1548779.603824] die even has been record!
>>
>
>
>
> .
>
