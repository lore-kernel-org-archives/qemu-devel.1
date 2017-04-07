Received: from eggs.gnu.org ([2001:4830:134:3::10]:34782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwV1z-0002rW-DG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwV1v-00051m-Ap
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cwV1v-00050u-4X
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:27 -0400
Received: by mail-wm0-x241.google.com with SMTP id o81so1769258wmb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:38:27 -0700 (PDT)
Date: Fri, 7 Apr 2017 15:38:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407143823.GJ16146@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
	<20170406103117.7elooodj2k5wrbnu@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <20170406103117.7elooodj2k5wrbnu@hz-desktop>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dan.j.williams@intel.com, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 06:31:17PM +0800, Haozhong Zhang wrote:
> On 04/06/17 10:43 +0100, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> > We should think about the optimal way of implementing Flush Hint
> > Addresses in QEMU.  But if there is no reasonable way to implement them
> > then I think it's better *not* to implement them, just like the Block
> > Window feature which is also not virtualization-friendly.  Users who
> > want a block device can use virtio-blk.  I don't think NVDIMM Block
> > Window can achieve better performance than virtio-blk under
> > virtualization (although I'm happy to be proven wrong).
> >=20
> > Some ideas for a faster implementation:
> >=20
> > 1. Use memory_region_clear_global_locking() to avoid taking the QEMU
> >    global mutex.  Little synchronization is necessary as long as the
> >    NVDIMM device isn't hot unplugged (not yet supported anyway).
> >
>=20
> ACPI spec does not say it allows or disallows multiple writes to the
> same flush hint address in parallel. If it can, I think we can remove
> the global locking requirement for the MMIO memory region of the flush
> hint address of vNVDIMM.

The Linux code tries to spread the writes but two CPUs can write to the
same address sometimes.

It doesn't matter if two vcpus access the same address because QEMU just
invokes fsync(2).  The host kernel has synchronization to make the fsync
safe.

Stefan

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY56RfAAoJEJykq7OBq3PIqdwH/2utxf5DLU6WPn+q7los98Sl
mb2H6NGU/ngZhb57thJNySEt6SU7n/ObRggueGlmuwuYQG6/jKKR1GV9ZWO/GB3m
gM3j/Sd9PtDlM+uoJ3VsWyzd9U7u3pAVLVwnEZ4u+voXenFLQxqYC+a8wlOfFAFf
Dowws52m072K0KsSmshaJ37N2QLwlPikpfriKSBbZgN55YcdIsc/EAsT00uD5mfo
0ckXYZecAZhSJjTNnjfPRyZK8nmONeaepIQVAbWlp4ID0DR9rA7HYOmwmTCk6ZMb
Rl/3hZT975FCPOIY9rjFq9jKZH5pM8ss+AYG/VP+enrJ5ZUkprJ5iwcP2AmdQfo=
=NDNS
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
