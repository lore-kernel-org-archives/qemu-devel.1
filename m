Received: from eggs.gnu.org ([2001:4830:134:3::10]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9JX-00056w-3d
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9JT-0006ok-Uq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:07:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT9JT-0006nj-Kn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:07:31 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-2-vsementsov@virtuozzo.com>
	<945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <040674c0-770d-3b05-0e6a-c46d1c15ac4c@redhat.com>
Date: Thu, 6 Jul 2017 11:07:26 -0500
MIME-Version: 1.0
In-Reply-To: <945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3lhx4rvQ0KAwJ00wtM8ToSNb8QhnVcaBN"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd/server: nbd_negotiate: return 1
 on NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3lhx4rvQ0KAwJ00wtM8ToSNb8QhnVcaBN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <040674c0-770d-3b05-0e6a-c46d1c15ac4c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd/server: nbd_negotiate: return 1
 on NBD_OPT_ABORT
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-2-vsementsov@virtuozzo.com>
 <945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
In-Reply-To: <945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 01:46 PM, Eric Blake wrote:
> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Separate case when client sent NBD_OPT_ABORT from other errors.
>=20
> Commit messages are best written in imperative tense (you can supply an=

> implicit "apply this patch in order to" prefix in front of the message,=

> and it should still generally read well); and that doesn't mix well wit=
h
> past-tense descriptions.  I might have written:
>=20
> Separate the case when a client sends NBD_OPT_ABORT from all other erro=
rs.
>=20
>> It will be needed for the following patch, where errors will be
>> reported.
>> Considered case is not actually the error - it honestly follows NBD
>> protocol. Therefore it should not be reported like an error.
>=20
> This particular case is not actually an error - it honestly follows the=

> NBD protocol.
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  nbd/server.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>=20
>> -
>> -/* Process all NBD_OPT_* client option commands.
>> - * Return -errno on error, 0 on success. */
>> +/* nbd_negotiate_options
>> + * Process all NBD_OPT_* client option commands.
>> + * Return:
>> + * -errno  on error
>> + * 0       on successful negotiation
>> + * 1       if client sent NBD_OPT_ABORT, i.e. on legal disconnect
>=20

Phooey, I'm just now noticing (while trying to rebase my existing
patches on top of yours) that we have a conflict in semantics.  For
reference, my patch was posted here:

https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04535.html

where I picked the semantics:

+/* Process all NBD_OPT_* client option commands, during fixed newstyle
+ * negotiation. Return -errno on error, 0 on successful
NBD_OPT_EXPORT_NAME,
+ * and 1 on successful NBD_OPT_GO. */
+static int nbd_negotiate_options(NBDClient *client, uint16_t myflags)

But since I'm rebasing my stuff anyways, I'll come up with some other
way to combine the two semantics (perhaps by refactoring the response to
NBD_OPT_EXPORT_NAME to occur in nbd_negotiate_options() instead of in
the caller, so that returning 0 is always sufficient to mark that
newstyle negotiation is complete and the server is now in transmission
phase).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3lhx4rvQ0KAwJ00wtM8ToSNb8QhnVcaBN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXmA/AAoJEKeha0olJ0Nq+SkIAI0EmP2EJ1tzGL25OP0toQuZ
YgGBPAxJemCy1LJ6mfNadJDtY/rtbigQ04bupodyWj1gac2tVA/Zz8qug0MiILFh
Ovnup7IJJh+yFnHxHFEqASbMhLDYyhDmZXlm9U53farzsTTS+LCj5iLzPY7S46Ga
+SA2oC3If3pL0dDtA7InZKjB4Pc9jzRscij6F3i0VzXAxm1ihMFHSyycJ6Tin58r
WTzemQA9kkKzJmRrJn3C7fr+oHAdA9CyLElCg4ugUPNc/wqiPL4utMTyNh1bbUq7
5UfXyiVl9goVLnDWUvfpWlNdDz/VhQ+jKfkyXbOTuXamlfc8aLY057r5lBHrcZ4=
=9g08
-----END PGP SIGNATURE-----

--3lhx4rvQ0KAwJ00wtM8ToSNb8QhnVcaBN--
