Received: from eggs.gnu.org ([2001:4830:134:3::10]:59789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDBwZ-0003h2-Q2
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDBwY-000396-Sq
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:14:11 -0500
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
	<d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
	<20171110160512.GF5466@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
Date: Fri, 10 Nov 2017 17:13:52 +0100
MIME-Version: 1.0
In-Reply-To: <20171110160512.GF5466@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BG9S1rArnJEukmIJLK0hHAqwklGpFgbBv"
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BG9S1rArnJEukmIJLK0hHAqwklGpFgbBv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
References: <20171109204315.27072-1-mreitz@redhat.com>
 <20171110024557.GB4849@lemon> <20171110131752.GD5466@localhost.localdomain>
 <20171110133207.GA9235@lemon.Home>
 <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
 <20171110160512.GF5466@localhost.localdomain>
In-Reply-To: <20171110160512.GF5466@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 17:05, Kevin Wolf wrote:
> Am 10.11.2017 um 16:23 hat Max Reitz geschrieben:
>> On 2017-11-10 14:32, Fam Zheng wrote:
>>> On Fri, 11/10 14:17, Kevin Wolf wrote:
>>>> Do you actually need to keep references to all BDSes in the whole li=
st
>>>> while using the iterator or would it be enough to just keep a refere=
nce
>>>> to the current one?
>>>
>>> To fix the bug we now see I think keeping the current is enough, but =
I think
>>> implementing just like this patch is also good with some future-proof=
ing: we
>>> cannot know what will be wedged into the nexted aio_poll()'s over tim=
e (and yes,
>>> we should really reduce the number of them.)
>>
>> I don't really want to think about whether it's safe to only keep a
>> reference to the current BDS.  I can't imagine any case where destroyi=
ng
>> one root BDS leads to destroying another, but I'd rather be safe and n=
ot
>> have to think about it.  (Unless there is an important reason to only
>> keep a strong reference to the current one.)
>=20
> Why would it be a problem if another BDS from the list went away? If it=

> is one that was already processed, we don't care, and if it was in the
> yet unprocessed part of the list, we'll just never return it.

You mean from bdrv_next() in its current form?  Well, I know that when I
just put a bdrv_ref()/bdrv_unref() pair around the drain, I got a
segfault in blk_all_next() in bdrv_next().  I can investigate more, but
that's pretty much what I mean by "I don't really want to think about it"=
=2E

So that's why I want bdrv_next() to copy all BDS into another list
instead of iterating through them on the fly.  And if we do that, a
disappearing BDS of course is an issue because we don't notice until
we're trying to iterate over it, at which point we have a use-after-free.=


Max


--BG9S1rArnJEukmIJLK0hHAqwklGpFgbBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF0EESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYB0H/A4CYrxxvNzEDeH2W7Jihu8djL3ziJ2V
wySGMp0ZsZfIAA89L7ueMpsSuDcOdtarSV+cQCIpl/thal3DY8In3JGuMDMHVLz3
yhvs+Uh4UJgh9XofdxKJBI2UOzA3xahzYP60v5TlhDZEdiKkQH1CqMQVdRKL4HZK
EP/A5xLp0Xi8/OeeWGn2HHg+mcc7ZyGKhpfIqAn22hfULBpCuiv5ylsPPpY7dl66
JysqU4YWagY6QF+ioHVq5xS6MK3gaq/gh3zz+jZM1REB6t9RzZZxf45T+TRxTx1I
5gKCrZZewS/yJ7cHY+8q0A0v3KxGOqpY1MqTZB44oWV2troPd7U66e4=
=wYJu
-----END PGP SIGNATURE-----

--BG9S1rArnJEukmIJLK0hHAqwklGpFgbBv--
