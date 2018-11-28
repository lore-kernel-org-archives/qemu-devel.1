Received: from eggs.gnu.org ([2001:4830:134:3::10]:56967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gS1JH-0001zn-H2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gS1JC-00059s-Ed
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:59:27 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:40724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gS1J3-00051J-Ky
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:59:17 -0500
References: <20181127145043.18545-1-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <c23486c2-e55e-4b88-7a70-76a77f6de1eb@weilnetz.de>
Date: Wed, 28 Nov 2018 15:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181127145043.18545-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] configure: Disable the nanoMIPS
 disassembler on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Am 27.11.2018 um 15:50 schrieb Philippe Mathieu-Daud=C3=A9:
> Stefan noticed the nanoMIPS disassembler uses incorrect format strings
> on big endian hosts.
>
> On big endian hosts, the output will appear as:
>
> $ qemu-system-mipsel -M malta -cpu I7200 -semihosting \
>   -bios nanoboot.bin -d in_asm
> 0xbfc0000: Asm output not supported on this arch
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 0a3c6a72c3..83a7c4746e 100755
> --- a/configure
> +++ b/configure
> @@ -7382,7 +7382,11 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>    mips*)
>      disas_config "MIPS"
>      if test -n "${cxx}"; then
> -      disas_config "NANOMIPS"
> +      # The nanomips disassembler currently does not work correctly
> +      # on big endian host.
> +      if test "$bigendian" =3D "no" ; then
> +        disas_config "NANOMIPS"
> +      fi
>      fi
>    ;;
>    moxie*)


Thank you. This looks like a patch which might be acceptable for 3.1.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
