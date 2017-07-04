Received: from eggs.gnu.org ([2001:4830:134:3::10]:47385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSVrR-0004cV-VF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSVrR-0006Ey-6x
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:59:57 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dSVrQ-0006Ec-UO
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:59:57 -0400
Received: by mail-lf0-x244.google.com with SMTP id g21so19066576lfk.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 14:59:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
References: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2017 23:59:54 +0200
Message-ID: <CAJ+F1CKUnefwkRtSUXdabuM6Scvu3z1OUeVnug9PFzaqz=_eoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Jul 5, 2017 at 12:33 AM, Peng Hao <peng.hao2@zte.com.cn> wrote:
> vhost exists a call for g_file_get_contents, but not call g_free.
>
> Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

mst: is this better?

> ---
>  hw/virtio/vhost-backend.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 4e31de1..2c481d6 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct vhost_d=
ev *dev)
>                              &s, NULL, NULL)) {
>          uint64_t val =3D g_ascii_strtoull(s, NULL, 10);
>          if (!((val =3D=3D G_MAXUINT64 || !val) && errno)) {
> +            g_free(s);
>              return val;
>          }
>          error_report("ignoring invalid max_mem_regions value in vhost mo=
dule:"
>                       " %s", s);
>      }
> +    g_free(s);
>      return limit;
>  }
>
> --
> 1.8.3.1
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
