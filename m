Received: from eggs.gnu.org ([209.51.188.92]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gk3eg-0006fJ-EC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gk3ec-0003pU-BL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:08:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gk3ec-0003p2-11
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:08:02 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
	<20190116132953.404247ec@redhat.com>
	<20190116110052-mutt-send-email-mst@kernel.org>
	<d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
Message-ID: <979f490a-f316-fb4b-b4fb-3ef563882b8d@redhat.com>
Date: Thu, 17 Jan 2019 09:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: acpi: add AVMF firmware blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 01/17/19 09:53, Laszlo Ersek wrote:
> Hello Michael,
> 
> On 01/16/19 17:01, Michael S. Tsirkin wrote:
>> On Wed, Jan 16, 2019 at 01:29:53PM +0100, Igor Mammedov wrote:
>>> On Tue, 15 Jan 2019 21:47:49 +0100
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>>> On 01/15/19 16:41, Igor Mammedov wrote:
>>>>> Add firmware blobs built with PcdAcpiTestSupport=TRUE,
>>>>> that puts RSDP address in RAM after 1Mb aligned GUID
>>>>>   AB87A6B1-2034-BDA0-71BD-375007757785
>>>>> so that tests could scan and find it in RAM once firmware's
>>>>> initialized ACPI tables.
>>>>>
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>>  Makefile              |   3 ++-
>>>>>  pc-bios/avmf.img      | Bin 0 -> 2097152 bytes
>>>>>  pc-bios/avmf_vars.img | Bin 0 -> 786432 bytes
>>>>>  3 files changed, 2 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 pc-bios/avmf.img
>>>>>  create mode 100644 pc-bios/avmf_vars.img  
>>>>
>>>> "AVMF" is not a great name. "AAVMF" is a downstream name alright, but
>>>> many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
>>>> would be more precise, but those are verbose. Sigh, why are names so
>>>> hard. What does everyone think?
>>> I'm fine with either version.
>>>  
>>>> Also, do you have to care about the license of firmware images built
>>>> from edk2 when bundling such images? Since edk2 commit 9a67ba261fe9
>>>> ("ArmVirtPkg: Replace obsoleted network drivers from platform DSC/FDF.",
>>>> 2018-12-14), you cannot build the ArmVirtQemu (aka AAVMF) firmware
>>>> without OpenSSL. Thus, the resultant license is 2-BSDL + OpenSSL -- for
>>>> now anyway.
>>>>
>>>> Because, in the near future, that might change again. edk2 is in the
>>>> process of moving to Apache-2.0, and OpenSSL will also move (AFAICT) to
>>>> Apache-2.0 starting with release 3.0.0. (See commit 151333164ece,
>>>> "Change license to the Apache License v2.0", 2018-12-06.)
>>> That's another reason to look into EFI app approach (a simple one without
>>> dependencies) ans let distro to provide firmware image.
>>
>> That will mean supporting very old firmware with the app.
>> I'm all for the EFI app approach for modularity
>> but I think we should include the batteries with this toy.
> 
> There are two approaches here. (Both require that edk2 be present in the
> QEMU source tree as a submodule, and both require QEMU to receive a
> script for building edk2 in *some* way.)
> 
> 
> (1) Carry the bios-tables-test helper UEFI app as an "out of tree"
> module, from the perspective of edk2; carry it natively in the QEMU tree.
> 
> * Edk2 supports this use case as a first class citizen.
> 
> * In this case, the UEFI application is permitted to link only such
> libraries from edk2 that the resultant binary inherit no platform
> dependencies. The app can only be made dependent on a minimum UEFI spec
> release, if necessary. The resultant binary can be run on any conformant
> UEFI implementation, including physical hardware.
> 
> An example for "platform dependency prohibition" is that the X64 build
> of the app could not print debug messages to the QEMU debug port (like
> the rest of OVMF does), only to the UEFI console. On OVMF, that console
> would direct the debug messages to the serial port and the graphics card.
> 
> Regarding a minimum UEFI spec release, the oldest UEFI spec I have on my
> disk is "2.3.1, Errata C", dated "June 27, 2012". I'm not aware of
> anything in the helper app that requires more recent spec features.
> 
> * Should we have to extend the UEFI app with a feature, we could easily
> do that in sync with the consumer QEMU test code.
> 
> * The build output to commit to the QEMU repo would be an ISO image
> containing the UEFI binary as a "boot loader". It would not contain
> OpenSSL bits. The derived license would be a combination of core edk2's
> license and our out-of-edk2-module's license.
> 
> 
> (2) Carry the bios-tables-test helper *functionality* (not necessarily a
> standalone UEFI application) in edk2; add a custom build flag to the
> OVMF and ArmVirtQemu firmware platforms to enable the helper functionality.
> 
> * In this case, the test helper logic is permitted to rely on platform
> internals. For example, on X64, it could print debug messages to the
> QEMU debug port, like the rest of OVMF does.
> 
> * Whenever a new feature became necessary, edk2 would get new patches,
> then QEMU would bump the submodule commit reference accordingly.
> 
> * The build output to commit to the QEMU repo would be a custom firmware
> image (built with the special build flag mentioned above), and no other
> bootable media would be formatted / saved. The custom firmware image
> would contain OpenSSL bits. The image's license would be derived from
> edk2 and from the OpenSSL submodule used by edk2.
> 
> * Also, the custom firmware image would not be suitable for "production"
> use, so it couldn't be at once bundled under pc-bios as well -- that
> would remain a separate RFE.
> 
> 
> Since last night, I have some rough patches for (1), including the
> QEMU-side Makefile + build script.
> 
> Regarding (2), I also have the edk2-native code ready (I had posted it a
> few weeks back -- that's what Igor used now). For the QEMU side of
> approach (2), I reckon I could reuse most of the build script I already
> have for (1).
> 
> Could we please decide for (1) vs (2), before I put more work into (1)?

Sorry, borked English, I meant "decide between (1) and (2)". I didn't
intend to express a preference (I don't have one).

Thanks,
Laszlo
