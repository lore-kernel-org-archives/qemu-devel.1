Received: from eggs.gnu.org ([209.51.188.92]:49635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glXhU-00025i-V7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glXhT-0003t4-Tc
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:25:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glXhT-0003pN-Kq
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:25:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so22891647wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 03:25:07 -0800 (PST)
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9dc7319d-f383-e4e3-1750-115ae6c1d8eb@redhat.com>
Date: Mon, 21 Jan 2019 12:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190118223400.24311-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] roms: add the edk2 project as a git
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Cc'ing Daniel & Alex.

On 1/18/19 11:33 PM, Laszlo Ersek wrote:
> The roms/edk2 submodule can help with three goals:
> - build the OVMF and ArmVirtQemu virtual UEFI firmware platforms (to be
>   implemented later),
> - build the EfiRom tool on the fly, which is used in roms/Makefile, for
>   building the "efirom" target,
> - build UEFI test applications (to be run in guests), for qtest support.
> 
> Edk2 commit 85588389222a3636baf0f9ed8227f2434af4c3f9 stands for the latest
> "stable tag", namely "edk2-stable201811".
> 
> The edk2 repository tracks some binary files that should not be removed by
> QEMU's top-level "make clean"; exempt the full pathnames from the "find"
> command.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  Makefile    | 6 +++++-
>  .gitmodules | 3 +++
>  roms/edk2   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index dccba1dca27f..1f768e2bcf8f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -602,7 +602,11 @@ clean:
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>  	rm -f qemu-options.def
>  	rm -f *.msi
> -	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
> +	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> +		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \

Hmm I never try in-tree builds and thought this rule was for the
archived release out of git, so this wouldn't matter.

> +		-exec rm {} +
>  	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
> diff --git a/.gitmodules b/.gitmodules
> index 6b91176098c8..ceafb0ee29a0 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -49,3 +49,6 @@
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path = tests/fp/berkeley-softfloat-3
>  	url = https://github.com/cota/berkeley-softfloat-3
> +[submodule "roms/edk2"]
> +	path = roms/edk2
> +	url = https://github.com/tianocore/edk2.git

Indeed this is enough to build EfiRom.
However if you want to build firmwares (your patch 4/5), the submodule
is incomplete, until you manually run "submodule update --init --recursive".

I suggest the following change, Daniel/Alex what do you think?

-- >8 --
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 98ca0f2737..5441fe3385 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -71,7 +71,7 @@ update)
         exit 0
     fi

-    $GIT submodule update --init $modules 1>/dev/null
+    $GIT submodule update --init --recursive $modules 1>/dev/null
     test $? -ne 0 && error "failed to update modules"

     $GIT submodule status $modules > "${substat}"
---

> diff --git a/roms/edk2 b/roms/edk2
> new file mode 160000
> index 000000000000..85588389222a
> --- /dev/null
> +++ b/roms/edk2
> @@ -0,0 +1 @@
> +Subproject commit 85588389222a3636baf0f9ed8227f2434af4c3f9
> 
