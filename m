Received: from eggs.gnu.org ([2001:4830:134:3::10]:53009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDQT-0000Oe-Cy
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDQS-0003MU-Dv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:49:09 -0500
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
	<20171109042137.GA13786@lemon>
	<67bb3458-80da-beda-eec1-c08168837832@redhat.com>
	<20171109152856.GA3661@lemon>
	<e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
	<20171110023604.GA4849@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <46b65050-d4f1-496c-abff-4228f57aaa2b@redhat.com>
Date: Fri, 10 Nov 2017 18:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171110023604.GA4849@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="27PsB7NnnXcnNsih1kimtD0LAWrFS99Vx"
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--27PsB7NnnXcnNsih1kimtD0LAWrFS99Vx
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <46b65050-d4f1-496c-abff-4228f57aaa2b@redhat.com>
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
 <20171109042137.GA13786@lemon>
 <67bb3458-80da-beda-eec1-c08168837832@redhat.com>
 <20171109152856.GA3661@lemon>
 <e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
 <20171110023604.GA4849@lemon>
In-Reply-To: <20171110023604.GA4849@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 03:36, Fam Zheng wrote:
> On Thu, 11/09 20:31, Max Reitz wrote:
>> On 2017-11-09 16:30, Fam Zheng wrote:
>>> On Thu, 11/09 16:14, Max Reitz wrote:

[...]

>>>> *sigh*
>>>>
>>>> OK, I'll look into it...
>>>
>>> OK, I'll let you.. Just one more thing: could it relate to the use-af=
ter-free
>>> bug reported on block_job_defer_to_main_loop()?
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html
>>
>> Thanks for the heads-up; I think it's a different issue, though.
>>
>> What appears to be happening is that the mirror job completes and then=

>> drains its BDS.  While that is happening, a bdrv_drain_all() comes in
>> from block_migration_cleanup().
>>
>> That now tries to drain the mirror node.  However, that node cannot be=

>> drained until the job is truly gone now, so that is what's happening:
>> mirror_exit() is called, it cleans up, destroys the mirror node, and
>> returns.
>>
>> Now bdrv_drain_all() can go on, specifically the BDRV_POLL_WHILE() on
>> the mirror node.  However, oops, that node is gone now...  So that's
>> where the issue seems to be. :-/
>>
>> Maybe all that we need to do is wrap the bdrv_drain_recurse() call in
>> bdrv_drain_all_begin() in a bdrv_ref()/bdrv_unref() pair?  Having run
>> 194 for a couple of minutes, that seems to indeed work -- until it die=
s
>> because of an invalid BB pointer in bdrv_next().  I guess that is
>> because bdrv_next() does not guard against deleted BDSs.
>>
>> Copying all BDS into an own list (in both bdrv_drain_all_begin() and
>> bdrv_drain_all_end()), with a strong reference to every single one, an=
d
>> then draining them really seems to work, though.  (Survived 9000
>> iterations, that seems good enough for something that usually fails
>> after, like, 5.)
>=20
> Yes, that makes sense. I'm curious if the patch in
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01649.html
>=20
> would also work?

No, unfortunately it did not.

(Or maybe fortunately so, since that means I didn't do a whole lot of
work for nothing :-))

Max


--27PsB7NnnXcnNsih1kimtD0LAWrFS99Vx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF5oUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APfgH/1dYpc6ikODeezdXWm2qiWuIuaNjdh/Z
yNQHomvsRZRkY5Whjj6rFu9cbctzQxH0E+TFRN00z3wpCB4eIElf2SVJ+JvwQufG
2sgztGy75EqfIB8pod98MaTAeuyein0PSy4LWgOdZxFNNwlyVu2oQibVMlmqe1zG
S0nZfQthre6GYdpwM/0+H9BFK3P55u1T5JIYCos9AtTaYws1x5QHR1x6hE9mroXF
HSRFewgf2N9RzWciA41C+mmQXjdMBa3xhXY3XcoDQvwIAfQqsUgGPrHTX1ulF60W
AgSDZDqtv/1Z0qEw8hMAXrfp8366J7UP5tRSNhvy/FvR9odU5Q7kH/A=
=1+kU
-----END PGP SIGNATURE-----

--27PsB7NnnXcnNsih1kimtD0LAWrFS99Vx--
