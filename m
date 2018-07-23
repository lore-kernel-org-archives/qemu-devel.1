Received: from eggs.gnu.org ([2001:4830:134:3::10]:42990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fhbyJ-0005u8-TZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fhbyI-0005y2-RU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:37:59 -0400
References: <20180719034118.27741-1-famz@redhat.com>
	<640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
	<CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
	<46511655-713c-6537-0495-0b36384d6fb7@redhat.com>
	<CAK1Eb9kzqTwEjkv5NN1zSYVMmg2h_6BOmxQc2Qz+-c3=_T3=7g@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <88ac3a1a-0eae-5356-d53c-ced561a5b890@redhat.com>
Date: Mon, 23 Jul 2018 16:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9kzqTwEjkv5NN1zSYVMmg2h_6BOmxQc2Qz+-c3=_T3=7g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WhBU62Smv4tRfIar5HVDt6m9QbxCh50E5"
Subject: Re: [Qemu-devel] [PATCH] block: Don't lock /dev/null and /dev/zero
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WhBU62Smv4tRfIar5HVDt6m9QbxCh50E5
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <88ac3a1a-0eae-5356-d53c-ced561a5b890@redhat.com>
Subject: Re: [PATCH] block: Don't lock /dev/null and /dev/zero automatically
References: <20180719034118.27741-1-famz@redhat.com>
 <640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
 <CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
 <46511655-713c-6537-0495-0b36384d6fb7@redhat.com>
 <CAK1Eb9kzqTwEjkv5NN1zSYVMmg2h_6BOmxQc2Qz+-c3=_T3=7g@mail.gmail.com>
In-Reply-To: <CAK1Eb9kzqTwEjkv5NN1zSYVMmg2h_6BOmxQc2Qz+-c3=_T3=7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-23 03:56, Fam Zheng wrote:
> On Sun, Jul 22, 2018 at 10:06 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 2018-07-22 04:37, Fam Zheng wrote:
>>> On Sun, Jul 22, 2018 at 5:08 AM Max Reitz <mreitz@redhat.com> wrote:
>>>>
>>>> On 2018-07-19 05:41, Fam Zheng wrote:
>>>>> On my Fedora 28, /dev/null is locked by some other process (couldn'=
t
>>>>> inspect it due to the current lslocks limitation), so iotests 226 f=
ails
>>>>> with some unexpected image locking errors because it uses qemu-io t=
o
>>>>> open it.
>>>>>
>>>>> Actually it's safe to not use any lock on /dev/null or /dev/zero.
>>>>>
>>>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>>>> ---
>>>>>  block/file-posix.c | 7 ++++++-
>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>>> index 60af4b3d51..8bf034108a 100644
>>>>> --- a/block/file-posix.c
>>>>> +++ b/block/file-posix.c
>>>>> @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *b=
s, QDict *options,
>>>>>          s->use_lock =3D false;
>>>>>          break;
>>>>>      case ON_OFF_AUTO_AUTO:
>>>>> -        s->use_lock =3D qemu_has_ofd_lock();
>>>>> +        if (!strcmp(filename, "/dev/null") ||
>>>>> +                   !strcmp(filename, "/dev/zero")) {
>>>>
>>>> I=E2=80=99m not sure I like a strcmp() based on filename (though it =
should work
>>>> for all of the cases where someone would want to specify either of t=
hose
>>>> for a qemu block device).  Isn=E2=80=99t there some specific major/m=
inor number
>>>> we can use to check for these two files?  Or are those Linux-specifi=
c?
>>>
>>> Yeah, I guess major/minor numbers are Linux-specific.
>>>
>>>>
>>>> I could also imagine just not locking any host_device, but since peo=
ple
>>>> do use qcow2 immediately on block devices, maybe we do want to lock =
them.
>>>
>>> That's right.
>>>
>>>>
>>>> Finally, if really all you are trying to do is to make test code eas=
ier,
>>>> then I don=E2=80=99t know exactly why.  Just disabling locking in 22=
6 shouldn=E2=80=99t
>>>> be too hard.
>>>
>>> The tricky thing is in remembering to do that for future test cases.
>>> My machine seems to be somehow different than John's so that my 226
>>> cannot lock /dev/null, but I'm not sure that is the case for other
>>> releases, distros or system instances.
>>
>> Usually we don=E2=80=99t need to use /dev/null, though, because null-c=
o:// is
>> better suited for most purposes.  This is a very specific test of host=

>> devices.
>>
>> Maybe we should start a doc file with common good practices about
>> writing iotests?
>=20
> Yes, mentioning using pseudo devices in docs/devel/testing.rst would
> probably be a good idea. So is my understanding right that you prefer
> fixing the test case and discard this patch? If so I'll send another
> version together with the doc update.

I personally would prefer fixing the test and not modifying the code,
yes.  But I'm aware that it is a personal opinion.

I think another alternative would be to not lock character devices, as I
don't suppose anyone is going to use them for anything serious.

Max


--WhBU62Smv4tRfIar5HVDt6m9QbxCh50E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltV6DwACgkQ9AfbAGHV
z0CX2ggAnk4TCWWWF8TiQrwkJDpnLlZaLoi/dfW0F6qztbj3xLrO72adMQAoPERa
0iyEL3gHSXNDo6MKOihyeEd0zD8921CxThxmLsErpc/U+/+GJw3RYz1pZRqKHEyD
m2EYi2bSKUj+6IXdFPAyHdxLApq617UiEdS7o2GoINwT/Hyra8WDhpjBn22l88Yj
0voNZgyZp00hEKRGKWiBmEsWcLD59KwTFK58gLKX/gv8dEUxEM4L7rwuZX27A2qu
i0V5avaor9Uym90leSqzZlvnDKHB7jse8Jf3ZLkU0sWmneELRnh00RAbP8FyYHmi
kkqENVzD7xH5brQW8OTrMq8rMpDBCw==
=bTCl
-----END PGP SIGNATURE-----

--WhBU62Smv4tRfIar5HVDt6m9QbxCh50E5--
