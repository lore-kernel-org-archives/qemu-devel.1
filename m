Received: from eggs.gnu.org ([209.51.188.92]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghn57-0007IG-Ae
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 22:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghn55-0000Z3-Az
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 22:02:01 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-4-eblake@redhat.com>
	<1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
	<719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be3b598e-21d1-f90e-d7ed-6324856043c5@redhat.com>
Date: Thu, 10 Jan 2019 20:56:54 -0600
MIME-Version: 1.0
In-Reply-To: <719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tgIJfTFDiXQLDMrBuKzqSRnOPaLX2mVxs"
Subject: Re: [Qemu-devel] [PATCH v2 03/22] maint: Allow for EXAMPLES in
 texi2pod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tgIJfTFDiXQLDMrBuKzqSRnOPaLX2mVxs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <be3b598e-21d1-f90e-d7ed-6324856043c5@redhat.com>
Subject: Re: [PATCH v2 03/22] maint: Allow for EXAMPLES in texi2pod
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-4-eblake@redhat.com>
 <1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
 <719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
In-Reply-To: <719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 5:45 PM, Eric Blake wrote:
> On 12/18/18 7:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 15.12.2018 16:53, Eric Blake wrote:
>>> The next commit will add an EXAMPLES section to qemu-nbd.8;
>>> for that to work, we need to recognize EXAMPLES in texi2pod,
>>> and we need to make all man pages be regenerated since the
>>> output of texi2pod can be different.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>=20
>>> +qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi \
>>> +	qemu-monitor-info.texi scripts/texi2pod.pl
>>> +qemu.1: qemu-option-trace.texi scripts/texi2pod.pl
>>
>> I think, no needs to add scripts/texi2pod.pl to both qemu.1: lines, as=
 they should be
>> merged anyway. And if you want to add line breaking anyway, it looks b=
etter to use one qemu.1:
>> dependency line.
>=20
> Easy to fix.
>=20
>>
>> On the other hand, it may be better to add MANS variable as subset of =
DOCS to combine all man page targets,
>> and than do like $(MANS): scripts/texi2pod.pl.. (and recombine DOCS, u=
sing MANS ofcourse)

Even easier (although it took me a while digging through 'info man' to
learn it):

$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl

although the dependency must be listed AFTER any more specific rule
(since rules.mak has a %.1: pattern rule which expands $< to the first
dependency, and we do not want scripts/texi2pod.pl to be treated as our
first dependency).

>> Hm, and I don't see here docs/interop/qemu-ga-ref.7 and docs/interop/q=
emu-qmp-ref.7,
>> which exist in DOCS.

They are there, just harder to see (hence why my v2 missed them). Of
course, doing the generic dependency is better than editing every single
man file listing.

>=20
> Oh, good point. The .txt files should also have the dependency

Or not. The .txt output files depend on the .texi source, not on the
generated .1 page; only the files that used scripts/texi2pod.pl need to
depend on that, and based on rules.mk, that is only the 3 man page
categories.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--tgIJfTFDiXQLDMrBuKzqSRnOPaLX2mVxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4BfYACgkQp6FrSiUn
Q2ppNgf/Wm4EVXdT3xyrYu2UaqzWd1ETHoGLY/MU7NTJkOoYVKNe4InT0GV4ZWD8
/rJiDnshIgJjPGLVEhv5fi0Tbn1rqDt9DRAL0L2hsMnMdpvpg+ycGiOxFS0bEbkk
3M3GToHLUbnZr3HxIiGcyl3NMJWVDVfrVW2mrqsY2iUSYa9NGfnz/3fpYpUSmvRa
rHVZvFleMxD02W1+pbaXY3hWa5t2qZoZRLdvNR+TcJayNlIwNeacAAS1Qf96o2LW
GJlDPOFZpP3WUqyeqQ1j4CnfeZIGqN6nWDJ28VGDLX2vq/FDAFQ6WBYhVtIy+adb
52ZM0agBnLWKGT/R5Pjpaxe5fbazRQ==
=vhg8
-----END PGP SIGNATURE-----

--tgIJfTFDiXQLDMrBuKzqSRnOPaLX2mVxs--
