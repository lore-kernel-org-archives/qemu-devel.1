Received: from eggs.gnu.org ([2001:4830:134:3::10]:60811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzzNt-0002AI-Ma
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzzNs-0005pU-TQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:16:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fzzNs-0005o3-MG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:16:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id j26-v6so820299wre.2
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 00:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Sep 2018 11:16:06 +0400
Message-ID: <CAJ+F1C+nhYjE1qCjJBuxePJ2LQkjGfoQF4=J=AdRF9EfJRVnWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_mem: add read memory region callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Sep 12, 2018 at 9:22 AM Li Qiang <liq3ea@gmail.com> wrote:
>
> The write/read should be paired, this can avoid the
> NULL-deref while the guest reads the fw_cfg port.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Do you have a reproducer and/or a backtrace?
memory_region_dispatch_write() checks if ops->write !=3D NULL.

> ---
>  hw/nvram/fw_cfg.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index d79a568f54..6de7809f1a 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -434,6 +434,11 @@ static bool fw_cfg_data_mem_valid(void *opaque, hwad=
dr addr,
>      return addr =3D=3D 0;
>  }
>
> +static uint64_t fw_cfg_ctl_mem_read(void *opaque, hwaddr addr, unsigned =
size)
> +{
> +    return 0;
> +}
> +
>  static void fw_cfg_ctl_mem_write(void *opaque, hwaddr addr,
>                                   uint64_t value, unsigned size)
>  {
> @@ -468,6 +473,7 @@ static bool fw_cfg_comb_valid(void *opaque, hwaddr ad=
dr,
>  }
>
>  static const MemoryRegionOps fw_cfg_ctl_mem_ops =3D {
> +    .read =3D fw_cfg_ctl_mem_read,
>      .write =3D fw_cfg_ctl_mem_write,
>      .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid.accepts =3D fw_cfg_ctl_mem_valid,
> --
> 2.11.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
