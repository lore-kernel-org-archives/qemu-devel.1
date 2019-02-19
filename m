Received: from eggs.gnu.org ([209.51.188.92]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=946e8a4f0=Paul.Durrant@citrix.com>)
	id 1gw8RT-0006pl-Fr
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=946e8a4f0=Paul.Durrant@citrix.com>)
	id 1gw8RR-0005W4-HB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:40:23 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 19 Feb 2019 16:36:28 +0000
Message-ID: <9510cf48c9064c0fb1e6eb64b414a7ea@AMSPEX02CL03.citrite.net>
References: <20190219163440.15702-1-paul.durrant@citrix.com>
In-Reply-To: <20190219163440.15702-1-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-block: stop leaking memory in
 xen_block_drive_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Apologies... typo-ed qemu-devel...

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 19 February 2019 16:35
> To: qeme-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Peter Maydell
> <peter.maydell@linaro.org>; Stefano Stabellini <sstabellini@kernel.org>;
> Anthony Perard <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>=
;
> Max Reitz <mreitz@redhat.com>
> Subject: [PATCH] xen-block: stop leaking memory in
> xen_block_drive_create()
>=20
> The locally allocated QDict-s need to be freed. ('file_layer' will be
> freed implicitly since it is added as an object to 'driver_layer').
>=20
> Spotted by Coverity: CID 1398649
>=20
> While in the neighbourhood free 'driver' and 'filename' as soon as they
> are
> added to the QDicts. Freeing after the 'done' label doesn't make that muc=
h
> sense as, if the error path jumps to that label, the values would be NULL
> anyway.
>=20
> This patch also makes that more obvious by taking the error path if
> 'params' is NULL and then asserting that both driver and filename are
> non-NULL in the normal path.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/xen-block.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 37a456c207..70fc2455e8 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -743,12 +743,12 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>          }
>=20
>          g_strfreev(v);
> -    }
> -
> -    if (!filename) {
> -        error_setg(errp, "no filename");
> +    } else {
> +        error_setg(errp, "no params");
>          goto done;
>      }
> +
> +    assert(filename);
>      assert(driver);
>=20
>      drive =3D g_new0(XenBlockDrive, 1);
> @@ -758,6 +758,7 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>=20
>      qdict_put_str(file_layer, "driver", "file");
>      qdict_put_str(file_layer, "filename", filename);
> +    g_free(filename);
>=20
>      if (mode && *mode !=3D 'w') {
>          qdict_put_bool(file_layer, "read-only", true);
> @@ -793,16 +794,17 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>      driver_layer =3D qdict_new();
>=20
>      qdict_put_str(driver_layer, "driver", driver);
> +    g_free(driver);
> +
>      qdict_put_obj(driver_layer, "file", QOBJECT(file_layer));
>=20
>      g_assert(!drive->node_name);
>      drive->node_name =3D xen_block_blockdev_add(drive->id, driver_layer,
>                                                &local_err);
>=20
> -done:
> -    g_free(driver);
> -    g_free(filename);
> +    qobject_unref(driver_layer);
>=20
> +done:
>      if (local_err) {
>          error_propagate(errp, local_err);
>          xen_block_drive_destroy(drive, NULL);
> --
> 2.20.1.2.gb21ebb6
