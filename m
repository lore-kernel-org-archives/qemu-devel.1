Received: from eggs.gnu.org ([2001:4830:134:3::10]:34380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK1Pf-0001j9-1j
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK1OU-0005ib-9q
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:27:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK1OT-0004on-Qr
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:27:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so11845359wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 05:27:38 -0800 (PST)
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-4-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <985ac802-2b0c-d81e-ca9c-636300a413a3@redhat.com>
Date: Tue, 6 Nov 2018 14:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181105181353.39804-4-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 03/33] configure: Rename FILES variable to
 LINKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 5/11/18 19:14, Michael S. Tsirkin wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> The FILES variable is used to accumulate a list of things to symlink
> from the source tree into the build tree.  These don't have to be
> individual files; symlinking an entire directory of data files is
> also fine.  Rename it to something less confusing before we add a few
> directories to it.
> 
> Improve the comment to clarify what DIRS and LINKS do and why
> it's not a good idea to add things to LINKS with wildcarding.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Again, I reviewed/tested this patch.

> ---
>   configure | 35 ++++++++++++++++++++++-------------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/configure b/configure
> index bfdca8b814..52408ed307 100755
> --- a/configure
> +++ b/configure
> @@ -7392,22 +7392,31 @@ if test "$ccache_cpp2" = "yes"; then
>     echo "export CCACHE_CPP2=y" >> $config_host_mak
>   fi
>   
> -# build tree in object directory in case the source is not in the current directory
> +# If we're using a separate build tree, set it up now.
> +# DIRS are directories which we simply mkdir in the build tree;
> +# LINKS are things to symlink back into the source tree
> +# (these can be both files and directories).
> +# Caution: do not add files or directories here using wildcards. This
> +# will result in problems later if a new file matching the wildcard is
> +# added to the source tree -- nothing will cause configure to be rerun
> +# so the build tree will be missing the link back to the new file, and
> +# tests might fail. Prefer to keep the relevant files in their own
> +# directory and symlink the directory instead.
>   DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>   DIRS="$DIRS tests/fp"
>   DIRS="$DIRS docs docs/interop fsdev scsi"
>   DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>   DIRS="$DIRS roms/seabios roms/vgabios"
> -FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
> -FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
> -FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
> -FILES="$FILES tests/fp/Makefile"
> -FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
> -FILES="$FILES pc-bios/spapr-rtas/Makefile"
> -FILES="$FILES pc-bios/s390-ccw/Makefile"
> -FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
> -FILES="$FILES pc-bios/qemu-icon.bmp"
> -FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
> +LINKS="Makefile tests/tcg/Makefile qdict-test-data.txt"
> +LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
> +LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
> +LINKS="$LINKS tests/fp/Makefile"
> +LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
> +LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
> +LINKS="$LINKS pc-bios/s390-ccw/Makefile"
> +LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
> +LINKS="$LINKS pc-bios/qemu-icon.bmp"
> +LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
>   for bios_file in \
>       $source_path/pc-bios/*.bin \
>       $source_path/pc-bios/*.lid \
> @@ -7419,10 +7428,10 @@ for bios_file in \
>       $source_path/pc-bios/u-boot.* \
>       $source_path/pc-bios/palcode-*
>   do
> -    FILES="$FILES pc-bios/$(basename $bios_file)"
> +    LINKS="$LINKS pc-bios/$(basename $bios_file)"
>   done
>   mkdir -p $DIRS
> -for f in $FILES ; do
> +for f in $LINKS ; do
>       if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
>           symlink "$source_path/$f" "$f"
>       fi
> 
