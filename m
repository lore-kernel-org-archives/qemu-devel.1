Received: from eggs.gnu.org ([2001:4830:134:3::10]:43665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakFE-0002oF-Oc
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakF6-0005iX-6k
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:26:11 -0500
Message-ID: <1486391163.32329.24.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Feb 2017 15:26:03 +0100
In-Reply-To: <1486115549-9398-1-git-send-email-mjt@msgid.tls.msk.ru>
References: <1486115549-9398-1-git-send-email-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] vnc: do not disconnect on EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org

On Fr, 2017-02-03 at 12:52 +0300, Michael Tokarev wrote:
> When qemu vnc server is trying to send large update to clients,
> there might be a situation when system responds with something
> like EAGAIN, indicating that there's no system memory to send
> that much data (depending on the network speed, client and server
> and what is happening).  In this case, something like this happens
> on qemu side (from strace):
>=20
> sendmsg(16, {msg_name(0)=3DNULL,
>         msg_iov(1)=3D[{"\244\"..., 729186}],
>         msg_controllen=3D0, msg_flags=3D0}, 0) =3D 103950
> sendmsg(16, {msg_name(0)=3DNULL,
>         msg_iov(1)=3D[{"lz\346"..., 1559618}],
>         msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EAGAIN
> sendmsg(-1, {msg_name(0)=3DNULL,
>         msg_iov(1)=3D[{"lz\346"..., 1559618}],
>         msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EBADF
>=20
> qemu closes the socket before the retry, and obviously it gets EBADF
> when trying to send to -1.
>=20
> This is because there WAS a special handling for EAGAIN, but now it doesn=
't
> work anymore, after commit 04d2529da27db512dcbd5e99d0e26d333f16efcc, beca=
use
> now in all error-like cases we initiate vnc disconnect.
>=20
> This change were introduced in qemu 2.6, and caused numerous grief for ma=
ny
> people, resulting in their vnc clients reporting sporadic random disconne=
cts
> from vnc server.
>=20
> Fix that by doing the disconnect only when necessary, i.e. omitting this
> very case of EAGAIN.
>=20
> Hopefully the existing condition (comparing with QIO_CHANNEL_ERR_BLOCK)
> is sufficient, as the original code (before the above commit) were
> checking for other errno values too.
>=20
> Apparently there's another (semi?)bug exist somewhere here, since the
> code tries to write to fd# -1, it probably should check if the connection
> is open before. But this isn't important.
>=20
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 04d2529da27db512dcbd5e99d0e26d333f16efcc
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-stable@nongnu.org

Added to ui patch queue.

thanks,
  Gerd
