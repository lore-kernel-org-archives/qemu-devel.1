Received: from eggs.gnu.org ([209.51.188.92]:55193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guYJG-0001Hy-SP
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guYJE-0004vC-Av
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:53:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guYJC-0004rl-GB
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:53:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
	<87h8d65r6k.fsf@dusky.pond.sub.org>
	<e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com>
Date: Fri, 15 Feb 2019 08:53:11 +0100
In-Reply-To: <e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com> (Eric Blake's
	message of "Thu, 14 Feb 2019 10:01:55 -0600")
Message-ID: <875ztlzdw8.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Proper use of unnest-vars (was: [PATCH v5 00/18] qapi:
 add #if pre-processor conditions to generated code (part 3))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Eric Blake <eblake@redhat.com> writes:

> On 2/14/19 9:24 AM, Markus Armbruster wrote:
>> Diff from v4:
>>=20
>
>> +++ b/qapi/Makefile.objs
>> @@ -18,8 +18,9 @@ util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-visit-%=
.o)
>>  util-obj-y +=3D qapi-emit-events.o
>>  util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-events-%.o)
>>=20=20
>> -common-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)
>> +common-obj-y =3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)
>
> In other situations, use of =3D instead of +=3D has resulted in inadverte=
nt
> omission of files. Should we just always use +=3D, rather than having to
> remember to audit if the use of =3D is not overriding earlier lines?

There's quite some magic at work around here, which today I understand
better than last week (and probably worse than next week), but maybe not
well enough to get things quite right.  I'm cc'ing Paolo and Fam for
advice.

The Makefile.objs get included via the magical unnest-vars function.
Note that the file names in qapi/Makefile.objs are all relative to
qapi/, like:

    util-obj-y +=3D qapi-emit-events.o

If we simply included this into the top level Makefile, this would be
wrong.  We'd have to say

    util-obj-y +=3D qapi/qapi-emit-events.o

We don't, because unnest-vars takes care of adding the prefix.  How?
Let me show you with the help of this tracing patch:

diff --git a/Makefile.target b/Makefile.target
index d6ce549388..b2218011ef 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -167,7 +167,9 @@ GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
 endif # CONFIG_SOFTMMU
=20
+$(info @target/ before $(obj-y))
 dummy :=3D $(call unnest-vars,,obj-y)
+$(info @target/ after $(obj-y))
 all-obj-y :=3D $(obj-y)
=20
 target-obj-y :=3D
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 87e4df1660..1789811769 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -1,3 +1,4 @@
+$(info @qapi/ initial $(obj-y))
 util-obj-y =3D qapi-visit-core.o qapi-dealloc-visitor.o qobject-input-visi=
tor.o
 util-obj-y +=3D qobject-output-visitor.o qmp-registry.o qmp-dispatch.o
 util-obj-y +=3D string-input-visitor.o string-output-visitor.o
@@ -29,3 +30,4 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
 obj-y +=3D qapi-events.o
 obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
 obj-y +=3D qapi-commands.o
+$(info @qapi/ final $(obj-y))

Output for me with V=3D1:

    make: Entering directory '/work/armbru/qemu/bld-x86'
[Eliding stuff that's redundant for the points I'm trying to make...]
    make[1]: Entering directory '/work/armbru/qemu/bld-x86/x86_64-softmmu'
    @target/ before exec.o accel/ tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o t=
cg/tcg-op-gvec.o tcg/tcg-common.o tcg/optimize.o fpu/softfloat.o target/i38=
6/ disas.o gdbstub-xml.o arch_init.o cpus.o monitor.o gdbstub.o balloon.o i=
oport.o numa.o qtest.o hw/ qapi/ memory.o memory_mapping.o dump.o win_dump.=
o migration/ram.o hw/i386/

This is right before $(call unnest-vars,,obj-y).  Note $(obj-y) is
non-blank.

$(call unnest-vars,,obj-y) now includes dir/Makefile.objs for all dir/
in $(obj-y).  In particular, it includes qapi/Makefile.objs.  Make
output continues:

    @qapi/ initial=20

