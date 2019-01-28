Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goBEk-0003Db-FR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goB1u-0002Ei-JL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:49:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goB1u-0002EQ-DN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:49:06 -0500
Date: Mon, 28 Jan 2019 15:48:57 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190128174857.GT4136@habkost.net>
References: <20190118133826.22447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118133826.22447-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: report invalid disable-legacy|modern
 usage for virtio-1-only devs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jan 18, 2019 at 01:38:26PM +0000, Daniel P. Berrang=E9 wrote:
> A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) only
> support the virtio-1 (aka modern) mode. Currently if the user launches
> QEMU, setting those devices to enable legacy mode, QEMU will silently
> create them in modern mode, ignoring the user's (mistaken) request.
>=20
> This patch introduces proper data validation so that an attempt to
> configure a virtio-1-only devices in legacy mode gets reported as an
> error to the user.
>=20
> Checking this required introduction of a new field to explicitly track
> what operating model is to be used for a device, separately from the
> disable_modern and disable_legacy fields that record the user's
> requested configuration.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

This breaks the virtio-1-only devices on pc-*-2.6:

  $ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-vga -machine pc-i4=
40fx-2.6
  qemu-system-x86_64: -device virtio-vga: Unable to set disable-legacy=3D=
off on a virtio-1.0 only device

Probably the simplest way to fix that is to append the following to
hw_compat_2_6:

  { virtio-vga,        disable-modern, off },
  { virtio-gpu-pci,    disable-modern, off },
  { virtio-input-pci,  disable-modern, off },
  { virtio-crypto-pci, disable-modern, off }

We could also remove the property completely from those devices
(e.g. by moving virtio-vga to virtio_vga_info.non_transitional_name),
but it would break compatibility in case people are explicitly
setting "disable-modern=3Doff" on those devices.

--=20
Eduardo
