Received: from eggs.gnu.org ([2001:4830:134:3::10]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyIsf-000265-Na
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyIsb-0000To-2l
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cyIsa-0000Ta-Qj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:04:17 -0400
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
	<70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
	<87vaq97mxf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com>
Date: Wed, 12 Apr 2017 09:03:54 -0500
MIME-Version: 1.0
In-Reply-To: <87vaq97mxf.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fgLwwVas6Muhts07RXChXptk3SgV9vJfx"
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fgLwwVas6Muhts07RXChXptk3SgV9vJfx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Message-ID: <480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
References: <20170406210917.6896-1-eblake@redhat.com>
 <877f2pnb2t.fsf@dusky.pond.sub.org>
 <70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
 <87vaq97mxf.fsf@dusky.pond.sub.org>
In-Reply-To: <87vaq97mxf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 08:52 AM, Markus Armbruster wrote:
>>> In other words, these three signals are polite requests to terminate
>>> QEMU.
>>>
>>> Stefan, are there equivalent requests under Windows?  I guess there
>>> might be one at least for SIGINT, namely whatever happens when you hi=
t
>>> ^C on the console.
>>
>> Mingw has SIGINT (C99 requires it), and that's presumably what happens=

>> for ^C,...
>>
>>>
>>> Could we arrange to run qemu_system_killed() then?
>>
>> ...but I don't know why it is not currently wired up to call
>> qemu_system_killed(), nor do I have enough Windows programming experti=
se
>> to try and write such a patch. But I think that is an orthogonal
>> improvement.  On the other hand, mingw has a definition for SIGTERM (b=
ut
>> I'm not sure how it gets triggered) and no definition at all for SIGHU=
P
>> (as evidenced by the #ifdef'fery in the patch to get it to compile und=
er
>> docker targetting mingw).
>=20
> If all we need is distingishing host- and guest-initiated shutdown, the=
n
> detecting the latter reliably lets us stay away from OS-specific stuff.=

> Can we do that?

I'll simplify what I can; I still can't guarantee that mingw will be
setting the bool correctly in all cases, but setting a bool is easier
than trying to set a signal name.


>> There are other reasons too: a guest can request shutdown immediately
>> before the host sends SIGINT. Based on when things are processed, you
>> could see either the guest or the host as the initiator.  And the race=

>> is not entirely implausible - when trying to shut down a guest, libvir=
t
>> first tries to inform the guest to initiate things (whether by interru=
pt
>> or guest agent), but after a given amount of time, assumes the guest i=
s
>> unresponsive and resorts to a signal to qemu. A heavily loaded guest
>> that takes its time in responding could easily overlap with the timeou=
t
>> resorting to a host-side action.
>=20
> This race doesn't worry me.  If both host and guest have initiated a
> shutdown, then reporting whichever of the two finishes first seems fair=
=2E

So maybe I just tone down the docs and not even mention it.

>=20
> Additional ways to terminate QEMU: HMP and QMP command "quit", and the
> various GUI controls such "close SDL window".

Good points. I have no idea what exit path those take (if they
raise(SIGINT) internally, it's quite easy - but if they go through some
other exit path, then I'll need to wire in something else).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fgLwwVas6Muhts07RXChXptk3SgV9vJfx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7jPKAAoJEKeha0olJ0NqfJUIAIj/mJ7GHkdZ2ip2QeOycbM2
6xb9S6q5jui7WoEDFuAjLVSrlBTINuRycLlFO8W5KBYEGWeb5obMXlyRZQ7dcIqT
i+K7Fiw+F2CKdlR8s+MJG85XakrQUGA778hqqY9leZUqF/hGbonME/Lpn6bxTCcJ
iKLKl/4vfQJ8e3aeqTzHK7qLdWnqOiKdSUpyUMIiONgF9QVWLno1gf3w4JGLy1cV
nkpzBk1DfiyqKUEppc48UPyaoyeuUreV6WnFBvajQ+k9ZV+vcBqYx6j7c6Ub87vw
ssYF15h+rvzevuBlgKb3RtTnCqbDydLHj14A6DXDg+a3OFRtDiVbeFMWBEVXvc4=
=bsWT
-----END PGP SIGNATURE-----

--fgLwwVas6Muhts07RXChXptk3SgV9vJfx--
