Received: from eggs.gnu.org ([209.51.188.92]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqhSC-0007jH-80
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqhSA-0005hU-BT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:50:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqhS6-0005d9-93
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:50:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so638891wml.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 08:50:27 -0800 (PST)
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <87310497-8360-f6ab-8671-c20ac14242c1@redhat.com>
Date: Mon, 4 Feb 2019 17:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190204160325.4914-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] roms: add the edk2 project as a git
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 2/4/19 5:03 PM, Laszlo Ersek wrote:
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
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Already reviewed v2 ;)
https://www.mail-archive.com/qemu-devel@nongnu.org/msg592311.html

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v3:
>     - no change
>     
>     v2:
>     - pick up R-b [Gerd]
> 
>  Makefile    | 6 +++++-
>  .gitmodules | 3 +++
>  roms/edk2   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 1278a3eb5293..e55bb7255ad8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -607,7 +607,11 @@ clean:
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>  	rm -f qemu-options.def
>  	rm -f *.msi
> -	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
> +	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> +		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
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
> diff --git a/roms/edk2 b/roms/edk2
> new file mode 160000
> index 000000000000..85588389222a
> --- /dev/null
> +++ b/roms/edk2
> @@ -0,0 +1 @@
> +Subproject commit 85588389222a3636baf0f9ed8227f2434af4c3f9
> 
