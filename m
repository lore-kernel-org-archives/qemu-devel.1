Received: from eggs.gnu.org ([2001:4830:134:3::10]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Q9A-0002Lb-2y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Q96-0007c9-Vi
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:19:20 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5Q96-0007at-Nl
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:19:16 -0400
Received: by mail-pl0-x22a.google.com with SMTP id c7-v6so1281701plr.5
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 23:19:16 -0700 (PDT)
Date: Mon, 9 Apr 2018 14:19:10 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180409061910.GD4848@stefanha-x1.localdomain>
References: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
	<20180403031147.GC6839@lemon.usersys.redhat.com>
	<CAEMkAmGrW=h5Z1YncOQ4v2nmHt99-0Wg6aP6yCTd2p-ooToA4A@mail.gmail.com>
	<20180403033033.GD6839@lemon.usersys.redhat.com>
	<20180404134122.GS4467@stefanha-x1.localdomain>
	<CAEMkAmETfoekTw=VP1K5c=z1P9uSb7pm7VNkrJjgEdd1NLjAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <CAEMkAmETfoekTw=VP1K5c=z1P9uSb7pm7VNkrJjgEdd1NLjAnA@mail.gmail.com>
Subject: Re: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2018 at 11:40:31AM +1000, Lindsay Mathieson wrote:
> Thanks Stefan, looking to develop a lizardfs block driver. A process that
> only involved building a module rather than the entire qemu tree would mike
> life easier, especially if I could test it on a live system (proxmox
> cluster). A custom qemu install is not an option for that.

Since your final goal is to create a native LizardFS block driver, it is
necessary to build a full QEMU.

With libvirt you can edit the domain XML to point
<emulator>/usr/bin/qemu-kvm</emulator> at your custom binary for just
that VM.

In the worst case you can put a little shell script in place of the
system QEMU binary that checks the command-line arguments to detect your
test VM.  It can exec your custom QEMU binary for the test VM, and the
system QEMU binary for all other VMs:

  # mv /usr/bin/qemu-kvm /usr/bin/qemu-kvm.orig
  # cat >/usr/bin/qemu-kvm
  #!/bin/sh
  if echo "$*" | grep -q -- '-name testvm'; then
      exec /path/to/custom/qemu "$@"
  else
      exec /usr/bin/qemu-kvm.orig "$@"
  fi
  ^D
  # chmod 755 /usr/bin/qemu-kvm

I recommend using qemu.git/master and not an old source tree to avoid
extra work if you want to contribute your code or if you need to ask for
help (the first question will be "does it work on qemu.git/master?" :)).

QEMU does not have stable APIs or out-of-tree modules.  Development is
most convenient when done upstream as part of the community.  Anything
else requires you to maintain a fork and community support will be very
limited.

Stefan

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaywXeAAoJEJykq7OBq3PIJm8H/26Zp/Go57R9dDRl+fUSlsyg
rMBOxQxh9zhTc5EUx/7pyI5ck4IQRxZHuJh7v+ky2GK9EsQi5cNTJ6AAlBI1Ud9n
TTxIWN3JiT6bcVvN76puBHxRVs6IO/WT+kLWoSLY/Kt2l/z+4ETbxRB8774lDFN5
ORTzes3UN1DW5MDxt963T6JJqgt6eMmj9TrLWQNS4CZwu5NRzmKlN6nueVlZi4po
GDk5dai/IfwL9lL7zNPm3hJtJbGCx7x4nsSj7uxHYU7qHwpWpZ6QHFLR7WH1gGgn
6dtC97IrQaM5yXwPMrTXmoC0sAi34Y2/6gFLyIZmgsjz6kFohaVxE43PZFTSLBM=
=GYi7
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
