Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQKFg-0004VA-NS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQKFf-0008As-Mu
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:11:56 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dQKFf-00089j-F6
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 17:11:55 -0400
Received: by mail-lf0-x242.google.com with SMTP id n136so6152474lfn.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 14:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <1498187397-127781-1-git-send-email-jsli@synology.com>
In-Reply-To: <1498187397-127781-1-git-send-email-jsli@synology.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Jun 2017 21:11:41 +0000
Message-ID: <CAJ+F1CJ0qP_0XiuUG8cA8PRsARzrWpxJWasPeKZv7M6J7MyNew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: Fix use-after-free in
 vhost_log_put()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia-Shiun Li <jsli@synology.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org

Hi

On Fri, Jun 23, 2017 at 6:28 AM Jia-Shiun Li <jsli@synology.com> wrote:

> In commit 9e0bc24f dev->log_size was reset to zero too early before
> syncing vhost log. It causes syncing to be skipped.
>
>
ooch, I guess I didn't realize it was also accessing dev->log_size when
taking dev->log in local variable.

I wonder why the code is written this way, it looks like the function may
be reentered. For consistency, and perhaps for the reentering case, I would
use a local log_size variable too.

Btw, how did you find this regression?


> Move it to clear dev->log* after use.
>
> Signed-off-by: Jia-Shiun Li <jsli@synology.com>
>
---
>  hw/virtio/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6eddb09..c9ddf11 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
>      if (!log) {
>          return;
>      }
> -    dev->log =3D NULL;
> -    dev->log_size =3D 0;
>
>      --log->refcnt;
>      if (log->refcnt =3D=3D 0) {
> @@ -396,6 +394,8 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
>
>          g_free(log);
>      }
> +    dev->log =3D NULL;
> +    dev->log_size =3D 0;
>  }
>
>  static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
