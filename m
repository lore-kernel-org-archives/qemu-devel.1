Received: from eggs.gnu.org ([2001:4830:134:3::10]:45679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJMGP-0005E9-5E
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJMGO-0006fY-31
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:55:53 -0400
Date: Fri, 9 Jun 2017 17:55:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170609155543.GF4462@noname.redhat.com>
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
	<8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
	<20170609125831.GD4462@noname.redhat.com>
	<ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.06.2017 um 16:16 hat Eric Blake geschrieben:
> On 06/09/2017 07:58 AM, Kevin Wolf wrote:
> > Am 09.06.2017 um 14:14 hat Eric Blake geschrieben:
> >> On 06/09/2017 06:50 AM, Kevin Wolf wrote:
> >>> When qemu is exited, all running jobs should be cancelled successfull=
y.
> >>> This adds a test for this for all types of block jobs that currently
> >>> exist in qemu.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> >>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "SHUTDOWN", "data": {"guest": false}}
> >>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, =
"offset": 524288, "speed": 65536, "type": "commit"}}
> >>
> >> I'm worried that if you don't sanitize at least offset, you will still
> >> be prone to some race conditions changing the output.  You may want to
> >> add in some additional filtering on the output to be safer.
> >=20
> > I considered that at first, but then I realised that these offsets are
> > indeed predictable and we want to know if they change (it would likely
> > mean that the throttling is broken).
> >=20
> > If you look at the individual cases, we have:
> >=20
> > * offset=3D512k for (intermediate) commit and streaming. This is exactly
> >   the buffer size for a single request and will be followed by a delay
> >   of eight seconds before the next chunk is copied, so we will never get
> >   a different value here.
> >=20
> > * offset=3D4M for active commit and mirror, because the mirror job has a
> >   larger buffer size by default, so one request completes it all. This
> >   number is already the maximum, so nothing is going to change here
> >   either.
> >=20
> > * offset=3D64k for backup, which works cluster by cluster. We know that
> >   the cluster size is exactly 64k, and while we have only one second
> >   of delay here, that's still plenty of time for the 'quit' command to
> >   arrive.
>=20
> These belong in comments in the test proper, because it is not obvious
> otherwise.  But with comments added (so someone debugging a theoretical
> test failure down the road knows what they are up against),

# Note that the reference output intentionally includes the 'offset' field =
in
# BLOCK_JOB_CANCELLED events for all of the following block jobs. They are
# predictable and any change in the offsets would hint at a bug in the job
# throttling code.
#
# In order to achieve these predictable offsets, all of the following tests
# use speed=3D65536. Each job will perform exactly one iteration before it =
has
# to sleep at least for a second, which is plenty of time for the 'quit' QMP
# command to be received (after receiving the command, the rest runs
# synchronously, so jobs can arbitrarily continue or complete).
#
# The buffer size for commit and streaming is 512k (waiting for 8 seconds a=
fter
# the first request), for active commit and mirror it's large enough to cov=
er
# the full 4M, and for backup it's the qcow2 cluster size, which we know is
# 64k. As all of these are at least as large as the speed, we are sure that=
 the
# offset doesn't advance after the first iteration before qemu exits.

Does this look okay?

Kevin

--rQ2U398070+RC21q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZOsT/AAoJEH8JsnLIjy/WoJgP/RYz7jHXUWpgc3de64RwAPb/
9S6WRUR0fiOJnRwrdr5OJAmyEl0vrO02Zi8lJMZD/0+klSkb4qk1jChW552DXukP
fO0ObtsL2ODK5DYaxGSLd5VhfZNWKVAnoV2YtY0yitODEXDrvQnd3vz9C2wso1iz
t49y2fFVFLfqwo6ELsdTzMgr15wZRkZl+S4QqlXIuyYQpvq5p8qqCWsMCsdbVh3y
6lWt0eD0Z+VAW0lET9DKOHRj+Q1RdhofrsK+qz9CLHj4C8tuiaolbRYvr5lZdLMJ
n6DIFToDNnhkEMcPjkCb9scO9sBdjFNhS5ouWhgc6giB5UZKoid6iXrefCzz4eT9
pvYTuHRdhxB6u7Gnf5btPe/uM8kvNn6QTPKpfhCisVZEuXGPzKLjNahpQ3CRvRes
Sy4fEmptQarHc+F3p1SODXo1CibPgqSZl2Km1trstq+bsKgancsRPZBQyxXMn0T4
LL4zmyEycIzFKyCCy+4VKDsR6EjfdSt+VhG8HBLJ22Z23w3rrE3KTBjqM+8fb3Br
fwhSIiY5jeVNqcEDTHE7pTqa/eM+7ucuJ6YaATbMH8Q0z2h/adIVsmse+u7VG3+k
1bdsP/7hU0ZHA6OVUYW5HIw3CWOLqTVCdnIjoAkoVIZzwedc6FStQdEET5tQqZ8A
xEgId0X4rsLsmKSPcXUA
=C3cM
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
