Received: from eggs.gnu.org ([209.51.188.92]:52469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzmRy-0000vg-GR
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzmRw-0004Gt-I3
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:59:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzmRs-0004Co-Nk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:59:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id i12so26880502wrw.0
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:59:51 -0800 (PST)
References: <20190214180216.246707-1-sgarzare@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214180216.246707-1-sgarzare@redhat.com>
Date: Fri, 01 Mar 2019 17:59:48 +0000
Message-ID: <87mumejx0r.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: run the multiboot loader
 before the PVH loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <George.Kennedy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Stefano Garzarella <sgarzare@redhat.com> writes:

> Some multiboot images could be in the ELF format. In the current
> implementation QEMU fails because we try to load these images
> as a PVH image.
>
> In order to fix this issue, we should try multiboot first (we
> already check the multiboot magic header before to load it).
> If it is not a multiboot image, we can try the PVH loader.
>
> Fixes: ab969087da6 ("pvh: Boot uncompressed kernel using direct boot ABI"=
, 2019-01-15)
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/i386/pc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3889eccdc3..207c267093 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1209,6 +1209,17 @@ static void load_linux(PCMachineState *pcms,
>      if (ldl_p(header+0x202) =3D=3D 0x53726448) {
>          protocol =3D lduw_p(header+0x206);
>      } else {
> +        /*
> +         * This could be a multiboot kernel. If it is, let's stop treati=
ng it
> +         * like a Linux kernel.
> +         * Note: some multiboot images could be in the ELF format (the s=
ame of
> +         * PVH), so we try multiboot first since we check the multiboot =
magic
> +         * header before to load it.
> +         */
> +        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
> +                           kernel_cmdline, kernel_size, header)) {
> +            return;
> +        }
>          /*
>           * Check if the file is an uncompressed kernel file (ELF) and lo=
ad it,
>           * saving the PVH entry point used by the x86/HVM direct boot AB=
I.
> @@ -1262,12 +1273,6 @@ static void load_linux(PCMachineState *pcms,
>
>              return;
>          }
> -        /* This looks like a multiboot kernel. If it is, let's stop
> -           treating it like a Linux kernel. */
> -        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
> -                           kernel_cmdline, kernel_size, header)) {
> -            return;
> -        }
>          protocol =3D 0;
>      }


--
Alex Benn=C3=A9e
