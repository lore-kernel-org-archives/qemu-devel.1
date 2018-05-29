Received: from eggs.gnu.org ([2001:4830:134:3::10]:39667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNdup-0000of-Hi
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNduo-0001zn-8S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:39:51 -0400
Date: Tue, 29 May 2018 14:39:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529123942.GE4756@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
	<2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
	<20180529121212.GD4756@localhost.localdomain>
	<824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
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


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.05.2018 um 14:15 hat Max Reitz geschrieben:
> On 2018-05-29 14:12, Kevin Wolf wrote:
> > Am 29.05.2018 um 13:48 hat Max Reitz geschrieben:
> >> On 2018-05-25 18:33, Kevin Wolf wrote:
> >>> This adds a helper function that logs both the QMP request and the
> >>> received response before returning it.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  tests/qemu-iotests/iotests.py | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
> >>> index 17aa7c88dc..319d898172 100644
> >>> --- a/tests/qemu-iotests/iotests.py
> >>> +++ b/tests/qemu-iotests/iotests.py
> >>> @@ -206,6 +206,10 @@ def filter_qmp_event(event):
> >>>          event['timestamp']['microseconds'] =3D 'USECS'
> >>>      return event
> >>> =20
> >>> +def filter_testfiles(msg):
> >>> +    prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
> >>> +    return msg.replace(prefix, 'TEST_DIR/')
> >>
> >> I'd prefer 'TEST_DIR/PID-' (just because).
> >>
> >> But if you really like just 'TEST_DIR/'...  Then OK.
> >=20
> > I preferred that because it leaves the output unchanged from the old
> > bash tests, which made reviewing the results easier. Maybe that's a too
> > temporary advantage to be of any use in the future, though, so we could
> > change it afterwards...
>=20
> It doesn't really make reviewing the patches easier, though, because the
> hardest part of course is the change of the test itself and not the
> change of the result. :-)
>=20
> (And some file name changes really are on the easy side.)

If you think so... For me the main reason to convert the test files was
to see whether the job actually does the same thing as the old
synchronous command did.

> >>> +
> >>>  def log(msg, filters=3D[]):
> >>>      for flt in filters:
> >>>          msg =3D flt(msg)
> >>> @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
> >>>              result.append(filter_qmp_event(ev))
> >>>          return result
> >>> =20
> >>> +    def qmp_log(self, cmd, **kwargs):
> >>> +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwar=
gs)
> >>> +        log(filter_testfiles(logmsg))
> >>> +        result =3D self.qmp(cmd, **kwargs)
> >>> +        log(result)
> >>
> >> I think we should apply the testfiles filter here, too (error messages
> >> may contain file names, after all).
> >=20
> > Didn't happen in the test outputs of this series, and filter_testfiles()
> > processes strings whereas result is a dict, so it would be more
> > complicated than just adding a function call.
>=20
> You mean it would be "log(filter_testfiles('%s' % result)))"?

Ah, you mean just for logging? Yes, we can do that. I thought you meant
returning a filtered result as well.

Kevin

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDUoOAAoJEH8JsnLIjy/WQLIP/2huQt4fXha2As6VwXj8K4xz
s6i/lZzPnr1tA9BsMmgq7IrI7ATLUhaQaPnBNd8ixH2k1mG5FgJNsF2dZhEmnf3D
vxy6Yn8M5esswqezgD+HUYvjHpFjhsfXH8u3L4jR0ySG5XZVaYBGTSFPc1D2Q/Ni
a+1Jb43mBHTO4gTzOCdVft8QsrmKJe8cmbV9UGBb/hbaGe/S5Kz4oDScgRrxTFdI
rCbEPmdLeK6i4k1BTX1IXzC7jn/smER65iDIrCUyPUyxMGY/scQW7oXG+rt1Hp57
6mkXuTc1vqi0ONVmSZiogtL0+zqovf9Ak52hMuWphmnDtw5RTzna2XTCQeBn4oTQ
3sB4XQ4ZqVXz0pbk3zs0ULZ8zPZ2WUTMb71jeMOdVZHFmK5Un5gSxVxK0hniiJd8
9V2cagmMqXZN/tmmBF//rQ6VYhN5XbosB1u4pGU3ubzefmiXHyj8ihWFJa5vVkAf
/RIQUOE6r8AAqtOVQnglffrU7XVrwnHSIGVXRlTTDozEJSk1S0BB0UUosW+eJjHH
R58Tdf4BbEMco9rjDxdmmnT4NmfKHLChFMhLwm+Pcl+4zyCYG9biK2N5p+boc+zd
xTum1zE7oSbkn3AZ/3qHehWa5QbWPd4ro6LHV8ZN6vKgW2tKLV+UVitsbcajJ1pC
fxMnV5WA2PO7zGCuofYu
=sIsz
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
