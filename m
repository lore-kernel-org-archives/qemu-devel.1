Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftZLw-0005i0-2c
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 10:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftZLv-000664-68
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 10:15:48 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
	<fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
	<e97c1bf4-9cbf-eb5a-7237-c83c534eb3b6@redhat.com>
	<208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
Message-ID: <f9019cc4-65da-eecc-4e2a-0e0d9d8db603@redhat.com>
Date: Sat, 25 Aug 2018 16:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2mCUYmOAYs4zOMvyDT1oMFVhSCF6kYpK3"
Subject: Re: [Qemu-devel] [PATCH 1/7] jobs: change start callback to run
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2mCUYmOAYs4zOMvyDT1oMFVhSCF6kYpK3
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <f9019cc4-65da-eecc-4e2a-0e0d9d8db603@redhat.com>
Subject: Re: [PATCH 1/7] jobs: change start callback to run callback
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-2-jsnow@redhat.com>
 <fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
 <e97c1bf4-9cbf-eb5a-7237-c83c534eb3b6@redhat.com>
 <208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
In-Reply-To: <208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-25 15:33, Max Reitz wrote:

[...]

> Having a central Error object doesn't really make sense.  Whenever the
> block job wants to return an error, it should probably do so as "return=
"
> values of methods (like .run()).  Same for ret, of course.
>=20
> I understand that this is probably really only possible after v2 when
> you've made more use of abort/commit.  But still, I don't think this
> patch improves anything, so I would leave this clean-up until later whe=
n
> you can really do something.
>=20
> I suppose the idea here is that you want to drop the errp parameter fro=
m
> job_completed(), because it is not going to be called by .exit().  But
> the obvious way around this would be to pass an errp to .exit() and the=
n
> pass the result on to job_completed().

You know what, I wrote a really long reply and in the end I realized you
basically did exactly what I wanted.  (Or, rather, I gave two
alternatives, and you did one of them.)

I noticed that having a central error object may still make sense;
=2Ecreate() shows why, jobs usually fail in .run() and then you need to
keep the error around for a bit.  You can either pass it around, or you
just keep it in Job (those are the two alternatives I gave).

(So I said, either rip out Job.error/Job.err and Job.ret completely, or
keep the iff relationship between Job.err and Job.ret, so together they
give you a meaningful state.)

Now by setting Job.ret and Job.err basically at the same time (both are
results of .run(), and whenever Job.ret is set somewhere else, it is
immediately followed by job_update_rc()), the iff relationship between
Job.err and Job.ret persists.  So that's good!

(In that case I don't know why you removed the "iff" part from the
comment, though.)


The only remaining question I have is why you still pass job->ret to
job_completed().  That seems superfluous to me.

Max


(No, I don't know what's up with me and completely misunderstanding this
series.)


--2mCUYmOAYs4zOMvyDT1oMFVhSCF6kYpK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluBZIcACgkQ9AfbAGHV
z0C6pwf/bkqzgJp51KHf0QF3Z9b/R1m6wkW53iQb3wYcBTbKxdhRfr9S1Yg2Tnmu
Os+aQYnjR+CnUikEnYwNoqiD4eXG39Fk7MhEciZaxPnBXHOLfhYMgGQ6MZSu5uii
ew+ZCRfHbbgzg6jdDCmh32DEt1ce9/6fcIG7CcVIpOWCLuekNNGUIs4en8iVv7By
M3n+/05AAkuZbwrZgAoPQpMzrJiJP+HdyhwXUk6i2/9qyEyc6XqBtrbYE7zHpFrr
/cIDQnb4eABYOkt4+zjOnGKbRHQkufdojlPO+dd/1S66mztQ2/CoZSbpDVC6MAnS
mS7dx88DhkVyQBP/cRoVsMX+ULIAqQ==
=OwqQ
-----END PGP SIGNATURE-----

--2mCUYmOAYs4zOMvyDT1oMFVhSCF6kYpK3--
