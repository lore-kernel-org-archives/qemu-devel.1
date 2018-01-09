Received: from eggs.gnu.org ([2001:4830:134:3::10]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYr5b-0006t1-9e
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYr5a-00070d-CZ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:25:03 -0500
Date: Tue, 9 Jan 2018 11:24:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180109102448.GC6063@localhost.localdomain>
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
	<1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
	<20171222135208.GI3763@localhost.localdomain>
	<edf5c1d0-c899-be0c-f4f2-b4e6eec0193b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <edf5c1d0-c899-be0c-f4f2-b4e6eec0193b@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: eblake@redhat.com, qemu-block@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Karl Heubaum <karl.heubaum@oracle.com>

Am 08.01.2018 um 20:57 hat Jack Schwartz geschrieben:
> Hi Kevin.
>=20
> On 2017-12-22 05:52, Kevin Wolf wrote:
> > Am 22.12.2017 um 01:11 hat Jack Schwartz geschrieben:
> > > BLOCK_IO_ERROR events currently contain a "reason" string which is
> > > strerror(errno) of the error.  This enhancement provides those even=
ts with
> > > the numeric errno value as well, since it is easier to parse for er=
ror type
> > > than a string.
> > >=20
> > > Signed-off-by: Jack Schwartz<jack.schwartz@oracle.com>
> > > Reviewed-by: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
> > > Reviewed-by: Karl Heubaum<karl.heubaum@oracle.com>
> > Apart from the technical details that Eric mentioed, I wonder what is
> > your use case for this?
> We have thousands of servers in our cloud, and would like to closely mo=
nitor
> for different kinds of disk errors without parsing the non-machine-read=
able
> error string.

So do you actually care about the semantical difference between, say,
EINVAL and EIO, and treat them differently in the monitoring? To be
honest, I can't see anything useful you could do with this information
because there are so many possible causes for each of the error codes.

Because if the only thing you want to do with them is to log them in
different categories, you can use the error strings without parsing
them.

> > Exposing errors in a machine readable form was discussed earlier,
> OK, found it.=A0 April of 2010.
>=20
> Upshot of discussion: exposing naked errnos are platform dependent.

Right, that's what Eric mentioned.

> >   and
> > the result was that nobody had an actual use for error codes other th=
an
> > presenting the right error message to the user - which the error stri=
ng
> > already achieves.
> Given the platform independence requirement, exposing errors to clients=
 is
> not that simple given that different OSs use different errno values.=A0=
 Other
> options/considerations than exposing naked errno values:
>=20
> - Having a platform-independent enumeration of errors, as Eric suggeste=
d.=A0
> This would have to explicitly set an enumerated value for each individu=
al
> errno we are interested in.=A0 It would be returned in a field that ~pa=
rallels
> the "reason" string.=A0 This should be OK since for BLOCK_IO_ERROR even=
ts we
> could limit values to just storage device errors plus a default "other"=
;
> otherwise this could be hard to maintain.

But what are "storage device errors"? Can't we get more or less any
error while processing an I/O request?

> - The strerror strings cannot be used because they can change with loca=
le.
> (This also assumes the strings are identical for given errnos
> cross-platform, and that there are no typos - which are not automatical=
ly
> checked-for.)

You mean when you aggregate errors from multiple different hosts running
on different platforms and where you don't control the locale?

But cross-platform, even the exact numeric error codes you get may
differ, so they become even less meaningful than they already are on a
single platform.

Kevin
