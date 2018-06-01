Received: from eggs.gnu.org ([2001:4830:134:3::10]:53306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOnuE-0006Sf-2r
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOnu9-0001k3-Vw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:32:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOnu9-0001jg-QS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:31:57 -0400
References: <20180601171521.1770-1-pbonzini@redhat.com>
	<20180601171521.1770-4-pbonzini@redhat.com>
	<d0ee9736-399a-ce20-5f69-1cf36f29090a@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d714788-b03f-0028-ed14-7fb344d4ff43@redhat.com>
Date: Fri, 1 Jun 2018 19:31:52 +0200
MIME-Version: 1.0
In-Reply-To: <d0ee9736-399a-ce20-5f69-1cf36f29090a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 56/56] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 01/06/2018 19:26, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/01/2018 02:15 PM, Paolo Bonzini wrote:
>> This is only half of the work, because the proxy devices (virtio-*-pci=
,
>> virtio-*-ccw, etc.) are still included unconditionally.  It is still a
>> move in the right direction.
>>
>> Based-on: <20180522194943.24871-1-pbonzini@redhat.com>
>=20
> Is this tag useful?

Yeah, usually it would go in the cover letter.  It remained here because
this patch was not part of a series.

Paolo

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak     |  1 +
>>  default-configs/hppa-softmmu.mak    |  2 --
>>  default-configs/pci.mak             |  4 +---
>>  default-configs/riscv32-softmmu.mak |  4 ++--
>>  default-configs/riscv64-softmmu.mak |  4 ++--
>>  default-configs/s390x-softmmu.mak   |  5 +----
>>  default-configs/virtio.mak          | 14 ++++++++++++++
>>  hw/9pfs/Makefile.objs               |  6 ++++--
>>  hw/block/Makefile.objs              |  6 ++----
>>  hw/char/Makefile.objs               |  2 +-
>>  hw/display/Makefile.objs            |  4 ++--
>>  hw/input/Makefile.objs              |  6 +++---
>>  hw/net/Makefile.objs                |  2 +-
>>  hw/scsi/Makefile.objs               |  2 +-
>>  hw/virtio/Makefile.objs             | 16 +++++++++-------
>>  15 files changed, 44 insertions(+), 34 deletions(-)
>>  create mode 100644 default-configs/virtio.mak
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index dd29e741c2..8ba2558b36 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -41,6 +41,7 @@ CONFIG_USB=3Dy
>>  CONFIG_USB_MUSB=3Dy
>>  CONFIG_USB_EHCI_SYSBUS=3Dy
>>  CONFIG_PLATFORM_BUS=3Dy
>> +CONFIG_VIRTIO_MMIO=3Dy
>> =20
>>  CONFIG_ARM11MPCORE=3Dy
>>  CONFIG_A9MPCORE=3Dy
>> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-s=
oftmmu.mak
>> index 013e5f046f..4badc0521e 100644
>> --- a/default-configs/hppa-softmmu.mak
>> +++ b/default-configs/hppa-softmmu.mak
>> @@ -4,8 +4,6 @@ CONFIG_SERIAL=3Dy
>>  CONFIG_SERIAL_ISA=3Dy
>>  CONFIG_ISA_BUS=3Dy
>>  CONFIG_I8259=3Dy
>> -CONFIG_VIRTIO_PCI=3D$(CONFIG_PCI)
>> -CONFIG_VIRTIO=3Dy
>>  CONFIG_E1000_PCI=3Dy
>>  CONFIG_IDE_ISA=3Dy
>>  CONFIG_IDE_CMD646=3Dy
>> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
>> index 163dd814c7..de53d20ac6 100644
>> --- a/default-configs/pci.mak
>> +++ b/default-configs/pci.mak
>> @@ -2,7 +2,7 @@ CONFIG_PCI=3Dy
>>  # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
>>  CONFIG_ISA_BUS=3Dy
>>  CONFIG_VIRTIO_PCI=3Dy
>> -CONFIG_VIRTIO=3Dy
>> +include virtio.mak
>>  CONFIG_USB_UHCI=3Dy
>>  CONFIG_USB_OHCI=3Dy
>>  CONFIG_USB_EHCI=3Dy
>> @@ -46,5 +46,3 @@ CONFIG_VGA=3Dy
>>  CONFIG_VGA_PCI=3Dy
>>  CONFIG_IVSHMEM_DEVICE=3D$(CONFIG_IVSHMEM)
>>  CONFIG_ROCKER=3Dy
>> -CONFIG_VHOST_USER_SCSI=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LI=
NUX))
>> -CONFIG_VHOST_USER_BLK=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LIN=
UX))
>> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/ris=
cv32-softmmu.mak
>> index 9159a4a8af..20e670d99c 100644
>> --- a/default-configs/riscv32-softmmu.mak
>> +++ b/default-configs/riscv32-softmmu.mak
>> @@ -1,5 +1,5 @@
>>  # Default configuration for riscv-softmmu
>> =20
>>  CONFIG_SERIAL=3Dy
>> -CONFIG_VIRTIO=3Dy
>> -CONFIG_SCSI=3Dy
>> +CONFIG_VIRTIO_MMIO=3Dy
>> +include virtio.mak
>> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/ris=
cv64-softmmu.mak
>> index 9159a4a8af..20e670d99c 100644
>> --- a/default-configs/riscv64-softmmu.mak
>> +++ b/default-configs/riscv64-softmmu.mak
>> @@ -1,5 +1,5 @@
>>  # Default configuration for riscv-softmmu
>> =20
>>  CONFIG_SERIAL=3Dy
>> -CONFIG_VIRTIO=3Dy
>> -CONFIG_SCSI=3Dy
>> +CONFIG_VIRTIO_MMIO=3Dy
>> +include virtio.mak
>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x=
-softmmu.mak
>> index 729033b25a..d6b67d50f0 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -1,9 +1,6 @@
>>  CONFIG_PCI=3Dy
>>  CONFIG_VIRTIO_PCI=3D$(CONFIG_PCI)
>> -CONFIG_VHOST_USER_SCSI=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LI=
NUX))
>> -CONFIG_VHOST_USER_BLK=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LIN=
UX))
>> -CONFIG_SCSI=3Dy
>> -CONFIG_VIRTIO=3Dy
>> +include virtio.mak
>>  CONFIG_SCLPCONSOLE=3Dy
>>  CONFIG_TERMINAL3270=3Dy
>>  CONFIG_S390_FLIC=3Dy
>> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
>> new file mode 100644
>> index 0000000000..1304849018
>> --- /dev/null
>> +++ b/default-configs/virtio.mak
>> @@ -0,0 +1,14 @@
>> +CONFIG_VHOST_USER_SCSI=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LI=
NUX))
>> +CONFIG_VHOST_USER_BLK=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LIN=
UX))
>> +CONFIG_VIRTIO=3Dy
>> +CONFIG_VIRTIO_9P=3Dy
>> +CONFIG_VIRTIO_BALLOON=3Dy
>> +CONFIG_VIRTIO_BLK=3Dy
>> +CONFIG_VIRTIO_CRYPTO=3Dy
>> +CONFIG_VIRTIO_GPU=3Dy
>> +CONFIG_VIRTIO_INPUT=3Dy
>> +CONFIG_VIRTIO_NET=3Dy
>> +CONFIG_VIRTIO_RNG=3Dy
>> +CONFIG_SCSI=3Dy
>> +CONFIG_VIRTIO_SCSI=3Dy
>> +CONFIG_VIRTIO_SERIAL=3Dy
>> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
>> index fd90b62900..e3fa673665 100644
>> --- a/hw/9pfs/Makefile.objs
>> +++ b/hw/9pfs/Makefile.objs
>> @@ -1,3 +1,4 @@
>> +ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
>>  common-obj-y  =3D 9p.o 9p-util.o
>>  common-obj-y +=3D 9p-local.o 9p-xattr.o
>>  common-obj-y +=3D 9p-xattr-user.o 9p-posix-acl.o
>> @@ -5,6 +6,7 @@ common-obj-y +=3D coth.o cofs.o codir.o cofile.o
>>  common-obj-y +=3D coxattr.o 9p-synth.o
>>  common-obj-$(CONFIG_OPEN_BY_HANDLE) +=3D  9p-handle.o
>>  common-obj-y +=3D 9p-proxy.o
>> -common-obj-$(CONFIG_XEN) +=3D xen-9p-backend.o
>> +endif
>> =20
>> -obj-$(CONFIG_VIRTIO) +=3D virtio-9p-device.o
>> +common-obj-$(CONFIG_XEN) +=3D xen-9p-backend.o
>> +obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-device.o
>> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
>> index 4c19a583c8..53ce5751ae 100644
>> --- a/hw/block/Makefile.objs
>> +++ b/hw/block/Makefile.objs
>> @@ -11,8 +11,6 @@ common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
>> =20
>>  obj-$(CONFIG_SH4) +=3D tc58128.o
>> =20
>> -obj-$(CONFIG_VIRTIO) +=3D virtio-blk.o
>> -obj-$(CONFIG_VIRTIO) +=3D dataplane/
>> -ifeq ($(CONFIG_VIRTIO),y)
>> +obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
>> +obj-$(CONFIG_VIRTIO_BLK) +=3D dataplane/
>>  obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
>> -endif
>> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>> index 1b979100b7..b570531291 100644
>> --- a/hw/char/Makefile.objs
>> +++ b/hw/char/Makefile.objs
>> @@ -6,7 +6,7 @@ common-obj-$(CONFIG_PL011) +=3D pl011.o
>>  common-obj-$(CONFIG_SERIAL) +=3D serial.o
>>  common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
>>  common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
>> -common-obj-$(CONFIG_VIRTIO) +=3D virtio-console.o
>> +common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-console.o
>>  common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
>>  common-obj-$(CONFIG_XEN) +=3D xen_console.o
>>  common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o
>> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
>> index d907b381ae..b5d97ab26d 100644
>> --- a/hw/display/Makefile.objs
>> +++ b/hw/display/Makefile.objs
>> @@ -36,8 +36,8 @@ obj-$(CONFIG_VGA) +=3D vga.o
>> =20
>>  common-obj-$(CONFIG_QXL) +=3D qxl.o qxl-logger.o qxl-render.o
>> =20
>> -obj-$(CONFIG_VIRTIO) +=3D virtio-gpu.o virtio-gpu-3d.o
>> -obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-gpu-pci.o
>> +obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-gpu.o virtio-gpu-3d.o
>> +obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) +=3D virti=
o-gpu-pci.o
>>  obj-$(CONFIG_VIRTIO_VGA) +=3D virtio-vga.o
>>  virtio-gpu.o-cflags :=3D $(VIRGL_CFLAGS)
>>  virtio-gpu.o-libs +=3D $(VIRGL_LIBS)
>> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
>> index 77e53e6883..c8b00f71ec 100644
>> --- a/hw/input/Makefile.objs
>> +++ b/hw/input/Makefile.objs
>> @@ -7,10 +7,10 @@ common-obj-y +=3D ps2.o
>>  common-obj-$(CONFIG_STELLARIS_INPUT) +=3D stellaris_input.o
>>  common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
>> =20
>> -common-obj-$(CONFIG_VIRTIO) +=3D virtio-input.o
>> -common-obj-$(CONFIG_VIRTIO) +=3D virtio-input-hid.o
>> +common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
>> +common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
>>  ifeq ($(CONFIG_LINUX),y)
>> -common-obj-$(CONFIG_VIRTIO) +=3D virtio-input-host.o
>> +common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
>>  endif
>> =20
>>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
>> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
>> index ab22968641..fa461d4463 100644
>> --- a/hw/net/Makefile.objs
>> +++ b/hw/net/Makefile.objs
>> @@ -36,7 +36,7 @@ obj-$(CONFIG_MILKYMIST) +=3D milkymist-minimac2.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_llan.o
>>  obj-$(CONFIG_XILINX_ETHLITE) +=3D xilinx_ethlite.o
>> =20
>> -obj-$(CONFIG_VIRTIO) +=3D virtio-net.o
>> +obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net.o
>>  obj-y +=3D vhost_net.o
>> =20
>>  obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
>> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
>> index b188f7242b..718b4c2a68 100644
>> --- a/hw/scsi/Makefile.objs
>> +++ b/hw/scsi/Makefile.objs
>> @@ -8,7 +8,7 @@ common-obj-$(CONFIG_ESP) +=3D esp.o
>>  common-obj-$(CONFIG_ESP_PCI) +=3D esp-pci.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_vscsi.o
>> =20
>> -ifeq ($(CONFIG_VIRTIO),y)
>> +ifeq ($(CONFIG_VIRTIO_SCSI),y)
>>  obj-y +=3D virtio-scsi.o virtio-scsi-dataplane.o
>>  obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-common.o vhost-scsi.o
>>  obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-scsi-common.o vhost-user-scs=
i.o
>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>> index 765d363c1f..1b2799cfd8 100644
>> --- a/hw/virtio/Makefile.objs
>> +++ b/hw/virtio/Makefile.objs
>> @@ -1,15 +1,17 @@
>>  ifeq ($(CONFIG_VIRTIO),y)
>> -common-obj-y +=3D virtio-rng.o
>> -common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
>>  common-obj-y +=3D virtio-bus.o
>> -common-obj-y +=3D virtio-mmio.o
>> +obj-y +=3D virtio.o
>> +
>> +common-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng.o
>> +common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
>> +common-obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
>> +obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
>> +obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
>> +obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D vi=
rtio-crypto-pci.o
>> =20
>> -obj-y +=3D virtio.o virtio-balloon.o=20
>>  obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
>>  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
>> -obj-y +=3D virtio-crypto.o
>> -obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-crypto-pci.o
>>  endif
>> =20
>> -common-obj-$(call lnot,$(CONFIG_LINUX)) +=3D vhost-stub.o
>> +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX)))=
 +=3D vhost-stub.o
>>  common-obj-$(CONFIG_ALL) +=3D vhost-stub.o
>>
