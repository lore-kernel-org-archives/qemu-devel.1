Received: from eggs.gnu.org ([2001:4830:134:3::10]:50525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1ekZBu-0008NN-2q
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1ekZBt-0004ew-3Q
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:43:58 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <8eb7f38c-ff46-df7d-1d43-d5c98bfd4ff2@redhat.com>
Date: Sat, 10 Feb 2018 18:43:39 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7504AC7-F974-4C7A-8FAA-C4D803C941E4@alex.org.uk>
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
	<8eb7f38c-ff46-df7d-1d43-d5c98bfd4ff2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, nbd list <nbd@other.debian.org>, vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mreitz@redhat.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>


> On 8 Feb 2018, at 16:28, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 02/08/2018 07:23 AM, Edgar Kaziakhmedov wrote:
>> Upstream NBD protocol implementation supports an efficient zero out
>> mechanism over the wire, along with the ability to check whether a
>> client allows using a hole.
>> Accordingly, since PWRITE_ZERO doesn't involve any payload on the =
wire,
>> increase a maximum size of the PWRITE_ZERO request up to 1Gb =
(aligned).
>> Moreover, such change will decrease the number of PWRITE_ZERO NBD =
commands
>> in comparison with the current 32M limit. The benefits of
>> the larger constraint can be examined in a block mirroring over NBD.
>=20
> We've got a potential problem.  Unless you have out-of-band =
communication of the maximum NBD_CMD_WRITE_ZEROES sizing (or if the NBD =
protocol is enhanced to advertise that as an additional piece of block =
size information during NBD_OPT_GO), then a client CANNOT assume that =
the server will accept a request this large.  We MIGHT get lucky if all =
existing servers that accept WRITE_ZEROES requests either act on large =
requests or reply with EINVAL but do not outright drop the connection =
(which is different from servers that DO outright drop the connection =
for an NBD_CMD_WRITE larger than 32M).  But I don't know if that's how =
all servers behave, so sending a too-large WRITE_ZEROES request may have =
the unintended consequence of killing the connection.
>=20
> I'm adding the NBD list; perhaps before accepting this into qemu, I =
should revive my earlier attempt at codifying an NBD_OPT_GO info =
advertisement for maximum trim/zero sizing, which would let clients have =
a guarantee that their choice of sizing won't cause unexpected failures.

A couple of comments:

1. The length field is only 32 bits, so no writes more than 0xffffffff =
in length are going to work anyway :-)

2. I'm not sure the situation is as bad as you make out Eric. I think =
you've forgotten the NBD_OPT_INFO work and the conversation around that =
we had where we determined that servers not supporting NBD_OPT_INFO were =
already meant to support 'unlimited' size writes. Per the spec:

"If block size constraints have not been advertised or agreed on =
externally, then a client SHOULD assume a default minimum block size of =
1, a preferred block size of 2^12 (4,096), and a maximum block size of =
the smaller of the export size or 0xffffffff (effectively unlimited)."

I read these to apply to all uses of 'length', but even if one argues it =
doesn't apply to NBD_CMD_WRITE_ZEROES because it doesn't have a payload, =
I think the rebuttal is that a server which supports NBD_CMD_WRITE of a =
given length must also support NBD_CMD_WRITE_ZEROES of that length.

So I think a reasonable logic for Qemu would be to try NBD_CMD_INFO and =
find the maximum write size, and if that's unsupported use 0xffffffff =
(capping at export size, or export size minus write offset).

--=20
Alex Bligh
