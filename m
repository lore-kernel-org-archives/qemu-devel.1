Received: from eggs.gnu.org ([209.51.188.92]:51067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEEd2-0004CZ-2K
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEEd0-0008Pu-51
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hEEcz-0008OU-Qc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:55:06 -0400
References: <20190405153314.2068-1-philmd@redhat.com>
	<20190405153314.2068-3-philmd@redhat.com>
	<fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
	<20190410082554.6c595b3f.olaf@aepfle.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6746a549-3ebf-80f3-e67a-62e536aa06be@redhat.com>
Date: Wed, 10 Apr 2019 16:54:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190410082554.6c595b3f.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 04/10/19 08:25, Olaf Hering wrote:
> Am Mon, 8 Apr 2019 13:05:07 +0200
> schrieb Laszlo Ersek <lersek@redhat.com>:
>
>> Then build scripts could be updated to invoke:
>>
>>   make -C roms \
>>     EDK2_BASETOOLS_OPTFLAGS='...' \
>>     EDK2_BASETOOLS_LDFLAGS='...' \
>>     efirom
>
> The question remains: 'But why?'.

Because it lets you pass "-fno-pie" & friends.

> Why can edk2 not be built with '-fno-pie' right away?

Those flags are not universal across gcc/binutils versions.

Some gcc/binutils versions don't enable PIE to begin with.

Some gcc/binutils versions take different PIE-disablement flags
(considering both the compiler and the linker) from other gcc/binutils
versions.

For example, please refer to the following *iPXE* commit:

> commit 7c395b0e21806b946fe944a27fc273407f357ea1
> Author: Michael Brown <mcb30@ipxe.org>
> Date:   Wed Jun 14 12:33:16 2017 +0100
>
>     [build] Use -no-pie on newer versions of gcc
>
>     Some distributions patch gcc to generate position independent
>     executables by default.  We currently include a workaround to check
>     for this and to add -fno-PIE -nopie to CFLAGS if required.
>
>     Newer patched versions of gcc require -fno-PIE -no-pie instead.  Check
>     for both variants.
>
>     Reported-by: Nathan Rennie-Waldock <nathan.renniewaldock@gmail.com>
>     Originally-fixed-by: Markos Chandras <mchandras@suse.de>
>     Signed-off-by: Michael Brown <mcb30@ipxe.org>

(I remember this commit because the logic it had added actually failed
on a system that I used once for building iPXE -- it was an x86_64
system with both a native gcc, and a *different version*
x86_64-to-x86_64 *cross* gcc. The selection logic determined the flags
for the one compiler toolchain, but then passed the flags to the other
compiler toolchain. The build broke. I narrowed it down to the above
commit, and then shrugged it off; it wasn't important enough to spend
more time on it.)

I also refer you to the following *edk2* commit:

> commit 11d0cd23dd1bc15a6e6a1598250ea2e0c4c36e9a
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Mon Jun 18 10:23:49 2018 +0200
>
>     BaseTools/tools_def IA32: drop -no-pie linker option for GCC49
>
>     As reported by Liming, GCC 4.9.2 does not support the -no-pie
>     linker option that we added to the GCC49 and GCC5 toolchain
>     profiles in commit c25d3905523a ("BaseTools/tools_def IA32:
>     disable PIE code generation explicitly") to work around issues
>     with recent distro toolchains that enable PIE code generation
>     by default.
>
>     So rollback the changes for GCC49 but preserve them for GCC5
>
>     Contributed-under: TianoCore Contribution Agreement 1.1
>     Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     Acked-by: Laszlo Ersek <lersek@redhat.com>

The above facility will let you stuff the options into the edk2
BaseTools build, in your downstream qemu.spec file, that match your
downstream gcc/binutils version.

Most build hosts will need no flags.

> Did noone approach the edk2 developers yet that their buildsystem is
> broken in that regard?

Well, have you?

I don't remember anyone else reporting such an issue yet, on edk2-devel
or elsewhere, with building BaseTools. I certainly remember
collaborating with Gary Lin from SUSE on various stuff, but not this.

You are welcome to file a bug at <https://bugzilla.tianocore.org/>.
Please pick "EDK2" for "Product", "Code" for "Component", and
"BaseTools" for "Package".

... Please don't try to force a "zero build-interface changes" policy on
upstream, just so you can avoid a small tweak in a downstream build
script when you rebase. Not even the gcc/binutils command lines conform
to that. We all hope downstream rebases to be painless, and upstreams do
strive to help with that, but the downstream rebase experience is never
*entirely* painless (or automated).

Thanks,
Laszlo