Now $(obj-y) is blank!  That's because unnest-vars makes it blank, so it
can more easily add the prefix later.

    @qapi/ final qapi-introspect.o qapi-types-target.o qapi-types.o qapi-vi=
sit-target.o qapi-visit.o qapi-events-target.o qapi-events.o qapi-commands-=
target.o qapi-commands.o

Makefile.objs did its thing.  Now unnest-vars works its magic:

    @target/ after exec.o tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o tcg/tcg-common.o tcg/optimize.o fpu/softfloat.o disas.o gdbstub-xm=
l.o arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o qtest.=
o memory.o memory_mapping.o dump.o win_dump.o migration/ram.o accel/accel.o=
 accel/kvm/kvm-all.o accel/stubs/hax-stub.o accel/stubs/hvf-stub.o accel/st=
ubs/whpx-stub.o accel/tcg/tcg-all.o accel/tcg/cputlb.o accel/tcg/tcg-runtim=
e.o accel/tcg/tcg-runtime-gvec.o accel/tcg/cpu-exec.o accel/tcg/cpu-exec-co=
mmon.o accel/tcg/translate-all.o accel/tcg/translator.o hw/9pfs/virtio-9p-d=
evice.o hw/block/virtio-blk.o hw/block/dataplane/virtio-blk.o hw/block/data=
plane/xen-block.o hw/char/virtio-serial-bus.o hw/display/vga.o hw/display/v=
irtio-gpu.o hw/display/virtio-gpu-3d.o hw/display/virtio-gpu-pci.o hw/displ=
ay/virtio-vga.o hw/hyperv/hyperv.o hw/hyperv/hyperv_testdev.o hw/intc/apic.=
o hw/intc/apic_common.o hw/intc/ioapic.o hw/isa/lpc_ich9.o hw/misc/ivshmem.=
o hw/misc/pvpanic.o hw/net/virtio-net.o hw/net/vhost_net.o hw/rdma/rdma_uti=
ls.o hw/rdma/rdma_backend.o hw/rdma/rdma_rm.o hw/rdma/vmw/pvrdma_dev_ring.o=
 hw/rdma/vmw/pvrdma_cmd.o hw/rdma/vmw/pvrdma_qp_ops.o hw/rdma/vmw/pvrdma_ma=
in.o hw/scsi/virtio-scsi.o hw/scsi/virtio-scsi-dataplane.o hw/scsi/vhost-sc=
si-common.o hw/scsi/vhost-scsi.o hw/timer/mc146818rtc.o hw/tpm/tpm_ppi.o hw=
/vfio/common.o hw/vfio/spapr.o hw/vfio/pci.o hw/vfio/pci-quirks.o hw/vfio/d=
isplay.o hw/virtio/virtio.o hw/virtio/virtio-balloon.o hw/virtio/virtio-cry=
pto.o hw/virtio/virtio-crypto-pci.o hw/virtio/vhost.o hw/virtio/vhost-backe=
nd.o hw/virtio/vhost-user.o hw/virtio/vhost-vsock.o hw/virtio/vhost-vsock-p=
ci.o hw/virtio/vhost-scsi-pci.o hw/virtio/virtio-input-host-pci.o hw/virtio=
/virtio-input-pci.o hw/virtio/virtio-rng-pci.o hw/virtio/virtio-balloon-pci=
.o hw/virtio/virtio-9p-pci.o hw/virtio/virtio-scsi-pci.o hw/virtio/virtio-b=
lk-pci.o hw/virtio/virtio-net-pci.o hw/virtio/virtio-serial-pci.o hw/xen/xe=
n-host-pci-device.o hw/xen/xen_pt.o hw/xen/xen_pt_config_init.o hw/xen/xen_=
pt_graphics.o hw/xen/xen_pt_msi.o hw/xen/xen_pt_load_rom.o hw/i386/multiboo=
t.o hw/i386/pc.o hw/i386/pc_piix.o hw/i386/pc_q35.o hw/i386/pc_sysfw.o hw/i=
386/x86-iommu.o hw/i386/intel_iommu.o hw/i386/x86-iommu.o hw/i386/amd_iommu=
.o hw/i386/vmport.o hw/i386/vmmouse.o hw/i386/kvmvapic.o hw/i386/acpi-build=
.o hw/i386/../xenpv/xen_machine_pv.o hw/i386/kvm/clock.o hw/i386/kvm/apic.o=
 hw/i386/kvm/i8259.o hw/i386/kvm/ioapic.o hw/i386/kvm/i8254.o hw/i386/xen/x=
