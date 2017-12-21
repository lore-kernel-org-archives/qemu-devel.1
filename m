Received: from eggs.gnu.org ([2001:4830:134:3::10]:55830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxdq-0001W7-5S
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxdl-0006N0-7z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:59:54 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:56987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRxdk-0006L6-TR
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:59:49 -0500
References: <20171220212308.12614-1-michael.weiser@gmx.de>
	<20171220212308.12614-7-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <03fd5dae-4835-c679-f38b-96cfd84ed31c@vivier.eu>
Date: Thu, 21 Dec 2017 10:59:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171220212308.12614-7-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] linux-user: Separate binfmt arm CPU
 families
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 20/12/2017 à 22:23, Michael Weiser a écrit :
> Give big-endian arm and aarch64 CPUs their own family in
> qemu-binfmt-conf.sh to make sure we register qemu-user for binaries of
> the opposite endianness on arm and aarch64. Apart from the family
> assignments of the magic vales, qemu_get_family() needs to be able to
> distinguish the two and recognise aarch64{,_be} as well.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  scripts/qemu-binfmt-conf.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index d69953525c..597efdbe50 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -24,7 +24,7 @@ arm_family=arm
>  
>  armeb_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28'
>  armeb_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> -armeb_family=arm
> +armeb_family=armeb
>  
>  sparc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x02'
>  sparc_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> @@ -94,7 +94,7 @@ aarch64_family=arm
>  
>  aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7'
>  aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> -aarch64_be_family=arm
> +aarch64_be_family=armeb
>  
>  hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
>  hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> @@ -115,9 +115,12 @@ qemu_get_family() {
>      ppc64el|ppc64le)
>          echo "ppcle"
>          ;;
> -    arm|armel|armhf|arm64|armv[4-9]*)
> +    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
>          echo "arm"
>          ;;
> +    armeb|armv[4-9]*b|aarch64_be)
> +        echo "armeb"
> +        ;;
>      sparc*)
>          echo "sparc"
>          ;;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
