Received: from eggs.gnu.org ([2001:4830:134:3::10]:47307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fJeSu-0001QI-C4
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fJeSr-0005Wo-7V
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:26:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fJeSq-0005Uy-Vd
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:26:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4ICPSvh146685
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:26:26 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j1vhw69sw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:26:26 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 18 May 2018 06:26:25 -0600
References: <20180518122304.31020-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 08:26:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180518122304.31020-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <7ae4578a-e3e6-ee61-fca7-9d60a0030cf6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com

On 05/18/2018 08:23 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
> with TPM2 (I haven't looked at TPM1, for lack of interest).
>
> PPI test runs successfully with Windows 10 WHLK, despite the limited
> number of supported funcions (tpm2_ppi_funcs table, in particular, no
> function allows to manipulate Tcg2PhysicalPresenceFlags)
>
> The way it works is relatively simple: a memory region is allocated by
> QEMU to save PPI related variables. An ACPI interface is exposed by
> QEMU to let the guest manipulate those. At boot, ovmf processes and
> updates the PPI qemu region and request variables.
>
> I build edk2 with:
>
> $ build -DTPM2_ENABLE
>
> I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2
>   --tpm-state tpmstatedir)
>
> $ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmso=
ck
>    --tpm2 &

Make this:

swtpm socket --tpmstate dir=3Dtpmstatedir --ctrl type=3Dunixio,path=3Dtpm=
sock=20
--tpm2

>
> $ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev
>    emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0
>
> Github trees:
> https://github.com/elmarco/edk2/tree/tpm-ppi
> https://github.com/elmarco/qemu/tree/tpm-ppi
>
> Thanks
>
> v3: after Laszlo review
>   - dropped DxeTcg2PhysicalPresenceLib.uni
>   - removed mTpm2PPIFuncs static initialization, use hard-coded assignm=
ents
>   - declared STATIC the functions that should be
>   - fixed an OUT/IN decorator
>   - use EFI_PROTOCOL_ERROR instead of EFI_INVALID_PARAMETER when PPI
>     initialization fails
>   - replaced EFI_D_INFO with DEBUG_INFO
>   - added a check for mPpi address that it doesn't cross a page boundar=
y
>   - added a GetMemorySpaceDescriptor() check for memory type
>   - declared *mPpi as volatile, to correct mmio access
>   - a few more style changes
>   - comments updated
>   - some minor dead code/inclusion/defines removal
>   - added a few r-b tags
>
> v2:
>   - style and commit message fixes
>
> Marc-Andr=C3=A9 Lureau (4):
>    OvmfPkg: add Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
>    OvmfPkg/IndustryStandard: add QemuTpm.h header
>    OvmfPkg: add Tcg2PhysicalPresenceLibQemu
>    OvmfPkg/PlatformBootManagerLib: process TPM PPI request
>
>   OvmfPkg/OvmfPkgIa32.dsc                       |   4 +-
>   OvmfPkg/OvmfPkgIa32X64.dsc                    |   4 +-
>   OvmfPkg/OvmfPkgX64.dsc                        |   4 +-
>   .../PlatformBootManagerLib.inf                |   2 +
>   .../DxeTcg2PhysicalPresenceLib.inf            |  33 +
>   .../DxeTcg2PhysicalPresenceLib.inf            |  46 +-
>   OvmfPkg/Include/IndustryStandard/QemuTpm.h    |  69 ++
>   .../PlatformBootManagerLib/BdsPlatform.c      |   6 +
>   .../DxeTcg2PhysicalPresenceLib.c              |  20 +-
>   .../DxeTcg2PhysicalPresenceLib.c              | 919 +++++++++++++++++=
+
>   .../PhysicalPresenceStrings.uni               |  33 +-
>   11 files changed, 1081 insertions(+), 59 deletions(-)
>   create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg=
2PhysicalPresenceLib.inf
>   copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Lib=
rary/Tcg2PhysicalPresenceLibQemu}/DxeTcg2PhysicalPresenceLib.inf (66%)
>   create mode 100644 OvmfPkg/Include/IndustryStandard/QemuTpm.h
>   copy EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/Base=
Lib/Ia32/CpuSleep.c =3D> OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeT=
cg2PhysicalPresenceLib.c (55%)
>   create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg=
2PhysicalPresenceLib.c
>   copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Lib=
rary/Tcg2PhysicalPresenceLibQemu}/PhysicalPresenceStrings.uni (56%)
>
