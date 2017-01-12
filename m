Received: from eggs.gnu.org ([2001:4830:134:3::10]:56378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRkYK-0004On-F8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRkYJ-0006Hr-Ce
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:56:48 -0500
Content-Type: multipart/signed;
	boundary="Apple-Mail=_98484D41-0B28-4BA1-9737-E905329FE5F9";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
Date: Thu, 12 Jan 2017 18:56:42 +0000
Message-Id: <B07FDA27-AF64-4BF1-874A-9B4AF201BA8E@alex.org.uk>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--Apple-Mail=_98484D41-0B28-4BA1-9737-E905329FE5F9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 12 Jan 2017, at 18:45, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 01/12/2017 11:57 AM, Bob Chen wrote:
>> There might be a time window between the NBD server's resize and the
>> client's `re-read size` request. Is it safe?
>=20
> For resize larger, it seems that it would be safe for the server to =
just
> remember the last size it has advertised to the client.  As long as =
the
> client doesn't request read/write to any offset beyond the
> last-advertised size (either the size the server gave at handshake, or
> the size that the server reported when the client last used the new
> 're-read size' command), there's no difference in behavior (and
> well-behaved clients fall in this group); if the client DOES try to
> access out-of-bounds with respect to the last known size, the server
> SHOULD reject the access, but MAY serve it instead.  A client that is
> unaware of the 're-read size' command will never learn that the server
> is now offering a larger image.
>=20
> For resize smaller, things are a lot trickier - how do you block =
access
> to a portion of a file that the client still thinks exist, but which =
the
> server has truncated away?  Maybe the easy way out is to state that =
the
> server MUST NOT resize smaller.

I'm not sure why this is any harder than Qemu writing to a physical =
partition
that changes size. You need to change the size of things in order. To
resize smaller, you tell Qemu it's smaller, then resize the partition. =
To
resize larger, you resize the partition then tell Qemu it's larger.

This is incidentally exactly the same thing you do if you have a filing
system on a partition (or a filing system on a real nbd device - we =
could
support the same reread of geometry in kernel).

>>=20
>> What about an active `resize` request from the client? Considering =
some NBD
>> servers might have the capability to do instant resizing, not =
applying to
>> LVM or host block device, of course...
>=20
> And perhaps the 're-read size' command can serve a dual purpose.  =
Since
> all NBD commands already include space for size and offset parameters,
> we could define that if the client passes 0/0 for size and offset, it
> wants to read the server's current size; if it passes 0/non-zero, it =
is
> asking the server to resize to the new non-zero size (and the server's
> success or error response tells whether the resize happened).
>=20
> Should I spend time turning this idea into a more formal spec, along =
the
> lines of other NBD extension proposals?

I'd support the reread bit. I'm less sure we ever want to push a new
size from the client. It seems a bit like a layering violation. Perhaps
I can be convinced.

My preferred way to do this would be essentially to allow NBD_OPT_INFO
to be sent (wrapped appropriately) during the main transmission phase.
That would allow *any* INFO stuff to be reread.

If it's just this (rather than a resize command) I guess it could
go into the NBD_OPT_INFO extension branch. If it's going to do
more than _INFO_, then I guess it needs its own extension.

--
Alex Bligh





--Apple-Mail=_98484D41-0B28-4BA1-9737-E905329FE5F9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYd9FqAAoJEBPm5K7i9iORhUAQAI+cSvW/inHffz/W8pDeJZZg
XxTVE1ovTArnotkc3gH3++jXlcVaO0S8gftzh3NXIhi0dmt5EzwiJGtl8ahSqlak
VoyjdOan/xqn84ZBrTEUIajtOna3HNnPVpYuCi9mg7C2PYArwqQw68hEhMnhGAqK
HlLr66PyS5LnHmvCLgtAhjgt/P2GMNsiIu4kgo12ogfmkxo46i773x4TIEzFWLv8
Xvi8uXTxrp3Z1xZPPXNZ1BP32czC6kUjKm+3aIr65Kvy776vo7Iv/VnFxt0R7b7p
sbIfYqeyBeqt/FtIoWqzcV0tpqoC/ODhKyUuV7IQEZg5arkwHN1+NS/Sn7xjYoeV
JqZwgkL/wrKz6Iawh5/SYFzCxh5gMpr3z+WhFdBBNc9vRxo2vitiXaYTffkXhFn7
vlDEGtuAhemOcBdOyzTv+oqh4sdk3FFYOiz9881S0W9azT8+GiOdMDfqKktoQvvq
+Rs5jjHJ1yftAQ8TQsgqGDIiicdOkjtyL1kibP+S64mOXNg6KWNnr5qoWqIDgFZ5
idslZEkbmLyyO1iq1O3FO8QaBCeSSaTMFHNI8fBZrBI0xO5MPotvQVno9dDbheS4
kb/CiBFanGh6KwOop5sqeQ8s3Qeox+0cNQvsuVTWo15LrZSvm5lCg2YOZQ2s+P3h
GtvdQMRhQZqvbBjOVL6P
=e4jn
-----END PGP SIGNATURE-----

--Apple-Mail=_98484D41-0B28-4BA1-9737-E905329FE5F9--
