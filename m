Received: from eggs.gnu.org ([209.51.188.92]:49114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gqZ74-0004dZ-3W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 02:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gqZ73-0003Y3-Bo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 02:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gqZ73-0003Xl-5e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 02:56:17 -0500
Date: Mon, 4 Feb 2019 15:50:23 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190204075023.GA15322@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Subject: [Qemu-devel] Querying the size of devdax devices from userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>, Jeff Moyer <jmoyer@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Cc: qemu-devel@nongnu.org, linux-nvdimm@lists.01.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

How can userspace applications query the size of devdax character
devices?

stat(1) doesn't know how large the device is:

  # stat /dev/dax0.0
    File: /dev/dax0.0
    Size: 0         	Blocks: 0          IO Block: 4096   character special file
  Device: 6h/6d	Inode: 56764       Links: 1     Device type: fa,d

ndctl(1) finds out by digging in /sys:

  # ndctl list
  [
    {
      "dev":"namespace0.0",
      "mode":"devdax",
      "map":"dev",
      "size":2111832064,
      "uuid":"235acf4d-503f-46be-bf64-f26faf9777ef",
      "chardev":"dax0.0"
    }
  ]

I'm not sure how to do it without enumerating all nvdimms in /sys.  Is
there a mapping from devdax major/minor number to a /sys path?

The use case I have in mind is that QEMU currently takes the size as a
command-line parameter.  The failure mode is ugly when users get this
value wrong: the guest gets a softlockup and there is no error message
on the host side.

I'd like QEMU to detect the size or at least reject size values that are
too large.  In order to do that userspace needs a convenient way of
querying the size.  Any ideas?

Stefan

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV+6/AAoJEJykq7OBq3PIE2MIAMXxtSr5u1UIYoiPbz9ZvVlu
gEb4tn/t3lMDq91aaZ4KdfWHWCxr9kNeKWw1xMgyLQiL8RlPp/ssK3los2giZDAR
ifjfImHbcq1mZsj1x18uYHk7outeciAiAfArssLT2190hHzDhFxSh1sbqo47bJm5
Uo/gY7gEjVa7fP9tFlRzvsjfIEaCESqCyQ1HbJlHbog/TvteontM9QSiFUE7Wu2j
utagrJjIgp0tpvTubf27LOQUxtmYN18HZWpzSDwy2RWaTO3unoup4rID4Tujo56Z
qbM77x9qKsEf81aYYtffHiOWTT1/D6oLYdd9p7I55qrSPGHPXLbT+DPDWcl/674=
=tye0
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
