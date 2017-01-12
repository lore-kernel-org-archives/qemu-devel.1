Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkNw-0004oT-U0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkNv-0003Ya-UG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:46:04 -0500
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
Date: Thu, 12 Jan 2017 12:45:56 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eSowBQ1KlggqRFQ9RweRGk6jAagGAtHnt"
Subject: Re: [Qemu-devel] [Qemu-block] [Nbd] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Bligh <alex@alex.org.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eSowBQ1KlggqRFQ9RweRGk6jAagGAtHnt
From: Eric Blake <eblake@redhat.com>
To: Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 qemu block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Bligh <alex@alex.org.uk>
Message-ID: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [Nbd] How to online resize qemu disk
 with nbd protocol?
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
 <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
 <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
 <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
 <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
In-Reply-To: <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 11:57 AM, Bob Chen wrote:
> There might be a time window between the NBD server's resize and the
> client's `re-read size` request. Is it safe?

For resize larger, it seems that it would be safe for the server to just
remember the last size it has advertised to the client.  As long as the
client doesn't request read/write to any offset beyond the
last-advertised size (either the size the server gave at handshake, or
the size that the server reported when the client last used the new
're-read size' command), there's no difference in behavior (and
well-behaved clients fall in this group); if the client DOES try to
access out-of-bounds with respect to the last known size, the server
SHOULD reject the access, but MAY serve it instead.  A client that is
unaware of the 're-read size' command will never learn that the server
is now offering a larger image.

For resize smaller, things are a lot trickier - how do you block access
to a portion of a file that the client still thinks exist, but which the
server has truncated away?  Maybe the easy way out is to state that the
server MUST NOT resize smaller.

>=20
> What about an active `resize` request from the client? Considering some=
 NBD
> servers might have the capability to do instant resizing, not applying =
to
> LVM or host block device, of course...

And perhaps the 're-read size' command can serve a dual purpose.  Since
all NBD commands already include space for size and offset parameters,
we could define that if the client passes 0/0 for size and offset, it
wants to read the server's current size; if it passes 0/non-zero, it is
asking the server to resize to the new non-zero size (and the server's
success or error response tells whether the resize happened).

Should I spend time turning this idea into a more formal spec, along the
lines of other NBD extension proposals?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eSowBQ1KlggqRFQ9RweRGk6jAagGAtHnt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd87kAAoJEKeha0olJ0Nq494H/iflclx2SAn5UV0ckc7SFDTd
V4qGZ/KoUAj8mYWhZjj9TOmuEegV0ocSFvKYbjDhqp7JH8O0yE6HicGOUQSH5QNY
SVEl3DkIGbiVwvm2t+wf7TsjlxxhSnjGqjOzZz0IplL4vN5iLNz9eXJDq0S31XT4
ceL3qd9s9gd3nUvOg8vfYfYu09WiRell6dS8D0EsboK+UZhu6zVK0ZgX9iHUXWmx
AUaLRve5BuSmgfNIhWfntNyqzC9za8seFOawUKKzKR57FMu3a/jJ7z6k4eL3WOjt
9M6PrCP/53B6HZ0iQaluTycbd9gDzQt6iCy1PgugoTMeWwER6okSjIg5utoH+T0=
=2LzR
-----END PGP SIGNATURE-----

--eSowBQ1KlggqRFQ9RweRGk6jAagGAtHnt--
