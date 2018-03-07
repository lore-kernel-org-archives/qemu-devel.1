Received: from eggs.gnu.org ([2001:4830:134:3::10]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS9-0005cS-6a
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS7-0001Bs-80
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbS7-0001Bf-1Z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:03 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:45 +0100
Message-Id: <20180307155746.18526-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 7/8] ovmf: link with Tcg2Dxe module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This module measures and log the boot environment. It also produces
the Tcg2 protocol, which allows for example to read the log from OS.

The linux kernel doesn't yet read the EFI_TCG2_EVENT_LOG_FORMAT_TCG_2,
which is required for crypto-agile log. In fact, only upcoming 4.16
adds support EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2:

[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS=3D0x3fa1f000  ACPI=3D0x3fbb6000  ACPI 2.0=3D0=
x3fbb6014  MEMATTR=3D0x3e7d4318  TPMEventLog=3D0x3db21018

$ python chipsec_util.py tpm parse_log binary_bios_measurements

[CHIPSEC] Version 1.3.5.dev2
[CHIPSEC] API mode: using OS native API (not using CHIPSEC kernel module)
[CHIPSEC] Executing command 'tpm' with args ['parse_log', '/tmp/binary_bi=
os_measurements']

PCR: 0	type: EV_S_CRTM_VERSION               	size: 0x2	digest: 1489f923c=
4dca729178b3e3233458550d8dddf29
	+ version:
PCR: 0	type: EV_EFI_PLATFORM_FIRMWARE_BLOB   	size: 0x10	digest: fd39ced7=
c0d2a61f6830c78c7625f94826b05bcc
	+ base: 0x820000	length: 0xe0000
PCR: 0	type: EV_EFI_PLATFORM_FIRMWARE_BLOB   	size: 0x10	digest: 39ebc678=
3b72bc1e73c7d5bcfeb5f54a3f105d4c
	+ base: 0x900000	length: 0xa00000
PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x35	digest: 57cd4dc1=
9442475aa82743484f3b1caa88e142b8
PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x24	digest: 9b138730=
6ebb7ff8e795e7be77563666bbf4516e
PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x26	digest: 9afa86c5=
07419b8570c62167cb9486d9fc809758
PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x24	digest: 5bf8faa0=
78d40ffbd03317c93398b01229a0e1e0
PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x26	digest: 734424c9=
fe8fc71716c42096f4b74c88733b175e
PCR: 7	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x3e	digest: 252f8ebb=
85340290b64f4b06a001742be8e5cab6
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x6e	digest: 22a4f6ee=
9af6dba01d3528deb64b74b582fc182b
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x80	digest: b7811d5b=
f30a7efd4e385c6179fe10d9290bb9e8
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x84	digest: 425e502c=
24fc924e231e0a62327b6b7d1f704573
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x9a	digest: 0b5d2c98=
ac5de6148a4a1490ff9d5df69039f04e
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0xbd	digest: 20bd5f40=
2271d57a88ea314fe35c1705956b1f74
PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x88	digest: df5d6605=
cb8f4366d745a8464cfb26c1efdc305c
PCR: 4	type: EV_EFI_ACTION                   	size: 0x28	digest: cd0fdb45=
31a6ec41be2753ba042637d6e5f7f256
PCR: 0	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 1	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 2	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 3	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 4	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473
PCR: 5	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca78e=
7450a285173431b3e52c5c25299e473

$ tpm2_pcrlist
sha1 :
  0  : 35bd1786b6909daad610d7598b1d620352d33b8a
  1  : ec0511e860206e0af13c31da2f9e943fb6ca353d
  2  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
  3  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
  4  : 45a323382bd933f08e7f0e256bc8249e4095b1ec
  5  : d16d7e629fd8d08ca256f9ad3a3a1587c9e6cc1b
  6  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
  7  : 518bd167271fbb64589c61e43d8c0165861431d8
  8  : 0000000000000000000000000000000000000000
  9  : 0000000000000000000000000000000000000000
  10 : 0000000000000000000000000000000000000000
  11 : 0000000000000000000000000000000000000000
  12 : 0000000000000000000000000000000000000000
  13 : 0000000000000000000000000000000000000000
  14 : 0000000000000000000000000000000000000000
  15 : 0000000000000000000000000000000000000000
  16 : 0000000000000000000000000000000000000000
  17 : ffffffffffffffffffffffffffffffffffffffff
  18 : ffffffffffffffffffffffffffffffffffffffff
  19 : ffffffffffffffffffffffffffffffffffffffff
  20 : ffffffffffffffffffffffffffffffffffffffff
  21 : ffffffffffffffffffffffffffffffffffffffff
  22 : ffffffffffffffffffffffffffffffffffffffff
  23 : 0000000000000000000000000000000000000000
sha256 :
  0  : 9ae903dbae3357ac00d223660bac19ea5c021499a56201104332ab966631ce2c
  1  : acc611d90245cf04e77b0ca94901f90e7fa54770f0426f53c3049b532243d1b8
  2  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
  3  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
  4  : 7a94ffe8a7729a566d3d3c577fcb4b6b1e671f31540375f80eae6382ab785e35
  5  : a5ceb755d043f32431d63e39f5161464620a3437280494b5850dc1b47cc074e0
  6  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
  7  : 65caf8dd1e0ea7a6347b635d2b379c93b9a1351edc2afc3ecda700e534eb3068
  8  : 0000000000000000000000000000000000000000000000000000000000000000
  9  : 0000000000000000000000000000000000000000000000000000000000000000
  10 : 0000000000000000000000000000000000000000000000000000000000000000
  11 : 0000000000000000000000000000000000000000000000000000000000000000
  12 : 0000000000000000000000000000000000000000000000000000000000000000
  13 : 0000000000000000000000000000000000000000000000000000000000000000
  14 : 0000000000000000000000000000000000000000000000000000000000000000
  15 : 0000000000000000000000000000000000000000000000000000000000000000
  16 : 0000000000000000000000000000000000000000000000000000000000000000
  17 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  18 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  19 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  20 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  21 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  22 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  23 : 0000000000000000000000000000000000000000000000000000000000000000
sha384 :

The PhysicalPresenceLib is required, it sets some variables, but the
firmware doesn't act on it yet.

Laszlo Ersek explained on the list why Tpm2DeviceLib has to be
resolved differently for DXE_DRIVER modules in general and for
"Tcg2Dxe.inf" specifically:

  * We have a library class called Tpm2DeviceLib -- this is basically the
  set of APIs declared in "SecurityPkg/Include/Library/Tpm2DeviceLib.h".
  Its leading comment says "This library abstract how to access TPM2
  hardware device".

  There are two *sets* of APIs in "Tpm2DeviceLib.h":

  (a) functions that deal with the TPM2 device:
      - Tpm2RequestUseTpm(),
      - Tpm2SubmitCommand()

      This set of APIs is supposed to be used by clients that *consume*
      the TPM2 device abstraction.

  (b) the function Tpm2RegisterTpm2DeviceLib(), which is supposed to be
      used by *providers* of various TPM2 device abstractions.

  * Then, we have two implementations (instances) of the Tpm2DeviceLib cl=
ass:
  (1) SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg2.inf
  (2) SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2DeviceLibRouterDxe.inf

  (1) The first library instance ("Tpm2DeviceLibTcg2.inf") implements the
  APIs listed under (a), and it does not implement (b) -- see
  EFI_UNSUPPORTED. In other words, this lib instance is strictly meant fo=
r
  drivers that *consume* the TPM2 device abstraction. And, the (a) group
  of APIs is implemented by forwarding the requests to the TCG2 protocol.

  The idea here is that all the drivers that consume the TPM2 abstraction
  do not have to be statically linked with a large TPM2 device library
  instance; instead they are only linked (statically) with this "thin"
  library instance, and all the actual work is delegated to whichever
  driver that provides the singleton TCG2 protocol.

  (2) The second library instance ("Tpm2DeviceLibRouterDxe.inf") is meant
  for the driver that offers (produces) the TCG2 protocol. This lib
  instance implements both (a) and (b) API groups.

  * Here's how things fit together:

  (i) The "SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.inf"
  library instance (which has no lib class) is linked into "Tcg2Dxe.inf"
  via NULL class resolution. This simply means that before the
  "Tcg2Dxe.inf" entry point function is entered, the constructor function
  of "Tpm2InstanceLibDTpm.inf" will be called.

  (ii) This Tpm2InstanceLibDTpmConstructor() function calls API (b), and
  registers its own actual TPM2 command implementation with the
  "Tpm2DeviceLibRouter" library instance (also linked into the Tcg2Dxe
  driver). This provides the back-end for the API set (a).

         TCG2 protocol provider (Tcg2Dxe.inf driver) launches
                      |
                      v
    NULL class: Tpm2InstanceLibDTpm instance construction
                      |
                      v
    Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
           backend registration for API set (a)

  (iii) The Tcg2Dxe driver exposes the TCG2 protocol.

  (iv) A TPM2 consumer calls API set (a) via lib instance (1). Such calls
  land in Tcg2Dxe, via the protocol.

  (v) Tcg2Dxe serves the protocol request by forwarding it to API set (a)
  from lib instance (2).

  (vi) Those functions call the "backend" functions registered by
  Tpm2DeviceLibDTpm in step (ii).

       TPM 2 consumer driver
                |
                v
  Tpm2DeviceLib class: Tpm2DeviceLibTcg2 instance
                |
                v
         TCG2 protocol interface
                |
                v
  TCG2 protocol provider: Tcg2Dxe.inf driver
                |
                v
  Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
                |
                v
     NULL class: Tpm2InstanceLibDTpm instance
        (via earlier registration)
                |
                v
       TPM2 chip (actual hardware)

  * So that is the "router" pattern in edk2. Namely,

  - Consumers of an abstraction use a thin library instance.

  - The thin library instance calls a firmware-global (singleton) service=
,
    i.e. a PPI (in the PEI phase) or protocol (in the DXE phase).

  - The PEIM providing the PPI, or the DXE driver providing the protocol,
    don't themselves implement the actual service either. Instead they
    offer a "registration" service too, and they only connect the incomin=
g
    "consumer" calls to the earlier registered back-end(s).

  - The "registration service", for back-ends to use, may take various
    forms.

    It can be exposed globally to the rest of the firmware, as
    another member function of the PPI / protocol structure. Then backend=
s
    can be provided by separate PEIMs / DXE drivers.

    Or else, the registration service can be exposed as just another
    library API. In this case, the backends are provided as NULL class
    library instances, and a platform  DSC file links them into the PEIM =
/
    DXE driver via NULL class resolutions. The backend lib instances call
    the registration service in their own respective constructor
    functions.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 16 ++++++++++++++++
 OvmfPkg/OvmfPkgX64.fdf |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 3fa1a31f4c37..7753852144fb 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -211,6 +211,8 @@ [LibraryClasses]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
+  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceLib=
/DxeTcg2PhysicalPresenceLib.inf
+  Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendorLi=
bNull.inf
 !endif
=20
 [LibraryClasses.common]
@@ -362,6 +364,10 @@ [LibraryClasses.common.DXE_DRIVER]
   PciLib|OvmfPkg/Library/DxePciLibI440FxQ35/DxePciLibI440FxQ35.inf
   MpInitLib|UefiCpuPkg/Library/MpInitLib/DxeMpInitLib.inf
   QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/DxeQemuFwCfgS3LibFwCfg.i=
nf
+!if $(TPM2_ENABLE)
+  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoR=
outerDxe.inf
+  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg2.=
inf
+!endif
=20
 [LibraryClasses.common.UEFI_APPLICATION]
   PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
@@ -642,6 +648,16 @@ [Components]
=20
   MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
+    <LibraryClasses>
+      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2DeviceLi=
bRouterDxe.inf
+      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.inf
+      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
+      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
+  }
+!endif
+
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index c0173e7adf5f..1a46104fc63d 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -392,6 +392,10 @@ [FV.DXEFV]
 INF  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
 !endif
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
+!endif
+
 ########################################################################=
########
=20
 [FV.FVMAIN_COMPACT]
--=20
2.16.2.346.g9779355e34
