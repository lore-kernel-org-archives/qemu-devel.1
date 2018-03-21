Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eya2X-0003vN-6k
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eya2S-0002Nx-CL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:28:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <665e0ccd-4440-4e0e-30f9-e38537795325@redhat.com>
References: <20180320135515.16823-1-berto@igalia.com>
	<665e0ccd-4440-4e0e-30f9-e38537795325@redhat.com>
Date: Wed, 21 Mar 2018 10:28:04 +0100
Message-ID: <w51po3xixqz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] qcow2: Reset free_cluster_index
 when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 20 Mar 2018 06:54:15 PM CET, Eric Blake wrote:

>> When we try to allocate new clusters we first look for available ones
>> starting from s->free_cluster_index and once we find them we increase
>> their reference counts. Before we get to call update_refcount() to do
>> this last step s->free_cluster_index is already pointing to the next
>> cluster after the ones we are trying to allocate.
>>=20
>  > During update_refcount() it may happen however that we also need to
>  > allocate a new refcount block in order to store the refcounts of
>  > these new clusters
>
> Your changes to test 121 covers this...
>
>  > (and to complicate things further that may also require us to grow
>  > the refcount table).
>
> ...but not this.  Is it worth also trying to cover this case in the
> testsuite as well?

I checked and the patch doesn't really fix that scenario. There's a
different problem that I haven't debugged completely yet, because of two
reasons:

 - One difference is that when we grow the refcount table we actually
   allocate a new one, so s->free_cluster_index points to the beginning
   of the image (where the previous table was) and any holes left during
   the process are allocated after that (depending on how much data we
   write though).

 - This scenario is harder to reach: in order to fill a 1-cluster
   refcount table the size of the image needs to be larger than
   (cluster_size=C2=B3 / refcount_bits) bytes, that's 16TB with the default
   parameters. So although it can be reproduced easily if you reduce the
   cluster size I think it's very infrequent under normal conditions.

But yes, it's a task left for the future.

>> +            /* If the caller needs to restart the search for free clust=
ers,
>> +             * try the same ones first to see if they're still free. */
>> +            if (ret =3D=3D -EAGAIN) {
>> +                if (s->free_cluster_index > (start >> s->cluster_bits))=
 {
>> +                    s->free_cluster_index =3D (start >> s->cluster_bits=
);
>> +                }
>
> Is there any harm in making this assignment unconditional, instead of
> only doing it when free_cluster_index has grown larger than start?

It can happen that it is smaller than 'start' if we were moving the
refcount table to a new location, so we want to keep the lowest value.

> [And unrelated, but it might be nice to do a followup cleanup to track
> free_cluster_offset by bytes instead of having to shift
> free_cluster_index everywhere]

I've actually just seen that we already have free_byte_offset, we use
that for compressed clusters, so it might be possible to use that one...

I'll put that in my TODO list.

Berto
