Received: from eggs.gnu.org ([2001:4830:134:3::10]:40336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwoU-0007qA-PJ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwoT-0006Cv-Ho
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:49:14 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-8-mreitz@redhat.com>
	<53a4f279-49cc-7bf3-824a-4cb98fd9590c@redhat.com>
	<906eccc3-dba6-5674-45cd-fa11b4ea25b8@redhat.com>
	<8c3b3d8a-93ca-451e-4929-af9d6210c1d5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d7a7eed8-718c-ac16-8f18-8a3244369a5d@redhat.com>
Date: Wed, 2 May 2018 20:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <8c3b3d8a-93ca-451e-4929-af9d6210c1d5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sTEVNgiXGUSGaEoApRU0BrYfNy3Stm2HS"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] iotests: Rework 113
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sTEVNgiXGUSGaEoApRU0BrYfNy3Stm2HS
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d7a7eed8-718c-ac16-8f18-8a3244369a5d@redhat.com>
Subject: Re: [Qemu-block] [PATCH 7/7] iotests: Rework 113
References: <20180421165423.30759-1-mreitz@redhat.com>
 <20180421165423.30759-8-mreitz@redhat.com>
 <53a4f279-49cc-7bf3-824a-4cb98fd9590c@redhat.com>
 <906eccc3-dba6-5674-45cd-fa11b4ea25b8@redhat.com>
 <8c3b3d8a-93ca-451e-4929-af9d6210c1d5@redhat.com>
In-Reply-To: <8c3b3d8a-93ca-451e-4929-af9d6210c1d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 20:18, John Snow wrote:
>=20
>=20
> On 05/02/2018 02:13 PM, Max Reitz wrote:
>> On 2018-05-02 20:03, John Snow wrote:
>>>
>>>
>>> On 04/21/2018 12:54 PM, Max Reitz wrote:
>>>> This test case has been broken since 398e6ad014df261d (roughly half =
a
>>>> year).  qemu-img amend requires its output image to be R/W, so it op=
ens
>>>> it as such; the node is then turned into an read-only node automatic=
ally
>>>> which is now accompanied by a warning, however.  This warning has no=
t
>>>> been part of the reference output.
>>>>
>>>> For one thing, this warning shows that we cannot keep the test case =
as
>>>> it is.  We would need a format that has no create_opts but that does=

>>>> have write support -- we do not have such a format, though.
>>>>
>>>> Another thing is that qemu now actually checks whether an image form=
at
>>>> supports amendment instead of whether it has create_opts (since the
>>>> former always implies the latter).  So we can now use any format tha=
t
>>>> does not support amendment (even if it supports creation) and thus t=
est
>>>> the same code path.
>>>>
>>>> The reason nobody has noticed the breakage until now of course is th=
e
>>>> fact that nobody runs the iotests for nbd+bochs.  There actually was=

>>>> never any reason to set the protocol to "nbd" but because that was
>>>> technically correct; functionally it made no difference.  So that is=
 the
>>>> first thing we are going to change: Make the protocol "file" instead=
 so
>>>> that people might actually notice breakage here.
>>>>
>>>> Secondly, now that bochs no longer works for the amend test case, we=

>>>> have to change the format there anyway.  Set let us just bend the tr=
uth
>>
>> I suppose s/Set/So/
>>
>>>> a bit, declare this test a raw test.  In fact, that does not even
>>>> concern the bochs test cases, other than the output now reading 'boc=
hs'
>>>> instead of 'IMGFMT'.
>>>>
>>>> So with this test now being a raw test, we can rework the amend test=

>>>> case to use raw instead.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>
>>> Well, it passes... Not sure if I'm wild about the format change, it
>>> sounds like a failure of our CI more than something that needed to
>>> change in the test, but... shrug.
>>
>> I think it's not really an issue in the CI.  Testing all possible
>> combinations of protocols and formats seems too much to me.
>>
>> I think it really is an issue in our test suite.  There are many tests=

>> that work only with a single combination (numerous file+qcow2 tests, f=
or
>> instance), so having our great test matrix capability is completely
>> useless for them.
>>
>> Maybe tests should be able to offer a preferred format+protocol
>> (+options) combination?  Then, when you run check without any such
>> arguments, it would just run each test in its preferred mode.
>>
>> Max
>>
>=20
> "You're not wrong" -- iotests presents an impossible matrix. You're not=

> going to fix our infrastructural problems with this one patch, which
> looks like a hack in contrast to how the rest of iotests is presently
> structured.
>=20
> I don't oppose it, though. Just voicing my full-throated ambivalence.
> There's definitely a discussion or two to be had about what
> instrumenting iotests looks like and how we can ensure we're getting
> proper coverage. The current solution *is* bad.

I do completely agree with you.  It's a hack.  That's why my
justification in the commit message is rather long.

And indeed I was thinking about what we could do to the iotests to get
around this.  I thought of maybe fixing some iotests to a specific
format+protocol combination and then always run them with that,
regardless of what the user specified -- but that would mean running
them always, which is stupid because it would take too much time for
every combination you want to test.

I didn't think of adding a "default" mode to the check script, though,
which would allow you to run that fixed combination only then.  (Though
you may want to be able to run such tests with different combinations,
too, though -- the "default" mode just ensures the test is run at all).

So my solution was to just hack around this with a questionable
(although not fully wrong) explanation; and to see which tests I
personally didn't run so far (and then added the proper combinations to
my test environment so they would run (except for some, e.g. the ones
requiring root)).  Then I decided that would be enough for me right now..=
=2E

Max


--sTEVNgiXGUSGaEoApRU0BrYfNy3Stm2HS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrqCBkACgkQ9AfbAGHV
z0DYxQf/XUChTTjq1eJbOvpMsMSWozTxOAg9EiGQ5+15FtlZzrNlZenUYqlB/IS0
4uHergsCe8jCxeeVUKsUp0sv/AX87fG9SGkG8YxyNr16ZReWKVmcXG+J5Vu9ofP+
l/IGzIWud2g/GyFh0Qg/8z4G75F8QjqY+QsiXW13aX37t6qe5frVFClVtCr3Vvf6
zAjlFT+ZEMFbe/38S7yNT97SN75Q1Nl1HfDIdWupsflB75/Haw8Soj0zfFO6tRKe
hCLzaiteTqxXJA8JC9yf7qm9czUOIV3oHBzEQk5kk81bVgzQdHU3sa/5FJP1GJYt
reAt/LESkjWtkIczDqsDZfv2ZyVqgA==
=L76K
-----END PGP SIGNATURE-----

--sTEVNgiXGUSGaEoApRU0BrYfNy3Stm2HS--