en_platform.o hw/i386/xen/xen_apic.o hw/i386/xen/xen_pvdevice.o hw/i386/xen=
/xen-hvm.o hw/i386/xen/xen-mapcache.o qapi/qapi-introspect.o qapi/qapi-type=
s-target.o qapi/qapi-types.o qapi/qapi-visit-target.o qapi/qapi-visit.o qap=
i/qapi-events-target.o qapi/qapi-events.o qapi/qapi-commands-target.o qapi/=
qapi-commands.o target/i386/helper.o target/i386/cpu.o target/i386/gdbstub.=
o target/i386/xsave_helper.o target/i386/translate.o target/i386/bpt_helper=
.o target/i386/cc_helper.o target/i386/excp_helper.o target/i386/fpu_helper=
.o target/i386/int_helper.o target/i386/mem_helper.o target/i386/misc_helpe=
r.o target/i386/mpx_helper.o target/i386/seg_helper.o target/i386/smm_helpe=
r.o target/i386/svm_helper.o target/i386/machine.o target/i386/arch_memory_=
mapping.o target/i386/arch_dump.o target/i386/monitor.o target/i386/kvm.o t=
arget/i386/hyperv.o target/i386/sev.o

This is

* All the non-directory names: exec.o ... migration/ram.o

* Stuff from directories: accel/ hw/ hw/i386/ qapi/ target/i386/.  Note
  that directories are reordered.

You can see how unnest-vars replaces each directory in $(obj-y) by the
value of $(obj-y) set in that directory's Makefile.objs, prefixed with
the directory.

The key insight to address Eric's concern is unnest-vars empties out
$(obj-y) before it includes a Makefile.objs.  Therefore, my "obj-y =3D" in
qapi/Makefile.objs can't clobber anything.

Having convinced you of this proposition, I'm now going to convince you
of its negation ;-P

A few lines down in Makefile.target, we have

    target-obj-y :=3D
    block-obj-y :=3D
    common-obj-y :=3D
    chardev-obj-y :=3D
    slirp-obj-y :=3D
    include $(SRC_PATH)/Makefile.objs
    dummy :=3D $(call unnest-vars,,target-obj-y)
    target-obj-y-save :=3D $(target-obj-y)
    dummy :=3D $(call unnest-vars,.., \
                   block-obj-y \
                   block-obj-m \
                   chardev-obj-y \
                   crypto-obj-y \
                   crypto-aes-obj-y \
                   qom-obj-y \
                   io-obj-y \
                   common-obj-y \
                   common-obj-m \
                   slirp-obj-y)
    target-obj-y :=3D $(target-obj-y-save)
    all-obj-y +=3D $(common-obj-y)
    all-obj-y +=3D $(target-obj-y)
    all-obj-y +=3D $(qom-obj-y)
    all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
    all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
    all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
    all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
    all-obj-$(CONFIG_SOFTMMU) +=3D $(slirp-obj-y)

$(call unnest-vars,,target-obj-y) is not interesting for us, as
$(target-obj-y) doesn't contain qapi/.  However, $(common-obj-y) does,
and the other $(call unnest-vars, ...) includes Makefile.objs again:

    @qapi/ initial exec.o tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o tcg/tcg-common.o tcg/optimize.o fpu/softfloat.o disas.o gdbstub-xm=
l.o arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o qtest.=
o memory.o memory_mapping.o dump.o win_dump.o migration/ram.o accel/accel.o=
 accel/kvm/kvm-all.o accel/stubs/hax-stub.o accel/stubs/hvf-stub.o accel/st=
