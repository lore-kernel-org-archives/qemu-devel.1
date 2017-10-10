Received: from eggs.gnu.org ([2001:4830:134:3::10]:45978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1wcF-0007b1-4d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1wcE-0000b4-1e
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:38:43 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-8-eblake@redhat.com>
	<20171010144644.GL4177@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a011341-2da7-b028-3fb4-aa2cc1065412@redhat.com>
Date: Tue, 10 Oct 2017 10:38:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171010144644.GL4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UlI9k87WnWRRsPOT4hhPOnwGBbuIQWH4A"
Subject: Re: [Qemu-devel] [PATCH v5 07/23] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UlI9k87WnWRRsPOT4hhPOnwGBbuIQWH4A
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <5a011341-2da7-b028-3fb4-aa2cc1065412@redhat.com>
Subject: Re: [PATCH v5 07/23] block: Convert bdrv_get_block_status() to bytes
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-8-eblake@redhat.com>
 <20171010144644.GL4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010144644.GL4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 09:46 AM, Kevin Wolf wrote:
> Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>
>> Changing the name of the function from bdrv_get_block_status() to
>> bdrv_block_status() ensures that the compiler enforces that all
>> callers are updated.  For now, the io.c layer still assert()s that
>> all callers are sector-aligned, but that can be relaxed when a later
>> patch implements byte-based block status in the drivers.
>>
>> Note that we have an inherent limitation in the BDRV_BLOCK_* return
>> values: BDRV_BLOCK_OFFSET_VALID can only return the start of a
>> sector, even if we later relax the interface to query for the status
>> starting at an intermediate byte; document the obvious interpretation
>> that valid offsets are always sector-relative.
>>
>> Therefore, for the most part this patch is just the addition of scalin=
g
>> at the callers followed by inverse scaling at bdrv_block_status().  Bu=
t
>> some code, particularly bdrv_is_allocated(), gets a lot simpler becaus=
e
>> it no longer has to mess with sectors.
>>
>> For ease of review, bdrv_get_block_status_above() will be tackled
>> separately.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +++ b/include/block/block.h
>=20
> A bit above the first hunk:
>=20
>  * Allocation status flags for bdrv_get_block_status() and friends.
>=20
> This should be bdrv_block_status() now.

Good catch. It wasn't there on v1, but I forgot to re-grep when rebasing.=


>> @@ -138,8 +138,10 @@ typedef struct HDGeometry {
>>   *
>>   * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MA=
SK)
>>   * represent the offset in the returned BDS that is allocated for the=

>> - * corresponding raw data; however, whether that offset actually cont=
ains
>> - * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follo=
ws:
>> + * corresponding raw data.  Individual bytes are at the same sector-r=
elative
>> + * locations (and thus, this bit cannot be set for mappings which are=

>> + * not equivalent modulo 512).  However, whether that offset actually=

>> + * contains data also depends on BDRV_BLOCK_DATA, as follows:
>=20
> This suggests to me that it was a bad idea to embed the offset in the
> bitmask. In the long run, we should probably make flags and offset two
> separate things (e.g. making offset a new by-reference parameter).

As this (plus the next series) is all about changing the driver
interface, NOW is as good a time as any to split those into two separate
parameters.  In fact, returning an offset only makes sense when the
caller also is asking for what file is associated with the offset, and
patch 1 of this series already changed several callers to pass NULL when
they don't care about the file.

Unless anyone has a reason why I should NOT split the offset from the
bitmask, I can proceed with making that change for v6 (it will be a bit
more rebase churn as a result - but thinking about the long-term
interface is worth the short-term pain).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UlI9k87WnWRRsPOT4hhPOnwGBbuIQWH4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc6W8ACgkQp6FrSiUn
Q2rhDgf/WlhSLWGfwPtyHntJAQxDovbUcoRbd36xSjJ0ADbx3UwgWWPuMkrK7M9L
LeIku5CMlGcPOIK54q1OpKgv/nfkP8d3iGTVjEFclRmgkMbbArInBKBfMJ226YmU
7kjKB1FQk6SsWiqDIbf2cS4GjZbZAtPrpikLM+ntU0RxzeuId/fGR0iZOF+s8G+I
RPMSGpaUV2828JmQzsiVDDOXEOOtva17Ypq4xxJp57gvm3n2i3CXwlMeWF/oTJXd
8OcOkgil9cpTtHwoHTAO56Du7bbLHJ1yyjcFH9WRYVrSwPOFinGpvSOfTwyigoyU
H8x116FYUl2pOpCg0Gi0QnL7Z0EW8A==
=ROjM
-----END PGP SIGNATURE-----

--UlI9k87WnWRRsPOT4hhPOnwGBbuIQWH4A--
