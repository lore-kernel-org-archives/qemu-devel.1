Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPJFt-0002io-W9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPJ7u-0006aQ-LE
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:24:31 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPJ7u-0006XN-G3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:24:30 -0500
Received: by mail-io1-xd44.google.com with SMTP id m1-v6so2997584ioc.13
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 19:24:30 -0800 (PST)
MIME-Version: 1.0
References: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 11:23:53 +0800
Message-ID: <CAKXe6SJPrqqMzd=4dj1htN+1Z4yMRv_RfGOaZdLY4Kg=KZW8Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: check write/read_with_attrs in
 memory dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

Ping...

It makes sense as when we use 'memory_region_read_accessor' we check
mr->ops->read.
but when we use 'memory_region_read_with_attrs_accessor', we doesn't check
this.

Thanks,
Li Qiang

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8813=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:42=E5=86=99=E9=81=93=EF=BC=9A

> This can avoid the NULL-deref if the rm doesn't has a
> read/write nor write/read_with_attrs callback.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index d14c6dec1d..3baf5857b9 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1377,13 +1377,15 @@ static MemTxResult
> memory_region_dispatch_read1(MemoryRegion *mr,
>                                           mr->ops->impl.max_access_size,
>                                           memory_region_read_accessor,
>                                           mr, attrs);
> -    } else {
> +    } else if (mr->ops->read_with_attrs) {
>          return access_with_adjusted_size(addr, pval, size,
>                                           mr->ops->impl.min_access_size,
>                                           mr->ops->impl.max_access_size,
>
> memory_region_read_with_attrs_accessor,
>                                           mr, attrs);
>      }
> +
> +    return MEMTX_DECODE_ERROR;
>  }
>
>  MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
> @@ -1454,7 +1456,7 @@ MemTxResult
> memory_region_dispatch_write(MemoryRegion *mr,
>                                           mr->ops->impl.max_access_size,
>                                           memory_region_write_accessor, m=
r,
>                                           attrs);
> -    } else {
> +    } else if (mr->ops->write_with_attrs) {
>          return
>              access_with_adjusted_size(addr, &data, size,
>                                        mr->ops->impl.min_access_size,
> @@ -1462,6 +1464,8 @@ MemTxResult
> memory_region_dispatch_write(MemoryRegion *mr,
>
>  memory_region_write_with_attrs_accessor,
>                                        mr, attrs);
>      }
> +
> +    return MEMTX_DECODE_ERROR;
>  }
>
>  void memory_region_init_io(MemoryRegion *mr,
> --
> 2.11.0
>
>
