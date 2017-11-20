Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGou6-0005Lz-Na
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGou2-00017F-Lq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:26:38 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eGou2-000175-C9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:26:34 -0500
Received: by mail-wm0-x244.google.com with SMTP id g130so7015975wme.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 08:26:34 -0800 (PST)
Date: Mon, 20 Nov 2017 16:26:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120162631.GK4516@stefanha-x1.localdomain>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline
In-Reply-To: <1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user
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


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 04:44:37AM +0800, Changpeng Liu wrote:
> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> used for live migration of vhost user devices, also vhost user devices
> can benefit from the messages to get/set virtio config space from/to the
> I/O target. For the purpose to support virtio config space change,
> VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> in case virtio config space change in the I/O target.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  docs/interop/vhost-user.txt       | 39 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 98 +++++++++++++++++++++++++++++++++=
++++++
>  hw/virtio/vhost.c                 | 63 +++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  8 ++++
>  include/hw/virtio/vhost.h         | 16 +++++++
>  5 files changed, 224 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 954771d..1b98388 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -116,6 +116,16 @@ Depending on the request type, payload can be:
>      - 3: IOTLB invalidate
>      - 4: IOTLB access fail
> =20
> + * Virtio device config space
> +   ---------------------------
> +   | offset | size | payload |
> +   ---------------------------
> +
> +   Offset: a 32-bit offset of virtio device's configuration space

s/of/in the/

> +   Size: a 32-bit size of configuration space that master wanted to chan=
ge

Is this also used for GET_CONFIG?  If yes, I suggest "a 32-bit
configuration space access size in bytes".

Please mention that Size must be <=3D 256 bytes.

> +   Payload: a 256-bytes array holding the contents of the virtio
> +       device's configuration space

What about bytes outside the [offset, offset+size) range?  I guess they
must be 0 and are ignored by the master/slave.

Would it be cleaner to make Payload a variable-sized field with Size
bytes?  That way it's not necessary to transfer 0s and memcpy() a subset
of the payload array.

> +
>  In QEMU the vhost-user message is implemented with the following struct:
> =20
>  typedef struct VhostUserMsg {
> @@ -129,6 +139,7 @@ typedef struct VhostUserMsg {
>          VhostUserMemory memory;
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
> +        VhostUserConfig config;
>      };
>  } QEMU_PACKED VhostUserMsg;
> =20
> @@ -596,6 +607,34 @@ Master message types
>        and expect this message once (per VQ) during device configuration
>        (ie. before the master starts the VQ).
> =20
> + * VHOST_USER_GET_CONFIG
> +      Id: 24
> +      Equivalent ioctl: N/A
> +      Master payload: virtio device config space
> +
> +      Submitted by the vhost-user master to fetch the contents of the vi=
rtio
> +      device configuration space. The vhost-user master may cache the co=
ntents
> +      to avoid repeated VHOST_USER_GET_CONFIG calls.
> +
> +* VHOST_USER_SET_CONFIG
> +      Id: 25
> +      Equivalent ioctl: N/A
> +      Master payload: virtio device config space
> +
> +      Submitted by the vhost-user master when the Guest changes the virt=
io
> +      device configuration space and also can be used for live migration
> +      on the destination host.

There might be security issues if the vhost slave cannot tell whether
SET_CONFIG is coming from the guest driver or from the master process
(live migration).  Typically certain fields are read-only for the guest
driver.  Maybe those fields need to be set by the master after live
migration.

One way to solve this is adding a flags field to the message.  A special
flag can be used for live migration so the slave knows that this
SET_CONFIG message is allowed to write to read-only fields.

It's also worth documenting that slaves MUST NOT accept SET_CONFIG for
read-only configuration space fields unless the live migration bit is
set.  Hopefully this will remind implementors to think through the
security issues.

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEwI2AAoJEJykq7OBq3PIX3AIAMIYI/KfGIZaBHeymsaDCW8t
DaRLacnCS7DxXQY+Fm//oYkx6HYnZL0WeIdTU3ZtE9kj3r+9B8wCZJ0aGzT9hB5U
MBiSOTXfE7hHAsnv2kIYgXGh2ih7qp7Bxa5xXcEL1j2VA8985+bqxORPC3k1sPd2
r318ygRIVQwGoE/v3+OjlTUcNpipqch1SvJIgi79nif5M4N+rPdKPlZbFIGv1uhP
Sm5z9CqNfj6d5jIVxEbjKCcTRz/0ftzMy6Tl4S9u2GT6LU0RCw3fFHmDQ1N5yDAQ
RHHtt8aGqKHAumi8+DFCrMCDBxzoXFM9dS2Qb6nk1eL1l84wQJRI8OdIfw116uA=
=SA7E
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--
