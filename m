Received: from eggs.gnu.org ([2001:4830:134:3::10]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewoib-0005WB-Ks
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewoia-0008Rs-Ox
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:44:21 -0400
Date: Fri, 16 Mar 2018 13:44:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180316124415.GA5851@localhost.localdomain>
References: <20180313161803.1814-1-kwolf@redhat.com>
	<CAFEAcA-u_++4suoFBnea--7hajd1Mnb1kadwRc+GjZvHXvou-Q@mail.gmail.com>
	<20180315165649.GE3876@localhost.localdomain>
	<ba91fe2c-ae5d-15a0-9d18-1ae15d5dcc74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba91fe2c-ae5d-15a0-9d18-1ae15d5dcc74@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Am 15.03.2018 um 18:55 hat John Snow geschrieben:
>=20
>=20
> On 03/15/2018 12:56 PM, Kevin Wolf wrote:
> > Am 15.03.2018 um 17:42 hat Peter Maydell geschrieben:
> >> On 13 March 2018 at 16:17, Kevin Wolf <kwolf@redhat.com> wrote:
> >>> The following changes since commit 22ef7ba8e8ce7fef297549b3defcac33=
3742b804:
> >>>
> >>>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-requ=
est' into staging (2018-03-13 11:42:45 +0000)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >>>
> >>> for you to fetch changes up to be6c885842efded81a20f4ca24f0d4e123a8=
0c00:
> >>>
> >>>   block/mirror: change the semantic of 'force' of block-job-cancel =
(2018-03-13 16:54:47 +0100)
> >>>
> >>> ----------------------------------------------------------------
> >>> Block layer patches
> >>>
> >>> ----------------------------------------------------------------
> >>
> >> I get a compile failure here on some hosts:
> >>
> >> /home/pm215/qemu/blockjob.c: In function =E2=80=98block_job_txn_appl=
y.isra.8=E2=80=99:
> >> /home/pm215/qemu/blockjob.c:524:5: error: =E2=80=98rc=E2=80=99 may b=
e used
> >> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>      return rc;
> >>      ^
> >>
> >> I guess the compiler can't always figure out whether there is
> >> guaranteed to be at least one thing in the list ?
> >=20
> > I think so.
> >=20
> > John, I'll just modify your patch 'blockjobs: add prepare callback' t=
o
> > initialise rc =3D 0 in this function and send a v2 pull request.
> >=20
> > Kevin
> >=20
>=20
> Oh, interesting. I guess technically the list COULD be empty and that'd
> be perfectly valid. I wonder why my compiler doesn't complain?
>=20
> Anyway, initializing to zero seems like the correct behavior, thanks.

You only call block_job_txn_apply() in the context of completing a
specific job, which has to be in its transaction, so I don't think the
list can actually be empty.

Not sure how the compiler is able to infer that, though.

Kevin
