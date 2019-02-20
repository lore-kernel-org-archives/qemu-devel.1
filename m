Received: from eggs.gnu.org ([209.51.188.92]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPxb-0007IY-1V
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPxa-0008MK-7E
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:22:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPxa-0008Lu-1Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:22:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so26698033qtp.8
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-17-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-17-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:22:30 +0100
Message-ID: <CAMxuvayRcj2W2_+hrZbVeH5yHDp2F8sBE1++Y0p2d6iJknLVbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/25] tpm: Use size_t to hold sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 2:06 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Avoid to use a signed type to hold an unsigned value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_emulator.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 70f4b10284..931e56f6ed 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -87,17 +87,18 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, uns=
igned long cmd, void *msg,
>  {
>      CharBackend *dev =3D &tpm->ctrl_chr;
>      uint32_t cmd_no =3D cpu_to_be32(cmd);
> -    ssize_t n =3D sizeof(uint32_t) + msg_len_in;
> +    size_t sz =3D sizeof(uint32_t) + msg_len_in;
> +    ssize_t n;
>      uint8_t *buf =3D NULL;
>      int ret =3D -1;
>
>      qemu_mutex_lock(&tpm->mutex);
>
> -    buf =3D g_alloca(n);
> +    buf =3D g_alloca(sz);
>      memcpy(buf, &cmd_no, sizeof(cmd_no));
>      memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
>
> -    n =3D qemu_chr_fe_write_all(dev, buf, n);
> +    n =3D qemu_chr_fe_write_all(dev, buf, sz);
>      if (n <=3D 0) {
>          goto end;
>      }
> --
> 2.20.1
>
