Received: from eggs.gnu.org ([209.51.188.92]:54022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpEdb-00037Y-Fl
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpEdY-0004W5-99
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:52:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpEdU-0004Uo-8t
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:52:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so3139674wmt.0
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:52:14 -0800 (PST)
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6701f7f1-78be-9979-9da8-75449d480428@redhat.com>
Date: Thu, 31 Jan 2019 16:52:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190124203959.30875-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] roms: add the edk2 project as a git
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

On 1/24/19 9:39 PM, Laszlo Ersek wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v2:
>     - pick up R-b [Gerd]
> 
>  Makefile    | 6 +++++-
>  .gitmodules | 3 +++
>  roms/edk2   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index de898eab6234..b0a70b2929ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -604,7 +604,11 @@ clean:
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
