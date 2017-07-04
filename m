Received: from eggs.gnu.org ([2001:4830:134:3::10]:57244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSOhf-0003RP-QA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSOhe-0003Ic-WD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:21:23 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dSOhe-0003HF-OB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:21:22 -0400
Received: by mail-lf0-x242.google.com with SMTP id z78so5749873lff.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Jul 2017 14:21:08 +0000
Message-ID: <CAJ+F1C+sWiCpSSqPdkiU0iBmdjofuv6m1FAgwPBJJUu9BJcUEA@mail.gmail.com>
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
To: Peng Hao <peng.hao2@zte.com.cn>, mst@redhat.com
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Hi

On Tue, Jul 4, 2017 at 4:16 PM Peng Hao <peng.hao2@zte.com.cn> wrote:

> vhost exists a call for g_file_get_contents, but not call g_free.
>
> Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/virtio/vhost-backend.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 4e31de1..2c481d6 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct
> vhost_dev *dev)
>                              &s, NULL, NULL)) {
>          uint64_t val =3D g_ascii_strtoull(s, NULL, 10);
>          if (!((val =3D=3D G_MAXUINT64 || !val) && errno)) {
> +            g_free(s);
>              return val;
>          }
>          error_report("ignoring invalid max_mem_regions value in vhost
> module:"
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
> --
Marc-Andr=C3=A9 Lureau
