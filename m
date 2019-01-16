Received: from eggs.gnu.org ([209.51.188.92]:48683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjj2m-0004pw-Dm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjj2k-0007N5-Cy
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:07:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gjj2i-000739-GE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:07:33 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
	<20190116113227.47ebdea2@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
Date: Wed, 16 Jan 2019 12:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190116113227.47ebdea2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

+Gerd

On 01/16/19 11:32, Igor Mammedov wrote:
> On Tue, 15 Jan 2019 21:31:54 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 01/15/19 16:41, Igor Mammedov wrote:
>>> once FW provides a pointer to SMBIOS entry point like it does for
>>> RSDP it should be possible to enable this one the same way.  
>>
>> Good point, I didn't think of SMBIOS.
>>
>> We have the following options:
>>
>> (1) Use just one "test support" structure, and add more fields (such as
>> the SMBIOS entry point) to it, beyond the RSDP1.0/RSDP2.0. For this, we
>> should also introduce a "size" field to the table, so we don't have to
>> extend the table between firmware and QEMU in lock-step.
>>
>> (2) Use a different table (with a different GUID) for exposing the
>> SMBIOS entry point.
>>
>> On the firmware side, (1) would be more work now, but it would keep
>> things simpler (and better separated) in the future. (2) would be more
>> lazy ^W convenient now, but it would introduce more churn / possibly
>> some code duplication in the future.
>>
>> In QEMU, which one would you prefer?
> I'd prefer #1 to minimize # of memory scans.
> However with size (i.e. implicit versioning) and who know what else in
> the future complexity grows up and dependency this approach causes
> between firmware and QEMU (I dislike special build instead of reusing
> shipped images).
> 
> So I've dug a little bit into the history why we've chosen including
> structure into the firmware itself instead of writing EFI application
> as part of QEMU that would provide the same test structure but won't
> require special firmware build.
> If I sum it up, it was issue with distros are shipping (if they do it at all)
> only a version that matches distro's architecture and a need for cross
> compiling EFI test app.
> 
> Could we revisit EFI app approach (I'd prefer it over firwmare hack if it's
> possible)? We can try to avoid dependency on gnu-efi and cross compiling on
> regular builds and ship along with efi app source code several prebuild app
> binaries (boot disk images), that one would rebuild only when efi app
> is changed, and it could be done manually (the same like special fw build
> but contained withing QEMU). As for gnu-efi, is it possible to use striped
> down gnu-efi stubs to drop external library dependency, something along of
> lines https://github.com/tqh/efi-example ?

If it is permissible to require the affected QEMU maintainers to
*manually* rebuild the UEFI binary on their workstations, whenever the
source code for the UEFI app changes, then the solution is a lot easier
indeed.

In particular, for this approach, we don't even need gnu-efi. (Because,
personally, I would strongly prefer to write the UEFI application with
the edk2 framework.) For a while now, edk2 has supported "multiple
workspaces":

https://github.com/tianocore/tianocore.github.io/wiki/Multiple_Workspace

and as a result, it is possible to build the necessary UEFI app from:
- an edk2 checkout that the maintainer has "somewhere" on their disk,
- and the UEFI app source code that is contained in a QEMU checkout that
the maintainer has "somewhere else" on their disk.

This approach allows the UEFI app source to live in the QEMU tree, and
the affected maintainer(s) would be personally responsible for setting
up their edk2 clones, and compilers. (The edk2 clone could even be a
submodule of QEMU, for example at roms/edk2.) For example,
"roms/Makefile" already calls an external EFIROM utility (also from
edk2) in order to build the combined iPXE option ROMs.

And yes, we could turn the UEFI binaries into bootable ISO images at once.

I'll try to post some patches soon (or not so soon). I think the app's
source code, and the edk2 submodule, should live under roms/, and the
bootable images should live under pc-bios/.

(In fact we could use this opportunity to build & bundle OVMF itself...
not sure if that's in scope for now. Gerd, what's your take?)

Thanks,
Laszlo
