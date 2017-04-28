Received: from eggs.gnu.org ([2001:4830:134:3::10]:56790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Ecx-0006My-0I
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Ect-0003HM-Tj
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d4Ect-0003GL-K6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:44:35 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-4-eblake@redhat.com>
	<87h918bmpz.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0824e24-ea2b-4037-939b-2327435b4f24@redhat.com>
Date: Fri, 28 Apr 2017 17:44:31 -0500
MIME-Version: 1.0
In-Reply-To: <87h918bmpz.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="scpFf48n2vDIicg5JPhmnUgRaEJMFN4fN"
Subject: [Qemu-devel] replay help [was: [PATCH v5 3/4] shutdown: Add source
 information to SHUTDOWN and RESET]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--scpFf48n2vDIicg5JPhmnUgRaEJMFN4fN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-ID: <f0824e24-ea2b-4037-939b-2327435b4f24@redhat.com>
Subject: replay help [was: [Qemu-devel] [PATCH v5 3/4] shutdown: Add source
 information to SHUTDOWN and RESET]
References: <20170428021317.24711-1-eblake@redhat.com>
 <20170428021317.24711-4-eblake@redhat.com>
 <87h918bmpz.fsf@dusky.pond.sub.org>
In-Reply-To: <87h918bmpz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[trimming cc's]

On 04/28/2017 10:01 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Libvirt would like to be able to distinguish between a SHUTDOWN
>> event triggered solely by guest request and one triggered by a
>> SIGTERM or other action on the host.  While qemu_kill_report() is
>> already able to tell whether a shutdown was triggered by a host
>> signal (but NOT by a host UI event, such as clicking the X on
>> the window), that information was then lost after being printed
>> to stderr.  The previous patch prepped things to use an enum
>> internally; now it's time to wire it up through all callers, and
>> to extend the SHUTDOWN and RESET events to report the details.
>>

>> The replay driver needs a followup patch if we want to be able to
>> faithfully replay the difference between a host- and guest-initiated
>> shutdown (for now, the replayed event is always attributed to host).
>=20
> I'd prefer to get this right from the start, but that requires input
> from replay guys.
>=20
> Scandalously, replay/ is not covered by MAINTAINERS.
> scripts/get_maintainers.pl blames it on Pavel Dovgalyuk (cc'ed), and gi=
t
> shows recent activity.  Pavel, please post a suitable patch to
> MAINTAINERS, and please help us figure out what to do about replaying
> reset here.

In particular, my questions include:

How sensitive is the enum ReplayEvents in replay-internal.h to
additions? Do we have to worry about cross-version compatibility (where
we can only add new events at the end), or can we reorder things at
will?  I suspect that depends on whether you ever plan to replay a
script recorded by old qemu while running new qemu.

One idea would be to carve out a range of new enums in ReplayEvents,
similar to how you have a range of CHECKPOINT_COUNT enums carved out;
the range would be large enough to encode each cause of shutdown, and
then you just map the range back into a reset request with the right
cause. Another would be to modify the replay script file format: right
now, it records a single byte for a shutdown request, but a single new
enum triggers that we now read a second byte for the cause (where the
second byte is directly the cause).  If replaying old streams matters,
we still have to burn a new enum (so that you can tell the difference
between old stream with no cause occupying one byte, vs. new stream with
second byte giving the cause); if cross-version qemu doesn't matter (ie.
upgrading qemu can invalidate all previously captured replay streams),
then this version would better be served by repurposing the existing
EVENT_SHUTDOWN enum in-place.

I'm probably up to the task of coding this, rather than waiting for a
solution from Pavel; but I would rather have some guidance on preferred
direction, particularly the understanding of how much we care about
cross-version replay (which is admittedly a tougher thing than
cross-version migration), so I don't waste time by starting coding down
a wrong direction.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--scpFf48n2vDIicg5JPhmnUgRaEJMFN4fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA8XPAAoJEKeha0olJ0NqPuoH/2UmFrV7vBsK5OabJipJEqB/
hwz6CFqgd2L9pT2nV0buKZNt3zvDTqmIVpeNFWT4fPEUGfdbfpjgNzpm8EECx/td
Ve+J4ziczl18qVdKQCE/kqQTsQHGfQK+KdLjtCiw1Ut1g8qgCGW3BT1JC+wLGBop
pEosIUbKcU2RQepZ3cjWlugTwKi+isXIcbWfO16VG7O5q4cibnZpRJPw4XwI57V1
dFhjHP/z42cPawSVBEGDvaAHEZQ/HLrtn+A4dTbE/NgKsE2PyuJHz+HsKSAMCOMN
xh8+vOX4hXAEMTQVqQO/4VLRZbn08se2IrcItXkrVMn3uvkwnjOEsGVftc/ASfE=
=Nj6x
-----END PGP SIGNATURE-----

--scpFf48n2vDIicg5JPhmnUgRaEJMFN4fN--
