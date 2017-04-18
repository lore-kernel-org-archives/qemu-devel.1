Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Wil-0006qz-2r
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Wih-0008Cj-4B
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:15:19 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0Wig-0008Ce-TQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:15:15 -0400
Received: by mail-wr0-x233.google.com with SMTP id c55so107165604wrc.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 10:15:14 -0700 (PDT)
Date: Tue, 18 Apr 2017 18:14:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418171457.GN21261@stefanha-x1.localdomain>
References: <CACaajQtOS+=G4yHfymqFJiCZBtMfR=qUbfVi6n5quTRtffULjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3hAdtgBjtgL7p0NQ"
Content-Disposition: inline
In-Reply-To: <CACaajQtOS+=G4yHfymqFJiCZBtMfR=qUbfVi6n5quTRtffULjA@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu and own disk driver writing questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vasiliy Tolstov <v.tolstov@selfip.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>


--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 13, 2017 at 01:57:17PM +0300, Vasiliy Tolstov wrote:
> Hi! If i want to develop some sort of qemu network block driver to own
> storage. I can write qemu driver or tcmu / scst userspace driver and
> attach to qemu block device (i'm use linux)
> So in theory what path have minimal overhead in case of memory copy
> and performance?
> Where i can find some info how qemu works with data that needs to be
> written or readed from block device passed to vm?

The best approach depends on your requirements.  If you want the code to
be merged into qemu.git it's important to discuss the requirements first
so that everyone is on board with adding another block driver.

Three options:

1. Implement iSCSI, NBD, or NFS on your storage server.  Doesn't require
   new QEMU code and users don't need to upgrade QEMU.

2. Implement a block driver in block/.  See iSCSI and other network
   protocol drivers for examples.  Useful if your storage system offers
   snapshot features.

3. Implement vhost-user-scsi in your storage server.  You need to write
   a virtio-scsi backend that runs in a separate userspace process on
   the host.  You are limited to supporting the virtio-scsi device - no
   IDE, SATA, virtio-blk, etc.  vhost-user-scsi is still under active
   development and you may need to contribute to it if you hit
   limitations/bugs.  Requires low-level knowledge of virtio.

Stefan

--3hAdtgBjtgL7p0NQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9kmRAAoJEJykq7OBq3PIoEgIAIQP4dgk7O8dUK5bOwQs9GTk
uPtFINksvK3fn6ICLrvX4NG8ZbS06y616oSI+YUd4kcS1y4dqGWXbZOigvbAPeBP
4zfOFrYBHvPf1DHnNrHjMe5xpBxYJ4TkPuJrEBAstgN3fsQevgNaln0xxX7uUJoL
RhFbDWS6GMkR05y75+eLtRAWhf2vIq0Xhb3XvIm7eYHtT9jmNtkOnazo0/LJjneG
rJKu7om9MfRFYpYpxO+1KToVEcXhW2m99aN35H+dDHdLiJgZl7CEjQjqJIwcl/Kb
FEQmT7SXfmTrbe9Zu4SBUDTTfVOXAI6ZDRSIGt0XBWk6tF/zJUCAstc7U6UiQJ8=
=vDS1
-----END PGP SIGNATURE-----

--3hAdtgBjtgL7p0NQ--
