Received: from eggs.gnu.org ([2001:4830:134:3::10]:33823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphb7-0007rV-Lo
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphb6-0007SA-HP
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:10:57 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-15-eblake@redhat.com>
	<8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
	<a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
Date: Wed, 6 Sep 2017 16:10:39 -0500
MIME-Version: 1.0
In-Reply-To: <a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lpkwGJEpmmEuJUCV76QGWV9N2oE0lq7sC"
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState
 for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lpkwGJEpmmEuJUCV76QGWV9N2oE0lq7sC
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>,
 armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState for
 fw_cfg operations
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-15-eblake@redhat.com>
 <8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
 <a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
In-Reply-To: <a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 06:03 AM, Thomas Huth wrote:
> On 05.09.2017 12:12, Thomas Huth wrote:
>> On 01.09.2017 20:03, Eric Blake wrote:
>>> Drop one more client of global_qtest by teaching all fw_cfg test
>>> functionality (invoked through alloc-pc) to pass in an explicit
>>> QTestState, adjusting all callers.  In particular, fw_cfg-test
>>> had to reorder things to create the test state prior to creating
>>> the fw_cfg.
>>>

>>> +++ b/tests/libqos/fw_cfg.h
>>> @@ -15,10 +15,12 @@
>>>
>>>
>>>  typedef struct QFWCFG QFWCFG;
>>> +typedef struct QTestState QTestState;
>>
>> Not sure, but I slightly remember that typedeffing a struct like this =
in
>> multiple places can cause compiler warnings or errors with certain
>> versions of GCC or clang? So a file that includes both, fw_cfg.h and
>> libqtest.h will then fail to compile?

Yes, older gcc fails to compile (my off-hand recollection is that it was
a bug in the older gcc, and not a standards-compliance issue to
encounter the same typedef twice, but I could be wrong), ergo the fixup
that you later noticed.

>>
>> I think it would be better to change the include order in the .c files=

>> instead, so that libqtest.h is always included before fw_cfg.h.
>=20
> Ah, well, I just saw that you also sent a fixup patch for this. Anyway,=

> I'm not a fan of including header files from other header files, so
> changing the include order in the .c files sounds like the better
> solution to me.

Eww. I like headers to be self-contained.  Other than stuff we get from
osdep.h (which we know is included by EVERY .c file), I prefer that if a
header uses another type, then it guarantees that an idempotent
inclusion of a header that declares that type is also present in the
header file, rather than forcing .c files to know which order to include
things in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lpkwGJEpmmEuJUCV76QGWV9N2oE0lq7sC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwZE8ACgkQp6FrSiUn
Q2rJvAgApaK3Jpqd7OOolxEHqTKLNjMtw7e7xbp9Hzui8U0C7aF+UnDm5UNvGy+B
X4UXcujPr+B1YIihuS9bCgfS6QMVkW5/xcnD+O6w1Byf87pckxnXOtkGZR7WVOs2
Rl8Vc6UB+JgBSJv/ZB0IF46Ysd2QJpH5e9fGIvHd0Pn6PPLyR0XKSCJAXEclXYgT
gwPVxC7JSQCd+5Ferwjt864xBROYqbp/Xn5TGFzHjhdZXGJwT0H8b1hYr6KYt8NK
b+/y6i+FgJ/1IpLdxA93SX6zJcbq9Rad/uyPQ+Z66Jf3gakFjAE68YocRVH8MTFN
dJnrxHbku/3sMROoTBU1/YNuqEuqQQ==
=7zE2
-----END PGP SIGNATURE-----

--lpkwGJEpmmEuJUCV76QGWV9N2oE0lq7sC--