ubs/whpx-stub.o accel/tcg/tcg-all.o accel/tcg/cputlb.o accel/tcg/tcg-runtim=
e.o accel/tcg/tcg-runtime-gvec.o accel/tcg/cpu-exec.o accel/tcg/cpu-exec-co=
mmon.o accel/tcg/translate-all.o accel/tcg/translator.o hw/9pfs/virtio-9p-d=
evice.o hw/block/virtio-blk.o hw/block/dataplane/virtio-blk.o hw/block/data=
plane/xen-block.o hw/char/virtio-serial-bus.o hw/display/vga.o hw/display/v=
irtio-gpu.o hw/display/virtio-gpu-3d.o hw/display/virtio-gpu-pci.o hw/displ=
ay/virtio-vga.o hw/hyperv/hyperv.o hw/hyperv/hyperv_testdev.o hw/intc/apic.=
o hw/intc/apic_common.o hw/intc/ioapic.o hw/isa/lpc_ich9.o hw/misc/ivshmem.=
o hw/misc/pvpanic.o hw/net/virtio-net.o hw/net/vhost_net.o hw/rdma/rdma_uti=
ls.o hw/rdma/rdma_backend.o hw/rdma/rdma_rm.o hw/rdma/vmw/pvrdma_dev_ring.o=
 hw/rdma/vmw/pvrdma_cmd.o hw/rdma/vmw/pvrdma_qp_ops.o hw/rdma/vmw/pvrdma_ma=
in.o hw/scsi/virtio-scsi.o hw/scsi/virtio-scsi-dataplane.o hw/scsi/vhost-sc=
si-common.o hw/scsi/vhost-scsi.o hw/timer/mc146818rtc.o hw/tpm/tpm_ppi.o hw=
/vfio/common.o hw/vfio/spapr.o hw/vfio/pci.o hw/vfio/pci-quirks.o hw/vfio/d=
isplay.o hw/virtio/virtio.o hw/virtio/virtio-balloon.o hw/virtio/virtio-cry=
pto.o hw/virtio/virtio-crypto-pci.o hw/virtio/vhost.o hw/virtio/vhost-backe=
nd.o hw/virtio/vhost-user.o hw/virtio/vhost-vsock.o hw/virtio/vhost-vsock-p=
ci.o hw/virtio/vhost-scsi-pci.o hw/virtio/virtio-input-host-pci.o hw/virtio=
/virtio-input-pci.o hw/virtio/virtio-rng-pci.o hw/virtio/virtio-balloon-pci=
.o hw/virtio/virtio-9p-pci.o hw/virtio/virtio-scsi-pci.o hw/virtio/virtio-b=
lk-pci.o hw/virtio/virtio-net-pci.o hw/virtio/virtio-serial-pci.o hw/xen/xe=
n-host-pci-device.o hw/xen/xen_pt.o hw/xen/xen_pt_config_init.o hw/xen/xen_=
pt_graphics.o hw/xen/xen_pt_msi.o hw/xen/xen_pt_load_rom.o hw/i386/multiboo=
t.o hw/i386/pc.o hw/i386/pc_piix.o hw/i386/pc_q35.o hw/i386/pc_sysfw.o hw/i=
386/x86-iommu.o hw/i386/intel_iommu.o hw/i386/x86-iommu.o hw/i386/amd_iommu=
.o hw/i386/vmport.o hw/i386/vmmouse.o hw/i386/kvmvapic.o hw/i386/acpi-build=
.o hw/i386/../xenpv/xen_machine_pv.o hw/i386/kvm/clock.o hw/i386/kvm/apic.o=
 hw/i386/kvm/i8259.o hw/i386/kvm/ioapic.o hw/i386/kvm/i8254.o hw/i386/xen/x=
