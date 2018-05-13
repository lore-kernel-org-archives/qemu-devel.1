Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHf7V-0003UO-8m
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHf7S-0002n8-4y
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:44:13 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHf7R-0002mo-VY
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:44:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id q6-v6so11899806qtn.3
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:44:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1526074301-211877-1-git-send-email-mst@redhat.com>
	<1526074301-211877-2-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97daf65f-81f8-ac85-405e-70e30247576c@amsat.org>
Date: Sat, 12 May 2018 21:43:53 -0300
MIME-Version: 1.0
In-Reply-To: <1526074301-211877-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] update-linux-headers.sh: unistd.h,
 kvm consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brijesh Singh <brijesh.singh@amd.com>, James Hogan <jhogan@kernel.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On 05/11/2018 06:32 PM, Michael S. Tsirkin wrote:
> Rework the update script slightly, add the unistd.h header and its
> dependencies on all architectures.
> 
> This also removes the IA64 and MIPS from a KVM blacklist:
> Linux dropped IA64, and there was never a reason to
> exclude MIPS from kvm specifically - it was
> excluded due to dependency of its unistd.h on sgidefs.h,
> which we also import.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/update-linux-headers.sh | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index a017b53..7af5bb1 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -84,11 +84,6 @@ for arch in $ARCHLIST; do
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
> @@ -99,9 +94,14 @@ for arch in $ARCHLIST; do
>  
>      rm -rf "$output/linux-headers/asm-$arch"
>      mkdir -p "$output/linux-headers/asm-$arch"
> -    for header in kvm.h unistd.h; do
> +    for header in kvm.h unistd.h bitsperlong.h; do
>          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
>      done
> +
> +    if [ $arch = mips ]; then
> +        cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
> +    fi
> +
>      rm -rf "$output/include/standard-headers/asm-$arch"
>      mkdir -p "$output/include/standard-headers/asm-$arch"
>      if [ $arch = s390 ]; then
> @@ -132,6 +132,12 @@ for header in kvm.h vfio.h vfio_ccw.h vhost.h \
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done
>  
> +rm -rf "$output/linux-headers/asm-generic"
> +mkdir -p "$output/linux-headers/asm-generic"
> +for header in unistd.h bitsperlong.h; do
> +    cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
> +done
> +
>  if [ -L "$linux/source" ]; then
>      cp "$linux/source/COPYING" "$output/linux-headers"
>  else
> 
