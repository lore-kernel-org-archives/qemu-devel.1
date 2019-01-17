Received: from eggs.gnu.org ([209.51.188.92]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9VK-0005hZ-Qt
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9VI-0001wT-W8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gk9VI-0001PV-ML
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:22:48 -0500
Date: Thu, 17 Jan 2019 16:22:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190117162231.54f0aea8@redhat.com>
In-Reply-To: <0e39924a-064b-b4fd-dad6-57aac29e8ea7@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
	<20190116113227.47ebdea2@redhat.com>
	<314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
	<b69a850b-35a4-6258-051d-573a2970e409@redhat.com>
	<20190116132046.042a99ae@redhat.com>
	<0e39924a-064b-b4fd-dad6-57aac29e8ea7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On Wed, 16 Jan 2019 17:17:23 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/16/19 13:20, Igor Mammedov wrote:
> > On Wed, 16 Jan 2019 12:09:03 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:  
> >> On 01/16/19 12:07, Laszlo Ersek wrote:  
> 
> >>> In particular, for this approach, we don't even need gnu-efi. (Because,
> >>> personally, I would strongly prefer to write the UEFI application with
> >>> the edk2 framework.) For a while now, edk2 has supported "multiple
> >>> workspaces":
> >>>
> >>> https://github.com/tianocore/tianocore.github.io/wiki/Multiple_Workspace
> >>>
> >>> and as a result, it is possible to build the necessary UEFI app from:
> >>> - an edk2 checkout that the maintainer has "somewhere" on their disk,
> >>> - and the UEFI app source code that is contained in a QEMU checkout that
> >>> the maintainer has "somewhere else" on their disk.
> >>>
> >>> This approach allows the UEFI app source to live in the QEMU tree, and
> >>> the affected maintainer(s) would be personally responsible for setting
> >>> up their edk2 clones, and compilers. (The edk2 clone could even be a
> >>> submodule of QEMU, for example at roms/edk2.) For example,
> >>> "roms/Makefile" already calls an external EFIROM utility (also from
> >>> edk2) in order to build the combined iPXE option ROMs.
> >>>
> >>> And yes, we could turn the UEFI binaries into bootable ISO images at once.
> >>>
> >>> I'll try to post some patches soon (or not so soon). I think the app's
> >>> source code, and the edk2 submodule, should live under roms/, and the
> >>> bootable images should live under pc-bios/.
> >>>
> >>> (In fact we could use this opportunity to build & bundle OVMF itself...
> >>> not sure if that's in scope for now. Gerd, what's your take?)    
> 
> >> Oh, I should add: the UEFI app in question could be built without
> >> pulling in any OpenSSL bits; OVMF itself can't be built like that (it
> >> now has a hard dependency on OpenSSL). This might matter from a
> >> licensing/bundling perspective.  
> 
> > That's why I've suggested non EDK2 variant, as we don't need very much
> > from it and its license looks BDS like and it's very simple to build
> > pretty much for everyone.
> > Dealing with EDK2 to rebuild EFI is rather daunting prospect
> > (at least from my point of view so I'd try to avoid it if possible)  
> 
> Writing the app against edk2 is a lot simpler for me, and I have working
> experience with cross-compiling edk2 stuff from x86_64 to aarch64 as well.
> 
> OTOH I have zero experience with gnu-efi, especially when it comes to
> cross-compilation. System-level gnu-efi packages don't offer cross-built
> binaries anyway, so we can't get around a git submodule -- whether it's
> gnu-efi or edk2, we have to build from source.
> 
> And once we have a git submodule, I can put all the build commands in a
> simple shell script.
> 
> Regarding OpenSSL, the edk2 metafiles for the EFI app will make it
> evident that OpenSSL is not used. OpenSSL is anyway a git submodule of
> edk2, so if *that* submodule is not inited -- which you can verify --,
> then any OpenSSL references would fail to build. The resultant UEFI
> binary will be covered by the 2-clause BSDL (from core edk2) and
> whatever license we choose for the UEFI app itself (could be BSDL, could
> be GPL, as you prefer).
> 
> Obviously I'm willing to take on maintenance for the EFI app and the
> build script, if that works for you.
That works for me too, it would be better if anyone would be able to do
rebuild as well (i.e. some in tree magic script/make target that would
do rebuild when it's executed and ask for necessary deps if something
is missing)

> I understand the point of gnu-efi, but it's just unbearably limiting,
> relative to the goodies in edk2.
The project I've pointed out is gnu-efi less (it borrowed some linking magic
and some protocol definitions from gnu-efi), so it's even more limited
but we do not need even most of what it provides. So I was thinking that
would benefit you and a random contributor as well.


> Thanks,
> Laszlo
