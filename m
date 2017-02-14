Received: from eggs.gnu.org ([2001:4830:134:3::10]:55298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlf-0003UA-Fi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUld-0001Oo-Gu
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:58026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdUld-0001O8-5P
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdUlb-0004PB-SA
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:31:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C90D52E80CA
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:31:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 04:17:36 -0000
From: Launchpad Bug Tracker <897750@bugs.launchpad.net>
Reply-To: Bug 897750 <897750@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111129155310.23239.76602.malonedeb@wampee.canonical.com>
Message-Id: <20170214041736.28611.22757.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 897750] Re: libvirt/kvm problem with disk
 attach/detach/reattach on running virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu-kvm (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu-kvm (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/897750

Title:
  libvirt/kvm problem with disk attach/detach/reattach on running virt

Status in QEMU:
  Expired
Status in qemu-kvm package in Ubuntu:
  Expired

Bug description:
  Release:         Ubuntu 11.10 (Oneiric)
  libvirt-bin:      0.9.2-4ubuntu15.1
  qemu-kvm:   0.14.1+noroms-0ubuntu6

  Summary:    With a running KVM virt,   performing an 'attach-disk',  then=
 a 'detach-disk', then another 'attach-disk' =

  in an attempt to reattach the volume at the same point on the virt, fails=
, with the qemu reporting back to
  libvirt a 'Duplicate ID' error.

  Expected behavior:   The 2nd invocation of 'attach-disk' should have succ=
eeded
  Actual behavior:         Duplicate ID error reported

  =

  I believe this is most likely a qemu-kvm issue, as the DOM  kvm spits bac=
k at libvirt after the 'detach-disk'
  does not show the just-detached disk.   There is some kind of registry/lo=
okup for devices in qemu-kvm
  and for whatever reason, the entry for the disk does not get removed when=
 it is detached from the
  virt.   Specifically, the error gets reported at the 2nd attach-disk atte=
mpt from:
    =

    qemu-option.c:qemu_opts_create:697

  684 QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id, int fa=
il_if_exists)                                                  =

  685 {                                                                    =
                                                               =

  686     QemuOpts *opts =3D NULL;                                         =
                                                                 =

  687                                                                      =
                                                               =

  688     if (id) {                                                        =
                                                               =

  689         if (!id_wellformed(id)) {                                    =
                                                               =

  690             qerror_report(QERR_INVALID_PARAMETER_VALUE, "id", "an ide=
ntifier");                                                     =

  691             error_printf_unless_qmp("Identifiers consist of letters, =
digits, '-', '.', '_', starting with a letter.\n");            =

  692             return NULL;                                             =
                                                               =

  693         }                                                            =
                                                               =

  694         opts =3D qemu_opts_find(list, id);                           =
                                                                 =

  695         if (opts !=3D NULL) {                                        =
                                                                 =

  696             if (fail_if_exists) {                                    =
                                                               =

  697                 qerror_report(QERR_DUPLICATE_ID, id, list->name);    =
       <<<< =3D=3D=3D=3D=3D=3D HERE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
                                                    =

  698                 return NULL;                                         =
                                                               =

  699             } else {                                                 =
                                                               =

  700                 return opts;                                         =
                                                               =

  701             }                                                        =
                                                               =

  702         }                                                            =
                                                               =

  703     }                                                                =
                                                               =

  704     opts =3D qemu_mallocz(sizeof(*opts));                            =
                                                                 =

  705     if (id) {                                                        =
                                                               =

  706         opts->id =3D qemu_strdup(id);                                =
                                                                 =

  707     }                                                                =
                                                               =

  708     opts->list =3D list;                                             =
                                                                 =

  709     loc_save(&opts->loc);                                            =
                                                               =

  710     QTAILQ_INIT(&opts->head);                                        =
                                                               =

  711     QTAILQ_INSERT_TAIL(&list->head, opts, next);                     =
                                                               =

  712     return opts;                                                     =
                                                               =

  713 }                                                                    =
                                                               =


  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Output of my  attach/detach/attach
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  virsh # attach-disk base1 /var/lib/libvirt/images/extrastorage.img vdb
  Disk attached successfully

  virsh # dumpxml base1
  <domain type=3D'kvm' id=3D'2'>
    <name>base1</name>
    <uuid>9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</uuid>
    <memory>1048576</memory>
    <currentMemory>1048576</currentMemory>
    <vcpu>2</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-0.14'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <cpu match=3D'exact'>
      <model>Opteron_G3</model>
      <vendor>AMD</vendor>
      <feature policy=3D'require' name=3D'skinit'/>
      <feature policy=3D'require' name=3D'vme'/>
      <feature policy=3D'require' name=3D'mmxext'/>
      <feature policy=3D'require' name=3D'fxsr_opt'/>
      <feature policy=3D'require' name=3D'cr8legacy'/>
      <feature policy=3D'require' name=3D'ht'/>
      <feature policy=3D'require' name=3D'3dnowprefetch'/>
      <feature policy=3D'require' name=3D'3dnowext'/>
      <feature policy=3D'require' name=3D'wdt'/>
      <feature policy=3D'require' name=3D'extapic'/>
      <feature policy=3D'require' name=3D'pdpe1gb'/>
      <feature policy=3D'require' name=3D'osvw'/>
      <feature policy=3D'require' name=3D'cmp_legacy'/>
      <feature policy=3D'require' name=3D'3dnow'/>
    </cpu>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/bin/kvm</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw'/>
        <source file=3D'/dev/rbd1'/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <alias name=3D'virtio-disk0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'block' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw'/>
        <source dev=3D'/var/lib/libvirt/images/extrastorage.img'/>
        <target dev=3D'vdb' bus=3D'virtio'/>
        <alias name=3D'virtio-disk1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' =
function=3D'0x0'/>
      </disk>
      <controller type=3D'ide' index=3D'0'>
        <alias name=3D'ide0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:a2:c1:2d'/>
        <source bridge=3D'br0'/>
        <target dev=3D'vnet0'/>
        <model type=3D'virtio'/>
        <alias name=3D'net0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <source path=3D'/dev/pts/1'/>
        <target port=3D'0'/>
        <alias name=3D'serial0'/>
      </serial>
      <console type=3D'pty' tty=3D'/dev/pts/1'>
        <source path=3D'/dev/pts/1'/>
        <target type=3D'serial' port=3D'0'/>
        <alias name=3D'serial0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'5900' autoport=3D'yes'/>
      <sound model=3D'ich6'>
        <alias name=3D'sound0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </sound>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <alias name=3D'video0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <alias name=3D'balloon0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
      </memballoon>
    </devices>
    <seclabel type=3D'dynamic' model=3D'apparmor'>
      <label>libvirt-9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</label>
      <imagelabel>libvirt-9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</imagelabel>
    </seclabel>
  </domain>

  virsh # detach-disk base1 vdb
  Disk detached successfully

  virsh # dumpxml base1
  <domain type=3D'kvm' id=3D'2'>
    <name>base1</name>
    <uuid>9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</uuid>
    <memory>1048576</memory>
    <currentMemory>1048576</currentMemory>
    <vcpu>2</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-0.14'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <cpu match=3D'exact'>
      <model>Opteron_G3</model>
      <vendor>AMD</vendor>
      <feature policy=3D'require' name=3D'skinit'/>
      <feature policy=3D'require' name=3D'vme'/>
      <feature policy=3D'require' name=3D'mmxext'/>
      <feature policy=3D'require' name=3D'fxsr_opt'/>
      <feature policy=3D'require' name=3D'cr8legacy'/>
      <feature policy=3D'require' name=3D'ht'/>
      <feature policy=3D'require' name=3D'3dnowprefetch'/>
      <feature policy=3D'require' name=3D'3dnowext'/>
      <feature policy=3D'require' name=3D'wdt'/>
      <feature policy=3D'require' name=3D'extapic'/>
      <feature policy=3D'require' name=3D'pdpe1gb'/>
      <feature policy=3D'require' name=3D'osvw'/>
      <feature policy=3D'require' name=3D'cmp_legacy'/>
      <feature policy=3D'require' name=3D'3dnow'/>
    </cpu>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/bin/kvm</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw'/>
        <source file=3D'/dev/rbd1'/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <alias name=3D'virtio-disk0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </disk>
      <controller type=3D'ide' index=3D'0'>
        <alias name=3D'ide0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:a2:c1:2d'/>
        <source bridge=3D'br0'/>
        <target dev=3D'vnet0'/>
        <model type=3D'virtio'/>
        <alias name=3D'net0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <source path=3D'/dev/pts/1'/>
        <target port=3D'0'/>
        <alias name=3D'serial0'/>
      </serial>
      <console type=3D'pty' tty=3D'/dev/pts/1'>
        <source path=3D'/dev/pts/1'/>
        <target type=3D'serial' port=3D'0'/>
        <alias name=3D'serial0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'5900' autoport=3D'yes'/>
      <sound model=3D'ich6'>
        <alias name=3D'sound0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </sound>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <alias name=3D'video0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <alias name=3D'balloon0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
      </memballoon>
    </devices>
    <seclabel type=3D'dynamic' model=3D'apparmor'>
      <label>libvirt-9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</label>
      <imagelabel>libvirt-9ebebe7f-7dfa-4735-a80c-c19ebe4e1459</imagelabel>
    </seclabel>
  </domain>

  virsh # attach-disk base1 /var/lib/libvirt/images/extrastorage.img vdb
  error: Failed to attach disk
  error: operation failed: adding virtio-blk-pci,bus=3Dpci.0,addr=3D0x8,dri=
ve=3Ddrive-virtio-disk1,id=3Dvirtio-disk1 device failed: Duplicate ID 'virt=
io-disk1' for device
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/897750/+subscriptions
