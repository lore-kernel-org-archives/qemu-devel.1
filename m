Received: from eggs.gnu.org ([2001:4830:134:3::10]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTRP8-0002Eo-Hm
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTRP3-0003Cz-Li
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:54:18 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTRP3-0003Cq-Ec
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:54:13 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so5018379wmi.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 02:54:13 -0800 (PST)
Date: Tue, 17 Jan 2017 10:54:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170117105405.GE4265@stefanha-x1.localdomain>
References: <20170116160730.4696-1-famz@redhat.com>
	<20170116160730.4696-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <20170116160730.4696-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi: Implement fc_host feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 12:07:30AM +0800, Fam Zheng wrote:
>  static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIOSCSI *s =3D VIRTIO_SCSI(dev);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>      Error *err =3D NULL;
> =20
> +    if (vs->conf.fc_host) {
> +        if (!strcmp(vs->conf.fc_host, "off")) {
> +            vs->conf.primary_wwpn =3D 0;
> +            vs->conf.primary_wwnn =3D 0;
> +            vs->conf.secondary_wwpn =3D 0;
> +            vs->conf.secondary_wwnn =3D 0;
> +        } else if (!strcmp(vs->conf.fc_host, "primary") ||
> +                   !strcmp(vs->conf.fc_host, "secondary")) {
> +            virtio_add_feature(&vdev->host_features, VIRTIO_SCSI_F_FC_HO=
ST);
> +            vs->conf.primary_active =3D !strcmp(vs->conf.fc_host, "prima=
ry");
> +            if (!vs->conf.primary_wwpn) {
> +                error_setg(errp, "fc_host enabled but primary_wwpn not s=
et");
> +                return;
> +            }
> +            if (!vs->conf.primary_wwnn) {
> +                error_setg(errp, "fc_host enabled but primary_wwnn not s=
et");
> +                return;
> +            }
> +            if (!vs->conf.secondary_wwpn) {
> +                error_setg(errp, "fc_host enabled but secondary_wwpn not=
 set");
> +                return;
> +            }
> +            if (!vs->conf.secondary_wwnn) {
> +                error_setg(errp, "fc_host enabled but secondary_wwnn not=
 set");
> +                return;
> +            }
> +            s->vm_state_change =3D
> +                qemu_add_vm_change_state_handler(virtio_scsi_vm_state_ch=
ange, s);

Missing qemu_del_vm_change_state_handler() in .unrealize() and in error
code paths in this function.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfffNAAoJEJykq7OBq3PIdOIIALrjAyxKE6NMRcgnV6qAd3jK
L1Ikwxa517bgdEPbGXNUcZDPb3IRmS15ZkOKKmPYYwPIC2oOGJxECLCF4EYKxFqR
zjI9+Ch5rJnxjgQwGsj25mDGJcA0igEJu5iMu259++v6xOmdCkfTzZ9OqU+vhfk8
OIdNCgRAm85bTRdY3rm1CtFz/esP0EWwvWLlV3BJ/G0zajERGxrCln7mJMjzenTv
+mCYNmah2+DMpp8UzSUb+WGKdCp+wJpsaUuxWczJ7iM4R/Fj4XYCO7hBWukElGxT
veD1ckvsKgwXI2L4Afh4Wau2PEV8vhBXuhjvKcNMeiF3VMAQfbYoVmdxhG24PR0=
=aISq
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