en_platform.o hw/i386/xen/xen_apic.o hw/i386/xen/xen_pvdevice.o hw/i386/xen=
/xen-hvm.o hw/i386/xen/xen-mapcache.o qapi/qapi-introspect.o qapi/qapi-type=
s-target.o qapi/qapi-types.o qapi/qapi-visit-target.o qapi/qapi-visit.o qap=
i/qapi-events-target.o qapi/qapi-events.o qapi/qapi-commands-target.o qapi/=
qapi-commands.o target/i386/helper.o target/i386/cpu.o target/i386/gdbstub.=
o target/i386/xsave_helper.o target/i386/translate.o target/i386/bpt_helper=
.o target/i386/cc_helper.o target/i386/excp_helper.o target/i386/fpu_helper=
.o target/i386/int_helper.o target/i386/mem_helper.o target/i386/misc_helpe=
r.o target/i386/mpx_helper.o target/i386/seg_helper.o target/i386/smm_helpe=
r.o target/i386/svm_helper.o target/i386/machine.o target/i386/arch_memory_=
mapping.o target/i386/arch_dump.o target/i386/monitor.o target/i386/kvm.o t=
arget/i386/hyperv.o target/i386/sev.o 9pfs/ acpi/ adc/ audio/ block/ bt/ ch=
ar/ cpu/ display/ dma/ gpio/ hyperv/ i2c/ ide/ input/ intc/ ipack/ ipmi/ is=
a/ misc/ net/ rdma/ nvram/ pci/ pci-bridge/ pci-host/ pcmcia/ scsi/ sd/ ssi=
/ timer/ tpm/ usb/ vfio/ virtio/ watchdog/ xen/ mem/ smbios/ core/ 9pfs/ ac=
pi/ adc/ audio/ block/ bt/ char/ cpu/ display/ dma/ gpio/ hyperv/ i2c/ ide/=
 input/ intc/ ipack/ ipmi/ isa/ misc/ net/ rdma/ nvram/ pci/ pci-bridge/ pc=
i-host/ pcmcia/ scsi/ sd/ ssi/ timer/ tpm/ usb/ vfio/ virtio/ watchdog/ xen=
/ mem/ smbios/ core/ virtio-9p-device.o virtio-blk.o dataplane/ virtio-seri=
al-bus.o vga.o virtio-gpu.o virtio-gpu-3d.o virtio-gpu-pci.o virtio-vga.o h=
yperv.o hyperv_testdev.o apic.o apic_common.o ioapic.o lpc_ich9.o ivshmem.o=
 pvpanic.o virtio-net.o vhost_net.o rdma_utils.o rdma_backend.o rdma_rm.o v=
mw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o=
 virtio-scsi.o virtio-scsi-dataplane.o vhost-scsi-common.o vhost-scsi.o mc1=
46818rtc.o tpm_ppi.o common.o spapr.o pci.o pci-quirks.o display.o virtio.o=
 virtio-balloon.o virtio-crypto.o virtio-crypto-pci.o vhost.o vhost-backend=
.o vhost-user.o vhost-vsock.o vhost-vsock-pci.o vhost-scsi-pci.o virtio-inp=
ut-host-pci.o virtio-input-pci.o virtio-rng-pci.o virtio-balloon-pci.o virt=
io-9p-pci.o virtio-scsi-pci.o virtio-blk-pci.o virtio-net-pci.o virtio-seri=
al-pci.o xen-host-pci-device.o xen_pt.o xen_pt_config_init.o xen_pt_graphic=
s.o xen_pt_msi.o xen_pt_load_rom.o

This time, $(obj-y) is very much not blank, and...

    @qapi/ final qapi-introspect.o qapi-types-target.o qapi-types.o qapi-vi=
sit-target.o qapi-visit.o qapi-events-target.o qapi-events.o qapi-commands-=
target.o qapi-commands.o
    [Trailing make output elided]

... qapi/Makefile.obj-y *does* clobber it.  Oww.

How come this works anyway?

Consider what would happen if qapi/Makefile.objs used +=3D as suggested by
Eric.  We'd end up with

    obj-y =3D exec.o [...] xen_pt_load_rom.o qapi-introspect.o [...] qapi-c=
ommands.o

which is just as wrong: the file names from qapi/Makefile.objs lack
their qapi/ prefix.

It works because $(obj-y) is not used!

Perhaps unnest-vars could be more hygienic.  But that's not my immediate
concern.  All I want to know right now is whether I should refrain from
=3D and :=3D in Makefile.objs.  Paolo, Fam?

>> +obj-y =3D qapi-introspect.o
>
> and again
>
>>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-types-%.o)
>>  obj-y +=3D qapi-types.o
>>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-visit-%.o)
>> @@ -28,4 +29,3 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
>>  obj-y +=3D qapi-events.o
>>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
>>  obj-y +=3D qapi-commands.o
>> -obj-y +=3D qapi-introspect.o
>>=20
