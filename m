Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoZRc-0007US-Jo
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoZRa-0005xt-N4
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:48:44 -0500
Date: Wed, 21 Feb 2018 19:48:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180221184822.GD353@localhost.localdomain>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<20180221165116.GB4196@localhost.localdomain>
	<aed232fa-af26-5994-0bed-ec84a514b645@redhat.com>
	<20180221173926.GB353@localhost.localdomain>
	<ea6477ec-74da-f4cf-2cec-629508d4d8d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ea6477ec-74da-f4cf-2cec-629508d4d8d1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com

Am 21.02.2018 um 19:32 hat Eric Blake geschrieben:
> On 02/21/2018 11:39 AM, Kevin Wolf wrote:
> > > See my commit message comment - we have other spots in the code bas=
e that
> > > blindly g_malloc(2 * s->cluster_size).
> >=20
> > Though is that a reason to do the same in new code or to phase out su=
ch
> > allocations whenever you touch them?
>=20
> Touch=E9.
>=20
> >=20
> > > And I intended (but sent the email without amending my commit) to u=
se
> > > g_malloc().  But as Berto has convinced me that an externally produ=
ced
> > > image can convince us to read up to 4M (even though we don't need t=
hat
> > > much to decompress), I suppose that the try_ variant plus checking =
is
> > > reasonable (and care in NULL'ing out if one but not both allocation=
s
> > > succeed).
> >=20
> > Sounds good.
> >=20
> > Another thought I had is whether we should do per-request allocation =
for
> > compressed clusters, too, instead of having per-BDS buffers.
>=20
> The only benefit of a per-BDS buffer is that we cache things - multiple
> sub-cluster reads in a row all from the same compressed cluster benefit=
 from
> decompressing only once.

Oh, you're right. I missed that this is actually used as a cache.

I guess we want to leave it for now then. Maybe at some point we can
actually implement the data cache that I proposed a few years ago (using
Qcow2Cache for data clusters under some circumstances), then we could
probably make that hold the data instead of having a separate cache.

> The drawbacks of a per-BDS buffer: we can't do things in parallel
> (everything else in qcow2 drops the lock around bdrv_co_pread[v]), so
> the initial read prevents anything else in the qcow2 layer from
> progressing.

Yes, though there are probably other optimisations that could be made
for compression before this becomes relevant, like reading more than one
cluster at a time.

> I also wonder - since we ARE allowing multiple parallel readers in othe=
r
> parts of qcow2 (without a patch, decompression is not in this boat, but
> decryption and even bounce buffers due to lower-layer alignment constra=
ints
> are), what sort of mechanisms do we have for using a pool of reusable
> buffers, rather than having each cluster access that requires a buffer
> malloc and free the buffer on a per-access basis?  I don't know how muc=
h
> time the malloc/free per-transaction overhead adds, or if it is already=
 much
> smaller than the actual I/O time.

I don't either. A while ago, we used g_slice_alloc() in some places (I
remember qemu_aio_get), but it was actually slower than just using
malloc/free each time.

So if we do want to pool buffers, we probably need to implement that
manually. I don't think we have a generic memory pool in qemu yet.

> But note that while reusable buffers from a pool would cut down on the
> per-I/O malloc/free overhead if we switch decompression away from per-B=
DS
> buffer, it would still not solve the fact that we only get the caching
> ability where multiple sub-cluster requests from the same compressed cl=
uster
> require only one decompression, since that's only possible on a per-BDS
> caching level.

Yes, as I said above, I didn't notice that it's a real cache. Without
the possibility to use Qcow2Cache instead, we'll want to keep it.

Kevin
