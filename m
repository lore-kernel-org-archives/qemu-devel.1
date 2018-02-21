Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoZCB-0001wU-57
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoZC7-0006Zm-KA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:32:47 -0500
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<20180221165116.GB4196@localhost.localdomain>
	<aed232fa-af26-5994-0bed-ec84a514b645@redhat.com>
	<20180221173926.GB353@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea6477ec-74da-f4cf-2cec-629508d4d8d1@redhat.com>
Date: Wed, 21 Feb 2018 12:32:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180221173926.GB353@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com

On 02/21/2018 11:39 AM, Kevin Wolf wrote:
>> See my commit message comment - we have other spots in the code base t=
hat
>> blindly g_malloc(2 * s->cluster_size).
>=20
> Though is that a reason to do the same in new code or to phase out such
> allocations whenever you touch them?

Touch=C3=A9.

>=20
>> And I intended (but sent the email without amending my commit) to use
>> g_malloc().  But as Berto has convinced me that an externally produced
>> image can convince us to read up to 4M (even though we don't need that
>> much to decompress), I suppose that the try_ variant plus checking is
>> reasonable (and care in NULL'ing out if one but not both allocations
>> succeed).
>=20
> Sounds good.
>=20
> Another thought I had is whether we should do per-request allocation fo=
r
> compressed clusters, too, instead of having per-BDS buffers.

The only benefit of a per-BDS buffer is that we cache things - multiple=20
sub-cluster reads in a row all from the same compressed cluster benefit=20
from decompressing only once.  The drawbacks of a per-BDS buffer: we=20
can't do things in parallel (everything else in qcow2 drops the lock=20
around bdrv_co_pread[v]), so the initial read prevents anything else in=20
the qcow2 layer from progressing.

I also wonder - since we ARE allowing multiple parallel readers in other=20
parts of qcow2 (without a patch, decompression is not in this boat, but=20
decryption and even bounce buffers due to lower-layer alignment=20
constraints are), what sort of mechanisms do we have for using a pool of=20
reusable buffers, rather than having each cluster access that requires a=20
buffer malloc and free the buffer on a per-access basis?  I don't know=20
how much time the malloc/free per-transaction overhead adds, or if it is=20
already much smaller than the actual I/O time.

But note that while reusable buffers from a pool would cut down on the=20
per-I/O malloc/free overhead if we switch decompression away from=20
per-BDS buffer, it would still not solve the fact that we only get the=20
caching ability where multiple sub-cluster requests from the same=20
compressed cluster require only one decompression, since that's only=20
possible on a per-BDS caching level.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
