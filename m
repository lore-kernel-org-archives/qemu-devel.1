Received: from eggs.gnu.org ([2001:4830:134:3::10]:35981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euFEO-0001bt-1w
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euFEK-0001Vg-4F
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:26:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euFEJ-0001VX-Uu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:26:28 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-9-marcandre.lureau@redhat.com>
	<a62073a3-cc41-ca4b-4822-e28ebcf5204b@redhat.com>
	<74D8A39837DF1E4DA445A8C0B3885C503AAEEFF3@shsmsx102.ccr.corp.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0835c904-e613-8e3e-3532-fe09e9900294@redhat.com>
Date: Fri, 9 Mar 2018 11:26:25 +0100
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503AAEEFF3@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] ovmf: add DxeTpm2MeasureBootLib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yao, Jiewen" <jiewen.yao@intel.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "pjones@redhat.com" <pjones@redhat.com>, "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

On 03/09/18 01:39, Yao, Jiewen wrote:
> Very good question.
> Comment below:
>
>> -----Original Message-----
>> From: Laszlo Ersek [mailto:lersek@redhat.com]
>> Sent: Friday, March 9, 2018 3:54 AM
>> To: marcandre.lureau@redhat.com; edk2-devel@lists.01.org; Yao, Jiewen
>> <jiewen.yao@intel.com>
>> Cc: pjones@redhat.com; stefanb@linux.vnet.ibm.com;
>> qemu-devel@nongnu.org; javierm@redhat.com
>> Subject: Re: [PATCH v2 8/8] ovmf: add DxeTpm2MeasureBootLib

>> However, it would be a problem for UEFI_DRIVER modules / apps
>> that come from external media (disk, network, PCI oprom, etc).

> [Jiewen] By design, the 3rd part module should not be invoked before
> EndOfDxe. All Arch Protocol Ready is not strong enough. :-) Please
> refer to
> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Se=
curityStubDxe/Defer3rdPartyImageLoad.c
>
> If a non-FV image is loaded before EndOfDxe, it will be queued into
> mDeferred3rdPartyImage.

OK, thank you -- I suspected image deferral was somehow related to this.
I remember deferred execution from the OVMF log, even though at present
we hook only DxeImageVerificationLib into SecurityStubDxe.

> We also added EfiBootManagerDispatchDeferredImages() API in
> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Include/Libr=
ary/UefiBootManagerLib.h
> and implemented in
> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/Uefi=
BootManagerLib/BmMisc.c
> A platform must call EfiBootManagerDispatchDeferredImages(), if the
> platform supports PCI OROM.

Yep, OVMF does that already. In
"OvmfPkg/Library/PlatformBootManagerLib", we have the following order of
operations, in PlatformBootManagerBeforeConsole():

(a) connect all PCI root bridges non-recursively (this produces PciIo
    instances and discovers the PCI oproms)

(b) kick QEMU so that it generates the ACPI tables that OVMF has to
    install (this depends on PciIo instances existing, from step (1a)),
    and actually install those tables

(c) signal End-of-Dxe (this depends on step (1b), because S3 support
    needs the FACS table coming from step (1b))

(d) write an INFO opcode to the S3 boot script so that the boot script
    is never empty

(e) install DxeSmmReadyToLock (this may come only after steps (1c) and
    (1d))

(f) we call EfiBootManagerDispatchDeferredImages(). This is from Ray's
    commit 9789894e3ba3 ("OvmfPkg/PlatformBds: Dispatch deferred images
    after EndOfDxe", 2016-11-10).

(The rest of PlatformBootManagerBeforeConsole() skipped here.)

So, we have all the right operations in place, I just missed that non-FV
images loaded before End-of-Dxe (such as PCI oproms) are deferred until
step (f), and that the deferral will cover the TPM measurements too.

This is great, because it's an even stronger guarantee than what I would
have wished for. I mean the argument I wrote up earlier -- about oproms
not being dispatched before entering BDS, at which point Tcg2Dxe will
have been dispatched already -- was already good enough, but now I know
that PCI oproms are delayed even *within* BDS until after we explicitly
end DXE and dispatch the deferred images.

> You can find the sample code in
> https://github.com/tianocore/edk2-platforms/blob/devel-MinPlatform/Plat=
form/Intel/MinPlatformPkg/Bds/Library/DxePlatformBootManagerLib/BdsPlatfo=
rm.c
>
>
>
>> However, such are loaded only in the BDS phase, and BDS is only
>> entered after all of the DXE drivers are dispatched from the firmware
>> volumes. In other words, the ordering between Tcg2Dxe and external
>> UEFI_DRIVER / UEFI_APPLICATION modules is ensured that Tcg2Dxe will
>> be dispatched in the DXE phase, while the latter will only be loaded
>> in BDS.
>>
>> Is this intentional? Is my understanding correct?
>
> [Jiewen] Right. The only assumption is: Tcg2Dxe is included in the
> firmware volume and it is dispatched before EndOfDxe.

Perfect. Thank you.

So, Marc-Andr=C3=A9, I would request the following commit message *additi=
on*
(not replacement!) then:

--------------
The following order of operations ensures that 3rd party UEFI modules,
such as PCI option ROMs and other modules possibly loaded from outside
of firmware volumes, are measured into the TPM:

(1) Tcg2Dxe is included in DXEFV, therefore it produces the TCG2
    protocol sometime in the DXE phase (assuming a TPM2 chip is present,
    reported via PcdTpmInstanceGuid).

(2) The DXE core finds that no more drivers are left to dispatch from
    DXEFV, and we enter the BDS phase.

(3) OVMF's PlatformBootManagerLib connects all PCI root bridges
    non-recursively, producing PciIo instances and discovering PCI
    oproms.

(4) The dispatching of images that don't originate from FVs is deferred
    at this point, by
    "MdeModulePkg/Universal/SecurityStubDxe/Defer3rdPartyImageLoad.c".

(5) OVMF's PlatformBootManagerLib signals EndOfDxe.

(6) OVMF's PlatformBootManagerLib calls
    EfiBootManagerDispatchDeferredImages() -- the images deferred in
    step (4) are now dispatched.

(7) Image dispatch invokes the Security / Security2 Arch protocols
    (produced by SecurityStubDxe). In this patch, we hook
    DxeTpm2MeasureBootLib into SecurityStubDxe, therefore image dispatch
    will try to locate the TCG2 protocol, and measure the image into the
    TPM2 chip with the protocol. Because of step (1), the TCG2 protocol
    will always be found and used (assuming a TPM2 chip is present).
--------------

Jiewen, does this look OK?

Thanks!
Laszlo
