Received: from eggs.gnu.org ([2001:4830:134:3::10]:40296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crAik-0005jR-OR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crAif-0003Yo-Vi
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crAif-0003Wv-NA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:56:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3791B437F47
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 21:56:33 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
	<a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
Date: Thu, 23 Mar 2017 16:56:30 -0500
MIME-Version: 1.0
In-Reply-To: <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GCTmm1fwSJticPRP83hEC8w0DQ7tVrCG3"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCTmm1fwSJticPRP83hEC8w0DQ7tVrCG3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com
Message-ID: <59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-5-git-send-email-armbru@redhat.com>
 <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
 <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
 <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
In-Reply-To: <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 04:43 PM, Eric Blake wrote:

> We'd still have to allow libvirt's use of
> ":key=3D...:auth_supported=3Dcephx\\;none" on the command line, but fro=
m the
> QMP side, we would support exactly one auth method, and libvirt will be=

> updated to match when it starts targetting blockdev-add instead of
> legacy command line.
>=20
> If librados really needs 'cephx;none' any time cephx authorization is
> requested, then even though the QMP only requests 'cephx', we can still=

> map it to 'cephx;none' in qemu - but I'm hoping that setting
> auth_supported=3Dcephx rather than auth_supported=3Dcephx;none on the
> librados side gives us what we (and libvirt) really want in the first p=
lace.

Or, if it becomes something that libvirt wants to allow users to tune in
their XML (right now, users don't get a choice, they get either 'none'
or 'cephx;none'), a forward-compatible solution under my QMP proposal
would be to have qemu add a third enum state, "none", "cephx", and
"cephx-no-fallback".

On the other hand, if supporting multiple methods at once makes sense
(say librados adds a 'cephy' method, and that users could legitimately
use both 'cephx;cephy' and 'cephy;cephx' with different behaviors), then
keeping auth as an array of instances of a simple flat union scales
nicer than having to add a combinatorial explosion of branches to the
flat union to cover every useful combination of auth_supported methods.
Maybe I'm overthinking it.

>=20
> Jeff or Josh, if you could chime in, that would be helpful.
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GCTmm1fwSJticPRP83hEC8w0DQ7tVrCG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1ESOAAoJEKeha0olJ0NqoIUIAI4u0vtrz4hhd/sYZgmn0PP/
7kmflT1WKjdq1OWifEA9OXZ34E2O+sOujVSzvfiLIESXVwXpMsvK0Byx5x5rubYc
rMspnBi1/HBeg4Nn5RLUeGhzqXnWGYlSOJJbS+1NRO20yG1xRpSxTyn5SIHCUNr7
2TAddRpj9An1jLDuzYpbTDTbNmSrnXFsSImUsPRmXH11U1C115f4hdR4VKRHw3Sl
gjMgE0P+kvS1RjU7rhrC/JlPnbkMOem826u74bfii+AUoOq5LrBIU+NAIa3a4mab
Pa1snaQl8fBmQl8XOOXYIBMXxdgcT4zdSuXx8fllwDkX13Ur5IJQvGHdmBuxe6Q=
=gvKC
-----END PGP SIGNATURE-----

--GCTmm1fwSJticPRP83hEC8w0DQ7tVrCG3--
