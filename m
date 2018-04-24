Received: from eggs.gnu.org ([2001:4830:134:3::10]:54784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3QD-0004Mu-4l
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3QC-00077q-92
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:16:13 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-2-eblake@redhat.com>
	<20180424154026.GC4080@localhost.localdomain>
	<7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
	<20180424171524.GH4080@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bf893b4-7c16-5339-4cb7-4ef8d3b50a7a@redhat.com>
Date: Tue, 24 Apr 2018 14:16:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180424171524.GH4080@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lwJZqiDg0fwVnwGy4wyHHkJIOuY3bYNpV"
Subject: Re: [Qemu-devel] [PATCH 1/6] block: Support byte-based aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lwJZqiDg0fwVnwGy4wyHHkJIOuY3bYNpV
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1bf893b4-7c16-5339-4cb7-4ef8d3b50a7a@redhat.com>
Subject: Re: [PATCH 1/6] block: Support byte-based aio callbacks
References: <20180215192829.9944-1-eblake@redhat.com>
 <20180215192829.9944-2-eblake@redhat.com>
 <20180424154026.GC4080@localhost.localdomain>
 <7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
 <20180424171524.GH4080@localhost.localdomain>
In-Reply-To: <20180424171524.GH4080@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 12:15 PM, Kevin Wolf wrote:

>>> Hm, this is kind of ugly. Previously, we handled everything byte-alig=
ned
>>> in the first section, now we mix both in the second section.
>>>
>>> I can see that you do this so you don't have to duplicate the acb and=

>>> coroutine yielding code below, but can we move things into the right
>>> place in the final patch at least? That is, calculate sector_num and
>>> nb_sectors only if all the byte-based interfaces weren't available.
>>
>> Yeah, that's easy enough to squash into patch 6:
>>

>=20
> Ah, yes. I thought of moving the code in the else block, but this works=
,
> too. Maybe it's even a bit nicer.

Moving the code into the 'if' works for bdrv_co_readv, but not so nicely
for the bdrv_co_writev vs. bdrv_co_writev_flags.  So for v2, I'll just
hoist the aio code first; and I guess I smell another round of cleanups
coming...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lwJZqiDg0fwVnwGy4wyHHkJIOuY3bYNpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfgnUACgkQp6FrSiUn
Q2rE8Af1FDx32UQd+tjHeCrf6OQHL/p3tGwcEzi3uBGhgmHMzYbRWH60QybDWxGs
WxxOlyf8l4G4tiFJd2UNimG6Ct8Fv8Xx324IPw5Afj0lbKvn7lNEXOSijO0Psr3O
VHptLCXZRw5r3rcqCKqdyj0cl/u3sBLCzYItRQOPRX7/fbI+T3JQTMQZ5EC1yjZT
1sVnd3gxF4QFquksnluSeA22DcRTAj+rIN1lMb6KjBC77qKzuF5waYDiGmtpqywH
ngdQ7G7wPhJLYb/qtJV4Woqu1rIlV9klVvvjg4E2dN0w2N53rtIENXG9xY4QuDt6
jCdsdDEcFl6ylzHAeq6E6+0cwAZe
=fbEU
-----END PGP SIGNATURE-----

--lwJZqiDg0fwVnwGy4wyHHkJIOuY3bYNpV--
