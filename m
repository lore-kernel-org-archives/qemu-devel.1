Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XRt-0002DJ-97
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XRq-0002oK-4v
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:07:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5XRp-0002ny-VI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 016F65BCBE
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 14:07:05 +0000 (UTC)
References: <20180408030542.17855-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <888b356e-284b-54a5-0646-b6999e0e2c89@redhat.com>
Date: Mon, 9 Apr 2018 09:06:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180408030542.17855-1-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQGQqUjapo4OWwQd9YW1mVqTH6IqC0YKf"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQGQqUjapo4OWwQd9YW1mVqTH6IqC0YKf
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <888b356e-284b-54a5-0646-b6999e0e2c89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix wait_until_completed()
References: <20180408030542.17855-1-peterx@redhat.com>
In-Reply-To: <20180408030542.17855-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2018 10:05 PM, Peter Xu wrote:
> If there are more than one events, wait_until_completed() might return
> the 2nd event even if the 1st event is JOB_COMPLETED, since the for loo=
p
> will continue to run even if completed is set to True.
>=20
> It never happened before, but it can be triggered when OOB is enabled
> due to the RESUME startup message. Fix that up.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

If you get the other OOB-related bug fixes working, I can include this
along with those for -rc3 through the qapi tree.  Otherwise, I'm fine
waiting for this until 2.13.


> +++ b/tests/qemu-iotests/iotests.py
> @@ -470,18 +470,15 @@ class QMPTestCase(unittest.TestCase):
> =20
>      def wait_until_completed(self, drive=3D'drive0', check_offset=3DTr=
ue):
>          '''Wait for a block job to finish, returning the event'''
> -        completed =3D False
> -        while not completed:
> +        while True:
>              for event in self.vm.get_qmp_events(wait=3DTrue):

Do we really need two loops?  Or can you eliminate the 'while True:'
loop and rely on just the 'for event...' loop?

>                  if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
>                      self.assert_qmp(event, 'data/device', drive)
>                      self.assert_qmp_absent(event, 'data/error')
>                      if check_offset:
>                          self.assert_qmp(event, 'data/offset', event['d=
ata']['len'])
> -                    completed =3D True
> -
> -        self.assert_no_active_block_jobs()
> -        return event
> +                    self.assert_no_active_block_jobs()
> +                    return event
> =20
>      def wait_ready(self, drive=3D'drive0'):
>          '''Wait until a block job BLOCK_JOB_READY event'''
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SQGQqUjapo4OWwQd9YW1mVqTH6IqC0YKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrLc4MACgkQp6FrSiUn
Q2rdZAf/UlHgK/126WKZm6jhNKqyiTgFtmLRiz/1mvXYpj5qLEo3FKEV5/N8J+2j
SRsqnZVfjQdQ/XIzg62mIGnNB2K+H/Op10o/9/uO5kigTKVCZdV+jXfpyBJOAkeM
5roQPQxzdqb2HHDnYu34heDSlnyIukl3MtDc3A2ooxzbgDSf2Opae158FXJNuuNR
h7wpU6J6j7UkmST9vxhUto4ZkbGuBszDwiDNR4kcWHsivwIMnNuEzLlbYTJK/cxU
OV746IV810VFo/cdsfPsKwuI+tk1XrQGYQh022t4FbubZuRLFmF3GEOALfQNCT9K
wULIoNHPFH39SsdADwLyW4zEyFpF5g==
=bElc
-----END PGP SIGNATURE-----

--SQGQqUjapo4OWwQd9YW1mVqTH6IqC0YKf--
