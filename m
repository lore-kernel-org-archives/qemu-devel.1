Received: from eggs.gnu.org ([2001:4830:134:3::10]:37372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eJKty-0003Z2-Fn
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eJKts-00068q-Ci
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:00:54 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123072438.GE1624@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8be98628-4ade-1c93-8133-5f841ed9fea2@redhat.com>
Date: Mon, 27 Nov 2017 16:00:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171123072438.GE1624@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="74FxWt0eaDrXo3QQ4x3Rg5Dj0pnVuWBfa"
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: Fix iotests for weird
 formats/options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--74FxWt0eaDrXo3QQ4x3Rg5Dj0pnVuWBfa
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <8be98628-4ade-1c93-8133-5f841ed9fea2@redhat.com>
Subject: Re: [PATCH 00/17] iotests: Fix iotests for weird formats/options
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123072438.GE1624@lemon>
In-Reply-To: <20171123072438.GE1624@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-23 08:24, Fam Zheng wrote:
> On Thu, 11/23 03:08, Max Reitz wrote:
>> (I hate to write Python tests because the boilerplate seems so large a=
nd
>>  the debugging is so hard.  But there is test 194 which shows that it =
is
>>  possible to write simple bash-like tests as well--and that is how I
>>  should probably write tests from now on.)
>=20
> If the boilerplate means copy&paste from another test it is not a big p=
roblem;

I do much more C&P in bash tests. ;-)

It's not about the boilerplate I have to write, but the boilerplate that
exists and that tries its best to be opaque to me.

> if you really mean it's more cumbersome than bash to write test code, I=
 think we
> can try new ways to exploit Python's expressiveness. 2c93c5cb43 and f48=
44ac0ad
> are good examples.

One thing is that I hate to write tests that are methods in classes and
are called automagically by their method name starting in "test_" (or
something?).  I personally don't like the start-up/tear-down semantics
through methods very much either and feel like often it doesn't quite
fit the iotests.

Indeed, I like the blocks Stefan uses in 194 with set-up in the with
statement and implicit tear-down at its end (which f4844ac0ad helps with)=
=2E

The kind of other thing is that by boilerplate I mean all of this magic.
 We have this QMPTestCase framework behind everything (except 194) and I
have no real idea how it works, and I don't feel like I'm supposed to.

Also, I just personally dislike frameworks in general.  I hate to write
code that's magically invoked by other code without me knowing how, and
that's exactly what's happening with QMPTestCase--you write some classes
and some methods and never are they actually instantiated in your code,
but it's some other code that I don't see (and that I'm supposed to not
care about).  I just don't like that.   I want to write a simple test,
not a library.

Finally, and probably least of the issues, VM.  Which inherits from
QEMUQtestMachine.  Which inherits from QEMUMachine.  All of which are in
different files.  This, too, feels a bit like I'm not supposed to know
what's going on and a bit opaque.  (In contrast to bash's common.qemu,
where I can see exactly what's doing what and don't have to follow
method calls through three files.)  But having to look at three files
instead of one is really a minor issue compared to the rest (but it does
add to the feeling of boilerplate).

So all in all much very personal annoyance.  But still, since I have to
write some tests, this personal annoyance used to result in me
preferring bash for the job.

> So what do you think about debugging? IMO the biggest problem is the le=
ss
> verbose reference output, and lack of a separate logging channel. We ca=
n and
> should improve that, even for existing scripts.

Yes, those are my issues as well.  Especially that stderr would be my
preferred separate logging channel, but it's redirected and never
printed.  Well, I now have this:

#define loggu(...) \
    do { \
        FILE *fp =3D fopen("/tmp/log", "a"); \
=C2=A0       fprintf(fp, __VA_ARGS__); \
        fclose(fp); \
    } while (0)

which helps me get around this, but, you know...

> And yes, the 194 style is actually better than "iotests.QMPTestCase" on=
es.

As you could see, roughly 90 % of my annoyance is due to QMPTestCase, so
I tend to agree. :-)

(The other 10 % is not iotests.VM, but Python itself--and that's
comparing it to bash...)

Max


--74FxWt0eaDrXo3QQ4x3Rg5Dj0pnVuWBfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlocKI0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGTcH/jOUL8OkDV/34vJVFqNgNDFa+lH5mHKx
5ZH0/9LiXmCkTwTyGS0YnOXZPSQXPruJspiXmlnd8/P51jLIIG5jXUW2di7+MYw9
w2sfQk10slJ/64pR00Ih7/uydrD6RU+yJa+GH61xiP/hT+9/HYZRmNkrsug8wbSA
csUdwOsG05Ry+qEBM+tvhR0nD/d9qO/H+vp41QcYmXHDjp0S4QRAl1RQiDql9RWG
BCfh2kKX53xwiAdDx3pKEjNY+cza4mGBfHcjbBOE0yphsE3ziw+J56AiXuJ0BtS5
bcYFpMo4yaT73PiiWygxGJYGRCwE8/ilgg+3DGhwYWh1p8iQcDpkcu8=
=irK+
-----END PGP SIGNATURE-----

--74FxWt0eaDrXo3QQ4x3Rg5Dj0pnVuWBfa--
