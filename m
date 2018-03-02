Received: from eggs.gnu.org ([2001:4830:134:3::10]:45288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereH1-0006ZF-KQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereGy-00031s-FC
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:34:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ereGy-0002me-BE
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A76F28D6EF
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:34:11 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:34:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302063401.GH27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-16-peterx@redhat.com>
	<20180301160304.GT14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301160304.GT14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/15] chardev: tcp: postpone TLS work
 until machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 04:03:04PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:38PM +0800, Peter Xu wrote:
> > TLS handshake may create background GSource tasks, while we won't kno=
w
> > the correct GMainContext until the whole chardev (including frontend)
> > inited.  Let's postpone the initial TLS handshake until machine done.
> >=20
> > If we dynamically add tcp chardev, it won't be affected since we have=
 a
> > new tcp_chr_machine_done flag to know whether we should postpone it o=
r
> > not.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
>=20
> I don't like this patch either for the same reasons as previous
> patch - its creating different behaviour depending on whether
> the 'wait' flag happens to have been set in -chardev.

IMHO it's because the socket chardev is indeed complicated... If you
see qmp_chardev_open_socket(), that's where most of the complexity
lies in.  And as I explained, each of the patch, or group of patches,
were only trying to solve a single problem.

Though I admit this patch has brought a little bit more complexity,
though in the short term I don't see a better solution. And, if you
consider the existing MUX machine done hook, then it's merely using
the same way to do it but even cleaned it up a bit...

Please let me know if you have any suggestion that I can do it in a
better way.  Thanks!

--=20
Peter Xu
