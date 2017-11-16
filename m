Received: from eggs.gnu.org ([2001:4830:134:3::10]:37196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFM7w-0008Tm-T5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFM7v-0005jd-MU
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:30:52 -0500
References: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
	<09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
	<20171114173745.egvtklxyrcprlcdn@grep.be>
	<cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
	<20171116095116.4weodui6w27clyre@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11977343-24b6-9b1d-59e0-275de8b988cb@redhat.com>
Date: Thu, 16 Nov 2017 09:30:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171116095116.4weodui6w27clyre@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jmak35i3JESNc2r3tUfHS0G1hTu31sLtE"
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Bob Chen <a175818323@gmail.com>, nbd list <nbd@other.debian.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmak35i3JESNc2r3tUfHS0G1hTu31sLtE
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Bob Chen <a175818323@gmail.com>, nbd list <nbd@other.debian.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <11977343-24b6-9b1d-59e0-275de8b988cb@redhat.com>
Subject: Re: [Nbd] [Qemu-devel] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
References: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
 <20170114144500.oxoqvrn5x4sdfo74@grep.be>
 <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
 <20170118080126.nyldkjhxdsxd4u2b@grep.be>
 <CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
 <20170122114339.l3ijhy3uymsru4ed@grep.be>
 <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
 <09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
 <20171114173745.egvtklxyrcprlcdn@grep.be>
 <cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
 <20171116095116.4weodui6w27clyre@grep.be>
In-Reply-To: <20171116095116.4weodui6w27clyre@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2017 03:51 AM, Wouter Verhelst wrote:

>> I also remember from talking with Vladimir during KVM Forum last month=

>> that one of the shortfalls of the NBD protocol is that you can only ev=
er
>> send a length of up to 32 bits on the command side (unless we introduc=
e
>> structured commands in addition to our current work to add structured
>> replies);
>=20
> Yes, and I'm thinking we should do so. This will obviously require more=

> negotiation.
>=20
> Can be done fairly easily though:
> - Client negotiates structured replies (don't think it makes sense to d=
o
>   structured requests without structured replies)
> - Server sets an extra transmission flag to say "I am capable of
>   receiving extended requests"
> - Extended requests have a different magic number, and should have a
>   "request length" field as well. I'm thinking we make it:
>=20
> magic          (32b)
> request length (16b)
> type           (16b)
> flags          (64b)
> handle         (64b)
> from           (64b)
> data length    (64b)
> (extra data)
>=20
> Request length in this proposal should always be at least 320.

320 bits, but we pass length in bytes, so 40.

>=20
> I made flags 64 bits rather than 16 as per the current format, because
> that way everything is aligned on a 4-byte boundary, which makes things=

> a bit easier on some architectures (e.g., I know that sparc doesn't lik=
e
> unaligned 64-bit access). 64 bits for flags looks like a bit of a waste=
,
> but then if we're going to waste some bits somewhere, I guess it's best=

> to assign them to flags.
>=20
> The idea is that "request length" is the length of the data that the
> client is sending, and "data length" is the length of the range that
> we're trying to deal with.

Yep, sounds reasonable.

>=20
> A write request would thus have to have request length be (data length =
+
> 320); a read request would have request length be 320, and expect data
> to be returned of data length bytes.

Umm, if data length is 64 bits, but request length is 16 bits, we can't
properly support write requests with that much payload.  I think it goes
back to the idea of block sizes: the maximum request that a server is
willing to accept (advertised via INFO during NBD_OPT_GO) still applies,
so you can't NBD_CMD_WRITE with more than that maximum size (and
therefore your maximum request size can't be more than that size plus
the overhead of the 40 byte header), but OTHER commands that CAN operate
on larger chunks of the export (WRITE_ZEROES, BLOCK_STATUS, maybe a new
extension LOCK for allowing fcntl()-like locking semantics) can now be
accommodated, because they don't have to send large amounts of payload
along with the request.

Keeping request length at 16 bits may therefore be too small (if we want
to allow 32M write payloads), and may require us laying out the
structured write header slightly differently (maybe fewer flag bits
after all).  Or we can say that NBD_CMD_WRITE still has to use old-style
requests.

>=20
> A metadata request could then tack on extra data, where request length
> of 320 implies "all negotiated metadata contexts", but anything more
> than that would imply there are some metadata IDs passed along.

Again, 40 bytes (not 320 bits), but yeah, that would be the idea.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jmak35i3JESNc2r3tUfHS0G1hTu31sLtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloNryEACgkQp6FrSiUn
Q2pikgf6AzjAUAwtvQC3Xcb2UMHbTAXrOZ/5GzTNtGF4lzkG5lbpCJZASWNqeQYn
3aH6JZ7emXavgAM965/EbsrTn9wmsElJrH1grgyyusAttGNsIdKiij+NpWLCOtlF
Yh0EdN/hiE+RXICZguvzfCzPXao25fnCpHllRdLYhtOgDaVClAR4Y3Caiou3a2Pr
Pl41jQWfignz6rSMBj3onKHpxCANfSSvggGii8w1nVPpWW6gBw2ZgdiIFatsSE/s
f9cJ1HcEWoJtnj3PhUOrgT5+oJrgr9MOsKP7ERsHneJWhJd6bSrz5Ner6ySgfgAt
WRJzmxdm7IB6WMJ9MlV4A5v/LTA8pQ==
=5Y7G
-----END PGP SIGNATURE-----

--jmak35i3JESNc2r3tUfHS0G1hTu31sLtE--
