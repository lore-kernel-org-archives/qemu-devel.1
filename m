Received: from eggs.gnu.org ([2001:4830:134:3::10]:60802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv68Z-0002mh-I3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv68Y-0003c1-AN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:23:47 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
	<ac533c95-a0f5-c6ce-cc6a-7fab63eb0517@redhat.com>
	<79eb6628-130e-af9d-cd39-56bf71194ae3@virtuozzo.com>
	<ccbd7d7e-512a-76ea-5b03-8853fd88fda2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4393a82e-de82-ed8d-15ae-8defe59413ac@redhat.com>
Date: Thu, 21 Sep 2017 13:23:32 -0500
MIME-Version: 1.0
In-Reply-To: <ccbd7d7e-512a-76ea-5b03-8853fd88fda2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HMupOISu5dlbE4vKPVNvg4dbMEIfXquAP"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] qcow2: truncate the tail
 of the image file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMupOISu5dlbE4vKPVNvg4dbMEIfXquAP
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <4393a82e-de82-ed8d-15ae-8defe59413ac@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] qcow2: truncate the tail of
 the image file after shrinking the image
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
 <20170920135833.20472-3-pbutsykin@virtuozzo.com>
 <ac533c95-a0f5-c6ce-cc6a-7fab63eb0517@redhat.com>
 <79eb6628-130e-af9d-cd39-56bf71194ae3@virtuozzo.com>
 <ccbd7d7e-512a-76ea-5b03-8853fd88fda2@redhat.com>
In-Reply-To: <ccbd7d7e-512a-76ea-5b03-8853fd88fda2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2017 11:48 AM, John Snow wrote:
>>> Looks sane to me, but under which circumstances might we grow such a
>>> tail? I assume the actual truncate call aligns to cluster boundaries =
as
>>> appropriate, so is this a bit of a "quick fix" to cull unused cluster=
s
>>> that happened to be near the truncate boundary?
>>>
>>> It might be worth documenting the circumstances that produces this
>>> unused space that will never get used. My hunch is that such unused
>>> space should likely be getting reclaimed elsewhere and not here, but
>>> perhaps I'm misunderstanding the causal factors.
>>>
>>
>> This is a consequence of how we implemented shrinking the qcow2 image.=

>> (https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04580.html)
>> But on the other hand, if we need to shrink the qcow2 image without
>> copying the data, this is the only way. The same guest offset can be
>> converted to almost any host offset in the file i.e. the first guest
>> cluster may be located somewhere at the end or the middle of the image=

>> file. So we can't just take and truncate the image file on the border =
of
>> the truncation, therefore to shrink the image we just discard the
>> clusters that corresponds to the truncated area. The result is a
>> sparse image file where the apparent file size differs from actual siz=
e.
>> And the tail in this case is the difference between the actual size an=
d
>> last used cluster in the image, so in fact the cutting of the tail doe=
s
>> not change the apparent file size.
>>
>=20
> Oh, duh, I get it. The truncation itself creates a lot of sparseness.

It is also interesting to think about whether we should someday
implement a qcow2 defragmenting operation (either a simple one: pull all
later clusters into earlier holes, but the end result is not necessarily
contiguous; or a complex one: shuffle things so that all clusters are in
order, even though it may require moving some clusters around twice), so
that you can remove all holes from the file (perhaps useful if the file
is stored on a system that does not support holes).  But not for this
series :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HMupOISu5dlbE4vKPVNvg4dbMEIfXquAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnEA6QACgkQp6FrSiUn
Q2qTQAf/dALnPjA3HdQ6tTAaOzGhK2i07S93WH6FhMAQEdpesvx679q3qV0OKwly
aYoEGMaR6S8f6vVeyLxF4tynE655E47mMakoehYMCNXjISMpVykMlo6qUd/mYtcN
Y6ozX2tWcNqlvPDrz9+OCyCkmUC+IiVPb1BIarTxiK7ymRwsiNq+cC5INSB05HzS
GChYVJfL5TlmVdEGU21ImXtzQiX+Q3XqUc9WKollU53+/TxP0neAEecbeYy5vePP
8Hics84kKYrs3qltuNBySt3ARsRSNJJCVz6iV4O6I4/kaG0f0BwgKnhCKpihoQSJ
XY1DVUJsk4bF8SNYUkW5PXoVFNBoBw==
=Ic+o
-----END PGP SIGNATURE-----

--HMupOISu5dlbE4vKPVNvg4dbMEIfXquAP--
