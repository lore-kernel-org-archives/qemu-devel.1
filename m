Received: from eggs.gnu.org ([209.51.188.92]:32996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guapw-0000uF-M1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guapu-0003V2-G9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1guapt-0003Kx-EU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:14 -0500
Date: Fri, 15 Feb 2019 10:34:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190215103455.GB14454@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118133826.22447-1-berrange@redhat.com>
	<20190128174857.GT4136@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128174857.GT4136@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Jan 28, 2019 at 03:48:57PM -0200, Eduardo Habkost wrote:
> On Fri, Jan 18, 2019 at 01:38:26PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) onl=
y
> > support the virtio-1 (aka modern) mode. Currently if the user launche=
s
> > QEMU, setting those devices to enable legacy mode, QEMU will silently
> > create them in modern mode, ignoring the user's (mistaken) request.
> >=20
> > This patch introduces proper data validation so that an attempt to
> > configure a virtio-1-only devices in legacy mode gets reported as an
> > error to the user.
> >=20
> > Checking this required introduction of a new field to explicitly trac=
k
> > what operating model is to be used for a device, separately from the
> > disable_modern and disable_legacy fields that record the user's
> > requested configuration.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> This breaks the virtio-1-only devices on pc-*-2.6:
>=20
>   $ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-vga -machine pc-=
i440fx-2.6
>   qemu-system-x86_64: -device virtio-vga: Unable to set disable-legacy=3D=
off on a virtio-1.0 only device
>=20
> Probably the simplest way to fix that is to append the following to
> hw_compat_2_6:
>=20
>   { virtio-vga,        disable-modern, off },
>   { virtio-gpu-pci,    disable-modern, off },
>   { virtio-input-pci,  disable-modern, off },
>   { virtio-crypto-pci, disable-modern, off }

That's no sufficient, as it needs to also set disable-legacy=3Don

Once we add all these extra properties, it becomes pointless to
try to use the generic settings against virtio-pci in hw_compat_2_6.
So I've just turn it into a whitelist, only listing the devices
which actually support both modern+legacy modes. This makes it
obvious which devices are being affected & avoids silent surprises
like this bug you found in my patch.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
