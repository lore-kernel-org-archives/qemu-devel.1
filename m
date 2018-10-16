Received: from eggs.gnu.org ([2001:4830:134:3::10]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gCRG1-0004Pc-8U
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gCRFx-0006Bf-3N
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:41 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gCRFw-0005gz-Jy
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:36 -0400
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id A044641931
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:27:14 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7yWok_GuLhwK for <qemu-devel@nongnu.org>;
	Tue, 16 Oct 2018 18:27:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 6EE734120A
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 18:27:13 +0300 (MSK)
Date: Tue, 16 Oct 2018 18:27:12 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181016152712.qpvjter6w47azcri@SPB-NB-133.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] modern virtio on HVF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello dear subscribers,

I'm running Linux in QEMU on macOS with hvf accel enabled and having an
issue that is very similar to the KVM bug in nested KVM environments,
where KVM is run under another hypervisor:
https://bugs.launchpad.net/qemu/+bug/1636217


The symptomps are the same as in the bug above. udev hangs unless:
* -machine type=pc-i440fx-X, where X <=2.6 is used
* -accel tcg is used
* -global virtio-pci.disable-modern=on is specified

The issue was briefly noted on packer mailing list:
https://groups.google.com/forum/#!topic/packer-tool/je2D0LRhWj0

If I send Magic SysRQ-t to the VM, I can notice virtio_pci hangs
indefinetly in vp_reset:
[   48.604482] systemd-udevd   D    0   121    106 0x00000100
[   48.608093] Call Trace:
[   48.609701]  ? __schedule+0x292/0x880
[   48.612076]  schedule+0x32/0x80
[   48.614189]  schedule_timeout+0x15e/0x300
[   48.616840]  ? call_timer_fn+0x140/0x140
[   48.619375]  msleep+0x2a/0x40
[   48.621284]  vp_reset+0x27/0x50 [virtio_pci]
[   48.624185]  register_virtio_device+0x71/0x100 [virtio]
[   48.627689]  virtio_pci_probe+0xad/0x120 [virtio_pci]
[   48.630825]  local_pci_probe+0x44/0xa0
[   48.633357]  pci_device_probe+0x127/0x140
[   48.636085]  driver_probe_device+0x297/0x450
[   48.638876]  __driver_attach+0xd9/0xe0
[   48.641484]  ? driver_probe_device+0x450/0x450
[   48.644393]  bus_for_each_dev+0x5a/0x90
[   48.646879]  bus_add_driver+0x41/0x260
[   48.649279]  driver_register+0x5b/0xd0
[   48.651703]  ? 0xffffffffc00ac000
[   48.653994]  do_one_initcall+0x50/0x1b0
[   48.656496]  do_init_module+0x5a/0x1fa
[   48.659001]  load_module+0x1557/0x1ed0
[   48.661507]  ? m_show+0x1b0/0x1b0
[   48.663725]  ? security_capable+0x47/0x60
[   48.666435]  SYSC_finit_module+0x80/0xb0
[   48.669021]  do_syscall_64+0x74/0x150
[   48.671222]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[   48.674565] RIP: 0033:0x7f71dac73139
[   48.677050] RSP: 002b:00007ffdcfd35058 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   48.681997] RAX: ffffffffffffffda RBX: 000055d25bd01500 RCX: 00007f71dac73139
[   48.686608] RDX: 0000000000000000 RSI: 00007f71db5af83d RDI: 000000000000000f
[   48.691191] RBP: 00007f71db5af83d R08: 0000000000000000 R09: 0000000000000000
[   48.695750] R10: 000000000000000f R11: 0000000000000246 R12: 0000000000020000
[   48.700568] R13: 000055d25bd039b0 R14: 0000000000000000 R15: 0000000003938700

It looks like virtio backend doesn't return 0 device status after
vp_iowrite8 and vp_reset blocks udev:
        while (vp_ioread8(&vp_dev->common->device_status))
                        msleep(1)

What could be the cause of the issue?
Any advices how to triage it are appreciated.

Thank you,
Roman
