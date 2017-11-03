Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZEj-0006VO-NX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZEf-0000hf-Q5
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:30:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:52436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAZEf-0000hR-Im
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:30:01 -0400
Received: by mail-wr0-x241.google.com with SMTP id k62so2074029wrc.9
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 03:30:01 -0700 (PDT)
Date: Fri, 3 Nov 2017 10:29:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103102958.GI5078@stefanha-x1.localdomain>
References: <20171031080303.15624-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20171031080303.15624-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] fix: unrealize virtio device if we fail to
 hotplug it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:03:03PM +0800, linzhecheng wrote:
> If we fail to hotplug virtio-blk device and then suspend
> or shutdown VM, qemu is likely to crash.
>=20
> Re-production steps:
> 1. Run VM named vm001
> 2. Create a virtio-blk.xml which contains wrong configurations:
> <disk device=3D"lun" rawio=3D"yes" type=3D"block">
>   <driver cache=3D"none" io=3D"native" name=3D"qemu" type=3D"raw" />
>   <source dev=3D"/dev/mapper/11-dm" />
>   <target bus=3D"virtio" dev=3D"vdx" />
> </disk>
> 3. Run command : virsh attach-device vm001 virtio-blk.xml
> error: Failed to attach device from blk-scsi.xml
> error: internal error: unable to execute QEMU command 'device_add': Pleas=
e set scsi=3Doff for virtio-blk devices in order to use virtio 1.0
> it means hotplug virtio-blk device failed.
> 4. Suspend or shutdown VM will leads to qemu crash
>=20
> Problem happens in virtio_vmstate_change which is called by
> vm_state_notify:
> vdev=E2=80=99s parent_bus is NULL, so qdev_get_parent_bus(DEVICE(vdev)) w=
ill crash.
> virtio_vmstate_change is added to the list vm_change_state_head at virtio=
_blk_device_realize(virtio_init),
> but after hotplug virtio-blk failed, virtio_vmstate_change will not be re=
moved from vm_change_state_head.
> Adding unrealize function of virtio-blk device can solve this problem.
>=20
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> ---
>  hw/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/EUmAAoJEJykq7OBq3PIHW4IAInCEoKooDnzadR3RAouzAfY
YKkw0xmCZzFFwTb9oBYikdp8/DoI83SXicxBNxicYg5Di0o0ju7Ad7b2Ql8DJRfH
xThCzWYxdzTbT6POlo6nK9ENTwReMf56pAS22s87ZEREzQpFulsRpfIzDv1iX2pk
ROGHQuGKfnxGXMFTF5EeXOeZt/cWo9attxdod1nK9HxuZt/1qfAqyXKjnpU0IWyH
AnTugfoJnxcAUMjDgi4EWeeh8mVsBHtYBxGgELXpY6zcNNzH+wDtteocLCTBayXa
t5pBAcSmPGM0s/na0TheNFtquMQpqQcUzSI8xjDYAtVzGNrftj6Wns02fSWTlAE=
=txwu
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
