Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjNJ-0006WO-Da
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjNE-0006r9-D4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:08:17 -0400
References: <cover.1489462214.git.sam.bobroff@au1.ibm.com>
	<0dee8b2e5316bf53099a530f8e9ea83a4c21507e.1489462214.git.sam.bobroff@au1.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc905f5e-e32b-f139-a8af-66b9961feb0a@redhat.com>
Date: Tue, 14 Mar 2017 11:08:08 +0100
MIME-Version: 1.0
In-Reply-To: <0dee8b2e5316bf53099a530f8e9ea83a4c21507e.1489462214.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/1]
 scripts/update-linux-headers.sh: refactor extra files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, paulus@ozlabs.org, peter.maydell@linaro.org



On 14/03/2017 04:30, Sam Bobroff wrote:
> update-linux-headers.sh now has enough code in it to suggest some
> refactoring. Parameterize some of it to make adding new files a bit
> easier.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  scripts/update-linux-headers.sh | 44 ++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 6a370a8669..49366103e1 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -82,33 +82,37 @@ for arch in $ARCHLIST; do
>      fi
>  
>      make -C "$linux" INSTALL_HDR_PATH="$tmpdir" $arch_var=$arch headers_install
> +    ARCH_EXTRA=
> +    ARCH_STD_EXTRA=
> +    case "$arch" in
> +        arm)
> +            ARCH_EXTRA="unistd-eabi.h unistd-oabi.h unistd-common.h"
> +            ;;
> +        powerpc)
> +            ARCH_EXTRA=epapr_hcalls.h
> +            ;;
> +        s390)
> +            ARCH_STD_EXTRA="kvm_virtio.h virtio-ccw.h"
> +            ;;
> +        x86)
> +            ARCH_EXTRA="unistd_32.h unistd_x32.h unistd_64.h"
> +            ARCH_STD_EXTRA="hyperv.h"
> +            ;;
> +    esac
>  
>      rm -rf "$output/linux-headers/asm-$arch"
>      mkdir -p "$output/linux-headers/asm-$arch"
> -    for header in kvm.h kvm_para.h unistd.h; do
> -        cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
> +    for header in kvm.h kvm_para.h unistd.h $ARCH_EXTRA; do
> +        cp "$tmpdir/include/asm/$header" \
> +           "$output/linux-headers/asm-$arch/"
>      done
> -    if [ $arch = powerpc ]; then
> -        cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
> -    fi
>  
>      rm -rf "$output/include/standard-headers/asm-$arch"
>      mkdir -p "$output/include/standard-headers/asm-$arch"
> -    if [ $arch = s390 ]; then
> -        cp_portable "$tmpdir/include/asm/kvm_virtio.h" "$output/include/standard-headers/asm-s390/"
> -        cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
> -    fi
> -    if [ $arch = arm ]; then
> -        cp "$tmpdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
> -        cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
> -        cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
> -    fi
> -    if [ $arch = x86 ]; then
> -        cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/standard-headers/asm-x86/"
> -        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
> -        cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
> -        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
> -    fi
> +    for header in $ARCH_STD_EXTRA; do
> +        cp_portable "$tmpdir/include/asm/$header" \
> +                    "$output/include/standard-headers/asm-$arch/"
> +    done
>  done
>  
>  rm -rf "$output/linux-headers/linux"
> 

Looks better indeed, thanks!

Paolo
