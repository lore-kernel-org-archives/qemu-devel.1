Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiVp-0007sD-C3
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiVm-0008Jo-6I
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCiVl-0008JB-US
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y16so28915211wrw.3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:53:05 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:53:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017095303.GL22755@stefanha-x1.localdomain>
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Content-Disposition: inline
In-Reply-To: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 03:33:40PM +0200, Igor Mammedov wrote:
> When [2] was fixed it was agreed that adding and calling post_plug()
> callback after device_reset() was low risk approach to hotfix issue
> right before release. So it was merged instead of moving already
> existing plug() callback after device_reset() is called which would
> be more risky and require all plug() callbacks audit.
>=20
> Looking at the current plug() callbacks, it doesn't seem that moving
> plug() callback after device_reset() is breaking anything, so here
> goes agreed upon [3] proper fix which essentially reverts [1][2]
> and moves plug() callback after device_reset().
> This way devices always comes to plug() stage, after it's been fully
> initialized (including being reset), which fixes race condition [2]
> without need for an extra post_plug() callback.
>=20
>  1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
>  2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
>  3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> TODO:
>  remove usage of Error** from plug() callback, we need to factor out
>  pre_plug part from plug() callbacks, before proceeding with it.
>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
>  mostly have pre_plug parts factored out, but there still are parts
>  that could fail so it needs some more work to eliminate failure points
>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>  necessary.
> ---
>  include/hw/hotplug.h  | 11 -----------
>  hw/core/hotplug.c     | 10 ----------
>  hw/core/qdev.c        | 16 ++++++----------
>  hw/scsi/virtio-scsi.c | 11 +----------
>  4 files changed, 7 insertions(+), 41 deletions(-)

Thanks.  I think we're okay from the virtio-scsi perspective.  I have
not audited all devices.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwZ/AAoJEJykq7OBq3PIfHkIAMT8QVTb2VE/4bFqM538GooI
UavLNwgBjkVGg3COGtHlp0I7cNp2sZSnXos7CA1ypP45X5oSlltIfyj3favCZkHZ
ppsb7f8gQSI0mZuCjSW/C6asy+WmkF7grtKmF2uXjuz32GH4XFxCS91bzKvTlg0i
3TVci+sJQmHBbOkbvtOlvPs8ZlQnmnpjfWXwKgWcMgttTDACRIJutMANNX6zshpG
mW0qZ17C5rsFg6izUr/KwuI3WsgilH4f/M3i6elXqL248COZedXwY314URGXtQnc
cXOqL7G+hnukpjhoEChElY27hBR61OdVXdpyHB+pWKaXTm96kByygtOXxcisEUw=
=ViFM
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
