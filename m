Received: from eggs.gnu.org ([209.51.188.92]:52057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlee-0006FZ-U9
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlec-0001ZD-KX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:54:51 -0500
Date: Wed, 16 Jan 2019 13:54:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116135444.GA16898@stefanha-x1.localdomain>
References: <cover.1547475602.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 04:23:58PM +0200, Alberto Garcia wrote:
> This series acquires the AioContext in the _realize() functions of
> several devices before making use of their block backends. This fixes
> at least a couple of crashes (in virtio-blk and scsi). The other
> devices don't currently support iothreads so there's no crashes.
>=20
> Berto

My assumption has been that drives are in the main loop AioContext until
the device model (e.g. virtio-blk) decides to move them into the
IOThread configured by the user.

(And when the VM is stopped or the device is removed, the drive is moved
back into the main loop AioContext by the device.)

The x-blockdev-set-iothread command is for low-level tests so I don't
expect users to invoke it.  So I'm not sure which real-world scenario is
being tested here?

This patch series makes virtio-blk and virtio-scsi more robust, although
I haven't checked what happens if the drive is attached to a different
IOThread than the device - will the switchover work?

What I'm unclear about is why fdc, ide, usb-msd, and nvme should worry
about IOThreads/AioContext in .realize() since they don't support it in
their data path.  What happens when you submit I/O requests to devices
configured like this?  I guess they would crash or hit assertion
failures since they invoke blk_aio_*() APIs from outside the appropriate
AioContext.

Maybe fdc and friends should forbid this scenario:

  /* Fail if @blk is attached to an IOThread */
  static bool blk_check_main_aio_context(BlockBackend *blk, Error **errp) {
      if (blk_get_aio_context(blk) !=3D qemu_get_aio_context()) {
          error_setg(errp, "Device does not support iothreads");
          return false;
      }
      return true;
  }

  ...in a realize() function...
  if (!blk_check_main_aio_context(blk, errp)) {
      return;
  }

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPzejAAoJEJykq7OBq3PICLsH/j+m+/a5pZw+/C19Q3jlRbgg
9q412py6hCAkZBBtNmMOImvzopLbqz44CHO7kAcQy/tzrNTV95zgd4FzFha/FWZu
ZUkShBHuy490JsfC+U/Wtx9ZM1o0oLxYEy+BD+KUDSkzbltzbUdHPcV9wdH3HOS4
5+RPkxcfPvsmcR1ZzAYJ3WKYbLWa5jRB+FvCCd2QsASn2LMY9Y0wWIFmXMqz+W/J
fX2KXEEcNVq1WESAPa+GafDhNlH8q6H+odmo1j1ce0NQSpB1mWKj/lIIPKND9Md5
kvwpZvt9FEFL+ApT2DhqfcKFj/2HO5J5lDourisTWtwQoKdcNSR/OJclFG4E6TU=
=YPDh
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
