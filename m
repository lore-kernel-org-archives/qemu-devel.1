Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afish@apple.com>) id 1eswZd-0005JB-O7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afish@apple.com>) id 1eswZa-00016f-CA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:19:05 -0500
Received: from mail-out4.apple.com ([17.151.62.26]:61951
	helo=mail-in4.apple.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afish@apple.com>) id 1eswZZ-00014l-NA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:19:02 -0500
MIME-version: 1.0
Sender: afish@apple.com
From: Andrew Fish <afish@apple.com>
Message-id: <A230E434-C42B-4D4B-B5A9-FC88FA5B42EC@apple.com>
Date: Mon, 05 Mar 2018 12:18:58 -0800
In-reply-to: <26353964-066c-5664-1d67-6a79a3d21ac9@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-4-marcandre.lureau@redhat.com>
	<91D51528-C2CA-41DF-921F-DBD5C2EC028C@apple.com>
	<CAJ+F1C+sTmv7M8QU2vqfPWE2Zej_DxJQF8aVSH5pZC8pqo8OZw@mail.gmail.com>
	<26353964-066c-5664-1d67-6a79a3d21ac9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 3/7] HACK: HobLib: workaround
 infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>
Cc: edk2-devel <edk2-devel@lists.01.org>, QEMU <qemu-devel@nongnu.org>, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>



