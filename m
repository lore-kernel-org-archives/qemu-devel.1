Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCov-0002A0-CB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCou-0003uY-B9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:54:21 -0500
Content-Type: multipart/signed;
	boundary="Apple-Mail=_DD3588A2-BA82-41CE-ADAE-59AAE78DA3E1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
Date: Wed, 14 Dec 2016 16:54:11 +0000
Message-Id: <2B7F64B1-85F5-4E7A-89A8-C3F22EEC14B2@alex.org.uk>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
	<20161213121856.b7fmjwjfkoeufz4g@grep.be>
	<f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
	<20161214082246.dwzqsu3tzmjmiem6@grep.be>
	<0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, Kevin Wolf <kwolf@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, subo7@huawei.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, xieyingtai@huawei.com, Paolo Bonzini <pbonzini@redhat.com>


--Apple-Mail=_DD3588A2-BA82-41CE-ADAE-59AAE78DA3E1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> ...  But your argument that 16 bits is at a premium may be worth
> considering an alternative representation for the same information.
> 
> Possibility 1: when we run out of our current 16 transmission flags,
> we'll need a way to extend the protocol to support more than that.  To
> do that, we'd probably want a new Handshake flag
> NBD_FLAG_LARGE_TRANSMISSION_FLAGS sent by the server, and which must be
> answered by the client sending a new Client flag
> NBD_FLAG_C_LARGE_TRANSMISSION_FLAGS, so that both sides know that all
> subsequent places in the protocol that send transmission flags will now
> send 64 bits instead of 16 bits (old-style negotiation cannot benefit
> from this, and is permanently stuck at 16 bits, but we discourage
> old-style negotiation).  We'd still want to prioritize which bits land
> in the first 16 positions, for maximum compatibility with older servers
> or clients (where the higher bit positions are used for data that is
> more suited for optimizations, rather than controlling correct usage) -
> thus NBD_FLAG_INIT_ZEROES would serve as an example to live in the
> extended positions.

Well, to me, this just reads like the transmission flags aren't
limited to 16 bits as you've demonstrated a workaround. Any client/server
needing to interpret more bits than the 16 just needs to also
understand extended transmission bit flags. I don't that that's
an unreasonable requirement, so I don't actually buy the prioritisation
argument.

So this seems to me like a good argument we should proceed how
you originally suggested and Wouter should be less worried about
your flag-burning activities :-)

> Possibility 2: Leverage the extension-info branch: Add a new
> NBD_INFO_INIT_ZERO information datum.  NBD_BLOCK_INFO already exists to

I think you mean NBD_INFO_BLOCK_SIZE?

> let server and client exchange as much per-export information as they
> want during handshake without burning any new transmission flags, and
> with a specification that gracefully ignores unknown requests from the
> client and unknown advertisements from the server.  There's the drawback
> that the server can't advertise the known-zero-init optimization to
> clients that don't use NBD_OPT_GO, but that's not too bad (especially if
> qemu is the first client with code to actually make use of the
> optimization, since I am already trying to get qemu to be one of the
> first adopters of NBD_OPT_GO).

I think you are suggesting add NBD_INFO_SOMETHINGELSE which could
be extended transmission flags. Fair enough.

Possibility #3: we modify NBD_INFO_EXPORT (which is still experimental)
*now* to have an extended transmission flags 64 bits. This is where
transmission flags SHOULD go, and just as we'll run out of them
in NBD_OPT_EXPORT_NAME we'll also run out of the same 16 flags in
NBD_OPT_GO. So it seems a good idea to free us from that limitation
now. And all clients (one hopes) will use NBD_OPT_GO eventually.

This has the minor disadvantage of breaking clients that rely on
the current state of the experimental extension, but that's why
it's experimental. Newer clients can talk to older servers if they
are so inclined by checking the length field on the option (which
will extend to 16 from 12).

> We'll probably have to eventually use something along the lines of
> possibility 1 for more transmission flags for some other reason down the
> road (since we have lately been adding one flag per new command/command
> group as we add extensions), but I agree that it is a bit heavy for now.
> So it sounds like I should rework the proposal along the lines of
> possibility 2, which also implies that we should get extension-info
> ready for promotion to current.  And that means that my current proposal
> to the extension-write-zeroes branch is probably not ideal, but it
> reopens the question of whether extension-write-zeroes as it currently
> stands is ready for promotion to stable now that qemu 2.8 implements it.

My view is:
#0 (your original proposal) is actually fine.
#1 seems too heavy
#2 also seems pretty heavyweight - adding a whole new info command for one
   bit
#3 is pretty simple, but carries the disadvantage that you won't be able
   to provide a reference implementation without also putting NBD_OPT_GO
   support into the reference implementation. Oh hang on, perhaps that's
   an advantage :-)

So I'd either go with #0 or #3.

--
Alex Bligh





--Apple-Mail=_DD3588A2-BA82-41CE-ADAE-59AAE78DA3E1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYUXkzAAoJEBPm5K7i9iORv4cQAIBiKAN3P6L5D5J9avGOVRYx
u6EImHyJjjcOhVt2Zd1gbTGjjH33Xwlc0xlO3OohZn4dyKoCjn2YsmEG5Fmi3Yvx
tiQValGmtZoF0xp4WPvjbX6K6Y9md+9uyITvzethsIUFdagXboapFDhW0PpB0/94
2PyYq93A0EO6sPDWMtWerzYi5wXMzrZm5q7pPNkluTDS4W94FAhzjJ0zJmbxMA61
2oDXtDpLC/wIdBmxT1Yey/ROFW/21X58lDqJYJHNduDF/Vdi55oDFae8DOVrb/X3
xPQbSWrDO5TDr/K5NjBeyBczkwPdrwh+0+Ke2OemOP+ZrStu7+qaWt4fzXdZGLc9
hUlyMguisrgEJIJoKR6wJQkmK5qTZ2+CRF6e21R8Q2/0BuTYhQLKSHbxYZ+MGLW4
e6ekZhl2M7fP8lP8ntxg45qmHHglHZJrbEwMV7BJ0tSvjQ+gMNjVPu0dDqF36PDU
gPdqwGjwIViB4mNHXex3sdXYKoQxdwAjL/TxR/Q4Fq422hxgIPGHMVMIUvNSfYbm
Y+aT/zzB8Y2W6AI87BCjiYPpzQOjK3rQRlaiQFpEoL7eCDdgxHrn/JhRx58XldtT
5liuzS2C3UOpBDAFWV9NhKLTihWqImo/3KDFStvFSD2krVuKwMQiBQewR01eFkum
a+XzGcyB2z5tF5pPNBiv
=zVzj
-----END PGP SIGNATURE-----

--Apple-Mail=_DD3588A2-BA82-41CE-ADAE-59AAE78DA3E1--
