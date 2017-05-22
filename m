Received: from eggs.gnu.org ([2001:4830:134:3::10]:42976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCmzR-000482-53
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCmzL-0000tS-0Z
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:03:13 -0400
References: <1495376506-13227-1-git-send-email-den@openvz.org>
	<705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
	<8d854387-01fc-1f36-7452-7e9cc3cdbcc2@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07c51989-1032-8039-0436-515e63f14df1@redhat.com>
Date: Mon, 22 May 2017 08:02:54 -0500
MIME-Version: 1.0
In-Reply-To: <8d854387-01fc-1f36-7452-7e9cc3cdbcc2@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1vHWjdRpPBS3NqJvt8cCgUaiiKvjM4Cg0"
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening
 with a guest TRIM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1vHWjdRpPBS3NqJvt8cCgUaiiKvjM4Cg0
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <07c51989-1032-8039-0436-515e63f14df1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening
 with a guest TRIM command
References: <1495376506-13227-1-git-send-email-den@openvz.org>
 <705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
 <8d854387-01fc-1f36-7452-7e9cc3cdbcc2@openvz.org>
In-Reply-To: <8d854387-01fc-1f36-7452-7e9cc3cdbcc2@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 06:56 AM, Denis V. Lunev wrote:
>>
>>
>> As it is, your patch doesn't apply to master.  And even if it did, you=
r
>> patch breaks semantics - we CANNOT discard clusters that must read bac=
k
>> as zeroes.
>>
> Can you pls give some details why the cluster can not be
> discarded? This is something that I can not understand.

The cluster CAN be discarded if the guest requests it.  There is a
difference between:

qemu-img -f qcow2 'w -z    0 64k' 1.img

which says to ensure that the cluster reads back as zero, but to NOT
unmap things (corresponding to NBD_CMD_WRITE_ZEROES with
NBD_CMD_FLAG_NO_HOLE set), and:

qemu-img -f qcow2 'w -z -u 0 64k' 1.img

which says to ensure that the cluster reads back as zero, and that
unmapping the cluster is permitted if that will make the operation
faster and/or use less space (corresponding to NBD_CMD_WRITE_ZEROES with
NBD_CMD_FLAG_NO_HOLE clear).

In current master, we've gone as far as to make an obvious difference
between the two types of qcow2 zero clusters (see commit fdfab37);
QCOW2_CLUSTER_ZERO_PLAIN corresponds to the case where the guest allowed
a cluster to be unmapped, while QCOW2_CLUSTER_ZERO_ALLOC corresponds to
the case where we've written zeroes but require the allocation mapping
to remain intact.

One of the big reasons why we do NOT want the guest to be able to
convert a cluster to QCOW2_CLUSTER_UNALLOCATED after a write zero
request (but only after a discard request) is that we don't want to
audit what will happen if a backing file is later added to the image.
If a guest does a discard, then they are acknowledging that the data in
that cluster can read back as anything (we try to make it read back as
zero where practical, but do not guarantee that).  But if a guest does a
write zero request, even if they permit unmapping, the semantics require
that they can read back zero, no matter what happens to the backing chain=
=2E

An example that Kevin used to convince me was the process of drive
mirroring: if you mirror just the active qcow2 layer, then cancel the
mirror, the destination is supposed to be a snapshot of what the guest
saw at that moment, once you rebase the destination image to be on top
of the same backing contents as the source saw.  That implies that I can
use 'qemu-img rebase -u' to inject a backing chain.  If we mirror a zero
cluster over to the destination, and make sure the destination sees a
QCOW2_CLUSTER_ZERO_PLAIN, then no matter what the backing chain we later
rebase the destination onto, we still read 0 for that cluster (as the
guest expected).  But if we mirror the zero cluster over and leave the
destination image with QCOW2_CLUSTER_UNALLOCATED, then supply a backing
chain where the cluster does not read as zero, then we have altered the
guest-visible contents.  So it is safer to ALWAYS require that a guest
write-zero action uses one of the two types of qcow2 zero clusters, to
keep the guest-visible contents of that cluster constant no matter what
rebasing actions later occur.

That said, we've also had a conversation on things we can do to improve
mirroring; one of the ideas was to add a new flag (comparable to the
existing BDRV_REQ_MAY_UNMAP) that mirroring (but not guest actions) can
use to request that zero_single_l2() is permitted to reuse
QCOW2_CLUSTER_UNALLOCATED instead of having to switch to
QCOW2_CLUSTER_ZERO_PLAIN, or where we can exploit PUNCH_HOLE semantics
on the underlying bs->file to efficiently write zeroes into the file
system even while keeping QCOW2_CLUSTER_ZERO_ALLOC at the qcow2 layer.

>=20
> At my opinion the cluster is clearly marked with QCOW_OFLAG_ZERO
> and thus will be read with zeroes regardless of the content of the
> cluster which is pointed by the offset. This is actually what
> happens on the FS without PUNCH_HOLE support.
>=20
> That is why this offset can be actually reused for any other
> block, what is I am trying to propose.

Yes, when using write zeros with unmap (qemu-io -c 'w -z -u ...'), then
the code already unmaps the cluster, so that it can be reused for any
other block.  So it boils down to whether your guest is really
requesting write zeroes with permission to unmap, and whether any other
options you have specified regarding the disk are filtering out
BDRV_REQ_MAY_UNMAP before it reaches the qcow2 layer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1vHWjdRpPBS3NqJvt8cCgUaiiKvjM4Cg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIuF+AAoJEKeha0olJ0NqjRQIAIHOg0wSyLG/YCreUoxAHb9x
KdYCcYDzDv3zghopF44cflAW7umBvnz09v+h2ZdKBzFjsrpJ49rwyuFFYt6NPbAH
3U4gpayL752OxqVAkIAdWqsqE67vfDmnV2x34kw4qdrNWwFACjbgJ44n1NzJoBiN
366wFfl/xbSLDKUOqmy6PkOhx94wxLgxxWnENT+9CPZpllhonj3NKGi65krtYZS6
eLvFf1Hfj84WDv86AImlfUGkTgnojba146rPbbfhobMISHlyhzjs1Dj6BkE1Te8a
WjNZ/q6lTtBm3DpzFSwLs+mrupE4QZmuDMg8iYdnOijvmaqK+mbi4D5VDBZQAts=
=Y+wo
-----END PGP SIGNATURE-----

--1vHWjdRpPBS3NqJvt8cCgUaiiKvjM4Cg0--
