Received: from eggs.gnu.org ([209.51.188.92]:42650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF2i-0006O3-Ia
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF2e-0000O8-NT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:41:16 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
	<87pnt7bflk.fsf@dusky.pond.sub.org>
	<d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
	<87bm4pewa8.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61b1ab31-e39d-1187-d8bd-42370eef5547@redhat.com>
Date: Wed, 9 Jan 2019 15:41:03 +0100
MIME-Version: 1.0
In-Reply-To: <87bm4pewa8.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ibaz3N9iyrqTeqH4EoLUi8VB9ZXvgiLjF"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibaz3N9iyrqTeqH4EoLUi8VB9ZXvgiLjF
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Message-ID: <61b1ab31-e39d-1187-d8bd-42370eef5547@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org>
 <20190107163606.GL23773@natto.ory.fergeau.eu>
 <87pnt7bflk.fsf@dusky.pond.sub.org>
 <d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
 <87bm4pewa8.fsf@dusky.pond.sub.org>
In-Reply-To: <87bm4pewa8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.01.19 15:32, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 08.01.19 11:36, Markus Armbruster wrote:
>>> Copying block maintainers for help with assessing the bug's (non-)imp=
act
>>> on security.
>>>
>>> Christophe Fergeau <cfergeau@redhat.com> writes:
>>>
>>>> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
>>>>> Eric Blake <eblake@redhat.com> writes:
>>>>>
>>>>>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>>>>>> Adding Markus to cc: list, I forgot to do it when sending the pat=
ch.
>>>>>>
>>>>>> Also worth backporting via qemu-stable, now in cc.
>>>>>>
>>>>>>>
>>>>>>> Christophe
>>>>>>>
>>>>>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrot=
e:
>>>>>>>> commit 8bca4613 added support for %% in json strings when interp=
olating,
>>>>>>>> but in doing so, this broke handling of % when not interpolating=
 as the
>>>>>>>> '%' is skipped in both cases.
>>>>>>>> This commit ensures we only try to handle %% when interpolating.=

>>>>>
>>>>> Impact?
>>>>>
>>>>> If you're unable to assess, could you give us at least a reproducer=
?
>>>>
>>>> This all came from https://lists.freedesktop.org/archives/spice-deve=
l/2018-December/046644.html
>>>> Setting up a VM with libvirt with <graphics type=3D'spice' autoport=3D=
'yes' passwd=3D'password%'/>
>>>> fails to start with:
>>>>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Asser=
tion `*ptr' failed.
>>>>
>>>> If you use 'password%%' as the password instead, when trying to conn=
ect
>>>> to the VM, you type 'password%' as the password instead of 'password=
%%'
>>>> as configured in the domain XML.
>>>
>>> Thanks.
>>>
>>> As the commit message says, the bug bites when we parse a string
>>> containing '%s' with !ctxt->ap.  The parser then swallows a character=
=2E
>>> If it swallows the terminating '"', it fails the assertion.
>>>
>>> We parse with !ctxt->ap in the following cases:
>>>
>>> * Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>>>   tests/test-visitor-serialization.c)
>>>
>>>   Plenty of tests, but we still failed to cover the buggy case :(
>>>
>>> * QMP input (monitor.c)
>>>
>>> * QGA input (qga/main.c)
>>>
>>> * qobject_from_json()
>>>
>>>   - JSON pseudo-filenames (block.c)
>>>
>>>     These are pseudo-filenames starting with "json:".
>>>
>>>   - JSON key pairs (block/rbd.c)
>>>
>>>     As far as I can tell, these can come only from pseudo-filenames
>>>     starting with "rbd:".
>>>
>>>   - JSON command line option arguments of -display and -blockdev
>>>     (qobject-input-visitor.c)
>>>
>>>     Reproducer: -blockdev '{"%"}'
>>>
>>> Command line, QMP and QGA input are trusted.
>>>
>>> Filenames are trusted when they come from command line, QMP or HMP.
>>> They are untrusted when they come from from image file headers.
>>> Example: QCOW2 backing file name.  Note that this is *not* the securi=
ty
>>> boundary between host and guest.  It's the boundary between host and =
an
>>> image file from an untrusted source.
>>>
>>> I can't see how the bug could be exploited.  Neither failing an
>>> assertion nor skipping a character in a filename of your choice is
>>> interesting.  We don't support compiling with NDEBUG.
>>>
>>> Kevin, Max, do you agree?
>>
>> I wouldn't call it "not interesting" if adding an image to your VM at
>> runtime can crash the whole thing.
>>
>> (qemu-img create -f qcow2 -u -b 'json:{"%"}' foo.qcow2 64M)
>=20
> "Not interesting" strictly from the point of view of exploiting the bug=

> to penetrate trust boundaries.
>=20
>> Whether this is a security issue...  I don't know, but it is a DoS.
>=20
> I'm not sure whether feeding untrusted images to QEMU is a good idea in=

> general --- there's so much that could go wrong.  How hardened against
> abuse are out block drivers?

They are supposed to handle such cases gracefully, that's for sure.  At
least for qcow2 we do care about it.

> I figure what distinguishes this case is how utterly trivial creating a=

> "bad" image is.

I don't think an untrusted image should be able to crash qemu.

> Anyway, you are the block layer maintainers, so you get to decide
> whether to give this the full security bug treatment.  I'm merely the
> clown who broke it %-/

Er, then I suppose it is no security bug? O:-)

Max


--ibaz3N9iyrqTeqH4EoLUi8VB9ZXvgiLjF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2B/8ACgkQ9AfbAGHV
z0DNeQf7Bc1pFXE6Xg/9Y2Tj+JESwzkOOt8ip2EoEEXcAHMgTsRV8tQvf9Aa4iKk
3aN4Lf2c5565iAkMpelMz0B5PyLTIhR7qjz8yaUCubx+dwNkv2GH3k2w9QY2odXF
yDOR422mSfzRoX3fmW7ZVfR/hd7OtC3RclCJqYHLWBrpMME7vQUCTRVmGpbuZoF1
SybN0hlUawQWiOdE9lfYpB4R4s6fiFqQP+/8fucp0981HDjYfpsmX36qvuip7D/f
BL/nAmFsWmtHs+27bBNKlkoWwLwBT3/PvamYfYiv5itJ/cB9xK94WgH9KphXAe0G
Pv5FWSLTtIm2tC+xY/Pb6PNysYi7dg==
=6BlU
-----END PGP SIGNATURE-----

--ibaz3N9iyrqTeqH4EoLUi8VB9ZXvgiLjF--
