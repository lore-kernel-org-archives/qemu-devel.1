Received: from eggs.gnu.org ([2001:4830:134:3::10]:60418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47nx-00070h-Es
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47nw-0005oa-7S
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d47nv-0005n8-Ub
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E0AFC05AD87
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:27:30 +0000 (UTC)
References: <20170427165526.19836-1-dgilbert@redhat.com>
	<20170428134230.GB11415@redhat.com> <20170428134532.GG2085@work-vm>
	<20170428151051.GH11415@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4259934c-58f5-16b2-4e24-6a3c926ef440@redhat.com>
Date: Fri, 28 Apr 2017 10:27:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170428151051.GH11415@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qR4xm4QLbuh7LMVjp2TDtvfPR1W80km6v"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qR4xm4QLbuh7LMVjp2TDtvfPR1W80km6v
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <4259934c-58f5-16b2-4e24-6a3c926ef440@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
References: <20170427165526.19836-1-dgilbert@redhat.com>
 <20170428134230.GB11415@redhat.com> <20170428134532.GG2085@work-vm>
 <20170428151051.GH11415@redhat.com>
In-Reply-To: <20170428151051.GH11415@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 10:10 AM, Daniel P. Berrange wrote:

>>> Or could we perhaps instead undo the damage via a hack like
>>>
>>>  #define g_assert_cmpint g_assert_cmpint_orig
>>>  #define g_assert_cmpint(x, y, z) \
>>>      g_assert_cmpint_orig(x, y,x); \
>>>      abort()

Not quite the right hack (we don't want to unconditionally abort, but
only when the condition fails).

>>
>> I'd be kind of OK adding a q_assert_cmpint if you wanted,
>> but I think we shouldn't change the semantics of a public
>> name.

I tend to agree there; having our own distinct name means that we can
see at a glance that our version will quit, no matter what the glib
version does.

>=20
> Personally I think it would be worth having them - the whole point of
> these more specific g_assert_* macros is that they provide clearer
> error messages when they're triggered, so I prefer their use generally

I agree that the improved error messages part is worthwhile.  So maybe
we want:

#define q_assert_cmpint(x, y, z) \
  do { \
    g_assert_cmpint(x, y, z); \
    assert(x y z); \
  } while (0)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qR4xm4QLbuh7LMVjp2TDtvfPR1W80km6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA19eAAoJEKeha0olJ0NqU9QH/R1xw77bLkKi+zCEL4rSVFGD
e1XOZkVMwvfP65CzbJuPBk7Updd5LRTBa2WhM+Zxjz841LL9lqxSzlNuLOp9hcwj
vKbLhJLr/Qvhcv3qAfWRD3xKnrs9K/CAupOWO2SFSCERfLNRen/7ME4CJ71YZLMB
1NegUA0RsKZ6MLoU/03oevnfEfOceoB5TdZwzWx3rq8M1EnVtN6uBCA2d5QdF0c0
7M0NYNsqJL2dH4SsKRyqdbakMiJhBfvWfny+WfxbnEIkCLn4XKxzKlLj1YOZkH9j
+/5xgNAL23mLhP5AfW6WJzWzSpJOmdycnXEvKD1Eb4gFfT4QKOnxNULBR85xpAg=
=OZl4
-----END PGP SIGNATURE-----

--qR4xm4QLbuh7LMVjp2TDtvfPR1W80km6v--
