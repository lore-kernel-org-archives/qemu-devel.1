Received: from eggs.gnu.org ([2001:4830:134:3::10]:33133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNdUM-0007t5-2f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNdUI-0008Nf-2v
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:12:30 -0400
Date: Tue, 29 May 2018 14:12:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529121212.GD4756@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
	<2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.05.2018 um 13:48 hat Max Reitz geschrieben:
> On 2018-05-25 18:33, Kevin Wolf wrote:
> > This adds a helper function that logs both the QMP request and the
> > received response before returning it.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> > index 17aa7c88dc..319d898172 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -206,6 +206,10 @@ def filter_qmp_event(event):
> >          event['timestamp']['microseconds'] =3D 'USECS'
> >      return event
> > =20
> > +def filter_testfiles(msg):
> > +    prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
> > +    return msg.replace(prefix, 'TEST_DIR/')
>=20
> I'd prefer 'TEST_DIR/PID-' (just because).
>=20
> But if you really like just 'TEST_DIR/'...  Then OK.

I preferred that because it leaves the output unchanged from the old
bash tests, which made reviewing the results easier. Maybe that's a too
temporary advantage to be of any use in the future, though, so we could
change it afterwards...

> > +
> >  def log(msg, filters=3D[]):
> >      for flt in filters:
> >          msg =3D flt(msg)
> > @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
> >              result.append(filter_qmp_event(ev))
> >          return result
> > =20
> > +    def qmp_log(self, cmd, **kwargs):
> > +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
> > +        log(filter_testfiles(logmsg))
> > +        result =3D self.qmp(cmd, **kwargs)
> > +        log(result)
>=20
> I think we should apply the testfiles filter here, too (error messages
> may contain file names, after all).

Didn't happen in the test outputs of this series, and filter_testfiles()
processes strings whereas result is a dict, so it would be more
complicated than just adding a function call.

Kevin

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDUOcAAoJEH8JsnLIjy/WNl0QAL4McutRR/JHZvAElz28ue60
F2v5xb8S0/n9DLH8TK3juuapeLwOrGHIUtV+TaTFZjCbenwyZ7Grt8M2WcW09z5i
/X357J/87fLfEjdSjW8kVhHZl8ADD4rPahwKsI51UBr6DV/thfeNA3UX0N7h1vHI
mafluYPmHHlp4eJO7HlLVRw9Jfs6mm8cnlapeP/VW660efGrajePZz8RM1Mru/K1
Gjg1sP//ug6agVMJzF0RaBfwCuJbTrAaDZ7rn2yR72d7O1CFeYI0unEhFzSk9/Kq
JzyIBPYv/vPXy3q0VEqNqzOfG2Bo6S0mRvx/zVvwj5RexI2smJzRkNwNXEB1ONJ4
BGj0yr/ijY6ry1DeHiJW3ySTFlbggrKzGGOppK6I5qGhrPKFXggtabLoO0wUhuxu
pBvZEW0cINPftErNqYW/PwlKRjFl8yXrnmWDLZE15Vzw2rqGwbusItR+OiVl0jo6
wwPLYDT/thpLfhXM4ujBO7dl40dxCHvqIkb47UwOE/53eNR1K0sm9YfIvecWm3F5
IfofDbaRLyA96/PsoyS4vJgEx4PAGBv6k+FknM640bhYpZwDjPlKuqdTuOoZ6gnT
otb3lSW7aCNfRRCldZVi23kGwoQmJHrKM0sz4Hr2spRs52WXNDj6RAAjqjO/1MAo
t1QaGozZftXxX1EtvKTW
=4i9z
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
