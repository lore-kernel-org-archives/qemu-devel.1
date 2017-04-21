Received: from eggs.gnu.org ([2001:4830:134:3::10]:55887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1mPo-0005I0-Ro
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1mPn-0002OY-PS
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:12:56 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6d49036-c222-ac33-65b6-25f2b6d0ac55@redhat.com>
Date: Fri, 21 Apr 2017 13:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="60VUiomCPn0pX1dkBKOSbxRjMdAkWHf5B"
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--60VUiomCPn0pX1dkBKOSbxRjMdAkWHf5B
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <f6d49036-c222-ac33-65b6-25f2b6d0ac55@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 04:49 AM, Kevin Wolf wrote:
>> Furthermore, this matches the behavior of discard_single_l2(), in
>> favoring an unallocated cluster over a zero cluster when full
>> discard is requested.
>=20
> The only use for "full discard" is qcow2_make_empty(). It explicitly
> requests that the backing file becomes visible again. This is a
> completely different case.

No, let's look at that code - I'm not referring to the
qcow2_make_empty() case, but to the bdrv_pdiscard() case:


        /*
         * If full_discard is false, make sure that a discarded area
reads back
         * as zeroes for v3 images (we cannot do it for v2 without actual=
ly
         * writing a zero-filled buffer). We can skip the operation if th=
e
         * cluster is already marked as zero, or if it's unallocated and =
we
         * don't have a backing file.
         *
         * TODO We might want to use bdrv_get_block_status(bs) here, but
we're
         * holding s->lock, so that doesn't work today.
         *
         * If full_discard is true, the sector should not read back as
zeroes,
         * but rather fall through to the backing file.
         */
        switch (qcow2_get_cluster_type(old_l2_entry)) {
            case QCOW2_CLUSTER_UNALLOCATED:
                if (full_discard || !bs->backing) {
                    continue;
                }
                break;


That says: if our cluster is currently unallocated, and we have no
backing file, then LEAVE it unallocated (rather than marking it
QCOW2_CLUSTER_ZERO), even through bdrv_pdiscard.

Meanwhile, the next lines:

            case QCOW2_CLUSTER_ZERO:
                if (!full_discard) {
                    continue;
                }

state that if we are doing bdrv_pdiscard(), and the cluster already
reads as zeroes, then minimize the churn by not changing the cluster
(and that in turn means we do NOT lose a preallocation).

>=20
> In other words, in order to stay consistent between discard and
> write_zeroes from a guest POV, we need to leave this code alone.

Again, my argument is that if we have no backing file, and the cluster
is previously unallocated, then leaving it unallocated is equivalent to
changing it to QCOW2_CLUSTER_ZERO.  There is no difference to the guest
POV by this change.

>=20
>> Meanwhile, version 2 qcow2 files (compat=3D0.10) lack support for an
>> explicit zero cluster.  This minor tweak therefore allows us to turn
>> write zeroes with unmap into an actual unallocation on those files,
>> where they used to return -ENOTSUP and cause an allocation due to
>> the fallback to explicitly written zeroes.
>=20
> Okay, this is true.
>=20
> But I doubt that making write_zeroes more efficient on v2 images withou=
t
> a backing file is really worth any extra complexity at this point...

My argument is that it is not much complexity, and that making this
change coupled with the new qemu-iotest 179 in patch 2/13 (which fails
without this change) enabled me to test qemu-io -c 'w -z -u' (which
nothing else was testing) and ensure that I'm not regression when the
rest of the series further tweaks things to be byte-based.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--60VUiomCPn0pX1dkBKOSbxRjMdAkWHf5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+lKPAAoJEKeha0olJ0Nq5JYH+wd596m38LaYfoVZNsoEA0X4
DdgWb3PcuIVPys0Rj+5Wb65HnGer/NJdDY6FpdM8G0Wt3AjaxjxGxoM+NOctyLzN
VzdK9dyrkTAFSm2rqc+iFGRR/d7zOKv0IjWHWJSBHI/EebcvMM5nzX2y6/r0hM4r
1y2PxxF2M0+nFbUW3LEF8h2AeOz5VI8o4fum5HfkYTMIZZdz1hDmQbcX03vkOdz6
zVWfNmnZOg1fUhLWcQ79lp52+/lyGsin4gLvjlBuvtYmJANWxi+MKbTi8npuCb/t
dTVBrNVAIrTUqx3wB8ISxns0p4MOJxUCs4ANJxhg9XIjkocmfSGbJNpX2GO3ofo=
=wGq8
-----END PGP SIGNATURE-----

--60VUiomCPn0pX1dkBKOSbxRjMdAkWHf5B--
