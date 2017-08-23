Received: from eggs.gnu.org ([2001:4830:134:3::10]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbE5-0000f8-If
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbE2-00072A-CL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkbE2-00070G-2s
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:22:02 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
Date: Wed, 23 Aug 2017 14:21:57 -0500
MIME-Version: 1.0
In-Reply-To: <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aGxVRtcXm1oC98fCqkVoad36WE2E4b35H"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aGxVRtcXm1oC98fCqkVoad36WE2E4b35H
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, armbru@redhat.com, f4bug@amsat.org
Message-ID: <ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert() in
 supported builds
References: <20170818222313.13391-1-eblake@redhat.com>
 <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
In-Reply-To: <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 06:19 AM, Halil Pasic wrote:

> OTOH I do think this is to some degree institutionalizing a bad practic=
e
> (you say we do not want to do that, but IMHO refusing to build with
> NDEBUG makes only sense if we want to alter the semantic of assert so
> that once bad becomes acceptable). I can live with that, but I'm not
> happy about it. Have we considered rolling our own construct which is
> designed to exhibit the properties we desire?

I've thought about it, and it may have even been discussed on the list
perhaps (although I didn't go searching to verify).

>=20
> I mean, if it's about the side effects we could create something like
> q_assert(cond) and state that cond is evaluate exactly once (and
> depending on what we want to have, make the actions on !cond (calling
> abort(), producing a diagnostic message) compile time tweak-able or
> not). I assume we could then convert each usage of assert to the safe
> q_assert programmatically.

I'd prefer that if we are going to introduce our own construct that
always evaluates side effects, and only has a compile-time switch on
whether to abort() or (foolishly) plow on, that we name it something
without 'assert' in the name, so that reviewers don't have to be
confused about remembering which variant evaluates side effects.  Maybe:

q_verify(cond)

is a good name, which performs the side effects of 'cond' no matter
what, but also allows us to abort() if cond fails vs. ignore the
failure; perhaps where we make a compile-time decision between the two
behaviors as a configure --enable-FOO flag.

Converting all existing assert() and g_assert() to q_verify() should be
fairly simple, if we like the idea.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aGxVRtcXm1oC98fCqkVoad36WE2E4b35H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmd1dUACgkQp6FrSiUn
Q2q8ZAf9EKlDJ3H8+IVKeAUY++iYN0KxLu28qkFugflgRFhv9LCNx1sqtT98CXfY
4NfVI+wlw/DCnAFIO9nzOCNvVgOkbNmGTytNqyu13PKCJa1nmFNHNU0jS+mB+xrc
Bh2giZyvF5TjK8uKaVZL+xe9Z0zoRckffPk6BjpblsSM6MrHl9+fxsDTeXO5+9CY
u+76ZSHd519kZUngItXD6a4Q4WdRAKIyfgjYaS8A2jSajBqpHSPCHzUBVMGQvdGZ
V4SdM2ZRjodB/Wf7a5T9pCK9SW7tlySzCUuyto5pcZVJ0CsxdoDTc9k3thEwYF5j
ZnBLG68f4myRV9MU80xr6WrRTfGQzg==
=Mgfl
-----END PGP SIGNATURE-----

--aGxVRtcXm1oC98fCqkVoad36WE2E4b35H--
