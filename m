Received: from eggs.gnu.org ([2001:4830:134:3::10]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezQeF-00067j-K0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezQeB-0002i9-Ea
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:38:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezQeB-0002hs-8X
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:38:35 -0400
Date: Fri, 23 Mar 2018 17:38:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180323173823.GD17165@work-vm>
References: <1521579652-180248-1-git-send-email-mst@redhat.com>
	<1521579652-180248-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521579652-180248-2-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] update-linux-headers.sh: add
 unistd.h and kvm on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, James Hogan <jhogan@kernel.org>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> Rework the update script slightly, add the unistd.h header and its
> dependencies on all architectures.
> 
> This also removes the IA64 and MIPS from a KVM blacklist:
> Linux dropped IA64, and there was never a reason to
> exclude MIPS from kvm specifically - it was
> excluded due to dependency of its unistd.h on sgidefs.h,
> which we also import.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index d18e2f1..2a4dac8a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -80,11 +80,6 @@ for arch in $ARCHLIST; do
>          continue
>      fi
>  
> -    # Blacklist architectures which have KVM headers but are actually dead
> -    if [ "$arch" = "ia64" -o "$arch" = "mips" ]; then
> -        continue
> -    fi
> -
>      if [ "$arch" = x86 ]; then
>          arch_var=SRCARCH
>      else
> @@ -95,9 +90,18 @@ for arch in $ARCHLIST; do
>  
>      rm -rf "$output/linux-headers/asm-$arch"
>      mkdir -p "$output/linux-headers/asm-$arch"
> -    for header in kvm.h kvm_para.h unistd.h; do
> +    for header in unistd.h bitsperlong.h; do
> +        cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
> +    done
> +
> +    for header in kvm.h kvm_para.h; do
>          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
>      done
> +
> +    if [ $arch = mips ]; then
> +        cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
> +    fi
> +
>      if [ $arch = powerpc ]; then
>          cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
>      fi
> @@ -120,6 +124,10 @@ EOF
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
>      fi
> +    if [ $arch = s390 ]; then
> +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-arm/"
> +        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm/"

That doesn't look right - I'm guessing that should be copying into
asm-s390 ?

Dave

> +    fi
>  done
>  
>  rm -rf "$output/linux-headers/linux"
> @@ -130,7 +138,7 @@ for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
>  done
>  rm -rf "$output/linux-headers/asm-generic"
>  mkdir -p "$output/linux-headers/asm-generic"
> -for header in kvm_para.h; do
> +for header in kvm_para.h bitsperlong.h unistd.h; do
>      cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
>  done
>  if [ -L "$linux/source" ]; then
> -- 
> MST
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
