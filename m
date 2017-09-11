Received: from eggs.gnu.org ([2001:4830:134:3::10]:47740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drPOn-0004r6-0o
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drPOl-0008JW-Rj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:09:16 -0400
Date: Mon, 11 Sep 2017 16:08:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170911140858.GA6951@localhost.localdomain>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-11-git-send-email-pl@kamp.de>
	<546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 10/10] block/qcow2: add compress info to
 image specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.07.2017 um 23:55 hat Eric Blake geschrieben:
> On 07/25/2017 09:41 AM, Peter Lieven wrote:
> > Signed-off-by: Peter Lieven <pl@kamp.de>
> > ---
> >  block/qcow2.c        | 7 +++++++
> >  qapi/block-core.json | 6 +++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >=20
> > +++ b/qapi/block-core.json
> > @@ -68,6 +68,9 @@
> >  # @encrypt: details about encryption parameters; only set if image
> >  #           is encrypted (since 2.10)
> >  #
> > +# @compress: details about parameters for compressed clusters; only se=
t if
> > +#            the compress format header extension is present (since 2.=
11)
>=20
> Thinking aloud:
>=20
> I still think this is better as "only set if the image uses compressed
> headers" (similar to encrypt).  That is, I would like this output to be
> present even when opening legacy deflate/0/12 images.
>=20
> But thinking more, what I am REALLY asking for is "if any cluster is
> compressed, then this information is present; if nothing is compressed,
> the choice of compression header doesn't matter".  But we don't have a
> quick-and-dirty way to tell if an image has any compressed clusters,
> short of examining every L2 map (including maps inside internal snapshots=
).
>=20
> Hmm - we already have 'Dirty bit' and 'Corrupt bit' as
> incompatible_features that can quickly identify certain image
> properties; do we want another bit set to 1 for images known to use
> compressed clusters?  Or even make it an auto-clear bit (or even a pair
> of auto-clear bits: one to designate that this image was written by a
> new-enough qemu that promises to mark the image if any compressed
> clusters exist, and the other is set only if such clusters do exist;
> that way, if both bits are clear, we know we have to walk L2 tables to
> look for compressed clusters, but if the first bit is set, then the
> second bit is reliable)?
>=20
> So maybe this means we are still debating spec ideas.  Kevin, do you
> want to chime in?

I'm not sure if this would be an useful extension. Adding feature bits
is a relatively big change and I don't see what it actually buys us
here.

First of all, what use is the information that an image contains
compressed clusters? For any practical use that I could imagine, there
is a big difference between an image that contains one compressed
cluster and an image that has 100% compressed clusters - much bigger
than between the image with one compressed cluster and an image that is
fully uncompressed.

But if we assume for a moment that the information is useful: For old
images, we would still be in the same situation as today and couldn't
tell whether an image contains compressed clusters or not. For new
images that are meant for new qemu versions, we can have the compression
header, which is probably as close as we can get (at least I don't think
you suggested something that would unset the compressed bit as soon as
the last compressed cluster gets uncompressed through copy-on-write).

That leaves us with images created by new qemu versions that are meant
to be consumed by old versions so that we can't set the incompatible
feature bit. If we are concerned about these, couldn't we simply specify
that a compression header that contains the current defaults MAY exist
even without the incompatible feature bit?

Kevin

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZtpj6AAoJEH8JsnLIjy/WPVgP/i1GmtRg1ZbzGxO/b4qnSPQ2
b7pimxKeYxL/7dCQA75YGRq9BPtXpczniSBuHjU8Nlwwp1BJj7K4qa3o0L9lTVgM
hM+tu0awJkGL52HOgQJr9mxd0rGW1c7L1LAub0EpQFBUK5A85yDIruy7STJ1AgQT
L+F5WMCCMcRIsK4OW2z92/mAWVh4OR/SxmA0vBVjipdLjKJ87OASHB+VPln8n8N6
WYad1WMtf1EN7SwM+Z7LviX3VjnSus1svNzRWPjpv1tmtHRwSxuMAFzdSNOTPjsX
rPP35x0hO4UC2WQLThg8TLyGf48oLhrwcFHRyfDjerq1GaXxi6FYdUieIoCJH8uR
Fy0dCGx7DIMwDtjRK2T0FIoaxA0UNSlxgVwE6PkNdvm3CAkqjfCQ17Ic/Y0bw5Qz
4Vok7/3Ai5UqApf7pHE6U3CVpsvNNOEZqi2hfCnYc2CIXyiavJsnxxN8kYQ5N1x9
C+SBNwRv0JqoK1c0gVR0R6SofAOn6jmGkH1J/Si9kLAuWSi2YqOPhCwcB6WQxPOG
LZMDfRPhRcXDPeLi85Z8Nsx3QwFJ4u/cbU7FdeK2ZUIKoQNk5pwIBNZScXfEiXIq
Qrhmne9EWQXuDerPFxwMkQscdImHHRCUihJm5ES6XJbhg9cyl87n1kXqm6uPN/8U
YN+g16VaAq6ITmvx13UT
=J5YR
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
