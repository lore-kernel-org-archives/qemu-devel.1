Received: from eggs.gnu.org ([2001:4830:134:3::10]:51986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df6AS-0005ah-Ra
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df6AR-0005tn-Ik
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:11:36 -0400
References: <20170807161529.3779-1-berto@igalia.com>
	<20170808100030.GB16801@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e8e9540-8644-af56-b658-932bc4b0f514@redhat.com>
Date: Tue, 8 Aug 2017 10:11:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170808100030.GB16801@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EEtGtbsSPCDmAOhJ0VibXTkKnej9Mu1oe"
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg
 and LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EEtGtbsSPCDmAOhJ0VibXTkKnej9Mu1oe
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <9e8e9540-8644-af56-b658-932bc4b0f514@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
References: <20170807161529.3779-1-berto@igalia.com>
 <20170808100030.GB16801@stefanha-x1.localdomain>
In-Reply-To: <20170808100030.GB16801@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 05:00 AM, Stefan Hajnoczi wrote:
> On Mon, Aug 07, 2017 at 07:15:29PM +0300, Alberto Garcia wrote:
>> Both the throttling limits set with the throttling.iops-* and
>> throttling.bps-* options and their QMP equivalents defined in the
>> BlockIOThrottle struct are integer values.
>>
>> Those limits are also reported in the BlockDeviceInfo struct and they
>> are integers there as well.
>>
>> Therefore there's no reason to store them internally as double and do
>> the conversion everytime we're setting or querying them, so this patch=

>> uses int64_t for those types.
>>

> Why is this marked for-2.10?  Does it fix a bug?

Theoretically, converting between int64_t and double loses precision on
any values larger than 2^53.  In all practicality, though, if you expect
throttling to be precise through 2^53 (approximately 16 orders of
magnitude), you're crazy.  I also don't see any change to potential
division-by-zero actions (where differences in NaN vs. SIGFPE each have
their own advantages, but changing between them can be construed as a
bug fix).  So I'm also having a hard time seeing this as 2.10 material.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EEtGtbsSPCDmAOhJ0VibXTkKnej9Mu1oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ1J8ACgkQp6FrSiUn
Q2oS6QgArsJ9T85rJnKURO5MQL+lRocaUacAP/pquOIE79LJVttjAiDkv+2aKpX8
BvAicUkWZ4q2vUAdyzyhXnCtjFOnjj8tgi4pxjbRiQrQOUwsKUxBrJLTFA2rOb7s
X1RUTqkt94rJgDK7Qf9MnUw41myzkn5nbHSFuY10NhlqiVZ6pJkwK6gQssitdiJv
/DeGDy3rksTlwQ38Fx5t/o5QfV1UUi76gyAI8YF2jesUvg3HqVfpg53BG43Arz0+
hDDRNtSZJA5aBre8S4ycqfCp1ft42bZUYmnDUmx8x+PPR3WXTqNmAqQY8oM1JRs7
fKPs4TE9ospTMnRgNH4LRf+FWGZd3w==
=LLcv
-----END PGP SIGNATURE-----

--EEtGtbsSPCDmAOhJ0VibXTkKnej9Mu1oe--
