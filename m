Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1fz4Re-0003BN-Ia
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1fz4Ra-0002p6-Gu
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 14:28:26 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1fz4Ra-0002lp-8C
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 14:28:22 -0400
Received: by mail-lj1-x241.google.com with SMTP id m84-v6so15981385lje.10
	for <qemu-devel@nongnu.org>; Sun, 09 Sep 2018 11:28:20 -0700 (PDT)
Date: Sun, 9 Sep 2018 21:28:16 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-ID: <20180909212816.6e0f0ee5@phystech.edu>
In-Reply-To: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
References: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: fix Windows dump memory run mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, rkagan@virtuozzo.com

=D0=92 Wed, 29 Aug 2018 21:30:56 +0300
Viktor Prutyanov <viktor.prutyanov@virtuozzo.com> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:

> We should map and use guest memory run by parts if it can't be mapped
> as a whole.
> After this patch, continuos guest physical memory blocks which are not
> continuos in host virtual address space will be processed correctly.
>=20
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> ---
>  win_dump.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/win_dump.c b/win_dump.c
> index b15c191..aa39d9c 100644
> --- a/win_dump.c
> +++ b/win_dump.c
> @@ -30,28 +30,32 @@ static size_t write_run(WinDumpPhyMemRun64 *run,
> int fd, Error **errp) void *buf;
>      uint64_t addr =3D run->BasePage << TARGET_PAGE_BITS;
>      uint64_t size =3D run->PageCount << TARGET_PAGE_BITS;
> -    uint64_t len =3D size;
> +    uint64_t len, l;
> +    size_t total =3D 0;
> =20
> -    buf =3D cpu_physical_memory_map(addr, &len, false);
> -    if (!buf) {
> -        error_setg(errp, "win-dump: failed to map run");
> -        return 0;
> -    }
> -    if (len !=3D size) {
> -        error_setg(errp, "win-dump: failed to map entire run");
> -        len =3D 0;
> -        goto out_unmap;
> -    }
> +    while (size) {
> +        len =3D size;
> =20
> -    len =3D qemu_write_full(fd, buf, len);
> -    if (len !=3D size) {
> -        error_setg(errp, QERR_IO_ERROR);
> -    }
> +        buf =3D cpu_physical_memory_map(addr, &len, false);
> +        if (!buf) {
> +            error_setg(errp, "win-dump: failed to map physical range"
> +                             " 0x%016lx-0x%016lx", addr, addr + size
> - 1);
> +            return 0;
> +        }
> +
> +        l =3D qemu_write_full(fd, buf, len);
> +        cpu_physical_memory_unmap(buf, addr, false, len);
> +        if (l !=3D len) {
> +            error_setg(errp, QERR_IO_ERROR);
> +            return 0;
> +        }
> =20
> -out_unmap:
> -    cpu_physical_memory_unmap(buf, addr, false, len);
> +        addr +=3D l;
> +        size -=3D l;
> +        total +=3D l;
> +    }
> =20
> -    return len;
> +    return total;
>  }
> =20
>  static void write_runs(DumpState *s, WinDumpHeader64 *h, Error
> **errp)

ping
