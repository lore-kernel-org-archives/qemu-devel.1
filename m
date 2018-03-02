Received: from eggs.gnu.org ([2001:4830:134:3::10]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereAM-0003Vv-KM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereAJ-0006DB-F7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:27:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ereAJ-0006D7-9k
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:27:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA3DE4022905
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:27:24 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:27:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302062714.GG27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-15-peterx@redhat.com>
	<20180301160138.GS14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301160138.GS14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/15] chardev: tcp: postpone async
 connection setup
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

On Thu, Mar 01, 2018 at 04:01:38PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:37PM +0800, Peter Xu wrote:
> > This patch allows the socket chardev async connection be setup with
> > non-default gcontext.  We do it by postponing the setup to machine do=
ne,
> > since until then we can know which context we should run the async
> > operation on.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> I don't like this as it is special casing behaviour wrt GMainContext
> only the the case where the chardev is configured as a client with
> non-blocking connect. So any code that uses chardevs and wants to
> set a different GMainContext may or may not work, depending on
> whether the user gave the ',wait' option to the chardev. I'm struggling
> to see why this is really needed at all.

Not sure whether I fully got your point, but IMHO when "wait" is there
we should be perfectly fine too if with all the TLS/TELNET patches in
the this series.  And for sure this patch only solves the problem when
"wait" is specified.

Or say, with this series, all configuration of chardev _should_ work
with non-default context now.  If not, then I must have missed
something else (which may be possible), then I would be very glad that
anyone can give me a hint on where.  Thanks,

--=20
Peter Xu
