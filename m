Received: from eggs.gnu.org ([2001:4830:134:3::10]:58092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEBwN-0001DZ-Ll
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEBwK-0003Bb-IP
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:21:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEBwK-0003BJ-BL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:21:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so20131510wmu.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:21:32 -0800 (PST)
Date: Tue, 6 Dec 2016 09:20:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206092029.GA12630@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-13-stefanha@redhat.com>
	<14acce63-5f93-ca54-477a-3a998769bbe9@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <14acce63-5f93-ca54-477a-3a998769bbe9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/13] aio: self-tune polling time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Karl Rister <krister@redhat.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 09:06:17PM +0100, Christian Borntraeger wrote:
> On 12/01/2016 08:26 PM, Stefan Hajnoczi wrote:
> > This patch is based on the algorithm for the kvm.ko halt_poll_ns
> > parameter in Linux.  The initial polling time is zero.
> >=20
> > If the event loop is woken up within the maximum polling time it means
> > polling could be effective, so grow polling time.
> >=20
> > If the event loop is woken up beyond the maximum polling time it means
> > polling is not effective, so shrink polling time.
> >=20
> > If the event loop makes progress within the current polling time then
> > the sweet spot has been reached.
> >=20
> > This algorithm adjusts the polling time so it can adapt to variations in
> > workloads.  The goal is to reach the sweet spot while also recognizing
> > when polling would hurt more than help.
> >=20
> > Two new trace events, poll_grow and poll_shrink, are added for observing
> > polling time adjustment.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Not sure way, but I have 4 host ramdisks with the same iothread as guest
> virtio-blk. running fio in the guest on one of these disks will poll, as
> soon as I have 2 disks  in fio I almost always see shrinks (so polling=20
> stays at 0) and almost no grows.

Shrinking occurs when polling + ppoll(2) time exceeds poll-max-ns.

What is the value of poll-max-ns and how long is run_poll_handlers_end -
run_poll_handlers_begin?

I wonder if polling both disks takes longer than poll-max-ns once you
have two disks.  The "polling" activity includes processing the I/O
requests, so I imagine the time extends significantly as more disks have
I/O requests ready for processing.

Maybe the block_ns timing calculation should exclude processing time to
avoid false shrinking?

It also strikes me that there's a blind spot to the self-tuning
algorithm: imagine virtqueue kick via ppoll(2) + ioeventfd takes N
nanoseconds.  Detecting new virtqueue buffers via polling takes M
nanoseconds.  When M <=3D poll-max-ns < N the algorithm decides there is
no point in polling but it would actually be faster to poll.  The reason
is that the algorithm only looks at block_ns, which is N, not M.

This seems difficult to tackle because the algorithm has no way of
predicting M unless it randomly tries to poll longer.

Stefan

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRoLcAAoJEJykq7OBq3PIp04H/RCbyUNoIU1uLrZbqR/6d+fE
h/MBDyD7+8xb/u+ut1a34XNgTsqJaKGI6mTZKumtUPJDBczRtog2KQHdRLWlHuTB
yAbavOaOYPvNxC0KyQUk5fjgoB1sSUZ68tSCKQHFn+WuZC/hUdne1zyQzKJZrh/b
q9zzapYwqDF6RyZOl3eLgeGfdxP2mVLQ1GBmDIVwKSgezDT9np2FCPJl7dVYIFpM
BLpgL0tI/fqzVtJ2bE8VSFlssqTsuCKxBs3yWpWS8g7Gr09mDSIcXrrX0edH+Nj9
aoNogwPAp0oLJY4g8k/xNDL0WENp0RUP26tkfnHziDzuYrtMTEeIU4KPsaId7K4=
=kc7h
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
