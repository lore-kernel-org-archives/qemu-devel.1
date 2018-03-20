Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyL06-0000Nv-95
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyL05-00072a-9F
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:24:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyL05-000727-47
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:24:41 -0400
Received: by mail-oi0-x243.google.com with SMTP id a16-v6so1974411oia.13
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 10:24:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521566230-111929-2-git-send-email-mst@redhat.com>
References: <1521566230-111929-1-git-send-email-mst@redhat.com>
	<1521566230-111929-2-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 17:24:20 +0000
Message-ID: <CAFEAcA-mpWJf6e05Q-_5+Pfh_-Ae2vnbYM+C9bdyYQe_1Sxq9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] update-linux-headers.sh: add
 unistd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20 March 2018 at 17:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> Add the header and its dependencies.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index d18e2f1..e528bda 100755
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
> @@ -95,9 +90,17 @@ for arch in $ARCHLIST; do
>
>      rm -rf "$output/linux-headers/asm-$arch"
>      mkdir -p "$output/linux-headers/asm-$arch"
> -    for header in kvm.h kvm_para.h unistd.h; do
> +    for header in unistd.h bitsperlong.h; do
>          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
>      done
> +
> +    # Blacklist architectures which have KVM headers but are actually dead
> +    if [ "$arch" != "ia64" -a "$arch" != "mips" ]; then

We don't need to blacklist ia64 here, beacues it doesn't have the kvm
headers in the kernel any more, so it is already being skipped because
of the condition at the top of the loop that ignores any arch which
doesn't have a kvm.h.

For MIPS, KVM is supposed to be properly supported these days, right?
That sounds like we should not be blacklisting them either, but instead
sorting out whatever issues it was that made us exclude them.

> +        for header in kvm.h kvm_para.h; do
> +            cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
> +        done
> +    fi
> +
>      if [ $arch = powerpc ]; then
>          cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
>      fi
> @@ -130,7 +133,7 @@ for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
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

thanks
-- PMM
