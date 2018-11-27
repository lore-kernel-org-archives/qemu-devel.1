Received: from eggs.gnu.org ([2001:4830:134:3::10]:37373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbvb-0006kN-Eg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbvX-0001DZ-G3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRbvX-0001Ab-CG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so14308079qka.9
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:53:15 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111123eucas1p15ecbe14062e47527e59ae7d219e3879c@eucas1p1.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-5-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-5-i.maximets@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 15:53:03 +0400
Message-ID: <CAMxuvazxg8HtUoqUpndk9RetgAVf7h1r+kDSiwfMVH=AKyzhNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] memfd: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maximets, Ilya" <i.maximets@samsung.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> This gives more information about the failure.
> Additionally 'ENOSYS' returned for a non-Linux platforms instead of
> 'errno', which is not initilaized in this case.
>
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/memfd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index 393d23da96..00334e5b21 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -71,14 +71,18 @@ int qemu_memfd_create(const char *name, size_t size, =
bool hugetlb,
>      }
>      mfd =3D memfd_create(name, flags);
>      if (mfd < 0) {
> +        error_setg_errno(errp, errno,
> +                         "failed to create memfd with flags 0x%x", flags=
);
>          goto err;
>      }
>
>      if (ftruncate(mfd, size) =3D=3D -1) {
> +        error_setg_errno(errp, errno, "failed to resize memfd to %zu", s=
ize);
>          goto err;
>      }
>
>      if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
> +        error_setg_errno(errp, errno, "failed to add seals 0x%x", seals)=
;
>          goto err;
>      }
>
> @@ -88,8 +92,9 @@ err:
>      if (mfd >=3D 0) {
>          close(mfd);
>      }
> +#else
> +    error_setg_errno(errp, ENOSYS, "failed to create memfd");
>  #endif
> -    error_setg_errno(errp, errno, "failed to create memfd");
>      return -1;
>  }
>
> --
> 2.17.1
>
