Received: from eggs.gnu.org ([2001:4830:134:3::10]:57915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPX39-0008W6-Vv
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPX1T-0007To-Sz
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPX1T-0007RE-IM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8822307D868
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 18:14:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-104.ams2.redhat.com
	[10.36.116.104])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D3902604A4
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 18:14:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org>
Date: Wed, 21 Nov 2018 19:14:43 +0100
In-Reply-To: <87a8fucx33.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 30 Aug 2016 13:31:12 +0200")
Message-ID: <87muq2fgbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Time for another update.  My HEAD is at v3.1.0-rc2.

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Paolo asked for an update.
>
> Another update; HEAD is commit e00da55.

A.k.a. v2.7.0-rc5~7.

>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> In my experience, too many files are not covered by MAINTAINERS.
>>>> scripts/get_maintainer.pl falls back to git then, unless you say
>>>> --no-git-fallback.  Copies sent there tends to annoy their recipients
>>>> without accomplishing all that much.
>>>>
>>>> Two obvious improvements:
>>>>
>>>> * Easy: Flip scripts/get_maintainer.pl's default to --no-git-fallback.
>>>>   I'll post the obvious patch, please raise your objections there.

We actually went with Paolo's commit c6561586f0f "get_maintainer.pl:
restrict cases where it falls back to --git".  Later modified by commit
4db84796e75 "get_maintainer.pl: fall back to git if only lists are
found".

>>>> * Harder: improve MAINTAINERS coverage.
>>>
>>> A few folks have started doing that.  Much appreciated!
>>>
>>> I collected recent patches to MAINTAINERS, and reran my analysis.
>>>
>>>> Let me back up subjective experience with hard data.  The tree has quite
>>>> a few files:
>>>>
>>>>     $ git-ls-files | wc -l
>>>>     3746
>>>
>>> Now 3752.
>>
>> Eleven months later, this is 4387.
>
> Another eleven months later, it's 4921.

27 months later, it's 6461.  2633 end in .c.

