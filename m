Received: from eggs.gnu.org ([2001:4830:134:3::10]:40069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOIY-00031r-AT
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOIT-0005mf-EE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:39:10 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eOOIT-0005lv-5p
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:39:05 -0500
Received: by mail-wr0-x244.google.com with SMTP id o2so17616858wro.5
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 05:39:05 -0800 (PST)
Date: Mon, 11 Dec 2017 13:39:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171211133901.GA5962@stefanha-x1.localdomain>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <1512455239-8296-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:27:16PM +0800, Changpeng Liu wrote:
> +* VHOST_USER_SET_CONFIG
> +      Id: 25
> +      Equivalent ioctl: N/A
> +      Master payload: virtio device config space
> +
> +      Submitted by the vhost-user master when the Guest changes the virt=
io
> +      device configuration space and also can be used for live migration
> +      on the destination host. The vhost-user slave must check the flags
> +      filed, and slaves MUST NOT accept SET_CONFIG for read-only

s/filed/field/

> +static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *c=
onfig,
> +                                 uint32_t offset, uint32_t size, uint32_=
t flags)
> +{
> +    uint8_t *p;
> +    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +
> +    VhostUserMsg msg =3D {
> +        msg.request =3D VHOST_USER_SET_CONFIG,
> +        msg.flags =3D VHOST_USER_VERSION,
> +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
> +    };
> +
> +    if (reply_supported) {
> +        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    msg.payload.config.offset =3D offset,
> +    msg.payload.config.size =3D size,
> +    msg.payload.config.flags =3D flags,
> +    p =3D msg.payload.config.region;
> +    memcpy(p, config + offset, size);

This function can be made more general by changing the semantics of the
config argument:

  memcpy(p, config, size);

Now the caller can pass just a single field instead of a whole 256-byte
config buffer.  It might be clearer to name the argument "data" or
"region" instead of "config" though.

> @@ -1505,6 +1508,67 @@ void vhost_ack_features(struct vhost_dev *hdev, co=
nst int *feature_bits,
>      }
>  }
> =20
> +int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
> +                         uint32_t config_len)
> +{
> +    assert(hdev->vhost_ops);
> +
> +    if (hdev->vhost_ops->vhost_get_config) {
> +        return hdev->vhost_ops->vhost_get_config(hdev, config, config_le=
n);
> +    }
> +
> +    return 0;
> +}
> +
> +int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *config,
> +                         uint32_t offset, uint32_t size, uint32_t flags)
> +{
> +    assert(hdev->vhost_ops);
> +
> +    if (hdev->vhost_ops->vhost_set_config) {
> +        return hdev->vhost_ops->vhost_set_config(hdev, config, offset,
> +                                                 size, flags);
> +    }
> +
> +    return 0;
> +}

Both vhost_dev_get_config() and vhost_dev_set_config() cannot fail
silently.  The device will not work properly if the configuration space
feature is not supported.

Please make these functions return an error if the callback is NULL.

The vhost-blk code should also check that
hdev->vhost_ops->vhost_set_config !=3D NULL during realize.  This way
users see the error when adding the device instead of at runtime when
the function gets called.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLop1AAoJEJykq7OBq3PI8U0H/3YRIbkyOWfEjdtSe1G5UhzV
DlNRF0cPZBcZeK9Ey4hXn/MtCrpJ4V5D4usAf4VVJhRWlFpj4HmmfNhhyjdXczOF
d+qLNnMA3GOPJaZK65l+SVgI4GhQGDnOMmTUgltDVoKygiI/BoUi50DvBGdaq6MX
P8yWDA0S4mkY1fPwLKmDTmwtDY0KE/juKBn5HP9CB78QEJszK0v3u511vDEiWPgs
yC5VU7IBWPqhneAGn4FDCEoORDFuFskQfSOjVQZjNL0msUHmTpFwcJzkq5O1rg6G
R8PJDCXOC7aG4EQePOh+MGNhOv2cw5sdm1nfIYKch594q+LvHfqzIKE0XLjtCxs=
=quPg
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
