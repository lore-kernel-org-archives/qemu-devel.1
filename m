Received: from eggs.gnu.org ([208.118.235.92]:39272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gfQI3-0005Ps-Ps
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gfQI2-0002dZ-Qf
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:17:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gfQI2-0002Yi-LS
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:17:34 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so30443020oia.4
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:17:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190104082731.24967-2-pbonzini@redhat.com>
References: <20190104082731.24967-1-pbonzini@redhat.com>
	<20190104082731.24967-2-pbonzini@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 4 Jan 2019 15:17:22 +0100
Message-ID: <CAL1e-=g24zvWnWfB6dyLqLfBLB8mn=pmuSP3gsRX2qBqc7kiyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/update-linux-headers.sh:
 adjust for Linux 4.21-rc1 (or 5.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>

On Friday, January 4, 2019, Paolo Bonzini <pbonzini@redhat.com> wrote:

> There are three new indirect inclusions: vhost_types.h, which we'll
> shortly put to use as a portable header and thus is copied to
> standard-headers; and new per-subtarget versions of MIPS unistd.h
> and PowerPC unistd.h.
>
> Because vhost.h includes vhost_types.h, we also need a proxy include
> from linux/vhost.h to standard-headers.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)


For MIPS parts:

 Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-
> headers.sh
> index 0a964fe240..c933489cbc 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -101,6 +101,13 @@ for arch in $ARCHLIST; do
>
>      if [ $arch = mips ]; then
>          cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-
> mips/"
> +        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-
> mips/"
> +        cp "$tmpdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-
> mips/"
> +        cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-
> mips/"
> +    fi
> +    if [ $arch = powerpc ]; then
> +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-
> powerpc/"
> +        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-
> powerpc/"
>      fi
>
>      rm -rf "$output/include/standard-headers/asm-$arch"
> @@ -162,6 +169,9 @@ EOF
>  cat <<EOF >$output/linux-headers/linux/virtio_ring.h
>  #include "standard-headers/linux/virtio_ring.h"
>  EOF
> +cat <<EOF >$output/linux-headers/linux/vhost_types.h
> +#include "standard-headers/linux/vhost_types.h"
> +EOF
>
>  rm -rf "$output/include/standard-headers/linux"
>  mkdir -p "$output/include/standard-headers/linux"
> @@ -171,6 +181,7 @@ for i in "$tmpdir"/include/linux/*virtio*.h \
>           "$tmpdir/include/linux/input-event-codes.h" \
>           "$tmpdir/include/linux/pci_regs.h" \
>           "$tmpdir/include/linux/ethtool.h" "$tmpdir/include/linux/kernel.h"
> \
> +         "$tmpdir/include/linux/vhost_types.h" \
>           "$tmpdir/include/linux/sysinfo.h"; do
>      cp_portable "$i" "$output/include/standard-headers/linux"
>  done
> --
> 2.20.1
>
>
>
>
