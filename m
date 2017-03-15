Received: from eggs.gnu.org ([208.118.235.92]:47035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coF19-00087E-BH
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coF15-0003AW-EF
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coF15-0003AO-4s
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F2C164DB2
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 19:55:27 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
	<20170313200752.GG5512@work-vm>
	<89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
	<20170314113234.GE2445@work-vm>
	<8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
Date: Wed, 15 Mar 2017 14:55:16 -0500
MIME-Version: 1.0
In-Reply-To: <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hp6ENqE0dCv2wvDefjF4au8wDAB2TMmc4"
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hp6ENqE0dCv2wvDefjF4au8wDAB2TMmc4
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Juan Quintela <quintela@redhat.com>
Message-ID: <9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-7-eblake@redhat.com> <20170313200752.GG5512@work-vm>
 <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
 <20170314113234.GE2445@work-vm>
 <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
In-Reply-To: <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 09:36 AM, Eric Blake wrote:

>>>> So why is a PRIx64 not the right way to print a __u64 ?
>>>
>>> Because __u64 is not the same type as uint64_t.  On 64-bit Linux, __u=
64
>>> is 'unsigned long long', while uint64_t is 'unsigned long'.
>>>
>>>> (I prefer %llx to the horrid PRIx64 syntax, but it still seems weird=
 in this case)
>>>
>>> As it is, I'm not sure if __u64 is always 'unsigned long long' in ALL=

>>> Linux clients; an even-more-conservative patch would be to switch all=

>>> callers to use explicit casts to something (like uint64_t or unsigned=

>>> long long) that we have full control over, rather than passing __u64
>>> where we have no control over what type it ultimately resolves to.
>>
>> That would be my preference - casting to (uint64_t) at the caller and
>> keep this as PRIx64.  We know it's a 64bit value so we should never
>> use unsigned long long anywhere for it.
>=20
> Okay, my next version will insert an explicit cast in any caller that i=
s
> otherwise passing a __u64 (since we can't guarantee what type __u64
> resolves to, and therefore what format string is appropriate for it).

Or maybe I will just omit those changes from my next version, in lieu of
a gcc bug report.  Here's my summary of an IRC conversation on the topic:=


I just discovered that 32-bit mingw has a bug: it's <winsock.h> header
declared ntohl() as a function that returns 'u_long' ('unsigned long'),
but that POSIX requires ntohl() to return 'uin32_t' (which is 'unsigned
int' in that platform).  The only workaround to buggy system headers is
to insert casts at all call sites, or to quit using overly-picky
-Wformat warnings.

The gist of my gcc bug report will be that newer gcc recently introduced
a fine-tuning for -Wformat, namely -Wformat-signedness.  Some people
really do care about mismatches between "%d" and 'unsigned', or between
"%x" and 'int', but most of us don't.  When -Wformat was originally
invented, there was a lot of 32-bit code, and very little 64-bit code,
so it made TOTAL sense that you wanted to flag mismatches between "%d"
and 'long', or between "%ld" and 'int', as it was a porting aid to
64-bit platforms.  But these days, when we KNOW that a 32-bit platform
has 32-bit 'int' and 'long', and therefore that printf will behave
identically, it would be nice to squelch the warning, and instead only
issue it when there really is a mismatch (such as "%d" and 'long' on
64-bit).  If there were such a knob (call it -Wformat-rank), then in
qemu, we'd turn it off (-Wno-format-rank) so we can play fast and sloppy
with same-width but different-rank typedefs (such as the kernel's __u64
vs. uint64_t, or mingw's 'u_long' vs. 'uint32_t), but still get the full
benefit of real warnings when there is a 32-bit vs. 64-bit difference.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Hp6ENqE0dCv2wvDefjF4au8wDAB2TMmc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyZwkAAoJEKeha0olJ0NqzfIIAJIcq02Sjh6wzqKn5S4h/uAV
wThyyIACWUKPb9B/gIfAsIw831p+qewcYo+GFbXezxNdU1fynPzLBu3rhZ0M7BZK
OE7O34GNP7AKOJn+nEcu97SdhhfmpOxpT5CtsVWjOgChII1KqZRtNHp6CJXZpbKN
XkZBb1vONR9myxsUQlItKNnLvFT3fWTLl93WBnMVo5V1AobNT9fmRJzfMyI2QTsa
NeTFdUoi2UWNDyVue8HLFqsgT8C1PdcHY75yUfUIU8/XKUTLcd9Yjg8+XEghddGm
/sVPaUvyy0thYP6Q1oCy9ti7bmMoNMk23VIZ54i0iN7aKpeWmcQerC9GPvL0cBM=
=383T
-----END PGP SIGNATURE-----

--Hp6ENqE0dCv2wvDefjF4au8wDAB2TMmc4--
