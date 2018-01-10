Received: from eggs.gnu.org ([2001:4830:134:3::10]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZFuC-0003gI-TL
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZFuB-000262-JS
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:54:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZFuB-00025U-8a
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:54:55 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-8-peterx@redhat.com>
	<ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
	<20180110082639.GH5984@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2de0d5c-924d-6de8-4bb9-92991801fb3c@redhat.com>
Date: Wed, 10 Jan 2018 06:54:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180110082639.GH5984@xz-mi>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HNePfuP90OprTSjhJk9IPX1QH99ssUhGq"
Subject: Re: [Qemu-devel] [RFC v6 07/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HNePfuP90OprTSjhJk9IPX1QH99ssUhGq
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a2de0d5c-924d-6de8-4bb9-92991801fb3c@redhat.com>
Subject: Re: [RFC v6 07/27] monitor: unify global init
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-8-peterx@redhat.com>
 <ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
 <20180110082639.GH5984@xz-mi>
In-Reply-To: <20180110082639.GH5984@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 02:26 AM, Peter Xu wrote:

>> The later initialization of the monitor_lock mutex is a potential
>> semantic change.  Please beef up the commit message to document why it=

>> is safe.  In fact, I requested this back on my review of v1, but it
>> still hasn't been done. :(
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05421.html
>=20
> Sorry for that! I thought you helped proved that somehow (which I
> really appreciate)...
>=20
>>
>> If my read of history is correct, I think it is sufficient to point to=

>> commit 05875687 as a place where we no longer care about constructor
>> semantics because we are no longer dealing with module_call_init().  B=
ut
>> you may find a better place to point to.  You already found that
>> d622cb587 was what introduced the constructor in the first place, but =
I
>> didn't spend time today auditing the state of qemu back at that time t=
o
>> see if the constructor was really necessary back then or just a
>> convenience for lack of a better initialization point.
>>
>> Alternatively, if you can't find a good commit message to point to, at=

>> least document how you (and I) tested things, using gdb watchpoints, t=
o
>> prove it is a safe delay.
>=20
> I did that by observing all users of the lock in current repository:


> AFAIK all of them are called even after monitor_init(), in other
> words, they are all after global init too.
>=20
> As a conclusion, we should be safe here.  Again, I may be wrong
> somewhere, please correct me if so.

My gdb testing and your analysis match; we're safe.  So all that's
needed is the paragraph documenting that we thought about the issue:

>=20
>>
>> Only if you improve the commit message, you may add:
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Besides the English fix, how about I add one more paragraph to talk
> about monitor_lock in commit message:
>=20
>   monitor_lock won't be used before monitor_init().  So as long as we
>   initialize the monitor globals before the first call to
>   monitor_init(), we will be safe.

Or even:

monitor_lock is not used before monitor_init() (as confirmed by code
analysis and gdb watchpoints); so we are safe delaying what was a
constructor-time initialization of the mutex into the later first call
to monitor_init().

>=20
> With that, could I take your r-b?

Yes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HNePfuP90OprTSjhJk9IPX1QH99ssUhGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWDRUACgkQp6FrSiUn
Q2qz6wf7BoR95l7lUk+J236LtjUbFKC4SclCbpkFRFJamtAYjKFFCpSIcfNuo2je
VQvUAkGAjLy0y3l4l0j9YN8Peh27p/qd3uXevYzHzZcbC3DtaDOe8i1ugYyyZbFk
l5OAvOMPnuHivRP5VrpqAP3GK5Fqzk6blWgjkMh8H58Rfx4Te34KWBwxxm3M5087
P08MLFTKF1KLYltKklM+eDNFlUby+rGj2lyHdq0fU29L3fC4WH8llSzc6TMWuz70
yNKKeZX+6X36YyXn0Ca+zDe0dVKgHXEehoCHhJJU8sXtBfHi43NibthT2pUfJqpN
b/b00N0tSt9Ry5f7MSWrPGlCVh+5Ww==
=I8p6
-----END PGP SIGNATURE-----

--HNePfuP90OprTSjhJk9IPX1QH99ssUhGq--
