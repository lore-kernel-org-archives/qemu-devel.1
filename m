Received: from eggs.gnu.org ([2001:4830:134:3::10]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fnst2-0004H1-Vr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fnssz-0006W9-0p
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:29 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fnssy-0006V9-PR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:24 -0400
Date: Thu, 9 Aug 2018 23:54:21 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180809215421.hexdewc3igklwvob@var.youpi.perso.aquilenet.fr>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180809111233.GA2619@work-vm>
	<CAFEAcA-+5xFDMuvK2W8v=Ufs2E1K4y9onZY_4x6RMYbHLFpkxA@mail.gmail.com>
	<20180809113204.GB2618@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809113204.GB2618@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

Dr. David Alan Gilbert, le jeu. 09 ao=C3=BBt 2018 12:32:05 +0100, a ecrit=
:
> >    |--datasize---->|---m_len------->
> >    |----------m_size------------------------------>
> >                    |----M_ROOM-------------------->
> >                                     |-M_FREEROOM-->
> >=20
> >    ^               ^                               ^
> >    m_dat           m_data                          end of buffer
> >=20
> > ("datasize" is a bit misnamed, as it's "size of the leading
> > gap between the start of the buffer and the data"; "gapsize"
> > would be more helpful.)
> >=20
> > Anyway, we allocate size + datasize, and
> > m_size =3D=3D datasize + M_ROOM. We know that size >=3D M_ROOM,
> > so the allocated buffer must be at least m_size big.
>=20
> Ah OK, thanks.
> (That ascii art could do with being in a comment somewhere!)

Indeed. Peter, maybe your Signed-off-by on this? :)

Samuel

commit 4be85a1eeb6b19e91491e689d4d0d054030cbb49
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Aug 9 23:52:59 2018 +0200

    slirp: document mbuf pointers and sizes
   =20
    Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index 33b84485d6..a5bb3f9e66 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -47,6 +47,16 @@
  * free the m_ext.  This is inefficient memory-wise, but who cares.
  */
=20
+/*
+ *  |--gapsize----->|---m_len------->
+ *  |----------m_size------------------------------>
+ *                  |----M_ROOM-------------------->
+ *                                   |-M_FREEROOM-->
+ *
+ *  ^               ^                               ^
+ *  m_dat/m_ext     m_data                          end of buffer
+ */
+
 /*
  * How much room is in the mbuf, from m_data to the end of the mbuf
  */