> On Mar 5, 2018, at 10:22 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 03/05/18 15:05, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Fri, Feb 23, 2018 at 8:45 PM, Andrew Fish <afish@apple.com> wrote:
>>>=20
>>>=20
>>>> On Feb 23, 2018, at 5:23 AM, marcandre.lureau@redhat.com wrote:
>>>>=20
>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>=20
>>>> Without this hack, GetNextHob() loops infinitely with the next
>>>> patch. I don't understand the reason.
>>>>=20
>>>> The loop is triggered by the GetFirstGuidHob (&gTpmErrorHobGuid)
>>>> call.
>>>>=20
>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>> Contributed-under: TianoCore Contribution Agreement 1.0
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>> MdePkg/Library/PeiHobLib/HobLib.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>=20
>>>> diff --git a/MdePkg/Library/PeiHobLib/HobLib.c =
b/MdePkg/Library/PeiHobLib/HobLib.c
>>>> index 5c0eeb992f..ed3c5fbd6d 100644
>>>> --- a/MdePkg/Library/PeiHobLib/HobLib.c
>>>> +++ b/MdePkg/Library/PeiHobLib/HobLib.c
>>>> @@ -89,6 +89,10 @@ GetNextHob (
>>>>    if (Hob.Header->HobType =3D=3D Type) {
>>>>      return Hob.Raw;
>>>>    }
>>>> +    if (GET_HOB_LENGTH (HobStart) =3D=3D 0) {
>>>=20
>>> As Laszlo points out this error condition is likely memory
>>> corruption. Thus it would be better to check for all know illegal
>>> values?
>>>=20
>>> if (GET_HOB_LENGTH(HobStart) < sizeof (EFI_HOB_GENERIC_HEADER)
>>>=20
>>=20
>> Thanks, I have adjusted the check.
>>=20
>> With manual calls and printf (I don't know  a better way to debug =
ovmf
>> ;),
>=20
> Well that's how I generally debug it too :)
>=20
>> I try to locate the issue. It's somehow related to
>> RegisterForShadow(). The "corruption" seems to happen during the
>> second call. After the
>> PeiLoadImage(...,PEIM_STATE_REGISTER_FOR_SHADOW,..), right before
>> calling PeimEntryPoint(), a GetFirstGuidHob() succeed, but inside the
>> function, it fails (with the same arguments). Right after it succeeds
>> again... The PeimEntryPoint() is not the Tcg2Pei:PeimEntryMA(), I
>> suppose there is some kind of wrapping code, but I fail to find =
where.
>> Any idea?
>=20
> This sounds helpful. I don't know what the problem is, but I can
> elaborate on your details a bit; perhaps someone else will have more
> ideas.
>=20
> Apparently there is a PEI service called RegisterForShadow().
> ("Apparently", because I've never seen, let alone written, a PEIM
> calling this service.) The service is specified in the PI spec, which =
is
> quoted in the edk2 tree [MdePkg/Include/Pi/PiPeiCis.h]:
>=20

In the "olden days" the PEI Core did not shadow PEIMs. There were a few =
PEIMs that had some hacky code to shadow themselves into memory. We =
thought of making it a library, but there was not a clean way to detect =
if the PEIM was shadowed. So we ended up adding the PEI Service. You =
could also use RegisterForShadow with a DEPEX of =
gEfiPeiMemoryDiscoveredPpiGuid to cause your PEIM to get shadowed even =
if the PEI Core did not support automatically shadowing PEIMs after =
memory showed up.=20

Anyway the RegisterForShadow can cause the entry point for the PEIM to =
get called again, and if there is a bug handling that I imagine bad =
things can happen.=20

There are plenty examples of RegisterForShadow usage in the edk2. Maybe =
looking at how other PEIMs are using it would be helpful.=20

(master)>git grep ".RegisterForShadow"
SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c:852:    Status =3D =
(**PeiServices).RegisterForShadow(FileHandle);
SecurityPkg/Tcg/TcgPei/TcgPei.c:776:    Status =3D =
(**PeiServices).RegisterForShadow(FileHandle);
SecurityPkg/Tcg/TrEEPei/TrEEPei.c:616:    Status =3D =
(**PeiServices).RegisterForShadow(FileHandle);
(master)>git grep "PeiServicesRegisterForShadow"
=
EmulatorPkg/Library/SecPeiServicesLib/PeiServicesLib.c:423:PeiServicesRegi=
sterForShadow (
FatPkg/FatPei/FatLiteApi.c:258:  Status =3D PeiServicesRegisterForShadow =
(FileHandle);
IntelFrameworkModulePkg/Bus/Isa/IsaFloppyPei/FloppyPeim.c:1725:  Status =
=3D PeiServicesRegisterForShadow (FileHandle);
MdeModulePkg/Bus/Pci/EhciPei/EhcPeim.c:1199:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Pci/IdeBusPei/AtapiPeim.c:44:  Status =3D =
PeiServicesRegisterForShadow (FileHandle);
MdeModulePkg/Bus/Pci/SdMmcPciHcPei/SdMmcPciHcPei.c:103:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Pci/UfsPciHcPei/UfsPciHcPei.c:92:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Pci/UhciPei/UhcPeim.c:121:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Pci/XhciPei/XhcPeim.c:1462:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Sd/EmmcBlockIoPei/EmmcBlockIoPei.c:693:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Sd/SdBlockIoPei/SdBlockIoPei.c:540:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Ufs/UfsBlockIoPei/UfsBlockIoPei.c:1147:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Usb/UsbBotPei/UsbBotPeim.c:96:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Bus/Usb/UsbBusPei/UsbPeim.c:140:  if (!EFI_ERROR =
(PeiServicesRegisterForShadow (FileHandle))) {
MdeModulePkg/Core/DxeIplPeim/DxeLoad.c:87:    Status =3D =
PeiServicesRegisterForShadow (FileHandle);
MdeModulePkg/Universal/Disk/CdExpressPei/PeiCdExpress.c:44:  if =
(!EFI_ERROR (PeiServicesRegisterForShadow (FileHandle))) {
MdePkg/Include/Library/PeiServicesLib.h:464:PeiServicesRegisterForShadow =
(
=
MdePkg/Library/PeiServicesLib/PeiServicesLib.c:474:PeiServicesRegisterForS=
hadow (
QuarkPlatformPkg/Platform/Pei/PlatformInit/PlatformEarlyInit.c:595:    =
PeiServicesRegisterForShadow (FileHandle);
QuarkSocPkg/QuarkSouthCluster/Usb/Ohci/Pei/OhcPeim.c:1302:  if =
(!EFI_ERROR (PeiServicesRegisterForShadow (FileHandle))) {
UefiCpuPkg/CpuIoPei/CpuIoPei.c:898:  Status =3D =
PeiServicesRegisterForShadow (FileHandle);


Thanks,

Andrew Fish


>> /**
>>  Register a PEIM so that it will be shadowed and called again.
>>=20
>>  This service registers a file handle so that after memory is
>>  available, the PEIM will be re-loaded into permanent memory and
>>  re-initialized. The PEIM registered this way will always be
>>  initialized twice. The first time, this function call will
>>  return EFI_SUCCESS. The second time, this function call will
>>  return EFI_ALREADY_STARTED. Depending on the order in which
>>  PEIMs are dispatched, the PEIM making this call may be
>>  initialized after permanent memory is installed, even the first
>>  time.
>>=20
>>  @param  FileHandle            PEIM's file handle. Must be the =
currently
>>                                executing PEIM.
>>=20
>>  @retval EFI_SUCCESS           The PEIM was successfully registered =
for
>>                                shadowing.
>>  @retval EFI_ALREADY_STARTED   The PEIM was previously
>>                                registered for shadowing.
>>  @retval EFI_NOT_FOUND         The FileHandle does not refer to a
>>                                valid file handle.
>>=20
>> **/
>> typedef
>> EFI_STATUS
>> (EFIAPI *EFI_PEI_REGISTER_FOR_SHADOW)(
>>  IN  EFI_PEI_FILE_HANDLE FileHandle
>>  );
>=20
> PEIMs generally "execute in place" (XIP), i.e. they run from flash, =
not
> RAM. In this status they use "temporary RAM" (e.g. CPU caches =
configured
> like RAM) for stack & heap; whatever HOBs they produce are stored in
> "temp RAM" as well. Then one of the PEIMs "discovers permanent RAM"
> (basically it programs the memory controller and publishes the RAM
> ranges). In turn the PEI core "migrates" PEIMs from temporary to
> permanent RAM, including the HOB list.
>=20
> Before the temporary RAM migration (when still executing in place from
> flash), PEIMs cannot have writeable global variables. For example,
> dynamic PCDs are also maintained in a HOB (the PCD HOB).
>=20
> A PEIM normally cannot (and shouldn't) tell whether it is dispatched
> before or after permanent RAM is published. If needed, a PEIM can
> advertise that it depends on permanent RAM (for example because it =
needs
> a lot of heap memory) by including "gEfiPeiMemoryDiscoveredPpiGuid" in
> its DEPEX.
>=20
> Finally, it seems like a PEIM can also express, "I'm fine with being
> dispatched from both flash (XIP) vs. permanent RAM, just the PEI core
> tell me whichever it is". Apparently, if the PEIM is dispatched from
> flash (before permanent RAM is available), its call to
> RegisterForShadow() returns EFI_SUCCESS (and then its entry point
> function will be invoked for a 2nd time, after the temp RAM =
migration).
> And when a PEIM is dispatched from RAM (either for the very first =
time,
> or for the second time, after being dispatched from flash first), the
> same call returns EFI_ALREADY_STARTED.
>=20
> Honestly, I'm unsure what this is good for (both in general, and
> specifically for Tcg2Pei). Apparently, Tcg2Pei needs permanent RAM for
> doing the measurements (which makes sense); I just wonder what exactly
> it does so that it cannot simply specify
> "gEfiPeiMemoryDiscoveredPpiGuid" in its DEPEX.
>=20
> I do see that the (!mImageInMemory) branch contains the TPM
> initialization code. However, as the PI spec itself says, it is not
> guaranteed that a PEIM will be dispatched from XIP (i.e., before
> permanent RAM) *at all*. So it's not clear to me how "business
> functionality" can depend on XIP.
>=20
>=20
> Now, OVMF is a bit different wrt. "memory controller programming" -- =
it
> runs on virtual platforms where programming the memory controllers is
> unnecessary. What happens is, instead, that only the SEC phase runs =
from
> flash (XIP), and it decompresses even the PEI firmware volume to =
normal
> RAM. The phase where PEIMs "run from flash" (XIP) still exists, of
> course, except they actually run from RAM -- so, for example, they =
have
> writeable global variables right off the bat. Perhaps this interferes
> somehow with the RegisterForShadow() service and/or how PEIMs expect
> that service to work.
>=20
> Regarding the PEIM entry point -- the PEIMs' "own" entry point =
functions
> are always wrapped.
>=20
> - The outermost (common) entry point function is called
>  _ModuleEntryPoint(). It is declared in
>  "MdePkg/Include/Library/PeimEntryPoint.h". This is what the PEI core
>  calls when dispatching a PEIM.
>=20
> - Individual PEIMs add the PeimEntryPoint lib class to their INF =
files,
>  under [LibraryClasses]. The implementation is in
>  "MdePkg/Library/PeimEntryPoint". In particular, the function calls
>  ProcessLibraryConstructorList().
>=20
> - The build tools generate the source code for
>  ProcessLibraryConstructorList(); based on the (recursively =
determined)
>  library instance dependency tree. (Search the Build subdirectory for
>  "AutoGen.c" files.) So, before the PEIM's actual entry point is
>  called, the lib instances' CONSTRUCTOR functions are called, in the
>  right order, so that the PEIM is entered with all libraries "ready to
>  use".
>=20
> I guess that, when Tcg2Pei is dispatched for the 2nd time, from
> permanent RAM, the first (successful) GetFirstGuidHob() call that you
> see occurs like this, from generated code, as part of library
> construction. Some library instance's constructor function calls
> GetFirstGuidHob(), successfully.
>=20
> The corruption could somehow be related to the HOB list's migration =
from
> temp RAM to permanent RAM. The OVMF debug log should contain something
> like this:
>=20
>> Temp Stack : BaseAddress=3D0x818000 Length=3D0x8000
>> Temp Heap  : BaseAddress=3D0x810000 Length=3D0x8000
>> Total temporary memory:    65536 bytes.
>>  temporary memory stack ever used:       28656 bytes.
>>  temporary memory heap used for HobList: 6056 bytes.
>>  temporary memory heap occupied by memory pages: 0 bytes.
>=20
> Implying that, before the temp RAM migration, the HOB list consumed =
~6KB
> in total of the 32KB temp RAM heap. It seems unlikely that we run out =
of
> temp RAM heap.
>=20
> Hopefully this helps you proceed with the debugging... Corrections are
> welcome too, obviously!
>=20
> Thanks,
> Laszlo
