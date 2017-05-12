Received: from eggs.gnu.org ([2001:4830:134:3::10]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Gj3-00087C-Ki
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Gj0-0007bU-FO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9Gj0-0007aw-6k
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DBAF7AEA2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 19:59:40 +0000 (UTC)
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
Date: Fri, 12 May 2017 14:59:29 -0500
MIME-Version: 1.0
In-Reply-To: <877f1mgx9h.fsf@secure.mitica>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xQJ4dMd8MM42IW80lixlfxQHMSXICsgEc"
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xQJ4dMd8MM42IW80lixlfxQHMSXICsgEc
From: Eric Blake <eblake@redhat.com>
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Message-ID: <5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
References: <20170511163228.6666-1-quintela@redhat.com>
 <20170511163228.6666-3-quintela@redhat.com>
 <20170512034033.GN28293@pxdev.xzpeter.org> <877f1mgx9h.fsf@secure.mitica>
In-Reply-To: <877f1mgx9h.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 05:55 AM, Juan Quintela wrote:
>>> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk,=
 bool blk,
>>>      }
>>> =20
>>>      if (has_inc && inc) {
>>> +        migrate_set_block_enabled(s, true);
>>>          migrate_set_block_shared(s, true);
>>
>> [2]
>>
>> IIUC for [1] & [2] we are solving the same problem that "shared"
>> depends on "enabled" bit. Would it be good to unitfy this dependency
>> somewhere? E.g., by changing migrate_set_block_shared() into:
>>
>> void migrate_set_block_shared(MigrationState *s, bool value)
>> {
>>     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] =3D val=
ue;
>>     if (value) {
>>         migrate_set_block_enabled(s, true);
>>     }
>> }
>=20
> ok with this.

Or, as I commented on 1/3, maybe having a single property that is a
tri-state enum value, instead of 2 separate boolean properties, might be
nicer (but certainly a bit more complex to code up).

> I will add once here that when we disable block enabled, we also disabl=
e
> shared, or just let it that way?
>=20
>> Another thing to mention: after switching to the capability interface,=

>> we'll cache the "enabled" and "shared" bits now while we don't cache
>> it before, right? IIUC it'll affect behavior of such sequence:
>>
>> - 1st migrate with enabled=3D1, shared=3D1, then
>> - 2nd migrate with enabled=3D0, shared=3D0
>>
>> Before the series, the 2nd migrate will use enabled=3Dshared=3D0, but
>> after the series it should be using enabled=3Dshared=3D1. Not sure whe=
ther
>> this would be a problem (or I missed anything?).
>=20
> We can't be consistent with both old/new way.
>=20
> Old way: we always setup the capabilities on command line (that should
> have been deprecated long, long ago)

Well, the easy way out is to have the HMP migrate command (I assume
that's what you mean by "on command line") explicitly clear the
parameters if it is called without the -b/-i flag.  So the start of each
migration is what changes the properties, so long as you are still using
HMP to start the migration.  Or, on the QMP side, since 'migrate' has
optional 'blk' and 'inc' booleans, basically leave the settings alone if
the parameters were omitted, and explicitly update the property to the
value of those parameters if they were present.

Or is the proposal that we are also going to simplify the QMP 'migrate'
command to get rid of crufty parameters?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xQJ4dMd8MM42IW80lixlfxQHMSXICsgEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhQiAAoJEKeha0olJ0Nq4cIH+gMbzH5iOoeKDxQVlDQOHaPB
UteCpzj/meH0dafUZfTqOXiYr50+01hx+KmdTTW9iEm2CmDWYa3HHdOQIORjtiyb
c1ZNLVekgTWbbGgw8351/xql5jghcdntIeAQNruPxbKO9mHhthCN6hKzFiopeTS3
U6EyAX61JwtKbtugwcBW1XoP0fA5nwc+J+DFh2VdGblBHnEO5gFyxVRoIiJSm+tk
5D46p4zVszq+ubeSznimfUsNmwbq+S8oUYJWFbFMrMIgbBPuij6M+G3L3nhXw6hI
Gx/O55AgenS5oG6lze4tZVhR5niRhHwxFhX32mQUl445Y8oBRPBT+x5vYRdAetM=
=t4Az
-----END PGP SIGNATURE-----

--xQJ4dMd8MM42IW80lixlfxQHMSXICsgEc--
