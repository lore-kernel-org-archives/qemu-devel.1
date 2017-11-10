Received: from eggs.gnu.org ([2001:4830:134:3::10]:37574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDCP8-0002Xs-H6
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDCP5-0004tE-Cv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:43:42 -0500
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
	<d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
	<20171110160512.GF5466@localhost.localdomain>
	<e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
	<20171110162224.GG5466@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <39d87980-4fb0-faa4-4e9f-ba6d2e2f5acd@redhat.com>
Date: Fri, 10 Nov 2017 17:43:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171110162224.GG5466@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AHIco30qbglkKx5e92pC1nAJOQxNpAFWg"
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
--AHIco30qbglkKx5e92pC1nAJOQxNpAFWg
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <39d87980-4fb0-faa4-4e9f-ba6d2e2f5acd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
References: <20171109204315.27072-1-mreitz@redhat.com>
 <20171110024557.GB4849@lemon> <20171110131752.GD5466@localhost.localdomain>
 <20171110133207.GA9235@lemon.Home>
 <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
 <20171110160512.GF5466@localhost.localdomain>
 <e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
 <20171110162224.GG5466@localhost.localdomain>
In-Reply-To: <20171110162224.GG5466@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 17:22, Kevin Wolf wrote:
> Am 10.11.2017 um 17:13 hat Max Reitz geschrieben:
>> On 2017-11-10 17:05, Kevin Wolf wrote:
>>> Am 10.11.2017 um 16:23 hat Max Reitz geschrieben:
>>>> On 2017-11-10 14:32, Fam Zheng wrote:
>>>>> On Fri, 11/10 14:17, Kevin Wolf wrote:
>>>>>> Do you actually need to keep references to all BDSes in the whole =
list
>>>>>> while using the iterator or would it be enough to just keep a refe=
rence
>>>>>> to the current one?
>>>>>
>>>>> To fix the bug we now see I think keeping the current is enough, bu=
t I think
>>>>> implementing just like this patch is also good with some future-pro=
ofing: we
>>>>> cannot know what will be wedged into the nexted aio_poll()'s over t=
ime (and yes,
>>>>> we should really reduce the number of them.)
>>>>
>>>> I don't really want to think about whether it's safe to only keep a
>>>> reference to the current BDS.  I can't imagine any case where destro=
ying
>>>> one root BDS leads to destroying another, but I'd rather be safe and=
 not
>>>> have to think about it.  (Unless there is an important reason to onl=
y
>>>> keep a strong reference to the current one.)
>>>
>>> Why would it be a problem if another BDS from the list went away? If =
it
>>> is one that was already processed, we don't care, and if it was in th=
e
>>> yet unprocessed part of the list, we'll just never return it.
>>
>> You mean from bdrv_next() in its current form?  Well, I know that when=
 I
>> just put a bdrv_ref()/bdrv_unref() pair around the drain, I got a
>> segfault in blk_all_next() in bdrv_next().  I can investigate more, bu=
t
>> that's pretty much what I mean by "I don't really want to think about =
it".
>=20
> No, I mean a bdrv_next() that is modified to bdrv_ref() only what
> it->blk/it->bs point to currently instead of allocating a whole list.

Seems to work, I guess my issue was that I unref'd the BDS too early
(should do that only after the next pointer has been fetched...).

This also means adding a new function like bdrv_next_cleanup() that has
to be called if you don't want to iterate over all of the BDSs, but I
guess it's still less code to write.

Max


--AHIco30qbglkKx5e92pC1nAJOQxNpAFWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF1ycSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUxUH/jlqhbEKfz3cwtK4kAmp2z55zD1Dcwhe
yCvp/f5ieE6g6I5XkRtH3Q8ND9vdFTpJD2DOCVFU0ZFXauce1UQNe/1DzHeHxDx6
mR3XZv6DcOeHOnhl/Li3OEq2MktRPBO8Oahwf0xXHiJEzr/Fdvtpo6Nrm3M6jqIn
X/IP1xPsabsu5NOw/5sRq3BXcSlAk/0VksxRcA/7J26yFMEBWbBJ7QLUefVij8QM
roKtTutXjpuzSSCBIFQ3UC2COsFHiBudsJiKmQnpA6bwM1+DT1cD4POg5l5Inz4H
X5PdkKQMJgFAt3O0p64wyiL1rsubWEoI3RpUDKGgTyQ8e5A4i9wvEAU=
=1zo7
-----END PGP SIGNATURE-----

--AHIco30qbglkKx5e92pC1nAJOQxNpAFWg--
