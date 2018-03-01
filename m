Received: from eggs.gnu.org ([2001:4830:134:3::10]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erRDH-0007YJ-QU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erRDD-0003uO-Pu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:37:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47726
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erRDD-0003ml-JU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:37:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21Gam7V015678
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 11:37:38 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gekty4mfb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 11:37:36 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 11:36:51 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<f9e4d63e-5e70-09ee-488b-3ab246708ee7@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 11:36:47 -0500
MIME-Version: 1.0
In-Reply-To: <f9e4d63e-5e70-09ee-488b-3ab246708ee7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c68322f5-4993-c597-0293-6b50f6a6cbc2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/7] RFC: ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, qemu-devel@nongnu.org, javierm@redhat.com

On 02/23/2018 10:55 AM, Laszlo Ersek wrote:
> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following series adds basic TPM2 support for OVMF-on-QEMU (I
>> haven't tested TPM1, for lack of interest). It links with the modules
>> to initializes the device in PEI phase, and do measurements (both PEI
>> and DXE). The Tcg2Dxe module provides the Tcg2 protocol which allows
>> the guest to access the measurement log and other facilities.
>>
>> DxeTpm2MeasureBootLib seems to do its job at measuring images that are
>> not measured in PEI phase (such as PCI PXE rom)
>>
>> Tcg2ConfigDxe is mostly interesting for debugging for now.
>>
>> A major lack is the support for Physical Present Interface (PPI, more
>> below).
>>
>> Linux guests seem to work fine. But windows guest generally complains
>> about the lack of PPI interface (most HLK tests require it, tpm.msc
>> admin interactions too). I haven't done "real" use-cases tests, as I
>> lack experience with TPM usage. Any help appreciated to test the TPM.
>>
>> Tcg2ConfigPei requires variable access, therefore
>> <https://bugzilla.tianocore.org/show_bug.cgi?id=3D386> must be solved
>> first. I used "[edk2] [PATCH v2 0/8] OvmfPkg: add the Variable PEIM,
>> defragment the UEFI memmap" as a base for this series.
>>
>> I build edk2 with:
>>
>> $ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE  -DMEM_VARSTORE_EMU_ENABLE=3D=
FALSE
>>
>> I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2=
 --tpm-state tpmstatedir)
>>
>> $ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpms=
ock  --tpm2 &
>> $ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev emulator,=
id=3Dtpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0
> Thanks for this work -- extra thanks for the instructions regarding the
> software TPM backend.

Please use the tpm2-preview.v2 branch of swtpm and the=20
tpm2-preview.rev146.v2 branch of libtpms. I had to change the way the=20
state is serialized, so unfortunately you will also have to remove the=20
tpm2-00.permall files.

    Stefan
