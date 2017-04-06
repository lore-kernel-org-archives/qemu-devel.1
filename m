Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw80O-0001OG-CJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw80F-00009Q-44
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:03:20 -0400
Date: Thu, 6 Apr 2017 15:02:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170406140255.GA31259@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> when migration with high speed, mig_save_device_bulk invoke
> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
> this patch limit the time used for bdrv_is_allocated.

bdrv_is_allocated() is supposed to yield back to the event loop if it
needs to block.  If your VNC session is experiencing jitter then it's
probably because a system call in the bdrv_is_allocated() code path is
synchronous when it should be asynchronous.

You could try to identify the system call using strace -f -T.  In the
output you'll see the duration of each system call.  I guess there is a
file I/O system call that is taking noticable amounts of time.

A proper solution is to refactor the synchronous code to make it
asynchronous.  This might require invoking the system call from a
thread pool worker.

Stefan

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5kqPAAoJEJykq7OBq3PIIXoIALlKH6+G2VMARezVQ4ADcLSR
li0n9yngs67hHeJD9PoSbYPkC+QUQfcDzS6Ry0NcFSeNwleoXP6JfICseteFdiK4
hQURbx+nFwrLhPlpgNYwbY9FhDOj2P63FBn3ZvqFbVdC58mEjvhgxW8TYE79VXaD
7OjHxdEEPROF8prphEqRpeeU94uuRkfNI/kfweaVJUE3fEDCkKDqVz89yMcutxTA
T8xV/tD7biLlqQNx9nYIcjTU7sDh7kldqMSq4qQLb1N2RFlQsuUmHZkNc1FidOTN
yRNW7p5xQWJyDd+Wzpbcs8d13Uxsp2Y2mJHzRdUsWF7ji34/QfRY7U2C+hnY0zs=
=UITi
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