>>>> Counting them by extension:
>>>>
>>>>     $ git-ls-files | sed -n 's#.*/##;s#.*\.##p' | sort | uniq -c | sort -nr
>>>>        1836 c
>>>>         818 h
>>>>         133 out
>>>>         105 S
>>>>          97 objs
>>>>          69 s
>>>>          64 mak
>>>>          48 json
>>>>          47 py
>>>>          41 txt
>>>>          33 exit
>>>>          33 err
>>>>          16 xml
>>>>          16 bin
>>>>          13 rom
>>>>          12 sh
>>>>          12 dsl
>>>> [Long tail that doesn't add up to anything interesting omitted]
>>>>
>>>> Let's look for .c not in MAINTAINERS:
>>>>
>>>> $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i`" ] || echo $i; done >unmaintained-files
>>>>     $ grep -c '\.c$' unmaintained-files
>>>>     1066
>>>>
>>>> That's almost 60%.  Not good.
>>>
>>> Down to 491 our of 1841 (27%).  Progress, but not quite enough.
>>
>> 461 out of 1945 (24%).  At this linear rate, we'll reach 10%
>> unmaintained in five years.
>
> This is now
>
> $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
> $ grep -c '\.c$' unmaintained-files
> 402
>
> 402 out of 2132 (19%).  More progress, but not yet there.

armbru@dusky:~/work/qemu$ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
armbru@dusky:~/work/qemu$ grep -c '\.c$' unmaintained-files
259

259 out of 2633 (10%).  Getting down to 10% took us "only" a bit over
three years instead of the projected five.

>> We're still adding unmaintained .c files:
>>
>>     $ git-diff --diff-filter=A --name-only e668d1b | grep -c '\.c$'
>>     116
>>     $ git-diff --diff-filter=A --name-only e668d1b | grep '\.c$' | join unmaintained-files - | wc -l
>>     37
>>
>> 37 out of 116 new files (32%) are not covered.  That's worse than we do
>> for old files.  Inexcusable.
>
> $ git-diff --diff-filter=A --name-only 6138fbd | grep -c '\.c$'
> 215
> $ git-diff --diff-filter=A --name-only 6138fbd | grep '\.c$' | join unmaintained-files - | wc -l
> 86
>
> This time, it's 86 out of 215 (40%).  Getting worse.  I'll cook up a
> patch to make checkpatch.pl catch such additions.

We eventually took Joe Perches's commit 4be6131e329 "checkpatch: emit a
warning on file add/move".

$ git-diff --diff-filter=A --name-only e00da55 | grep -c '\.c$'
574
$ git-diff --diff-filter=A --name-only e00da55 | grep '\.c$' | join unmaintained-files - | wc -l
68

68 out of 574 new .c files are unmaintained (12%).  We've gotten better,
but still not good enough.

>>>> Apparently, nobody cares for tests:
>>>>
>>>>     $ grep '^tests/' unmaintained-files | grep -c '\.c$'
>>>>     654
>>>>     $ git-ls-files | grep '^tests/' | grep -c '\.c$'
>>>>     664
>>>
>>> Now 91 out of 665.
>>
>> 105 out of 687.
>
> 114 out of 726.

59 out of 794.

>>>> Filtering those out leaves us with 412 unmaintained out of of 1172, or
>>>> 35% unmaintained.  Not good even if we (foolishly!) considered tests not
>>>> worthy of maintenance.
>>>>
>>>> Maybe unmaintained files are much smaller.  David A.  Wheeler's
>>>> SLOCCount counts 570kSLOC in 1212 maintained files (+140 files sloccount
>>>> doesn't know how to count) vs. 300kSLOC in 1798 unmaintained files (+596
>>>> uncounted), or 35% unmaintained SLOC.  With tests/ ignored, it's 30%.
>>>> So, unmaintained files are indeed smaller, but 30-something percent is
>>>> still not good.
>>>>
>>>> Where are the unmaintained files?  Top-scoring directories outside
>>>> tests/ and include/, files in subdirs not counted:
>>>>
>>>>     #files   directory
>>>>     84  68%  .
>>>>     63 100%  default-configs
>>>>     48 100%  pc-bios
>>>>     43  97%  stubs
>>>>     39 100%  util
>>>>     37 100%  pc-bios/keymaps
>>>>     35  81%  hw/display
>>>>     32  94%  scripts
>>>>     26  92%  docs
>>>>     26 100%  libcacard
>>>>     23  69%  hw/misc
>>>>     22  57%  hw/net
>>>>     21  63%  hw/intc
>>>>     19 100%  roms
>>>>     18 100%  disas
>>>>     18  56%  hw/timer
>>>>     16 100%  hw/core
>>>>     15  53%  hw/char
>>>>     15 100%  qga
>>>>     14 100%  docs/specs
>>>>     12  92%  hw/input
>>>>     12 100%  qobject
>>>>     12 100%  target-m68k
>>>>     11 100%  backends
>>>>     11 100%  pc-bios/s390-ccw
>>>>     10  71%  hw/dma
>>
>> Different tack: what are the unmaintained files we actually change?
>>
>> Unmaintained files sorted by number of commits in the past year (commit
>> 1733681):
>>
>>     $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list 1733681.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn | head -n 100
>>          79 trace-events
>>          77 MAINTAINERS
>>          74 tests/Makefile
>>          37 hw/core/qdev.c
>>          35 arch_init.c
>>          33 tests/libqos/ahci.c
>>          30 tests/libqos/ahci.h
>>          27 qdev-monitor.c
>>          27 include/hw/boards.h
>>          27 Makefile
>>          26 include/exec/exec-all.h
>>          25 include/hw/virtio/virtio.h
>>          24 hw/xen/xen_pt_config_init.c
>>          23 include/hw/virtio/virtio-scsi.h
>>          22 util/qemu-option.c
>>          22 hw/net/rtl8139.c
>>          22 hw/intc/arm_gic.c
>>          22 VERSION
>>          21 target-tilegx/translate.c
>>          21 include/ui/console.h
> [...]
>
> Unmaintained files sorted by number of commits in the past year (commit
> 351053e):
>
> $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list 351053e.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn | head -n 100
>     181 trace-events
>     104 configure
>      98 MAINTAINERS
>      82 hw/misc/ivshmem.c
>      54 qemu-options.hx
>      53 Makefile.objs
>      50 target-tilegx/translate.c
>      49 Makefile
>      42 include/sysemu/block-backend.h
>      31 include/qemu-common.h
>      30 tests/vhost-user-test.c
>      28 tests/.gitignore
>      28 include/qom/cpu.h
>      27 include/qemu/osdep.h
>      23 include/sysemu/sysemu.h
>      22 tests/test-throttle.c
>      22 scripts/checkpatch.pl
>      22 hw/ipmi/ipmi_bmc_sim.c
>      21 qemu-doc.texi
>      20 util/log.c
[...]
>
> Active subsystems lacking a maintainer include tilegx, qdev, replay.
>
> Headers that should probably be covered by existing MAINTAINERS stanzas
> include include/sysemu/block-backend.h include/qom/cpu.h
> include/hw/arm/xlnx-zynqmp.h.

Unmaintained files sorted by number of commits in the past year
(v2.11.0-rc2):

$ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v2.11.0-rc2.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn | head -n 100
    139 MAINTAINERS
    138 configure
    108 tests/Makefile.include
     87 qemu-options.hx
     62 qemu-doc.texi
     56 Makefile
     44 tests/test-bdrv-drain.c
     26 tests/test-blockjob.c
     24 Makefile.objs
     22 VERSION
     21 tests/test-blockjob-txn.c
     21 scripts/checkpatch.pl
     20 default-configs/arm-softmmu.mak
     19 hw/display/sm501.c
     17 hw/misc/Makefile.objs
     16 include/sysemu/sysemu.h
     15 include/hw/mem/pc-dimm.h
     15 hw/sd/trace-events
     15 contrib/libvhost-user/libvhost-user.c
     14 tests/test-char.c
     14 hw/core/qdev.c
     13 scripts/update-linux-headers.sh
     13 scripts/device-crash-test
     13 hw/display/Makefile.objs
     13 .gitignore
     12 include/qom/cpu.h
     12 include/hw/mem/memory-device.h
     12 include/elf.h
     12 hw/misc/trace-events
     12 default-configs/ppc-softmmu.mak
     11 util/qht.c
     10 util/memfd.c
     10 qdev-monitor.c
     10 include/sysemu/blockdev.h
     10 include/qapi/qmp/dispatch.h
     10 hw/misc/ivshmem.c
     10 gdbstub.c
     10 docs/devel/testing.rst
      9 tests/check-qobject.c
      9 include/qemu/osdep.h
      9 include/hw/compat.h
      9 contrib/libvhost-user/libvhost-user.h
      8 util/qemu-config.c
      8 util/Makefile.objs
      8 linux-headers/linux/kvm.h
      8 iothread.c
      8 include/qemu/timer.h
      8 include/qemu/qht.h
      8 include/hw/qdev-properties.h
      8 include/hw/pci-host/uninorth.h
      8 hw/intc/trace-events
      8 hw/hyperv/hyperv.c
      8 hw/core/loader.c
      7 util/qsp.c
      7 tests/test-qht.c
      7 tests/.gitignore
      7 os-posix.c
      7 include/qemu/compiler.h
      7 include/monitor/monitor.h
      7 include/hw/qdev-core.h
      7 include/hw/loader.h
      7 include/hw/arm/smmu-common.h
      7 docs/qcow2-cache.txt
      7 default-configs/i386-softmmu.mak
      7 Makefile.target
      7 .gitmodules
      6 tests/check-qlit.c
      6 pc-bios/README
      6 include/sysemu/arch_init.h
      6 include/qemu/thread.h
      6 include/qemu/memfd.h
      6 include/hw/ssi/xilinx_spips.h
      6 include/hw/hyperv/hyperv.h
      6 include/hw/block/block.h
      6 hw/nvram/fw_cfg.c
      6 hw/input/ps2.c
      6 docs/nvdimm.txt
      6 docs/interop/qmp-spec.txt
      6 device-hotplug.c
      6 default-configs/x86_64-softmmu.mak
      5 win_dump.c
      5 util/uri.c
      5 util/qemu-thread-posix.c
      5 util/oslib-posix.c
      5 tests/test-x86-cpuid-compat.c
      5 tests/test-rcu-list.c
      5 tests/tcg/README
      5 tests/migration/Makefile
      5 rules.mak
      5 roms/openbios
      5 pc-bios/openbios-ppc
      5 linux-headers/asm-x86/kvm.h
      5 linux-headers/asm-powerpc/kvm.h
      5 include/standard-headers/linux/pci_regs.h
      5 include/qemu/typedefs.h
      5 include/qemu/cutils.h
      5 include/hw/misc/iotkit-secctl.h
      5 hw/watchdog/watchdog.c
      5 hw/sd/ssi-sd.c
      5 hw/pci-host/bonito.c

Maintainers lacks a pattern covering tests/ in a few places,
e.g. tests/test-blockjob*.c, tests/test-char.c.

qdev needs a maintainer.  It has needed one since forever.

>> Sorted by maximum(added lines, deleted lines), top scorers:
>>
>>     $ git-diff --numstat 1733681 `cat unmaintained-files ` | awk '{ print ($1 > $2 ? $1 : $2), $0 }' | sort -nr | sed 's/^[0-9]* //' | head -n 100
>>     2161    0       target-tilegx/translate.c
>>     1504    0       pc-bios/qemu.rsrc
>>     1406    0       target-tilegx/opcode_tilegx.h
>>     1255    0       tests/test-cutils.c
>>     1203    0       include/standard-headers/linux/input.h
>>     1       1112    arch_init.c
>>     1104    0       tests/pkix_asn1_tab.c
>>     1039    767     fpu/softfloat.c
>>     1014    0       docs/specs/rocker.txt
>>     962     0       tests/libqos/ahci.c
>>     924     4       disas/mips.c
>>     908     0       include/standard-headers/linux/pci_regs.h
>>     609     150     hw/intc/arm_gic.c
>>     597     0       scripts/analyze-migration.py
>>     586     0       tests/libqos/ahci.h
>>     565     119     hw/display/tcx.c
>>     485     0       tests/crypto-tls-x509-helpers.c
>>     465     0       tests/tco-test.c
>>     463     0       tests/rcutorture.c
>>     439     0       hw/display/vga-helpers.h
> [...]
>
> $ git-diff --numstat 351053e `cat unmaintained-files ` | awk '{ print ($1 > $2 ? $1 : $2), $0 }' | sort -nr | sed 's/^[0-9]* //' | head -n 100
> 2453	0	target-tilegx/translate.c
> 1810	0	hw/ipmi/ipmi_bmc_sim.c
> 63	1542	trace-events
> 1438	0	tests/vhost-user-bridge.c
> 1406	0	target-tilegx/opcode_tilegx.h
> 1348	5	tests/test-cutils.c
> 1105	0	tests/pkix_asn1_tab.c
> 1063	0	linux-headers/asm-mips/unistd.h
> 950	515	hw/misc/ivshmem.c
> 930	0	tests/test-qga.c
> 907	559	configure
> 844	0	util/qht.c
> 825	0	hmp-commands-info.hx
> 805	0	include/standard-headers/linux/input-event-codes.h
> 71	788	include/standard-headers/linux/input.h
> 778	0	tests/Makefile.include
> 635	0	include/hw/ide/internal.h
> 623	0	tests/migration/guestperf/plot.py
> 177	539	scripts/checkpatch.pl
> 537	0	hw/ipmi/isa_ipmi_bt.c
[...]

$ git-diff --numstat v2.11.0-rc2 `cat unmaintained-files ` | awk '{ print ($1 > $2 ? $1 : $2), $0 }' | sort -nr | sed 's/^[0-9]* //' | head -n 100
1848	0	include/standard-headers/linux/ethtool.h
1609	0	tests/test-bdrv-drain.c
1148	359	configure
992	0	tests/fp/fp-test.c
928	806	util/uri.c
836	0	include/hw/xtensa/xtensa-isa.h
795	0	hw/misc/iotkit-secctl.c
794	0	util/qsp.c
785	0	linux-headers/asm-generic/unistd.h
732	0	docs/devel/testing.rst
725	0	util/vfio-helpers.c
668	10	tests/test-cutils.c
667	0	include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
664	323	qemu-doc.texi
654	0	hw/hyperv/hyperv.c
653	0	tests/fp/wrap.inc.c
9	620	hw/input/adb.c
597	0	tests/fp/Makefile
587	0	include/standard-headers/drm/drm_fourcc.h
574	0	contrib/vhost-user-blk/vhost-user-blk.c
508	571	qemu-options.hx
566	0	pc-bios/canyonlands.dts
558	30	contrib/libvhost-user/libvhost-user.c
541	0	hw/pci-host/sabre.c
540	0	docs/interop/firmware.json
503	121	MAINTAINERS
128	442	hw/input/ps2.c
407	0	hw/input/adb-kbd.c
4	397	linux-headers/asm-s390/unistd.h
389	0	win_dump.c
383	0	include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
367	0	linux-headers/asm-s390/unistd_32.h
359	0	linux-headers/LICENSES/preferred/GPL-2.0
10	348	linux-headers/COPYING
335	28	hw/core/loader.c
334	0	linux-headers/asm-s390/unistd_64.h
327	0	hw/hyperv/hyperv_testdev.c
61	312	include/glib-compat.h
297	0	include/standard-headers/rdma/vmw_pvrdma-abi.h
281	82	Makefile
277	0	hw/misc/imx7_ccm.c
274	31	hw/display/sm501.c
266	0	tests/test-util-sockets.c
265	233	tests/Makefile.include
262	0	hw/input/adb-mouse.c
253	0	tests/migration/s390x/a-b-bios.h
249	12	tests/test-blockjob.c
240	0	hw/misc/pca9552.c
216	12	tests/test-char.c
51	208	hw/intc/openpic.c
202	0	hw/nvram/eeprom_at24c.c
11	195	hw/i2c/i2c-ddc.c
191	0	hw/display/sii9022.c
179	0	include/qemu/win_dump_defs.h
171	0	tests/atomic64-bench.c
170	58	util/qht.c
170	0	include/hw/arm/smmu-common.h
31	160	memory_ldst.inc.c
158	0	docs/interop/prl-xml.txt
157	0	tests/test-image-locking.c
154	0	linux-headers/linux/psp-sev.h
153	0	include/qemu/atomic128.h
150	6	linux-headers/linux/kvm.h
149	0	tests/socket-helpers.c
147	0	include/exec/memory_ldst_phys.inc.h
26	144	hw/pci-host/bonito.c
139	0	include/hw/misc/imx7_ccm.h
138	0	tests/multiboot/aout_kludge.S
133	2	include/qemu/rcu_queue.h
63	130	hw/core/qdev.c
130	0	include/hw/hyperv/hyperv-proto.h
129	41	Makefile.objs
129	0	util/cutils.c
128	7	include/qemu/thread.h
127	20	scripts/checkpatch.pl
125	0	include/hw/misc/iotkit-secctl.h
124	0	hw/misc/imx7_gpr.c
123	48	gdbstub.c
123	2	docs/specs/tpm.txt
122	0	include/standard-headers/asm-x86/kvm_para.h
114	0	include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
109	0	include/hw/mem/memory-device.h
109	0	docs/amd-memory-encryption.txt
108	0	include/exec/memory_ldst_cached.inc.h
107	0	docs/can.txt
105	11	tests/test-qht.c
105	0	include/sysemu/hvf.h
102	0	linux-headers/linux/vfio.h
99	5	tests/vhost-user-bridge.c
97	0	include/standard-headers/linux/qemu_fw_cfg.h
96	0	include/qemu/lockable.h
96	0	hw/core/qdev-fw.c
94	3	include/elf.h
93	0	include/qemu/units.h
91	50	util/memfd.c
91	37	docs/qcow2-cache.txt
9	89	tests/.gitignore
89	5	util/oslib-posix.c
89	3	include/qemu/compiler.h
89	0	hw/misc/imx2_wdt.c

>>>>
>>>> Ideas?  Takers?
>>>
>>> Full list of unmaintained files now:
[...]

.dir-locals.el
.editorconfig
.exrc
.gdbinit
.gitignore
.gitmodules
.gitpublish
.mailmap
CODING_STYLE
COPYING
COPYING.LIB
Changelog
HACKING
LICENSE
MAINTAINERS
Makefile
Makefile.objs
Makefile.target
README
VERSION
accel/Makefile.objs
accel/accel.c
accel/stubs/Makefile.objs
accel/stubs/hax-stub.c
accel/stubs/hvf-stub.c
accel/stubs/kvm-stub.c
accel/stubs/tcg-stub.c
accel/stubs/whpx-stub.c
arch_init.c
backends/Makefile.objs
balloon.c
bsd-user/Makefile.objs
bsd-user/bsd-mman.h
bsd-user/bsdload.c
bsd-user/elfload.c
bsd-user/errno_defs.h
bsd-user/freebsd/strace.list
bsd-user/freebsd/syscall_nr.h
bsd-user/i386/target_signal.h
bsd-user/i386/target_syscall.h
bsd-user/main.c
bsd-user/mmap.c
bsd-user/netbsd/strace.list
bsd-user/netbsd/syscall_nr.h
bsd-user/openbsd/strace.list
bsd-user/openbsd/syscall_nr.h
bsd-user/qemu.h
bsd-user/signal.c
bsd-user/sparc/target_signal.h
bsd-user/sparc/target_syscall.h
bsd-user/sparc64/target_signal.h
bsd-user/sparc64/target_syscall.h
bsd-user/strace.c
bsd-user/syscall.c
bsd-user/syscall_defs.h
bsd-user/uaccess.c
bsd-user/x86_64/target_signal.h
bsd-user/x86_64/target_syscall.h
bt-host.c
bt-vhci.c
capstone
configure
contrib/ivshmem-client/Makefile.objs
contrib/ivshmem-client/ivshmem-client.c
contrib/ivshmem-client/ivshmem-client.h
contrib/ivshmem-client/main.c
contrib/ivshmem-server/Makefile.objs
contrib/ivshmem-server/ivshmem-server.c
contrib/ivshmem-server/ivshmem-server.h
contrib/ivshmem-server/main.c
contrib/libvhost-user/Makefile.objs
contrib/libvhost-user/libvhost-user-glib.c
contrib/libvhost-user/libvhost-user-glib.h
contrib/libvhost-user/libvhost-user.c
contrib/libvhost-user/libvhost-user.h
contrib/systemd/qemu-guest-agent.service
contrib/systemd/qemu-pr-helper.service
contrib/systemd/qemu-pr-helper.socket
contrib/vhost-user-blk/Makefile.objs
contrib/vhost-user-blk/vhost-user-blk.c
contrib/vhost-user-scsi/Makefile.objs
contrib/vhost-user-scsi/vhost-user-scsi.c
cpus-common.c
default-configs/aarch64-softmmu.mak
default-configs/alpha-softmmu.mak
default-configs/arm-softmmu.mak
default-configs/cris-softmmu.mak
default-configs/hppa-softmmu.mak
default-configs/hyperv.mak
default-configs/i386-bsd-user.mak
default-configs/i386-softmmu.mak
default-configs/lm32-softmmu.mak
default-configs/m68k-softmmu.mak
default-configs/microblaze-softmmu.mak
default-configs/microblazeel-softmmu.mak
default-configs/mips-softmmu-common.mak
default-configs/mips-softmmu.mak
default-configs/mips64-softmmu.mak
default-configs/mips64el-softmmu.mak
default-configs/mipsel-softmmu.mak
default-configs/nios2-softmmu.mak
default-configs/or1k-softmmu.mak
default-configs/ppc-softmmu.mak
default-configs/ppc64-softmmu.mak
default-configs/riscv32-softmmu.mak
default-configs/riscv64-softmmu.mak
default-configs/sh4-softmmu.mak
default-configs/sh4eb-softmmu.mak
default-configs/sound.mak
default-configs/sparc-bsd-user.mak
default-configs/sparc-softmmu.mak
default-configs/sparc64-bsd-user.mak
default-configs/sparc64-softmmu.mak
default-configs/tricore-softmmu.mak
default-configs/unicore32-softmmu.mak
default-configs/virtio.mak
default-configs/x86_64-bsd-user.mak
default-configs/x86_64-softmmu.mak
default-configs/xtensa-softmmu.mak
default-configs/xtensaeb-softmmu.mak
device-hotplug.c
disas.c
disas/Makefile.objs
dma-helpers.c
docs/amd-memory-encryption.txt
docs/bootindex.txt
docs/can.txt
docs/ccid.txt
docs/config/ich9-ehci-uhci.cfg
docs/config/mach-virt-graphical.cfg
docs/config/mach-virt-serial.cfg
docs/config/q35-emulated.cfg
docs/config/q35-virtio-graphical.cfg
docs/config/q35-virtio-serial.cfg
docs/devel/atomics.txt
docs/devel/blkdebug.txt
docs/devel/blkverify.txt
docs/devel/loads-stores.rst
docs/devel/lockcnt.txt
docs/devel/memory.txt
docs/devel/multi-thread-tcg.txt
docs/devel/multiple-iothreads.txt
docs/devel/rcu.txt
docs/devel/stable-process.rst
docs/devel/testing.rst
docs/devel/virtio-migration.txt
docs/igd-assign.txt
docs/image-fuzzer.txt
docs/interop/firmware.json
docs/interop/live-block-operations.rst
docs/interop/pr-helper.rst
docs/interop/prl-xml.txt
docs/interop/qed_spec.txt
docs/interop/qemu-qmp-ref.texi
docs/interop/qmp-intro.txt
docs/interop/qmp-spec.txt
docs/interop/vnc-ledstate-Pseudo-encoding.txt
docs/memory-hotplug.txt
docs/multi-thread-compression.txt
docs/multiseat.txt
docs/nvdimm.txt
docs/pr-manager.rst
docs/qcow2-cache.txt
docs/qdev-device-use.txt
docs/qemu-block-drivers.texi
docs/qemu_logo.pdf
docs/qemupciserial.inf
docs/rdma.txt
docs/specs/acpi_cpu_hotplug.txt
docs/specs/acpi_mem_hotplug.txt
docs/specs/acpi_nvdimm.txt
docs/specs/edu.txt
docs/specs/fw_cfg.txt
docs/specs/ivshmem-spec.txt
docs/specs/pvpanic.txt
docs/specs/standard-vga.txt
docs/specs/tpm.txt
docs/specs/vmcoreinfo.txt
docs/specs/vmw_pvscsi-spec.txt
docs/spice-port-fqdn.txt
docs/spin/aio_notify.promela
docs/spin/aio_notify_accept.promela
docs/spin/aio_notify_bug.promela
docs/spin/tcg-exclusive.promela
docs/spin/win32-qemu-event.promela
docs/virtio-balloon-stats.txt
docs/xbzrle.txt
dtc
gdb-xml/aarch64-core.xml
gdb-xml/aarch64-fpu.xml
gdb-xml/arm-core.xml
gdb-xml/arm-neon.xml
gdb-xml/arm-vfp.xml
gdb-xml/arm-vfp3.xml
gdb-xml/cf-core.xml
gdb-xml/cf-fp.xml
gdb-xml/i386-32bit-core.xml
gdb-xml/i386-32bit-sse.xml
gdb-xml/i386-32bit.xml
gdb-xml/i386-64bit-core.xml
gdb-xml/i386-64bit-sse.xml
gdb-xml/i386-64bit.xml
gdb-xml/m68k-fp.xml
gdb-xml/power-altivec.xml
gdb-xml/power-core.xml
gdb-xml/power-fpu.xml
gdb-xml/power-spe.xml
gdb-xml/power-vsx.xml
gdb-xml/power64-core.xml
gdbstub.c
hw/Makefile.objs
hw/bt/Makefile.objs
hw/bt/core.c
hw/bt/hci-csr.c
hw/bt/hci.c
hw/bt/hid.c
hw/bt/l2cap.c
hw/bt/sdp.c
hw/core/Makefile.objs
hw/core/bus.c
hw/core/empty_slot.c
hw/core/fw-path-provider.c
hw/core/hotplug.c
hw/core/irq.c
hw/core/loader.c
hw/core/nmi.c
hw/core/or-irq.c
hw/core/platform-bus.c
hw/core/ptimer.c
hw/core/qdev-fw.c
hw/core/qdev-properties-system.c
hw/core/qdev-properties.c
hw/core/qdev.c
hw/core/reset.c
hw/core/split-irq.c
hw/core/stream.c
hw/core/sysbus.c
hw/core/uboot_image.h
hw/cpu/Makefile.objs
hw/cpu/core.c
hw/display/Makefile.objs
hw/display/ads7846.c
hw/display/blizzard.c
hw/display/cg3.c
hw/display/dpcd.c
hw/display/framebuffer.c
hw/display/framebuffer.h
hw/display/g364fb.c
hw/display/jazz_led.c
hw/display/sii9022.c
hw/display/sm501.c
hw/display/sm501_template.h
hw/display/ssd0303.c
hw/display/ssd0323.c
hw/display/tc6393xb.c
hw/display/tc6393xb_template.h
hw/display/tcx.c
hw/display/trace-events
hw/display/vmware_vga.c
hw/dma/Makefile.objs
hw/dma/rc4030.c
hw/dma/soc_dma.c
hw/dma/trace-events
hw/gpio/Makefile.objs
hw/gpio/gpio_key.c
hw/gpio/max7310.c
hw/gpio/mpc8xxx.c
hw/gpio/zaurus.c
hw/hyperv/Makefile.objs
hw/hyperv/hyperv.c
hw/hyperv/hyperv_testdev.c
hw/i2c/Makefile.objs
hw/i2c/bitbang_i2c.c
hw/i2c/bitbang_i2c.h
hw/i2c/core.c
hw/i2c/i2c-ddc.c
hw/i2c/smbus.c
hw/i2c/smbus_eeprom.c
hw/i2c/trace-events
hw/input/Makefile.objs
hw/input/adb-internal.h
hw/input/adb-kbd.c
hw/input/adb-mouse.c
hw/input/adb.c
hw/input/hid.c
hw/input/lm832x.c
hw/input/ps2.c
hw/input/trace-events
hw/input/tsc2005.c
hw/input/tsc210x.c
hw/intc/Makefile.objs
hw/intc/gicv3_internal.h
hw/intc/intc.c
hw/intc/nios2_iic.c
hw/intc/ompic.c
hw/intc/openpic.c
hw/intc/openpic_kvm.c
hw/intc/slavio_intctl.c
hw/intc/trace-events
hw/intc/vgic_common.h
hw/isa/Makefile.objs
hw/isa/apm.c
hw/isa/isa-bus.c
hw/isa/trace-events
hw/m68k/Makefile.objs
hw/misc/Makefile.objs
hw/misc/applesmc.c
hw/misc/arm_l2x0.c
hw/misc/auxbus.c
hw/misc/cbus.c
hw/misc/imx25_ccm.c
hw/misc/imx2_wdt.c
hw/misc/imx6_ccm.c
hw/misc/imx7_ccm.c
hw/misc/imx7_gpr.c
hw/misc/imx7_snvs.c
hw/misc/iotkit-secctl.c
hw/misc/ivshmem.c
hw/misc/max111x.c
hw/misc/pca9552.c
hw/misc/pvpanic.c
hw/misc/tmp105.c
hw/misc/tmp105.h
hw/misc/tmp421.c
hw/misc/trace-events
hw/nvram/Makefile.objs
hw/nvram/ds1225y.c
hw/nvram/eeprom93xx.c
hw/nvram/eeprom_at24c.c
hw/nvram/fw_cfg.c
hw/nvram/trace-events
hw/pci-host/Makefile.objs
hw/pci-host/bonito.c
hw/pci-host/gpex.c
hw/pci-host/sabre.c
hw/pci-host/trace-events
hw/pcmcia/Makefile.objs
hw/pcmcia/pcmcia.c
hw/sd/Makefile.objs
hw/sd/ssi-sd.c
hw/sd/trace-events
hw/timer/Makefile.objs
hw/timer/altera_timer.c
hw/timer/ds1338.c
hw/timer/m48t59-internal.h
hw/timer/m48t59.c
hw/timer/slavio_timer.c
hw/timer/trace-events
hw/timer/twl92230.c
hw/watchdog/Makefile.objs
hw/watchdog/trace-events
hw/watchdog/watchdog.c
hw/watchdog/wdt_i6300esb.c
include/disas/bfd.h
include/disas/capstone.h
include/disas/disas.h
include/elf.h
include/exec/address-spaces.h
include/exec/gdbstub.h
include/exec/gen-icount.h
include/exec/hwaddr.h
include/exec/log.h
include/exec/memattrs.h
include/exec/memory_ldst.inc.h
include/exec/memory_ldst_cached.inc.h
include/exec/memory_ldst_phys.inc.h
include/exec/poison.h
include/exec/ramlist.h
include/exec/semihost.h
include/exec/softmmu-semi.h
include/exec/target_page.h
include/exec/tb-context.h
include/exec/tb-hash-xx.h
include/exec/tb-lookup.h
include/exec/translator.h
include/exec/user/abitypes.h
include/exec/user/thunk.h
include/glib-compat.h
include/hw/arm/fdt.h
include/hw/arm/fsl-imx25.h
include/hw/arm/linux-boot-if.h
include/hw/arm/sharpsl.h
include/hw/arm/smmu-common.h
include/hw/arm/smmuv3.h
include/hw/arm/soc_dma.h
include/hw/arm/sysbus-fdt.h
include/hw/block/block.h
include/hw/block/flash.h
include/hw/bt.h
include/hw/char/cadence_uart.h
include/hw/char/digic-uart.h
include/hw/char/escc.h
include/hw/char/nrf51_uart.h
include/hw/char/serial.h
include/hw/char/xilinx_uartlite.h
include/hw/compat.h
include/hw/core/split-irq.h
include/hw/cpu/core.h
include/hw/devices.h
include/hw/display/dpcd.h
include/hw/elf_ops.h
include/hw/empty_slot.h
include/hw/fw-path-provider.h
include/hw/hotplug.h
include/hw/hw.h
include/hw/hyperv/hyperv-proto.h
include/hw/hyperv/hyperv.h
include/hw/i2c/i2c-ddc.h
include/hw/i2c/i2c.h
include/hw/i2c/smbus.h
include/hw/input/adb-keys.h
include/hw/input/adb.h
include/hw/input/hid.h
include/hw/input/ps2.h
include/hw/intc/heathrow_pic.h
include/hw/intc/intc.h
include/hw/ipack/ipack.h
include/hw/irq.h
include/hw/isa/apm.h
include/hw/isa/i8259_internal.h
include/hw/isa/isa.h
include/hw/kvm/clock.h
include/hw/loader-fit.h
include/hw/loader.h
include/hw/mem/memory-device.h
include/hw/mem/pc-dimm.h
include/hw/misc/arm_integrator_debug.h
include/hw/misc/auxbus.h
include/hw/misc/imx25_ccm.h
include/hw/misc/imx2_wdt.h
include/hw/misc/imx6_ccm.h
include/hw/misc/imx7_ccm.h
include/hw/misc/imx7_gpr.h
include/hw/misc/imx7_snvs.h
include/hw/misc/iotkit-secctl.h
include/hw/misc/ivshmem.h
include/hw/misc/pca9552.h
include/hw/misc/pca9552_regs.h
include/hw/misc/pvpanic.h
include/hw/misc/tmp105_regs.h
include/hw/nmi.h
include/hw/nvram/eeprom93xx.h
include/hw/nvram/fw_cfg.h
include/hw/nvram/sun_nvram.h
include/hw/or-irq.h
include/hw/pci-bridge/simba.h
include/hw/pci-host/gpex.h
include/hw/pci-host/sabre.h
include/hw/pci-host/uninorth.h
include/hw/pci-host/xilinx-pcie.h
include/hw/pcmcia.h
include/hw/platform-bus.h
include/hw/ptimer.h
include/hw/qdev-core.h
include/hw/qdev-dma.h
include/hw/qdev-properties.h
include/hw/qdev.h
include/hw/sparc/sparc64.h
include/hw/sparc/sun4m_iommu.h
include/hw/sparc/sun4u_iommu.h
include/hw/ssi/xilinx_spips.h
include/hw/stream.h
include/hw/sysbus.h
include/hw/timer/digic-timer.h
include/hw/xtensa/xtensa-isa.h
include/libdecnumber/dconfig.h
include/libdecnumber/decContext.h
include/libdecnumber/decDPD.h
include/libdecnumber/decNumber.h
include/libdecnumber/decNumberLocal.h
include/libdecnumber/dpd/decimal128.h
include/libdecnumber/dpd/decimal128Local.h
include/libdecnumber/dpd/decimal32.h
include/libdecnumber/dpd/decimal64.h
include/monitor/monitor.h
include/monitor/qdev.h
include/qapi/qmp/dispatch.h
include/qemu-common.h
include/qemu-io.h
include/qemu/acl.h
include/qemu/atomic.h
include/qemu/atomic128.h
include/qemu/base64.h
include/qemu/bcd.h
include/qemu/bitmap.h
include/qemu/bitops.h
include/qemu/bswap.h
include/qemu/compiler.h
include/qemu/config-file.h
include/qemu/cpuid.h
include/qemu/crc32c.h
include/qemu/cutils.h
include/qemu/drm.h
include/qemu/envlist.h
include/qemu/event_notifier.h
include/qemu/fifo32.h
include/qemu/fifo8.h
include/qemu/fprintf-fn.h
include/qemu/futex.h
include/qemu/help_option.h
include/qemu/host-utils.h
include/qemu/id.h
include/qemu/int128.h
include/qemu/iov.h
include/qemu/jhash.h
include/qemu/lockable.h
include/qemu/log-for-trace.h
include/qemu/log.h
include/qemu/main-loop.h
include/qemu/memfd.h
include/qemu/mmap-alloc.h
include/qemu/module.h
include/qemu/notify.h
include/qemu/option_int.h
include/qemu/osdep.h
include/qemu/path.h
include/qemu/pmem.h
include/qemu/processor.h
include/qemu/qdist.h
include/qemu/qht.h
include/qemu/qsp.h
include/qemu/queue.h
include/qemu/range.h
include/qemu/ratelimit.h
include/qemu/rcu.h
include/qemu/rcu_queue.h
include/qemu/readline.h
include/qemu/seqlock.h
include/qemu/stats64.h
include/qemu/sys_membarrier.h
include/qemu/systemd.h
include/qemu/thread-posix.h
include/qemu/thread.h
include/qemu/timed-average.h
include/qemu/timer.h
include/qemu/typedefs.h
include/qemu/unicode.h
include/qemu/units.h
include/qemu/uri.h
include/qemu/vfio-helpers.h
include/qemu/win_dump_defs.h
include/qemu/xattr.h
include/qom/cpu.h
include/standard-headers/asm-s390/virtio-ccw.h
include/standard-headers/asm-x86/kvm_para.h
include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
include/standard-headers/drm/drm_fourcc.h
include/standard-headers/linux/ethtool.h
include/standard-headers/linux/if_ether.h
include/standard-headers/linux/input-event-codes.h
include/standard-headers/linux/input.h
include/standard-headers/linux/kernel.h
include/standard-headers/linux/pci_regs.h
include/standard-headers/linux/qemu_fw_cfg.h
include/standard-headers/linux/sysinfo.h
include/standard-headers/linux/types.h
include/standard-headers/linux/virtio_9p.h
include/standard-headers/linux/virtio_balloon.h
include/standard-headers/linux/virtio_blk.h
include/standard-headers/linux/virtio_config.h
include/standard-headers/linux/virtio_console.h
include/standard-headers/linux/virtio_crypto.h
include/standard-headers/linux/virtio_gpu.h
include/standard-headers/linux/virtio_ids.h
include/standard-headers/linux/virtio_input.h
include/standard-headers/linux/virtio_mmio.h
include/standard-headers/linux/virtio_net.h
include/standard-headers/linux/virtio_pci.h
include/standard-headers/linux/virtio_ring.h
include/standard-headers/linux/virtio_rng.h
include/standard-headers/linux/virtio_scsi.h
include/standard-headers/linux/virtio_types.h
include/standard-headers/linux/virtio_vsock.h
include/standard-headers/rdma/vmw_pvrdma-abi.h
include/sysemu/accel.h
include/sysemu/arch_init.h
include/sysemu/balloon.h
include/sysemu/block-backend.h
include/sysemu/blockdev.h
include/sysemu/bt.h
include/sysemu/dma.h
include/sysemu/hax.h
include/sysemu/hvf.h
include/sysemu/hw_accel.h
include/sysemu/iothread.h
include/sysemu/memory_mapping.h
include/sysemu/os-posix.h
include/sysemu/qtest.h
include/sysemu/reset.h
include/sysemu/sev.h
include/sysemu/sysemu.h
include/sysemu/watchdog.h
include/sysemu/whpx.h
include/trace-tcg.h
iothread.c
libdecnumber/Makefile.objs
libdecnumber/decContext.c
libdecnumber/decNumber.c
libdecnumber/dpd/decimal128.c
libdecnumber/dpd/decimal32.c
libdecnumber/dpd/decimal64.c
linux-headers/COPYING
linux-headers/LICENSES/exceptions/Linux-syscall-note
linux-headers/LICENSES/preferred/BSD-2-Clause
linux-headers/LICENSES/preferred/BSD-3-Clause
linux-headers/LICENSES/preferred/GPL-2.0
linux-headers/README
linux-headers/asm-arm/bitsperlong.h
linux-headers/asm-arm/kvm.h
linux-headers/asm-arm/unistd-common.h
linux-headers/asm-arm/unistd-eabi.h
linux-headers/asm-arm/unistd-oabi.h
linux-headers/asm-arm/unistd.h
linux-headers/asm-arm64/bitsperlong.h
linux-headers/asm-arm64/kvm.h
linux-headers/asm-arm64/unistd.h
linux-headers/asm-generic/bitsperlong.h
linux-headers/asm-generic/unistd.h
linux-headers/asm-mips/bitsperlong.h
linux-headers/asm-mips/kvm.h
linux-headers/asm-mips/sgidefs.h
linux-headers/asm-mips/unistd.h
linux-headers/asm-powerpc/bitsperlong.h
linux-headers/asm-powerpc/kvm.h
linux-headers/asm-powerpc/unistd.h
linux-headers/asm-s390/bitsperlong.h
linux-headers/asm-s390/kvm.h
linux-headers/asm-s390/unistd.h
linux-headers/asm-s390/unistd_32.h
linux-headers/asm-s390/unistd_64.h
linux-headers/asm-x86/bitsperlong.h
linux-headers/asm-x86/kvm.h
linux-headers/asm-x86/unistd.h
linux-headers/asm-x86/unistd_32.h
linux-headers/asm-x86/unistd_64.h
linux-headers/asm-x86/unistd_x32.h
linux-headers/linux/kvm.h
linux-headers/linux/psci.h
linux-headers/linux/psp-sev.h
linux-headers/linux/userfaultfd.h
linux-headers/linux/vfio.h
linux-headers/linux/vfio_ccw.h
linux-headers/linux/vhost.h
linux-headers/linux/virtio_config.h
linux-headers/linux/virtio_ring.h
memory_ldst.inc.c
memory_mapping.c
module-common.c
os-posix.c
pc-bios/Makefile
pc-bios/QEMU,cgthree.bin
pc-bios/QEMU,tcx.bin
pc-bios/README
pc-bios/bamboo.dtb
pc-bios/bamboo.dts
pc-bios/bios-256k.bin
pc-bios/bios.bin
pc-bios/canyonlands.dtb
pc-bios/canyonlands.dts
pc-bios/efi-e1000.rom
pc-bios/efi-e1000e.rom
pc-bios/efi-eepro100.rom
pc-bios/efi-ne2k_pci.rom
pc-bios/efi-pcnet.rom
pc-bios/efi-rtl8139.rom
pc-bios/efi-virtio.rom
pc-bios/efi-vmxnet3.rom
pc-bios/hppa-firmware.img
pc-bios/keymaps/Makefile
pc-bios/keymaps/ar
pc-bios/keymaps/bepo
pc-bios/keymaps/common
pc-bios/keymaps/cz
pc-bios/keymaps/da
pc-bios/keymaps/de
pc-bios/keymaps/de-ch
pc-bios/keymaps/en-gb
pc-bios/keymaps/en-us
pc-bios/keymaps/es
pc-bios/keymaps/et
pc-bios/keymaps/fi
pc-bios/keymaps/fo
pc-bios/keymaps/fr
pc-bios/keymaps/fr-be
pc-bios/keymaps/fr-ca
pc-bios/keymaps/fr-ch
pc-bios/keymaps/hr
pc-bios/keymaps/hu
pc-bios/keymaps/is
pc-bios/keymaps/it
pc-bios/keymaps/ja
pc-bios/keymaps/lt
pc-bios/keymaps/lv
pc-bios/keymaps/mk
pc-bios/keymaps/modifiers
pc-bios/keymaps/nl
pc-bios/keymaps/nl-be
pc-bios/keymaps/no
pc-bios/keymaps/pl
pc-bios/keymaps/pt
pc-bios/keymaps/pt-br
pc-bios/keymaps/ru
pc-bios/keymaps/sl
pc-bios/keymaps/sv
pc-bios/keymaps/th
pc-bios/keymaps/tr
pc-bios/kvmvapic.bin
pc-bios/linuxboot.bin
pc-bios/linuxboot_dma.bin
pc-bios/multiboot.bin
pc-bios/openbios-ppc
pc-bios/optionrom/Makefile
pc-bios/optionrom/code16gcc.h
pc-bios/optionrom/flat.lds
pc-bios/optionrom/kvmvapic.S
pc-bios/optionrom/linuxboot.S
pc-bios/optionrom/linuxboot_dma.c
pc-bios/optionrom/multiboot.S
pc-bios/optionrom/optionrom.h
pc-bios/palcode-clipper
pc-bios/petalogix-ml605.dtb
pc-bios/petalogix-s3adsp1800.dtb
pc-bios/pxe-e1000.rom
pc-bios/pxe-eepro100.rom
pc-bios/pxe-ne2k_pci.rom
pc-bios/pxe-pcnet.rom
pc-bios/pxe-rtl8139.rom
pc-bios/pxe-virtio.rom
pc-bios/qemu-icon.bmp
pc-bios/qemu-nsis.bmp
pc-bios/qemu-nsis.ico
pc-bios/qemu.rsrc
pc-bios/qemu_logo.svg
pc-bios/qemu_logo_no_text.svg
pc-bios/qemu_vga.ndrv
pc-bios/s390-netboot.img
pc-bios/sgabios.bin
pc-bios/u-boot-sam460-20100605.bin
pc-bios/vgabios-bochs-display.bin
pc-bios/vgabios-cirrus.bin
pc-bios/vgabios-qxl.bin
pc-bios/vgabios-ramfb.bin
pc-bios/vgabios-stdvga.bin
pc-bios/vgabios-virtio.bin
pc-bios/vgabios-vmware.bin
pc-bios/vgabios.bin
po/Makefile
po/bg.po
po/de_DE.po
po/fr_FR.po
po/hu.po
po/it.po
po/messages.po
po/tr.po
po/zh_CN.po
qdev-monitor.c
qdict-test-data.txt
qemu-bridge-helper.c
qemu-doc.texi
qemu-keymap.c
qemu-options-wrapper.h
qemu-options.h
qemu-options.hx
qemu-tech.texi
qom/cpu.c
roms/Makefile
roms/QemuMacDrivers
roms/SLOF
roms/config.seabios-128k
roms/config.seabios-256k
roms/config.vga-bochs-display
roms/config.vga-cirrus
roms/config.vga-isavga
roms/config.vga-qxl
roms/config.vga-ramfb
roms/config.vga-stdvga
roms/config.vga-virtio
roms/config.vga-vmware
roms/configure-seabios.sh
roms/ipxe
roms/openbios
roms/openhackware
roms/qemu-palcode
roms/seabios
roms/seabios-hppa
roms/sgabios
roms/skiboot
roms/u-boot
roms/u-boot-sam460ex
rules.mak
scripts/analyze-inclusions
scripts/archive-source.sh
scripts/checkpatch.pl
scripts/clean-header-guards.pl
scripts/clean-includes
scripts/cleanup-trace-events.pl
scripts/cocci-macro-file.h
scripts/coccinelle/cpu_restore_state.cocci
scripts/coccinelle/err-bad-newline.cocci
scripts/coccinelle/error_propagate_null.cocci
scripts/coccinelle/inplace-byteswaps.cocci
scripts/coccinelle/memory-region-init-ram.cocci
scripts/coccinelle/overflow_muldiv64.cocci
scripts/coccinelle/remove_local_err.cocci
scripts/coccinelle/remove_muldiv64.cocci
scripts/coccinelle/return_directly.cocci
scripts/coccinelle/round.cocci
scripts/coccinelle/simplify_muldiv64.cocci
scripts/coccinelle/swap_muldiv64.cocci
scripts/coccinelle/tcg_gen_extract.cocci
scripts/coccinelle/typecast.cocci
scripts/coccinelle/use-error_fatal.cocci
scripts/create_config
scripts/device-crash-test
scripts/disas-objdump.pl
scripts/extract-vsssdk-headers
scripts/feature_to_c.sh
scripts/get_maintainer.pl
scripts/git.orderfile
scripts/gtester-cat
scripts/hxtool
scripts/kvm/kvm_flightrecorder
scripts/kvm/vmxcap
scripts/make-release
scripts/make_device_config.sh
scripts/modules/module_block.py
scripts/qemugdb/__init__.py
scripts/qemugdb/coroutine.py
scripts/qemugdb/mtree.py
scripts/qemugdb/tcg.py
scripts/qemugdb/timers.py
scripts/refresh-pxe-roms.sh
scripts/shaderinclude.pl
scripts/show-fixed-bugs.sh
scripts/switch-timer-api
scripts/texi2pod.pl
scripts/update-linux-headers.sh
target/tilegx/Makefile.objs
target/tilegx/cpu.c
target/tilegx/cpu.h
target/tilegx/helper.c
target/tilegx/helper.h
target/tilegx/opcode_tilegx.h
target/tilegx/simd_helper.c
target/tilegx/spr_def_64.h
target/tilegx/translate.c
tests/.gitignore
tests/Makefile.include
tests/acceptance/README.rst
tests/acceptance/avocado_qemu/__init__.py
tests/acceptance/boot_linux_console.py
tests/acceptance/version.py
tests/acceptance/vnc.py
tests/atomic64-bench.c
tests/atomic_add-bench.c
tests/boot-sector.c
tests/boot-sector.h
tests/check-block.sh
tests/check-qlit.c
tests/check-qnull.c
tests/check-qobject.c
tests/crypto-tls-psk-helpers.c
tests/crypto-tls-psk-helpers.h
tests/crypto-tls-x509-helpers.c
tests/crypto-tls-x509-helpers.h
tests/data/acpi/pc/APIC
tests/data/acpi/pc/APIC.cphp
tests/data/acpi/pc/APIC.dimmpxm
tests/data/acpi/pc/DSDT
tests/data/acpi/pc/DSDT.bridge
tests/data/acpi/pc/DSDT.cphp
tests/data/acpi/pc/DSDT.dimmpxm
tests/data/acpi/pc/DSDT.ipmikcs
tests/data/acpi/pc/DSDT.memhp
tests/data/acpi/pc/DSDT.numamem
tests/data/acpi/pc/FACP
tests/data/acpi/pc/FACS
tests/data/acpi/pc/HPET
tests/data/acpi/pc/NFIT.dimmpxm
tests/data/acpi/pc/SLIT.cphp
tests/data/acpi/pc/SLIT.memhp
tests/data/acpi/pc/SRAT.cphp
tests/data/acpi/pc/SRAT.dimmpxm
tests/data/acpi/pc/SRAT.memhp
tests/data/acpi/pc/SRAT.numamem
tests/data/acpi/pc/SSDT.dimmpxm
tests/data/acpi/q35/APIC
tests/data/acpi/q35/APIC.cphp
tests/data/acpi/q35/APIC.dimmpxm
tests/data/acpi/q35/DSDT
tests/data/acpi/q35/DSDT.bridge
tests/data/acpi/q35/DSDT.cphp
tests/data/acpi/q35/DSDT.dimmpxm
tests/data/acpi/q35/DSDT.ipmibt
tests/data/acpi/q35/DSDT.memhp
tests/data/acpi/q35/DSDT.mmio64
tests/data/acpi/q35/DSDT.numamem
tests/data/acpi/q35/FACP
tests/data/acpi/q35/FACS
tests/data/acpi/q35/HPET
tests/data/acpi/q35/MCFG
tests/data/acpi/q35/NFIT.dimmpxm
tests/data/acpi/q35/SLIT.cphp
tests/data/acpi/q35/SLIT.memhp
tests/data/acpi/q35/SRAT.cphp
tests/data/acpi/q35/SRAT.dimmpxm
tests/data/acpi/q35/SRAT.memhp
tests/data/acpi/q35/SRAT.mmio64
tests/data/acpi/q35/SRAT.numamem
tests/data/acpi/q35/SSDT.dimmpxm
tests/data/acpi/rebuild-expected-aml.sh
tests/data/test-qga-config
tests/data/test-qga-os-release
tests/decode/check.sh
tests/decode/err_argset1.decode
tests/decode/err_argset2.decode
tests/decode/err_field1.decode
tests/decode/err_field2.decode
tests/decode/err_field3.decode
tests/decode/err_field4.decode
tests/decode/err_field5.decode
tests/decode/err_init1.decode
tests/decode/err_init2.decode
tests/decode/err_init3.decode
tests/decode/err_init4.decode
tests/decode/err_overlap1.decode
tests/decode/err_overlap2.decode
tests/decode/err_overlap3.decode
tests/decode/err_overlap4.decode
tests/decode/err_overlap5.decode
tests/decode/err_overlap6.decode
tests/decode/err_overlap7.decode
tests/decode/err_overlap8.decode
tests/decode/err_overlap9.decode
tests/fp/.gitignore
tests/fp/Makefile
tests/fp/berkeley-softfloat-3
tests/fp/berkeley-testfloat-3
tests/fp/fp-test.c
tests/fp/platform.h
tests/fp/wrap.inc.c
tests/guest-debug/test-gdbstub.py
tests/io-channel-helpers.c
tests/io-channel-helpers.h
tests/iothread.c
tests/iothread.h
tests/keys/README
tests/keys/id_rsa
tests/keys/id_rsa.pub
tests/migration/.gitignore
tests/migration/Makefile
tests/migration/aarch64/Makefile
tests/migration/aarch64/a-b-kernel.S
tests/migration/aarch64/a-b-kernel.h
tests/migration/guestperf-batch.py
tests/migration/guestperf-plot.py
tests/migration/guestperf.py
tests/migration/guestperf/__init__.py
tests/migration/guestperf/comparison.py
tests/migration/guestperf/engine.py
tests/migration/guestperf/hardware.py
tests/migration/guestperf/plot.py
tests/migration/guestperf/progress.py
tests/migration/guestperf/report.py
tests/migration/guestperf/scenario.py
tests/migration/guestperf/shell.py
tests/migration/guestperf/timings.py
tests/migration/i386/Makefile
tests/migration/i386/a-b-bootblock.S
tests/migration/i386/a-b-bootblock.h
tests/migration/migration-test.h
tests/migration/s390x/Makefile
tests/migration/s390x/a-b-bios.c
tests/migration/s390x/a-b-bios.h
tests/migration/stress.c
tests/multiboot/.gitignore
tests/multiboot/Makefile
tests/multiboot/aout_kludge.S
tests/multiboot/aout_kludge.out
tests/multiboot/libc.c
tests/multiboot/libc.h
tests/multiboot/link.ld
tests/multiboot/mmap.c
tests/multiboot/mmap.out
tests/multiboot/module.txt
tests/multiboot/modules.c
tests/multiboot/modules.out
tests/multiboot/multiboot.h
tests/multiboot/run_test.sh
tests/multiboot/start.S
tests/pkix_asn1_tab.c
tests/ptimer-test-stubs.c
tests/ptimer-test.h
tests/qemu-iotests-quick.sh
tests/qht-bench.c
tests/rcutorture.c
tests/requirements.txt
tests/socket-helpers.c
tests/socket-helpers.h
tests/tcg/README
tests/tcg/hppa/Makefile.include
tests/tcg/hppa/Makefile.target
tests/tcg/m68k/Makefile.include
tests/tcg/m68k/Makefile.target
tests/tcg/ppc/Makefile.include
tests/tcg/ppc/Makefile.target
tests/tcg/riscv/Makefile.include
tests/tcg/sh4/Makefile.include
tests/tcg/sh4/Makefile.target
tests/tcg/sparc64/Makefile.include
tests/tcg/sparc64/Makefile.target
tests/test-aio-multithread.c
tests/test-aio.c
tests/test-base64.c
tests/test-bdrv-drain.c
tests/test-bitcnt.c
tests/test-bitops.c
tests/test-block-backend.c
tests/test-blockjob-txn.c
tests/test-blockjob.c
tests/test-bufferiszero.c
tests/test-char.c
tests/test-cutils.c
tests/test-filter-mirror.c
tests/test-filter-redirector.c
tests/test-image-locking.c
tests/test-int128.c
tests/test-iov.c
tests/test-logging.c
tests/test-mul64.c
tests/test-netfilter.c
tests/test-qdev-global-props.c
tests/test-qdist.c
tests/test-qht-par.c
tests/test-qht.c
tests/test-rcu-list.c
tests/test-rcu-simpleq.c
tests/test-rcu-tailq.c
tests/test-shift128.c
tests/test-thread-pool.c
tests/test-timed-average.c
tests/test-util-sockets.c
tests/test-vmstate.c
tests/test-write-threshold.c
tests/test-x86-cpuid-compat.c
tests/test-x86-cpuid.c
tests/test-xbzrle.c
tests/vhost-user-bridge.c
util/Makefile.objs
util/acl.c
util/aiocb.c
util/atomic64.c
util/base64.c
util/bitmap.c
util/bitops.c
util/bufferiszero.c
util/cacheinfo.c
util/compatfd.c
util/crc32c.c
util/cutils.c
util/envlist.c
util/event_notifier-posix.c
util/fifo8.c
util/getauxval.c
util/hexdump.c
util/host-utils.c
util/id.c
util/iohandler.c
util/iov.c
util/lockcnt.c
util/log.c
util/memfd.c
util/mmap-alloc.c
util/module.c
util/notify.c
util/osdep.c
util/oslib-posix.c
util/pagesize.c
util/path.c
util/qdist.c
util/qemu-config.c
util/qemu-openpty.c
util/qemu-thread-common.h
util/qemu-thread-posix.c
util/qemu-timer-common.c
util/qht.c
util/qsp.c
util/range.c
util/rcu.c
util/readline.c
util/stats64.c
util/sys_membarrier.c
util/systemd.c
util/thread-pool.c
util/timed-average.c
util/trace-events
util/unicode.c
util/uri.c
util/vfio-helpers.c
version.rc
win_dump.c
win_dump.h
