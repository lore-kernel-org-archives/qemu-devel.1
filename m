Received: from eggs.gnu.org ([2001:4830:134:3::10]:39837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDtRo-00026m-Cb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDtRn-00070G-Br
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:13:36 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
	<69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
Date: Wed, 2 May 2018 17:13:19 +0200
MIME-Version: 1.0
In-Reply-To: <69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sMrFWYkI4KWRv493OktHmrf7AkDVvHiSW"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sMrFWYkI4KWRv493OktHmrf7AkDVvHiSW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Ivan Ren <renyime@gmail.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
 <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
 <69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
In-Reply-To: <69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 17:01, Eric Blake wrote:
> On 05/02/2018 09:37 AM, Max Reitz wrote:
>> On 2018-05-02 15:34, Ivan Ren wrote:
>>> qemu-img info with a block device which has a qcow2 format always
>>> return 0 for disk size, and this can not reflect the qcow2 size
>>> and the used space of the block device. This patch return the
>>> allocated size of qcow2 as the disk size.
>>
>> I'm not quite sure whether you really need this information for block
>> devices (I tend to agree with Eric that wr_highest_cluster is the more=

>> important information there), but I can imagine it just being nice to
>> have.
>=20
> Hmm, so in an extreme case, if you create an internal snapshot, then th=
e
> guest makes edits, then you remove the internal snapshot, we have a
> wr_highest_offset that has advanced (because the guest changes had to
> allocate new clusters due to COW of refcount=3D2 clusters); but the
> deleted snapshot now means we have a lot of unused clusters earlier in
> the image (deleting the snapshot took refcount=3D2 clusters back to 1, =
and
> any COW'd clusters edited after the internal snapshot means the snapsho=
t
> version is now back to refcount=3D0, whether or not we also try to punc=
h a
> hole in the protocol layer for those freed clusters).=C2=A0 Thus, repor=
ting
> the highest written cluster is a larger number than the number of
> clusters that are actually in use, and both numbers might be useful to
> know (how big do I have to size my block device, and how utilized is my=

> block device), especially if we add code for online compaction or
> defragmentation of a qcow2 image so that we can move higher offsets int=
o
> holes left earlier in the image.

In any case, since a block device is linear you really need to know the
highest offset that is in use.  Sure, if you know how much space there
is wasted in holes in the middle of the file, that is nice to know, but
it doesn't tell you when you need to grow your block device.

(It does tell you when to consider qemu-img convert or a mirror job to
defragment the image, though...)

> If you don't use internal snapshots, the only way to get holes of
> unallocated clusters earlier in the image is if the guest uses TRIM
> operations, and I'm not sure if that's easier or harder to trigger, nor=

> which approach (internal snapshots vs. guest TRIM operations) is likely=

> to leave more holes of unallocated clusters.

And I think we (at least used to) have quirks in qcow2's allocation
algorithm that meant it could leave some clusters unallocated in the
middle of the image (I think that was in case you allocate more than a
single cluster (e.g. for an L1 table), but then you also need to
allocate a new refblock, so you allocate that first and then you only
start to allocate clusters after that refblock, even though there might
still be space in front of it).

>> The whole implementation reminds me a lot of qcow2's check function,
>> which basically just recalculates the refcounts.=C2=A0 So I'm wonderin=
g
>> whether you could just count how many clusters with non-0 refcount the=
re
>> are and thus simplify the implementation dramatically.
>=20
> We also recently added 'qemu-img measure', which DOES report how many
> clusters are in use.=C2=A0 Is any of that reusable here?

It only tells you that information for a hypothetical new image, though,
doesn't it?

Max


--sMrFWYkI4KWRv493OktHmrf7AkDVvHiSW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrp1Y8ACgkQ9AfbAGHV
z0ASowf/bob2ztZgJtpQtmZ4MFvY9wheVbj+2rdCXcvnk1hLiE64xOXqVmVc+HRJ
0d5lCLJ301Rs5VVmgzGKtBn44asKufVF1yWU5KfWN1keCFTQhsrb3CuA6Qc/QrII
ly1n8hUzJK8TxTMI5LUeBsS0iqcjSnndvwnA/GsOTsvMOlMVCc+EYY/dtydeYRtv
H7wh67VQ3jXFuZSHl/YTOq3AaPux5AkTgLeSyKifOQqhC10Php2xW8Dsj2hjMX1a
QTT4CzYr4QFEqbA4TH/xxnzRzos/HjdKF62s+O6s+Udrihu+5BL8KZ+HkB6m1Um2
Ub7doN13Pb5jIV5nIymZGEpjRD7Qtg==
=s0eK
-----END PGP SIGNATURE-----

--sMrFWYkI4KWRv493OktHmrf7AkDVvHiSW--
