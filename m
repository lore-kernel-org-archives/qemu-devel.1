Received: from eggs.gnu.org ([209.51.188.92]:50888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzSea-0008E7-8o
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzSeZ-0000KB-KG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:51:40 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gzSeS-0000B0-Qs
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:51:35 -0500
Date: Thu, 28 Feb 2019 12:51:09 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190228205109.hmldtldbnlw3pnqq@function>
References: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] socket: fix blocking udp recvfrom.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: llyzs <llyzs.vic@gmail.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

Hello,

llyzs, le jeu. 28 f=C3=A9vr. 2019 19:59:12 +0800, a ecrit:
> Sometimes sorecvfrom() is called from slirp.c because revents =3D=3D G_=
IO_IN,
> however inside sorecvfrom() function, ioctlsocket() returns 0 bytes ava=
ilable
> and recvfrom could be blocking indefinitely. This adds a non-blocking f=
lag to
> recvfrom and checks data availability.

When ioctlsocket() returns 0 bytes available, we could as well just
immediately return, without even calling recvfrom. We could just move
that ioctlsocket call above the m_get() call, so we can just return
without having to clean up anything.

This however still looks weird. AFAIK, G_IO_IN means that we can make
one recv call and be sure that it won't block. Do you have an idea why
it wouldn't necessarily be the case?

Samuel
