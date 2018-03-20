Received: from eggs.gnu.org ([2001:4830:134:3::10]:45311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ey7R4-0008Kj-SR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ey7R1-0001bc-0B
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:55:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ey7R0-0001au-LE
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:55:34 -0400
Date: Tue, 20 Mar 2018 10:55:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180320025527.GA20227@xz-mi>
References: <20180316140508.863778-1-eblake@redhat.com>
	<CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
	<20180319092618.GF2477@xz-mi>
	<3a7260c1-bb51-63a0-5a1b-588a7b1757b3@redhat.com>
	<c0c59533-3501-e17e-92d3-6af81f872206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0c59533-3501-e17e-92d3-6af81f872206@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Mar 19, 2018 at 10:27:41AM -0500, Eric Blake wrote:
> On 03/19/2018 09:57 AM, Eric Blake wrote:
> > On 03/19/2018 04:26 AM, Peter Xu wrote:
> >=20
> > > > > for you to fetch changes up to
> > > > > 75eb57e3ed3682f011a6694863044e8b143a9821:
> > > > >=20
> > > > > =C2=A0=C2=A0 qapi: Pass '-u' when doing non-silent diff (2018-0=
3-16
> > > > > 09:00:07 -0500)
> > > > >=20
> >=20
> > > > Hi. I get a bunch of test assertion failures with this:
> > > >=20
>=20
> >=20
> > I haven't been able to reproduce the testsuite failures on my Linux b=
ox,
> > but if it's a race, then that doesn't make me all the more confident =
on
> > what it takes to reproduce and/or fix the race.
>=20
> Okay, my simple builds on just x86_64-softmmu weren't hitting it, but m=
y
> 'build all binaries' tree seems to be hitting the same thing:
>=20
>   GTESTER check-qtest-ppcemb
> qemu-system-ppcemb: chardev/char-io.c:91: io_watch_poll_finalize: Asser=
tion
> `iwp->src =3D=3D NULL' failed.
> Broken pipe
> GTester: last random seed: R02S74d45e64b38428eddd131a5c1b4c878c
> make: *** [/home/eblake/qemu-tmp/tests/Makefile.include:878:
> check-qtest-ppcemb] Error 1
>=20
> so I'm now testing if your squash makes a difference, now that it looks=
 like
> I'm reproducing the problem.

Exactly what I encountered.  My old tests on v8 are not strong enough
(less binaries, less concurrency).  I reproduced that easily when I
didn't specify --target-list (so all binaries), then run tests with
more concurrency (-j8).

However still I never reproduced the QIO problem even with that.  I
suspect that's a more hard-to-trigger race, and even it might not
related to OOB (but I'm not sure).

--=20
Peter Xu
