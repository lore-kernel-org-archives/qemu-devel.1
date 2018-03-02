Received: from eggs.gnu.org ([2001:4830:134:3::10]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereUH-0001ZD-VJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereUE-0005t5-SJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:48:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ereUE-0005st-Mm
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:48:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D2758182D1E
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:48:10 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:48:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302064804.GJ27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301160706.GV14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301160706.GV14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/15] qio: general non-default
 GMainContext support
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

On Thu, Mar 01, 2018 at 04:07:06PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:23PM +0800, Peter Xu wrote:
> > This is another preparation work for monitor OOB seires.
> >=20
> > V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.=
html
> >=20
> > V2 rewrote the bottom half of the code.  The first 8 patches are
> > mostly the same, but I rewrote the last patches to solve both TLS and
> > reconnect use cases by introducing a machine_done hook for chardevs i=
n
> > general.  So if I copy the problems:
> >=20
> > - migration
> >   - incoming side: still always running on main context, while we nee=
d
> >     to be able to run some command in OOB thread [1]
> > - tcp chardev (non-tcp chardevs should all support non-NULL context n=
ow)
> >   - server listening mode: QIO net listener used [2]
> >   - TELNET session: an isolated GSource used (tcp_chr_telnet_init) [3=
]
> >   - when "reconnect=3DN" is used, QIO threaded task is used [4]
> >   - TLS session: QIO tls handshake is used (tcp_chr_tls_init) [5]
> >=20
> > Problem [1-3] are still fixed in the old way, but [4-5] now are fixed
> > by using the new machine_done notifier.
>=20
> The QIO code changes all look good to me know, aside from minor
> comments. I really dislike all of the chardev stuff though. I
> think it makes the chardev code even harder to follow & rationalize
> behaviour of.
>=20
> If you post a v3 series contaning just the qio/ directory changes,
> I'd queue those patches, while we discuss chardev stuff more.
>=20
> I struggle to suggest better approach, because its any missing
> context of how the changes are going to be used, presumably by
> patch series yet to be posted.=20

Yeah I think I'll split the series into two.

Thank you and Paolo for the quick review comments!

--=20
Peter Xu
