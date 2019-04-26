Received: from eggs.gnu.org ([209.51.188.92]:56207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxA8-0004WV-1J
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxA7-0000iG-21
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:28:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJxA6-0000hI-Nh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:28:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id n25so3376560wmk.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 02:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-3-marcandre.lureau@redhat.com>
	<20190426071152.fxsicstylxa3bk3e@sirius.home.kraxel.org>
In-Reply-To: <20190426071152.fxsicstylxa3bk3e@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 11:28:41 +0200
Message-ID: <CAJ+F1C+C4hLMSPRiW9kKD8ADLaxwddd-gx2pUVo90uOgA1zsLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/11] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Fri, Apr 26, 2019 at 9:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > +static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config=
_data)
> > +{
> > +    VirtIOInput *vinput =3D VIRTIO_INPUT(vdev);
> > +    VHostUserInput *vhi =3D VHOST_USER_INPUT(vdev);
> > +    int ret;
> > +
> > +    memset(config_data, 0, vinput->cfg_size);
> > +
> > +    ret =3D vhost_dev_get_config(&vhi->vhost->dev, config_data, vinput=
->cfg_size);
> > +    if (ret) {
> > +        error_report("vhost-user-input: get device config space failed=
");
> > +        return;
> > +    }
> > +}
> > +
> > +static void vhost_input_set_config(VirtIODevice *vdev,
> > +                                   const uint8_t *config_data)
> > +{
> > +    VHostUserInput *vhi =3D VHOST_USER_INPUT(vdev);
> > +    int ret;
> > +
> > +    ret =3D vhost_dev_set_config(&vhi->vhost->dev, config_data,
> > +                               0, sizeof(virtio_input_config),
> > +                               VHOST_SET_CONFIG_TYPE_MASTER);
> > +    if (ret) {
> > +        error_report("vhost-user-input: set device config space failed=
");
> > +        return;
> > +    }
> > +
> > +    virtio_notify_config(vdev);
> > +}
>
> These two look rather generic, the only virtio-input specific thing is
> the config space size.  Can we store the size somewhere, then move the
> functions to common vhost-user code?

vhost-user-input is simple, vhost-user-gpu is fiddling with the config
on qemu side.

virtio-input set_config() calls virtio_notify_config(), while
virtio-gpu does not (vhost-user versions copy that).

There isn't much code to share at this point.


--=20
Marc-Andr=C3=A9 Lureau
