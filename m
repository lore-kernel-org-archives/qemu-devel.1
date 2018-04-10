Received: from eggs.gnu.org ([2001:4830:134:3::10]:42725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5shV-0003XY-FF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5shS-0000Lf-90
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:48:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5shS-0000LQ-3F
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:48:38 -0400
References: <20180410044942.17059-1-peterx@redhat.com>
	<20180410050119.GA30685@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c4822ab-e233-2a28-daa1-9037af43db25@redhat.com>
Date: Tue, 10 Apr 2018 07:48:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180410050119.GA30685@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0ge96L4aLG7teCDzJcQKnXXA4wAqAnrLx"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ge96L4aLG7teCDzJcQKnXXA4wAqAnrLx
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <5c4822ab-e233-2a28-daa1-9037af43db25@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] monitor: bind dispatch bh to
 iohandler context
References: <20180410044942.17059-1-peterx@redhat.com>
 <20180410050119.GA30685@stefanha-x1.localdomain>
In-Reply-To: <20180410050119.GA30685@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 12:01 AM, Stefan Hajnoczi wrote:
> On Tue, Apr 10, 2018 at 12:49:42PM +0800, Peter Xu wrote:
>> Eric Auger reported the problem days ago that OOB broke ARM when runni=
ng
>> with libvirt:
>>
>> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>>
>> The problem was that the monitor dispatcher bottom half was bound to
>> qemu_aio_context now, which could be polled unexpectedly in block code=
=2E
>=20
> And TPM and 9P code, who all use nested event loops.

I'll tweak the commit message to mention that.

>=20
>> We should keep the dispatchers run in iohandler_ctx just like what we
>> did before the Out-Of-Band series (chardev uses qio, and qio binds
>> everything with iohandler_ctx).
>>

>> ---
>> v2:
>> - enhanced commit message

Thanks for that.  As you are learning, the hardest part of writing a
patch is often not the code itself, but figuring out the most efficient
way to get reviewers to understand why the patch is important.  The
better you get at writing GOOD commit messages, the easier it is for
your patches to be accepted!

>> ---
>>  monitor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 51f4cf480f..39f8ee17ba 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4467,7 +4467,7 @@ static void monitor_iothread_init(void)
>>       * have assumption to be run on main loop thread.  It would be
>>       * nice that one day we can remove this assumption in the future.=

>>       */
>> -    mon_global.qmp_dispatcher_bh =3D aio_bh_new(qemu_get_aio_context(=
),
>> +    mon_global.qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_con=
text(),
>>                                                monitor_qmp_bh_dispatch=
er,
>>                                                NULL);
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>

and queuing through my qapi tree, pull request for -rc3 going out shortly=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0ge96L4aLG7teCDzJcQKnXXA4wAqAnrLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMspwACgkQp6FrSiUn
Q2rT/gf/eL9wP6g4F4gBLsf58jw3STtihN09/YCnZlBmmgK00E9nXZh3q6jdvdjt
VUeFJGkkBUc3cH7mYLLLlEmlO86TeXXBfrR7erwH+OoxMYGAabsRLTgEtXLrxjGe
4hRmammXvaW6HWUedD+hAD+zrNVq7niluw3/O+75ukrMKinykvtee+0ORAnQnv2F
BqxTlAQJbPO8G0cjHe1pqCu6EhLOkdmsa2teS0WC4c6uuqgXxzue1bq4qzHw/Hbp
iAllzcw7z/+j/ranSgtOAuxaWeyZEZwknAPYTA6xDZ2bXhJZe00oZ2Z3CQ/FNSah
QlTkBvhQe6PFvnYE6fjmXqq2REhYCA==
=PCuj
-----END PGP SIGNATURE-----

--0ge96L4aLG7teCDzJcQKnXXA4wAqAnrLx--
