Received: from eggs.gnu.org ([2001:4830:134:3::10]:46261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dL6Z4-0002T4-Aa
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dL6Z1-0002Hg-MN
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:34:22 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dL6Z1-0002GK-Bf
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:34:19 -0400
Message-ID: <1497440051.15929.10.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 14 Jun 2017 13:34:11 +0200
In-Reply-To: <20170614081717.GA4370@redhat.com>
References: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
	<c1871854a5510bdb24198d266c28788aa81d3f10.1497035841.git-series.knut.omang@oracle.com>
	<20170614081717.GA4370@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] socket: Handle race condition between
 binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, 2017-06-14 at 09:17 +0100, Daniel P. Berrange wrote:
> On Fri, Jun 09, 2017 at 09:19:49PM +0200, Knut Omang wrote:
> > If an offset of ports is specified to the inet_listen_saddr function(),
> > and two or more processes tries to bind from these ports at the same ti=
me,
> > occasionally more than one process may be able to bind to the same
> > port. The condition is detected by listen() but too late to avoid a fai=
lure.
> >=20
> > This function is called by socket_listen() and used
> > by all socket listening code in QEMU, so all cases where any form of dy=
namic
> > port selection is used should be subject to this issue.
> >=20
> > Add code to close and re-establish the socket when this
> > condition is observed, hiding the race condition from the user.
> >=20
> > This has been developed and tested by means of the
> > test-listen unit test in the previous commit.
> > Enable the test for make check now that it passes.
> >=20
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> > ---
> > =C2=A0tests/Makefile.include |=C2=A0=C2=A0=C2=A02 +-
> > =C2=A0util/qemu-sockets.c=C2=A0=C2=A0=C2=A0=C2=A0| 106 ++++++++++++++++=
+++++++++++++-------------
> > =C2=A02 files changed, 76 insertions(+), 32 deletions(-)
>=20
> FYI, the changes here will conflict with a pull request that I have
> pending, so please rebase against this PR
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01940.html

Ok, v3 will be from this base,

Knut

>=20
> Regards,
> Daniel
